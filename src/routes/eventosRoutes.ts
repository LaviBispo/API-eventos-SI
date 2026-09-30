import { Router, Request, Response } from "express";
import prisma from "../prismaClient";

const router = Router()

router.post("/", async (req: Request, res: Response) => {
    const {name, descricao, local, palestranteId } = req.body;

    if (!name || !descricao || !local || !palestranteId) {
        return res.status(400).json({ error: "Todos os campos são obrigatórios para o cadastro" });
    }

    const eventos = await prisma.eventos.create({
        data: {
            name,
            descricao,
            local,
            palestrante: {
                connect: { id: Number(palestranteId) }
        }
        },
        include: {
            palestrante: true
        }
    })

    return res.status(201).json(eventos)

})

router.get("/", async (req: Request, res: Response) => {
    try{
        const eventos = await (await prisma.eventos.findMany({
            include: {
                palestrante: true
            }
        }))
        res.json(eventos)
    } catch (error) {
        res.status(500).json({error: "Erro interno no servidor"})
    }
})

router.get("/:id", async (req: Request, res: Response) => {
    try{
        const eventos = await prisma.eventos.findUnique({
            where: {id: Number(req.params.id)}
        })

        if(!eventos) {
            return res.status(404).json({error: " Evento não encontrado"})
        }

        res.json(eventos)
    } catch (error) {
        res.status(500).json({error: "Erro interno no servidor"})
    }
})

router.put("/:id", async (req: Request, res: Response) => {
    try{
        const {name, descricao, palestranteId, palestrante, local} = req.body

        const eventos = await prisma.eventos.update({
            where: {id: Number(req.params.id)},
            data: {name, descricao, palestranteId, palestrante, local}
        })


        res.json(eventos)
    } catch (error) {
        console.log(error)
        res.status(500).json({error: "Erro interno no servidor"})
    }
})

router.delete("/:id", async (req: Request, res:Response) => {
    try {
        await prisma.eventos.delete({
            where: {id: Number(req.params.id)}
        })
        return res.status(204).send()
    } catch (error) {
         res.status(500).json({error: "Erro interno do servidor"})
    }
})


export default router