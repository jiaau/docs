import { defineConfig, type DefaultTheme } from 'vitepress'

import * as fs from 'fs'
import * as path from 'path'

import { content } from './content'

const navList: string[] = Object.keys(content)

/* navList format:
  ['Guide', 'Deep Learning']
*/

export default defineConfig({
  title: 'whicha',
  base: '/docs/',
  description: 'A Docs Site',
  lang: 'zh-CN',
  head: [
    ['link', { rel: 'icon', type: 'image/x-icon', href: '/docs/favicon.ico' }],
  ],
  themeConfig: {
    nav: navList.map(navItemGenerator),

    sidebar: navList.reduce(sidebarItemGenerator, {}),

    search: {
      provider: 'local',
    },

    socialLinks: [{ icon: 'github', link: 'https://github.com/whicha/docs' }],

    editLink: {
      pattern: 'https://github.com/whicha/docs/edit/main/docs/:path',
      text: 'Edit this page on GitHub',
    },

    footer: {
      message: 'NO LICENSE HERE',
      copyright: `Copyright © 2024-${new Date().getFullYear()} whicha`,
    },

    docFooter: {
      prev: false,
      next: false,
    },

    outline: {
      label: 'In this article',
      level: 'deep',
    },

    lastUpdated: {
      text: 'Last updated:',
      formatOptions: {
        dateStyle: 'short',
        timeStyle: 'medium',
      },
    },
  },
})

function navItemGenerator(navText: string): DefaultTheme.NavItem {
  const navPath = navText.toLowerCase().split(' ').join('-')
  return {
    text: navText,
    link: `/${navPath}/index`,
    activeMatch: `/${navPath}/`,
  }
}

/* navItem format:
   {
      text: 'Guide',
      link: '/guide/index',
      activeMatch: '/guide/',
    },
*/

function sidebarItemGenerator(acc: DefaultTheme.Sidebar, navText: string) {
  const baseDirName = navText.toLowerCase().split(' ').join('-')

  return {
    ...acc,
    [`/${baseDirName}/`]: {
      base: `/${baseDirName}/`,
      items: (function () {
        /* Disable SidebarMulti */
        if (!Array.isArray(content[navText].sidebar)) return []

        const currentDir = __dirname
        // */docs
        const parentDir = path.dirname(currentDir)
        const baseDir = path.join(parentDir, baseDirName)

        return content[navText].sidebar?.map(subSidebar => {
          const subDirName = subSidebar.specifiedDir || subSidebar.text?.toLowerCase().split(' ').join('-') || 'noSuchDir'
          try {
            const subDir = path.join(baseDir, subDirName)

            let files = fs.readdirSync(subDir)
            files = files.filter(file => {
              const filePath = path.join(subDir, file)
              const stats = fs.statSync(filePath)
              return stats.isFile()
            })
            subSidebar.items = files.map(file => {
              const filePath = path.join(subDir, file)

              // 读取文件的前 100 字节（或整个文件如果小于 100 字节）
              const fd = fs.openSync(filePath, 'r')
              const buffer = Buffer.alloc(100)
              const bytesRead = fs.readSync(fd, buffer, 0, 100, 0)
              fs.closeSync(fd)

              // 将 buffer 转换为字符串并获取第一行
              const lines = buffer.toString('utf8', 0, bytesRead)
              const firstLine = lines.split('\n')[0].trim()
              const title = firstLine.slice(firstLine.search(' ') + 1)

              const noFileType = file.slice(0, -3)
              return {
                text: title,
                link: `/${subDirName}/${noFileType}`,
              }
            })
          } catch (err) {
            console.error('Error reading directory:', err)
          }

          return subSidebar
        })
      })(),
    },
  }
}
/* sidebarItem format:
  '/guide/': { 
    base: '/guide/', 
    items: [
    {text: 'Chinese input method, link:'/guide/ubuntu2204-config/chinese-input-method'}
  ]},
*/
