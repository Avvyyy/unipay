# unipay
Unified payment for any purpose


### Scaffolding the backend
- nest new backend 
- npx prisma init
- setup the postrgres server on pgadmin
- setup schema.prisma
- npx prisma migrate dev --name init 
- npx prisma generate
- npx prisma studio [allows me to access prisma stuio on localhost:5555 - GUI]
- create prisma service and export it from prisma module
- nest new clerk-auth
- npm add @clerk/backend @nestjs/config @nestjs/passport passport passport-custom




### Scaffolding the frontend
- npm create nuxt frontend or npx nuxi init
- npm install @nuxt/ui
- npx nuxi@latest module add google-fonts
- npm install @nuxtjs/color-mode [allows toggling between light and dark mode]
