Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E65B2F5A0E
	for <linux-fbdev@vger.kernel.org>; Tue,  9 Jun 2026 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780985814; cv=none; b=sqCMurREzO+bd30nBPCBQlSIc8e7mFWTumOQVhdP2QPwbTxR3+FHnDtZVQ4yLBzopapqwdwlyAMEw7ClvZ1G6EJ3xcHgosL3Fl1Fyth1DQF3UiskHI7pVE+t+7j1nEb7ZBgYo9BrARMKypFctnB3r9FXU40Qtsz6aNFw/fyI9lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780985814; c=relaxed/simple;
	bh=n91LapINfjma9uc2SSZ4n17CalVS06NAo9fkyMkJ/aI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=omLNeJfJp8llm5jJfwZdBKmRluX+gB/5uIviCFRpydZ51xgAJldNbAeJKLNVcti4q2noMZRhoRPkiTcz0SBP9ziunWxpEaZxQB4QabgD3LNPKd4cjLPeYf2fTJP+e1JSluPdErTvsBAwpIrpg0piem/YKoaofm4GYBJ9ZPbn3RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=n7cnPKKi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xFNacBBQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TxTkGiCI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=sXzA9dp2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="n7cnPKKi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xFNacBBQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TxTkGiCI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="sXzA9dp2"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8DA0E6A7FD;
	Tue,  9 Jun 2026 06:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780985811; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4EkHWkZfCXFhZ8jvbkcSnmrQcELJaziDMqkg4fgZ3E=;
	b=n7cnPKKi3kVEx39mHk1yfn7wxO/owQ/6Ex3a9zPgaWOuYyxiRPc0t31jOi/cQw+2W7S0wx
	Y3lpMYEUMmC3hBNm68ulRNaHsC42DTHw4gn2gDC3ot2hZf4el8V+vPjd7EzhfvpsvvZv3Y
	qGOklIwOSc0zqz9dGvnfe6syic3GGEw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780985811;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4EkHWkZfCXFhZ8jvbkcSnmrQcELJaziDMqkg4fgZ3E=;
	b=xFNacBBQs6QLrkPfYtphcPGq/h8Layn/ck651UPiD6s48vVZYnxfCTEGgyTAwwzVE9LHZ5
	fe8vYs7+whM942CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780985810; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4EkHWkZfCXFhZ8jvbkcSnmrQcELJaziDMqkg4fgZ3E=;
	b=TxTkGiCIlxtrlx6XixF5HtMwZllt89+zxzXDvtbZvtpzy+ZhiGlGEaFGR4K+vJrxkurvdB
	17ousbm0bD58R725sYzNIUu63VaUNKeeSrlgck4rNFJ/+0uRPL8jXnkWuRgw3asRC/LpJ4
	1uR0WVCos5ncu8dAtan1zbHv12sj+y8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780985810;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Q4EkHWkZfCXFhZ8jvbkcSnmrQcELJaziDMqkg4fgZ3E=;
	b=sXzA9dp2PHvgH6Lpra6q00F/N2Ns7Q1xPS6+fLEOx66KFOjNjDp6GKfKKGekBxnJ5ERJxT
	/aCTVneROcA5RaBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CAD3779A7;
	Tue,  9 Jun 2026 06:16:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id KkJCGdKvJ2oqWAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 09 Jun 2026 06:16:50 +0000
Message-ID: <64b807ea-649c-4ee6-9db4-631e310465ff@suse.de>
Date: Tue, 9 Jun 2026 08:16:49 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbcon: correct CONFIG_FB_TILEBLITTING macro name in
 #endif comment
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>, linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>, Simona Vetter <simona@ffwll.ch>
References: <20260609033503.23428-1-enelsonmoore@gmail.com>
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
In-Reply-To: <20260609033503.23428-1-enelsonmoore@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,ffwll.ch];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid,suse.com:url]
X-Spam-Level: 



Am 09.06.26 um 05:35 schrieb Ethan Nelson-Moore:
> A comment in drivers/video/fbdev/core/fbcon.c incorrectly refers to
> CONFIG_MISC_TILEBLITTING instead of CONFIG_FB_TILEBLITTING. Correct it.
>
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/core/fbcon.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index b0e3e765360d..07eab2729895 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -769,7 +769,7 @@ static int fbcon_invalid_charcount(struct fb_info *info, unsigned charcount)
>   	return 0;
>   }
>   
> -#endif /* CONFIG_MISC_TILEBLITTING */
> +#endif /* CONFIG_FB_TILEBLITTING */
>   
>   static void fbcon_release(struct fb_info *info)
>   {

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


