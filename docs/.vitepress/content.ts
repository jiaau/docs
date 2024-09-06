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
      {
        text: 'Tools',
        collapsed: false,
      },
    ],
  },
}
