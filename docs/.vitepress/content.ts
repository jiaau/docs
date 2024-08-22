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
      },
      {
        text: 'Windows',
        collapsed: false,
      },
      {
        text: 'Writer',
        collapsed: false,
      },
      {
        text: 'Basic Skills',
        collapsed: false,
      },
    ],
  },
  ['Deep Learning']: {
    sidebar: [
      {
        text: 'LHY',
        collapsed: false,
      },
    ],
  },
}
