-- CreateTable
CREATE TABLE "Area" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,
    "ownerId" BIGINT NOT NULL,

    CONSTRAINT "pkArea" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AreaUser" (
    "areaId" BIGINT NOT NULL,
    "userId" BIGINT NOT NULL,

    CONSTRAINT "pkAreaUser" PRIMARY KEY ("areaId","userId")
);

-- CreateTable
CREATE TABLE "Message" (
    "areaId" BIGINT NOT NULL,
    "fromId" BIGINT NOT NULL,
    "id" BIGSERIAL NOT NULL,
    "text" VARCHAR NOT NULL,

    CONSTRAINT "pkMessage" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Role" (
    "id" BIGSERIAL NOT NULL,
    "name" VARCHAR NOT NULL,

    CONSTRAINT "pkRole" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Session" (
    "sessionId" BIGSERIAL NOT NULL,
    "userId" BIGINT NOT NULL,
    "token" VARCHAR NOT NULL,
    "ip" INET NOT NULL,
    "data" JSONB NOT NULL,

    CONSTRAINT "pkSession" PRIMARY KEY ("sessionId")
);

-- CreateTable
CREATE TABLE "User" (
    "id" BIGSERIAL NOT NULL,
    "login" VARCHAR(64) NOT NULL,
    "password" VARCHAR NOT NULL,

    CONSTRAINT "pkUser" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "UserRole" (
    "roleId" BIGINT NOT NULL,
    "userId" BIGINT NOT NULL,

    CONSTRAINT "pkUserRole" PRIMARY KEY ("userId","roleId")
);

-- CreateIndex
CREATE UNIQUE INDEX "akAreaName" ON "Area"("name");

-- CreateIndex
CREATE UNIQUE INDEX "akRoleName" ON "Role"("name");

-- CreateIndex
CREATE UNIQUE INDEX "akSessionToken" ON "Session"("token");

-- CreateIndex
CREATE UNIQUE INDEX "akUserLogin" ON "User"("login");

-- AddForeignKey
ALTER TABLE "Area" ADD CONSTRAINT "fkAreaOwner" FOREIGN KEY ("ownerId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "AreaUser" ADD CONSTRAINT "fkAreaUserArea" FOREIGN KEY ("areaId") REFERENCES "Area"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "AreaUser" ADD CONSTRAINT "fkAreaUserUser" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "fkMessageArea" FOREIGN KEY ("areaId") REFERENCES "Area"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Message" ADD CONSTRAINT "fkMessageFrom" FOREIGN KEY ("fromId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "fkSessionAccount" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "UserRole" ADD CONSTRAINT "fkUserRoleRole" FOREIGN KEY ("roleId") REFERENCES "Role"("id") ON DELETE CASCADE ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "UserRole" ADD CONSTRAINT "fkUserRoleUser" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE NO ACTION;
