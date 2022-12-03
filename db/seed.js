import { PrismaClient } from "@prisma/client";

const prisma = new PrismaClient();

const main = async () => {
  const spongeBob = await prisma.user.upsert({
    create: {
      email: "spongebob@email.com",
      name: "Sponge Bob",
      ownChannels: {
        create: [
          {
            name: "Channel #1",
          },
        ],
      },
      password: "Qwer1234)",
    },
    include: { ownChannels: true },
    update: {},
    where: {
      email: "spongebob@email.com",
    },
  });

  const patrickStar = await prisma.user.upsert({
    create: {
      email: "patrickstar@email.com",
      name: "Patrick Star",
      password: "Qwer1234)",
    },
    update: {},
    where: {
      email: "patrickstar@email.com",
    },
  });

  const spongeBobChannelId = spongeBob.ownChannels[0].id;

  await prisma.channel.update({
    data: {
      users: {
        connect: [
          {
            channelId_userId: {
              channelId: spongeBobChannelId,
              userId: patrickStar.id,
            },
          },
          {
            channelId_userId: {
              channelId: spongeBobChannelId,
              userId: spongeBob.id,
            },
          },
        ],
      },
    },
    where: { id: spongeBob.ownChannels[0].id },
  });

  const channel = await prisma.channel.findFirst({
    include: { users: true },
    where: { ownerId: spongeBob.id },
  });

  console.log({ spongeBob, patrickStar, channel });
};

main()
  .then(async () => {
    await prisma.$disconnect();
  })
  .catch(async (e) => {
    console.error("Seed db error", e);
    await prisma.$disconnect();
    process.exit(1);
  });
