import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { ClerkAuthGuard } from './auth/clerk-auth.guard';
import { ClerkAuthService } from './auth/clerk.strategy';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);
  await app.listen(process.env.PORT ?? 3000);
  app.useGlobalGuards(new ClerkAuthGuard(new ClerkAuthService()));

}
bootstrap();
