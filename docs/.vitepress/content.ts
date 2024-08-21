import { type DefaultTheme } from 'vitepress'

type contentObject = Record<
  string,
  {
    sidebar?: DefaultTheme.Sidebar
  }
>

export const content: contentObject = {
  ['Guide']: {
    sidebar: [
      {
        text: 'Ubuntu',
        collapsed: false,
        items: [
          {
            text: 'Install Ubuntu alongside Windows 10 (Dual Boot)',
            link: 'dual-system-installation',
          },
          {
            text: 'Quickstart with Ubuntu 22.04 Desktop',
            link: 'quickstart-with-ubuntu',
          },
        ],
      },
      {
        text: 'Windows',
        collapsed: false,
        items: [
          {
            text: 'Quickstart with Windows 10',
            link: 'quickstart-with-windows',
          },
        ],
      },
      {
        text: 'Writer',
        collapsed: false,
        items: [
          {
            text: 'VSCode + TexLive in Ubuntu2204 installed by WSL2',
            link: 'vscode-texlive-wsl2',
          },
        ],
      },
      {
        text: 'Basic Skills',
        collapsed: false,
        items: [{ text: 'Docker Notes', link: 'docker-notes' }],
      },
    ],
  },
  ['Deep Learning']: {},
}
