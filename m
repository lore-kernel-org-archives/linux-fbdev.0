Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7C30EF86;
	Mon, 17 Aug 2026 06:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786948454; cv=none; b=VCso1KfdcaiMbh3YVAr2oD+JdFHX8Nr0Sw5UA/uwq1ITvnAGJcCGiX7j0kNWdZ65eKSWVNroM3PPPEFnOUXxptwhzGahsnw8pXkQ9SeXAh+S2K/NHPB26p1KcgffZrooOqEs4QQkb5VTfkBX9cg+6kMFVediToJ90eB9dPWqT2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786948454; c=relaxed/simple;
	bh=JmUGL5z3QYSeBaYggYZxygsC53hmDd8zW0/9FEDyPbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y9hNECFNQwHTYwDX1nqPnwIauDTrsFcMTdooIhn8mZ50yeR2hxTgZs4T3MGInKRkqBv6URzVQCPFiPtQLE28jiU/pd+Jf/nHa/Y73BU4KqnaqdEaqKqr+zghpoAM4XT0TqtADO3hfVu1Y/ZJWzThxHvqfmOv26dQIVTOQJm8jWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tIcAnPon; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tI28GBDf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pyWGG0Mr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vJDm+D0M; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tIcAnPon";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tI28GBDf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pyWGG0Mr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vJDm+D0M"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id BC9A083E78;
	Mon, 17 Aug 2026 06:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786948446; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kvzQhZn/pCu/8w/Lod6xQbw+DBDD2ctgEr8Hqm5FR64=;
	b=tIcAnPonf7KsTU4SrDjD7rYPK2Tm/karuY8bqWvYrMhD4dlQNeno0ebKHj0cZXeksTqjKJ
	mfo4hxcZvO5HsbjQAnpZMfIXVldV/BL8MKP1y90Sw/KHD/rUuJUAHFw7q7VT0kiJTQyRaV
	hkkCXHKXU41Qwdf2Z+dUv0VA/yWXN5U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786948446;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kvzQhZn/pCu/8w/Lod6xQbw+DBDD2ctgEr8Hqm5FR64=;
	b=tI28GBDfXKjjrxzW390mc/Uu4BgaMEj5nJqAN0hSaKg5G83nbTuQIaQI0pBYnQpcFa1EY0
	pufgHfvKVF36IoAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pyWGG0Mr;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vJDm+D0M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786948441; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kvzQhZn/pCu/8w/Lod6xQbw+DBDD2ctgEr8Hqm5FR64=;
	b=pyWGG0MrQ5YvhB3qV1oIpfnMha/itxgmmSJnGMmKPm/OcG1fQ682akpvcque7SSsIx6kUf
	TE5leFugCkwRUw+wmzvUKGKgR7TqVuo1KhOlPzKy7Si8zN7NptA5oqg6H/kBlmUQ0+gTFh
	Fvu/TnOP7aj6U3o/pygXwQbn2r7+7j4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786948441;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=kvzQhZn/pCu/8w/Lod6xQbw+DBDD2ctgEr8Hqm5FR64=;
	b=vJDm+D0MTaUJzQ37As3J4LIqNjG3Wcv247cUitYwc6ojj/NFt+PpSLjiqhynsQStLxDCzG
	6VRPDmcjNmbw1lBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 972E279310;
	Mon, 17 Aug 2026 06:34:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mDuoI1mrgmpdFgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Aug 2026 06:34:01 +0000
Message-ID: <a486820d-8500-41b1-bc32-a23d908c9f86@suse.de>
Date: Mon, 17 Aug 2026 08:34:01 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] fbdev: Give atafb proper parent
To: Michael Schmitz <schmitzmic@gmail.com>, linux-m68k@vger.kernel.org,
 geert@linux-m68k.org
Cc: Miro Kropacek <miro.kropacek@gmail.com>, linux-fbdev@vger.kernel.org
References: <20260816073752.16656-1-schmitzmic@gmail.com>
 <20260816073752.16656-3-schmitzmic@gmail.com>
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
In-Reply-To: <20260816073752.16656-3-schmitzmic@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,linux-m68k.org];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:dkim,suse.com:url];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Queue-Id: BC9A083E78
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

Hi

Am 16.08.26 um 09:37 schrieb Michael Schmitz:
> From: Miro Kropacek <miro.kropacek@gmail.com>
>
> The atafb fb device registers no parent, causing a missing symlink
> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
> symlink when scanning for devices, so add a parent node for atafb.

Do you really have these devices to test with?

If so, could you also replace the hard coded fb_info with a call to 
framebuffer_alloc()?

>
> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
> Cc: <linux-fbdev@vger.kernel.org>
> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
> ---
>   drivers/video/fbdev/atafb.c | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
> index b8ed1c537293..3d540803dc2b 100644
> --- a/drivers/video/fbdev/atafb.c
> +++ b/drivers/video/fbdev/atafb.c
> @@ -3101,6 +3101,11 @@ static int __init atafb_probe(struct platform_device *pdev)
>   #endif /* ATAFB_EXT */
>   
>   //	strcpy(fb_info.mode->name, "Atari Builtin ");
> +	/* Parent the fb device properly: without this fb0 registers as a
> +	 * virtual sysfs device with no /sys/class/graphics/fb0/device link,
> +	 * which makes Xorg's fbdevhw reject it ("No devices detected").
> +	 */
> +	fb_info.device = &pdev->dev;

Because this is supposed to happen in framebuffer_alloc() and keeping it 
there would be preferable.

Best regards
Thomas

>   	fb_info.fbops = &atafb_ops;
>   	// try to set default (detected; requested) var
>   	do_fb_set_var(&atafb_predefined[default_par - 1], 1);

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


