import { error, redirect } from '@sveltejs/kit';
import type { EmailOtpType } from '@supabase/supabase-js';

const emailOtpTypes = ['signup', 'invite', 'magiclink', 'recovery', 'email_change', 'email'];
const isEmailOtpType = (type: string): type is EmailOtpType => emailOtpTypes.includes(type);

// export const GET = async (event) => {
export const GET = async ({ url, locals: { supabase } }) => {
	// const {
	// 	url,
	// 	locals: { supabase }
	// } = event;

	const token_hash = url.searchParams.get('token_hash');
	const type = url.searchParams.get('type');
	const next = url.searchParams.get('next') ?? '/profile';
	console.log(JSON.stringify(url));

	if (
		typeof token_hash !== 'string' ||
		typeof type !== 'string' ||
		typeof next !== 'string' ||
		!isEmailOtpType(type)
	) {
		throw error(400, 'Invalid parameters given');
	}

	if (token_hash && type) {
		const { error } = await supabase.auth.verifyOtp({ token_hash, type });
		console.error(error);
		if (!error) {
			throw redirect(303, `${next.slice(1)}`);
		}
	}

	throw error(400, 'Something went wrong validating your credentials');
};
