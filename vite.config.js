import { defineConfig } from 'vite'
import { existsSync } from 'node:fs'
import { resolve } from 'node:path'

function trailingSlashRedirect() {
  return {
    name: 'trailing-slash-redirect',
    configureServer(server) {
      server.middlewares.use((req, res, next) => {
        const url = req.url?.split('?')[0]
        if (url && !url.endsWith('/') && !url.includes('.')) {
          const htmlPath = resolve(server.config.root, `.${url}/index.html`)
          if (existsSync(htmlPath)) {
            res.writeHead(301, { Location: `${url}/` })
            res.end()
            return
          }
        }
        next()
      })
    },
  }
}

export default defineConfig({
  appType: 'mpa',
  plugins: [trailingSlashRedirect()],
})
