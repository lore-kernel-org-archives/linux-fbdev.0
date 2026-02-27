Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3927449EDD
	for <linux-fbdev@vger.kernel.org>; Fri, 27 Feb 2026 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207775; cv=none; b=oKxRucLOLQsJDLfHux4JGFIwoNkBPbkLCdo4lAmXU1+GNx0bFGu8gNhy97RAdWMtzSRip48xcoIqzC9o2ChaoTPgrpLSMmVm0FY/wkBL7PTGJfeS6lZZslRnINlypFChpv0KZ2aDpa5502zYzUswB+H63FYgJL0FsvYqrHI7bZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207775; c=relaxed/simple;
	bh=p4b4us+S6KE3Kh8fRMmExHp3mfUJ7/SYMFbk61mpEww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GAM/Ys3/B8qBxQw2JahLDBseLScjuop2/s3UJWT4Inu7AmloX1hK5E7N+raS7vKmjLJQcTqSytY2XzrVOl2dmmHL8fnR1v7PvZQzqZCBI8iGPsmAabLNQTV/57HJQ2IBqY9Kr4qMVQKcIeUShM9GQWinYui+mqfq6qZyIYi4Tdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p2IKGVxw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5kAfa51R; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=p2IKGVxw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5kAfa51R; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p2IKGVxw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5kAfa51R";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p2IKGVxw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5kAfa51R"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 80F884DEF0;
	Fri, 27 Feb 2026 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772207768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/AQ0zUlvp2RNrM3N1mdRZl2bYkCvuzp+Mgnn8EwUIX8=;
	b=p2IKGVxwVmMUOVAp4QeQftFbXRy2WfUDTPVLZEFy57k1Nxg1rEq+ikicThH3quhuX8edmS
	r+HEyXAQLkcfSD8aS8f1HASHD9GoUwnaHbYSHHKAtGyjCfYzrMJPsTvGQvTf+h2cOyGnz2
	ZtPfYsat6ltFcIuZgB+9QSck+LfdY3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772207768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/AQ0zUlvp2RNrM3N1mdRZl2bYkCvuzp+Mgnn8EwUIX8=;
	b=5kAfa51RXRVcGAamNcljhLnSLWpzvHdnE8hkJcSLMRj5q4G8q1PQq/UvKCefqnh9Jpt/zt
	Zo4uU7aEVbmUT4AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=p2IKGVxw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5kAfa51R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772207768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/AQ0zUlvp2RNrM3N1mdRZl2bYkCvuzp+Mgnn8EwUIX8=;
	b=p2IKGVxwVmMUOVAp4QeQftFbXRy2WfUDTPVLZEFy57k1Nxg1rEq+ikicThH3quhuX8edmS
	r+HEyXAQLkcfSD8aS8f1HASHD9GoUwnaHbYSHHKAtGyjCfYzrMJPsTvGQvTf+h2cOyGnz2
	ZtPfYsat6ltFcIuZgB+9QSck+LfdY3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772207768;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=/AQ0zUlvp2RNrM3N1mdRZl2bYkCvuzp+Mgnn8EwUIX8=;
	b=5kAfa51RXRVcGAamNcljhLnSLWpzvHdnE8hkJcSLMRj5q4G8q1PQq/UvKCefqnh9Jpt/zt
	Zo4uU7aEVbmUT4AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 55DD83EA69;
	Fri, 27 Feb 2026 15:56:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZPCFE5i+oWnVRQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 27 Feb 2026 15:56:08 +0000
Message-ID: <bc9a37ac-43d2-451b-81b7-e0b23827006f@suse.de>
Date: Fri, 27 Feb 2026 16:56:07 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
To: Chen Jun <chenjun102@huawei.com>, simona@ffwll.ch, deller@gmx.de,
 linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: linruifeng4@huawei.com
