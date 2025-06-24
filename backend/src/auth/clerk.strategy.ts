// src/auth/clerk.strategy.ts
import { Injectable, UnauthorizedException } from '@nestjs/common';
import { verifyToken } from '@clerk/backend';

@Injectable()
export class ClerkAuthService {
    async verifyClerkToken(token: string) {
        try {
            const { payload } = await verifyToken(token, {
                secretKey: process.env.CLERK_SECRET_KEY,
            });

            return payload.sub; // the Clerk user ID
        } catch (error) {
            throw new UnauthorizedException('Invalid token');
        }
    }
}
