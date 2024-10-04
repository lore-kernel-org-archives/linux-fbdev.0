Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE015748E;
	Fri,  4 Oct 2024 14:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050568; cv=none; b=dJKFGI4usTeSAbGzfo2k2HQ8KGfZeswRFt1DUMGacgbfwNkNUZy4DCCt4N0Ok/6oxJqeITabBnsZ6y4/Cu/xQGWPFgghZd/v0tCcy16/cUCkN4M2RcE2RyNhp+cUjiMwTMAQAHsqI952sQ7Y1iIr7JXmRk+VElv0qXHl++sUqjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050568; c=relaxed/simple;
	bh=Foo2ekqWaWWi28wmA/yN6/45dO3dfNCZnOQEmUN4X18=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N2tCsIxT06Pn+erifcw/+VzDVtE1bw7cVp1LAPEt1tOT54wbGrrqwyM+M+m5ZmJ/0Moi2gle2AcC3dw6OHjmjIWwMuVYNfcrz5YnUG4+BTjudSkoXKI+xkIUNoJbRbLHCsB3E+twIeqv87PAPjyOLsdSjvayirY7yUHHjQs3/OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zq6kmT7f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+7PlV7z3; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=zq6kmT7f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+7PlV7z3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zq6kmT7f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+7PlV7z3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zq6kmT7f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+7PlV7z3"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7381821CA8;
	Fri,  4 Oct 2024 14:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728050562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gqObr0AigrA7ZpSBRTkZlMkVnj4cssT1fvsbDoNXTBA=;
	b=zq6kmT7fngtRfjgf9qUkwTesO8WgncvKkraHd2d8ezCwKqSdaxEFtwIKIxNP+Nmv4s6o+1
	qbJo/d8FsMqk/NshOosnwiNswVOBsRux5Nu135oArTM0eucWh10iF7ptbGgK4Me5qcRkWz
	trMj+a848KoRwX8ptLOvoD2Vl4kXsoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728050562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gqObr0AigrA7ZpSBRTkZlMkVnj4cssT1fvsbDoNXTBA=;
	b=+7PlV7z3ZLT73G0jZTspuxXdOAmuf2J5/0vMiX54e6PEESOg69lWqzIccWfLZUbW781hyb
	B+nN77x3oiYupTCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zq6kmT7f;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=+7PlV7z3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1728050562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gqObr0AigrA7ZpSBRTkZlMkVnj4cssT1fvsbDoNXTBA=;
	b=zq6kmT7fngtRfjgf9qUkwTesO8WgncvKkraHd2d8ezCwKqSdaxEFtwIKIxNP+Nmv4s6o+1
	qbJo/d8FsMqk/NshOosnwiNswVOBsRux5Nu135oArTM0eucWh10iF7ptbGgK4Me5qcRkWz
	trMj+a848KoRwX8ptLOvoD2Vl4kXsoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1728050562;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=gqObr0AigrA7ZpSBRTkZlMkVnj4cssT1fvsbDoNXTBA=;
	b=+7PlV7z3ZLT73G0jZTspuxXdOAmuf2J5/0vMiX54e6PEESOg69lWqzIccWfLZUbW781hyb
	B+nN77x3oiYupTCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4962313A6E;
	Fri,  4 Oct 2024 14:02:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eC2iEIL1/2ZxYAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 04 Oct 2024 14:02:42 +0000
Message-ID: <713a42f1-83d0-4d20-96f0-db9815313205@suse.de>
Date: Fri, 4 Oct 2024 16:02:41 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: clps711x-fb: Remove dead code
To: Qianqiang Liu <qianqiang.liu@163.com>, deller@gmx.de
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241004014349.435006-1-qianqiang.liu@163.com>
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
In-Reply-To: <20241004014349.435006-1-qianqiang.liu@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7381821CA8
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[163.com,gmx.de];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmx.de];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 04.10.24 um 03:43 schrieb Qianqiang Liu:
> The code can never be reached: unregister_framebuffer(info);
>
> Fixes: 36462ac19308 ("fbdev: clps711x-fb: Replace check_fb in favor of struct fb_info.lcd_dev")
> Signed-off-by: Qianqiang Liu <qianqiang.liu@163.com>

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/clps711x-fb.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/clps711x-fb.c b/drivers/video/fbdev/clps711x-fb.c
> index 9e3df1df5ac4..b57134bc63e7 100644
> --- a/drivers/video/fbdev/clps711x-fb.c
> +++ b/drivers/video/fbdev/clps711x-fb.c
> @@ -332,8 +332,6 @@ static int clps711x_fb_probe(struct platform_device *pdev)
>   
>   	return 0;
>   
> -	unregister_framebuffer(info);
> -

This used to be code for error rollback, but is now unused. Thanks for 
fixing the issue.

Best regards
Thomas

>   out_fb_dealloc_cmap:
>   	regmap_update_bits(cfb->syscon, SYSCON_OFFSET, SYSCON1_LCDEN, 0);
>   	fb_dealloc_cmap(&info->cmap);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

