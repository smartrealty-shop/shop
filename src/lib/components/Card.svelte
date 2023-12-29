<script lang="ts">
	import Icon from '@iconify/svelte';

	export let title = '';
	export let text = '';
	export let iconName: string | null = null;
</script>

<div class="card card-compact card-side bg-neutral shadow-lg">
	{#if iconName !== null}
		<figure class="px-6">
			<div class="btn btn-circle btn-secondary">
				<Icon icon={iconName} width="24" height="24" />
				<!-- <div class="rounded bg-base-200 object-cover w-24">
			</div> -->
			</div>
		</figure>
	{/if}
	<div class="card-body px-2">
		<h2 class="card-title">{title}</h2>
		<p>{text}</p>
	</div>
</div>

<style lang="postcss">
	/*  */
</style>