References: <20260227144358.101173-1-chenjun102@huawei.com>
Content-Language: en-US
From: Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 xsBNBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAHNJ1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPsLAjgQTAQgAOAIb
 AwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftODH
 AAoJEGgNwR1TC3ojx1wH/0hKGWugiqDgLNXLRD/4TfHBEKmxIrmfu9Z5t7vwUKfwhFL6hqvo
 lXPJJKQpQ2z8+X2vZm/slsLn7J1yjrOsoJhKABDi+3QWWSGkaGwRJAdPVVyJMfJRNNNIKwVb
 U6B1BkX2XDKDGffF4TxlOpSQzdtNI/9gleOoUA8+jy8knnDYzjBNOZqLG2FuTdicBXblz0Mf
 vg41gd9kCwYXDnD91rJU8tzylXv03E75NCaTxTM+FBXPmsAVYQ4GYhhgFt8S2UWMoaaABLDe
 7l5FdnLdDEcbmd8uLU2CaG4W2cLrUaI4jz2XbkcPQkqTQ3EB67hYkjiEE6Zy3ggOitiQGcqp
 j//OwE0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRHUE9eosYb
 T6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgTRjP+qbU6
 3Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+RdhgATnWW
 GKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zbehDda8lv
 hFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r12+lqdsA
 EQEAAcLAdgQYAQgAIAIbDBYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJftOH6AAoJEGgNwR1T
 C3ojVSkIALpAPkIJPQoURPb1VWjh34l0HlglmYHvZszJWTXYwavHR8+k6Baa6H7ufXNQtThR
 yIxJrQLW6rV5lm7TjhffEhxVCn37+cg0zZ3j7zIsSS0rx/aMwi6VhFJA5hfn3T0TtrijKP4A
 SAQO9xD1Zk9/61JWk8OysuIh7MXkl0fxbRKWE93XeQBhIJHQfnc+YBLprdnxR446Sh8Wn/2D
 Ya8cavuWf2zrB6cZurs048xe0UbSW5AOSo4V9M0jzYI4nZqTmPxYyXbm30Kvmz0rYVRaitYJ
 4kyYYMhuULvrJDMjZRvaNe52tkKAvMevcGdt38H4KSVXAylqyQOW5zvPc4/sq9c=
In-Reply-To: <20260227144358.101173-1-chenjun102@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[huawei.com,ffwll.ch,gmx.de,vger.kernel.org];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 80F884DEF0

Hi,

thanks for the patch.

Am 27.02.26 um 15:43 schrieb Chen Jun:
> When a font is set on an invisible console, the screen will not update.
> However, the fontbuffer is not updated to match the new font dimensions.

I looked through vc_resize() but cannot quite find the logic that calls 
fbcon_rotate_font(). Can you please point to correct place?

Best regards
Thomas

>
> This inconsistency leads to out-of-bounds memory access when writing to
> the tty bound to fbcon, as demonstrated by the following KASAN report:
>
> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140
> Read of size 1 at addr ffff8881195a2280 by task a.out/971
> Call Trace:
>   <TASK>
>   fb_pad_aligned_buffer+0xdf/0x140
>   ud_putcs+0x88a/0xde0
>   fbcon_putcs+0x319/0x430
>   do_update_region+0x23c/0x3b0
>   do_con_write+0x225c/0x67f0
>   con_write+0xe/0x30
>   n_tty_write+0x4b5/0xff0
>   file_tty_write.isra.41+0x46c/0x880
>   vfs_write+0x868/0xd60
>   ksys_write+0xf2/0x1d0
>   do_syscall_64+0xfa/0x570
>
> Fix this by calling fbcon_rotate_font() if vc is invisible in
> fbcon_do_set_font().
>
> Signed-off-by: Chen Jun <chenjun102@huawei.com>
> ---
>   drivers/video/fbdev/core/fbcon.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 666261ae59d8..d76100188bee 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2444,6 +2444,11 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>   		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
>   		cols /= w;
>   		rows /= h;
> +		if (!con_is_visible(vc)) {
> +			ret = fbcon_rotate_font(info, vc);
> +			if (ret)
> +				goto err_out;
> +		}
>   		ret = vc_resize(vc, cols, rows);
>   		if (ret)
>   			goto err_out;

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


