// src/auth/clerk-auth.guard.ts
import {
    CanActivate,
    ExecutionContext,
    Injectable,
    UnauthorizedException,
} from '@nestjs/common';
import { ClerkAuthService } from './clerk.strategy';

@Injectable()
export class ClerkAuthGuard implements CanActivate {
    constructor(private readonly clerkAuthService: ClerkAuthService) { }

    async canActivate(context: ExecutionContext): Promise<boolean> {
        const req = context.switchToHttp().getRequest();

        const authHeader = req.headers['authorization'];

        if (!authHeader || !authHeader.startsWith('Bearer ')) {
            throw new UnauthorizedException('Missing or invalid Authorization header');
        }

        const token = authHeader.split(' ')[1];

        const userId = await this.clerkAuthService.verifyClerkToken(token);

        req.user = { id: userId }; // attach the user info to the request
        return true;
    }
}
  