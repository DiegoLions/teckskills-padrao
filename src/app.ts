import express, { Express, NextFunction, Request, Response } from 'express'
import { routes } from './routes/routes'

import { log } from './middleware/log.middleware';
import { errorHandling } from './middleware/error_handling.middleware';

const app: Express = express()

app.use(express.json())
app.use(express.urlencoded({extended: true}))

app.use(log)

//configuração das rotas
app.use(routes)

//tentativa de erro
app.use(errorHandling);
// 

// (err: any, req: Request, res: Response, next: NextFunction) => {
// //     if(err){
// //         return res.status(400).json({
// //             msg: 'Ocorreu um problema!',
// //             error: err.message
// //         })
// //     }
// //     next()
// // })

export { app }