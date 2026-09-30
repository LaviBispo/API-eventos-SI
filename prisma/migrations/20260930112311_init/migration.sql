-- CreateTable
CREATE TABLE "Eventos" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "local" TEXT NOT NULL,
    "descricao" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Palestrantes" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "nome" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "eventoId" INTEGER NOT NULL,
    CONSTRAINT "Palestrantes_eventoId_fkey" FOREIGN KEY ("eventoId") REFERENCES "Eventos" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "Palestrantes_email_key" ON "Palestrantes"("email");
