import { redirect } from '@sveltejs/kit';
import type { Actions, PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ locals: { getSession, supabase } }) => {
	const session = await getSession();

	// if the user is not logged in return them to home page
	if (!session) {
		throw redirect(303, '/login');
	}

	// TODO: check if user has a subscription
};

export const actions: Actions = {
	signOut: async ({ locals: { supabase } }) => {
		await supabase.auth.signOut();
		throw redirect(303, '/');
	}
};
