-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "username" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "paymentStream" (
    "id" SERIAL NOT NULL,
    "creator_id" INTEGER NOT NULL,
    "code" TEXT NOT NULL,
    "description" TEXT,
    "amount" DOUBLE PRECISION NOT NULL,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updated_at" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "paymentStream_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "userPaymentStreams" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "payment_stream_id" INTEGER NOT NULL,
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "userPaymentStreams_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "dues" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "payment_stream_id" INTEGER NOT NULL,
    "amount" INTEGER NOT NULL,
    "due_date" TIMESTAMP(3) NOT NULL,
    "paid" BOOLEAN NOT NULL DEFAULT false,
    "status" TEXT NOT NULL,
    "paid_at" TIMESTAMP(3),
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "dues_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "streamMembers" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "payment_stream_id" INTEGER NOT NULL,
    "role" TEXT NOT NULL,
    "unique_id" TEXT NOT NULL,
    "full_name" TEXT NOT NULL,
    "joined_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "streamMembers_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "payments" (
    "id" SERIAL NOT NULL,
    "user_id" INTEGER NOT NULL,
    "payment_stream_id" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "paid_at" TIMESTAMP(3) NOT NULL,
    "reference" TEXT NOT NULL,
    "method" TEXT NOT NULL,
    "note" TEXT,
    "refunded" BOOLEAN NOT NULL DEFAULT false,
    "refund_amount" DOUBLE PRECISION,
    "refund_reason" TEXT,
    "refunded_at" TIMESTAMP(3),

    CONSTRAINT "payments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "refunds" (
    "id" SERIAL NOT NULL,
    "payment_id" INTEGER NOT NULL,
    "user_id" INTEGER NOT NULL,
    "payment_stream_id" INTEGER NOT NULL,
    "amount" DOUBLE PRECISION NOT NULL,
    "refunded_at" TIMESTAMP(3) NOT NULL,
    "reason" TEXT,

    CONSTRAINT "refunds_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "users_username_key" ON "users"("username");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- CreateIndex
CREATE UNIQUE INDEX "paymentStream_code_key" ON "paymentStream"("code");

-- CreateIndex
CREATE UNIQUE INDEX "refunds_payment_id_key" ON "refunds"("payment_id");

-- AddForeignKey
ALTER TABLE "paymentStream" ADD CONSTRAINT "paymentStream_creator_id_fkey" FOREIGN KEY ("creator_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userPaymentStreams" ADD CONSTRAINT "userPaymentStreams_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "userPaymentStreams" ADD CONSTRAINT "userPaymentStreams_payment_stream_id_fkey" FOREIGN KEY ("payment_stream_id") REFERENCES "paymentStream"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dues" ADD CONSTRAINT "dues_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "dues" ADD CONSTRAINT "dues_payment_stream_id_fkey" FOREIGN KEY ("payment_stream_id") REFERENCES "paymentStream"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "streamMembers" ADD CONSTRAINT "streamMembers_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "streamMembers" ADD CONSTRAINT "streamMembers_payment_stream_id_fkey" FOREIGN KEY ("payment_stream_id") REFERENCES "paymentStream"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "payments" ADD CONSTRAINT "payments_payment_stream_id_fkey" FOREIGN KEY ("payment_stream_id") REFERENCES "paymentStream"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refunds" ADD CONSTRAINT "refunds_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refunds" ADD CONSTRAINT "refunds_payment_stream_id_fkey" FOREIGN KEY ("payment_stream_id") REFERENCES "paymentStream"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "refunds" ADD CONSTRAINT "refunds_payment_id_fkey" FOREIGN KEY ("payment_id") REFERENCES "payments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
