module.exports = {
  content: [
    './app/views/**/*.{html,html.erb,erb}',
    './app/helpers/**/*.rb',
    './app/assets/stylesheets/**/*.{css,scss}',
    './app/javascript/**/*.{js,jsx,ts,tsx}',
    './node_modules/flowbite/**/*.js'
  ],
  theme: {
    extend: {},
  },
  plugins: [
    require('flowbite/plugin')
  ],
  safelist: [
    {
      pattern: /shadow-.+/,
    },
    {
      pattern: /bg-gradient-.+/,
    },
    {
      pattern: /from-.+/,
    },
    {
      pattern: /via-.+/,
    },
    {
      pattern: /to-.+/,
    },
    {
      pattern: /ring-.+/,
    }
  ]
}