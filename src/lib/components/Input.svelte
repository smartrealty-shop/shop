<script lang="ts">
	export let value = '';
	export let placeholder = '';
	export let type = 'text';
	export let id: string | null = null;
	export let label: string | null = null;
	export let disabled = false;
	export let required = false;
</script>

<label class="form-control w-full">
	<div class="label">
		<span class="label-text">{label}</span>
	</div>
	<input
		class="input input-bordered w-full bg-gray-50 text-gray-900"
		{type}
		{placeholder}
		{required}
		{disabled}
		{id}
		name={id}
		{value}
	/>
</label>

<style lang="postcss">
	/*  */
</style>
