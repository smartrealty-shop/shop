<script lang="ts">
	// Component code is from
	// https://github.com/martykuentzel/svelte-tailwind-drawer

	import { createEventDispatcher } from 'svelte';
	import { onMount } from 'svelte';

	const dispatch = createEventDispatcher();
	export let isOpen: boolean;
	// by default drawer opens from right. Change to 'left-0' for left opening
	export let placement: string = 'right-0';
	// max size of content section
	export let maxScreenSize = 'max-w-lg';

	const handleClickAway = () => {
		dispatch('clickAway');
		isOpen = !isOpen;
	};

	let mounted: boolean;
	// scrolllock for content underneath
	function scrollLock(isOpen: boolean) {
		if (mounted) {
			const body = document.querySelector('body');
			body?.style?.setProperty('overflow', isOpen ? 'hidden' : 'auto');
		}
	}
	$: scrollLock(isOpen);

	onMount(() => {
		mounted = true;
		scrollLock(isOpen);
	});
</script>

<aside>
	<div class="fixed inset-0 z-50 h-full w-full overflow-hidden {isOpen ? 'visible' : 'invisible'}">
		<div
			class="bg-neutral h-full w-screen cursor-pointer overflow-hidden transition-opacity duration-500 {isOpen
				? 'opacity-70'
				: 'opacity-0'}"
			on:click={handleClickAway}
		/>
		<div
			class="absolute {placement} top-0 h-full overflow-y-auto bg-base-100 p-4 shadow-xl transition-all duration-300 {maxScreenSize} {isOpen
				? 'w-screen'
				: 'w-0'}"
		>
			<slot />
			<!-- <p class="text-5xl">PIPISA</p> -->
		</div>
	</div>
</aside>

<style lang="postcss">
	/*  */
</style>
