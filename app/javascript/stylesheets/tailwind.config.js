module.exports = {
  purge: [
    './app/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js'
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontFamily: {
        'great-vibes': ['"Great Vibes"', 'cursive']
      },
      height: {
        xl: '450px',
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}
