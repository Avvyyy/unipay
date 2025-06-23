import { Injectable, onModuleInit} from '@nestjs/common';
import {PrismaClient} from '../../generated/prisma'

@Injectable()
export class PrismaService extends PrismaClient implements onModuleInit{
}
