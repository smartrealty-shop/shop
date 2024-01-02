<script lang="ts">
	import Card from '$lib/components/Card.svelte';

	interface Item {
		title: string;
		text: string;
		iconName?: string | null;
	}

	export let items: Item[];
</script>

<!-- my-10 p-4 xl:p-10 -->
<!-- p-4 lg:p-10 -->
<div class="lg:p-2">
	<div class={'grid gap-4' + (items.length % 2 === 0 ? ' lg:grid-cols-2' : ' lg:grid-cols-3')}>
		{#each items as i}
			<Card title={i.title} text={i.text} iconName={i.iconName} />
		{/each}
	</div>
	<!--  -->
</div>

<style lang="postcss">
	/*  */
</style>
