import express from 'express'
import eventosRouter from "./routes/eventosRoutes"
import palestrantesRouter from "./routes/palestrantesRoutes"

const app = express()

app.use(express.json())
app.use("/api/eventos", eventosRouter)
app.use("/api/palestrantes", palestrantesRouter)

app.listen(3000, () => {
    console.log("Servidor rodando na porta 3000")
})    