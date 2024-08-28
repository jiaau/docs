import { type DefaultTheme } from 'vitepress'

type ExtendedSidebarItem = DefaultTheme.SidebarItem & {
  /**
   * Specified directory for the item.
   */
  specifiedDir?: string
}

type contentObject = Record<
  string,
  {
    sidebar?: ExtendedSidebarItem[]
  }
>

export const content: contentObject = {
  ['Guide']: {
    sidebar: [
      {
        text: 'Platform Setup',
        collapsed: false,
      },
      {
        text: 'Basic Skills',
        collapsed: false,
      },
      {
        text: 'Writer',
        collapsed: false,
      },
    ],
  },
  ['Deep Learning']: {
    sidebar: [
      {
        text: '【李宏毅】Machine Learning 2022 Spring',
        specifiedDir: 'lhy',
        collapsed: false,
      },
    ],
  },
  ['Programming Languages']: {
    sidebar: [
      {
        text: 'C++',
        specifiedDir: 'cpp',
        collapsed: false,
      },
      {
        text: 'Python',
        collapsed: false,
      },
      {
        text: 'TypeScript && JavaScript',
        specifiedDir: 'ts-js',
        collapsed: false,
      },
    ],
  }
}
