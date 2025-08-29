import express, { Express, NextFunction, Request, Response } from 'express'
import { routes } from './routes/routes'
import morgan from 'morgan'
import fs from 'fs'
import path from 'path'

const app: Express = express()

const filelog  =fs.createWriteStream(path.join(__dirname, 'storage', 'access.log'), { flags: 'a'})

app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.use(morgan('combined', {stream: filelog}))

//configuração das rotas
app.use(routes)

//tentativa de erro
app.use((err: any, req: Request, res: Response, next: NextFunction) => {
    if(err){
        return res.status(400).json({
            msg: 'Ocorreu um problema!',
            error: err.message
        })
    }
    next()
})

export { app }