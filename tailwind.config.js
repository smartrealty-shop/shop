/** @type {import('tailwindcss').Config} */
export default {
	content: ['./src/**/*.{html,js,svelte,ts}'],
	darkMode: 'class',
	daisyui: {
		themes: [
			{
				smartrealty: {
					primary: 'oklch(58.89% 0.113 268.65)', // #6179C0
					'primary-content': 'oklch(98% 0 0)',
					secondary: 'oklch(47.44% 0.087 259.83)', // #3E5C8D
					accent: '#d95100',
					neutral: 'oklch(99% 0 0)',
					'base-100': '#F1F4F9',
					info: '#00d9ff',
					success: '#008b6e',
					warning: '#a17d00',
					error: '#e2484e',

					'--rounded-box': '1rem', // border radius rounded-box utility class, used in card and other large boxes
					'--rounded-btn': '0.5rem', // border radius rounded-btn utility class, used in buttons and similar element
					'--rounded-badge': '0.4rem', // border radius rounded-badge utility class, used in badges and similar
					'--animation-btn': '0.25s', // duration of animation when you click on button
					'--animation-input': '0.2s', // duration of animation for inputs like checkbox, toggle, radio, etc
					'--btn-focus-scale': '0.95', // scale transform of button when you focus on it
					'--border-btn': '1px', // border width of buttons
					'--tab-border': '1px', // border width of tabs
					'--tab-radius': '0.5rem' // border radius of tabs
				}
			},
			'corporate'
		]
	},
	theme: {
		extend: {}
	},
	plugins: [require('@tailwindcss/typography'), require('@tailwindcss/forms'), require('daisyui')]
};
