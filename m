Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FC635FF62
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 11:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770031945; cv=none; b=ePcPnRFe0MEIn97iBORAuxMum9ZTYi9+u3FB1SpX05HDvXOcuehvALbMEuDP5vVs91Y3CdKjkvrY1Lax7afNTTjparWv9QbsH7iJ5YbCtgGLsGf1JwrLuXlsu+4E9svkGWvrJqwIhblNctXrLLAmZ1I0ExVjzUgRwudJDJO5Iqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770031945; c=relaxed/simple;
	bh=mUCrAZqcinKH9QJjA9Kg0MyLFK5ptvtxp6gfS4/oiGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RVeoS2e8jX59Wz/lJ/5u6fRJIg1CLCaL2rHwz/Ir6mjJkjxChrMk3joRrmG8icyMxtG6iGQkCwWkVAAbJlYG4ns9aOhmBSVKR11chvhsELKuSEj3J81LKYHh6LzbJudwy7bWBchro6geSmurckQwtCPbI4pF+1/+lGZbn+cAwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mlb+GwAY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mYbf+iLI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=mlb+GwAY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mYbf+iLI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mlb+GwAY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mYbf+iLI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="mlb+GwAY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mYbf+iLI"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 98E713E719;
	Mon,  2 Feb 2026 11:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770031941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AjFFbuCMGX4c6rpQG5b6UggcvLc5Zw7pkhwvyzOLCx8=;
	b=mlb+GwAYIfG8OkWc/NUaWgrG1ReRBUtc+W26HHAIp9wKx65IlyRDp4kD04mJGvX3YXXhQJ
	uhVssVGawavfBDD5m0SSV3ZFFoQmlveUwCBuJwjEQy4TGcBnZ2gSXmCdtvQ8bZ3eWmbqWG
	Dcob+1bcZfT/kmU/y5cYSraAL90+qqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770031941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AjFFbuCMGX4c6rpQG5b6UggcvLc5Zw7pkhwvyzOLCx8=;
	b=mYbf+iLIR3FeSWDgsDvDwEGsXsMJJRVY3yUuQ2KR4KAFsM3KIWc6wFuNIWmu8JRyiRE5Ms
	xOIw1whhh5NTpbAA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=mlb+GwAY;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mYbf+iLI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770031941; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AjFFbuCMGX4c6rpQG5b6UggcvLc5Zw7pkhwvyzOLCx8=;
	b=mlb+GwAYIfG8OkWc/NUaWgrG1ReRBUtc+W26HHAIp9wKx65IlyRDp4kD04mJGvX3YXXhQJ
	uhVssVGawavfBDD5m0SSV3ZFFoQmlveUwCBuJwjEQy4TGcBnZ2gSXmCdtvQ8bZ3eWmbqWG
	Dcob+1bcZfT/kmU/y5cYSraAL90+qqA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770031941;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=AjFFbuCMGX4c6rpQG5b6UggcvLc5Zw7pkhwvyzOLCx8=;
	b=mYbf+iLIR3FeSWDgsDvDwEGsXsMJJRVY3yUuQ2KR4KAFsM3KIWc6wFuNIWmu8JRyiRE5Ms
	xOIw1whhh5NTpbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E62A3EA62;
	Mon,  2 Feb 2026 11:32:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /2UKBkWLgGnrZAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Feb 2026 11:32:21 +0000
Message-ID: <6580aa60-5f9d-49c7-8482-83bed12dfb0c@suse.de>
Date: Mon, 2 Feb 2026 12:32:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: fbtft: fix dev_info() device arguments
To: Arnd Bergmann <arnd@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Noralf Tronnes <notro@tronnes.org>, Helge Deller <deller@gmx.de>,
 Chintan Patel <chintanlike@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Abdun Nihaal <abdun.nihaal@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jianglei Nie <niejianglei2021@163.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260202095743.1309162-1-arnd@kernel.org>
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
In-Reply-To: <20260202095743.1309162-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[kernel.org,linuxfoundation.org,free-electrons.com,tronnes.org,gmx.de,gmail.com];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,linaro.org,infradead.org,163.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,arndb.de:email,suse.com:url]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 98E713E719
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

Hi,

there's already

https://patchwork.freedesktop.org/series/160468/

which no one picked up yet. This needs to go into the fbdev tree, but I 
can also take into drm-misc-fixes.


Am 02.02.26 um 10:57 schrieb Arnd Bergmann:
> From: Arnd Bergmann <arnd@arndb.de>
>
> When CONFIG_FB_DEVICE is disabled, the fbtft driver fails to
> build with:
>
> In file included from include/linux/device.h:15,
>                   from drivers/staging/fbtft/fbtft-core.c:18:
> drivers/staging/fbtft/fbtft-core.c: In function 'fbtft_fb_setcolreg':
> drivers/staging/fbtft/fbtft-core.c:368:21: error: 'struct fb_info' has no member named 'dev'
>    368 |         dev_dbg(info->dev,
> drivers/staging/fbtft/fbtft-core.c:394:21: error: 'struct fb_info' has no member named 'dev'
>    394 |         dev_dbg(info->dev, "%s(blank=%d)\n",
> drivers/staging/fbtft/fbtft-core.c:796:25: error: 'struct fb_info' has no member named 'dev'
>    796 |         dev_info(fb_info->dev,
> drivers/staging/fbtft/fbtft-core.c:796:9: note: in expansion of macro 'dev_info'
>    796 |         dev_info(fb_info->dev,
>
> Use fb_info->device instead of fb_info->dev here, which appears
> to be what was intended in the first place.
>
> Fixes: c296d5f9957c ("staging: fbtft: core support")
> Fixes: bc9f9cb85a7d ("staging: fbtft: Make FB_DEVICE dependency optional")

These commit hashes differ from the other fix?

Best regards
Thomas


> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>   drivers/staging/fbtft/fbtft-core.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/fbtft/fbtft-core.c b/drivers/staging/fbtft/fbtft-core.c
> index 15affe6f1537..41326b1df733 100644
> --- a/drivers/staging/fbtft/fbtft-core.c
> +++ b/drivers/staging/fbtft/fbtft-core.c
> @@ -365,7 +365,7 @@ static int fbtft_fb_setcolreg(unsigned int regno, unsigned int red,
>   	unsigned int val;
>   	int ret = 1;
>   
> -	dev_dbg(info->dev,
> +	dev_dbg(info->device,
>   		"%s(regno=%u, red=0x%X, green=0x%X, blue=0x%X, trans=0x%X)\n",
>   		__func__, regno, red, green, blue, transp);
>   
> @@ -391,7 +391,7 @@ static int fbtft_fb_blank(int blank, struct fb_info *info)
>   	struct fbtft_par *par = info->par;
>   	int ret = -EINVAL;
>   
> -	dev_dbg(info->dev, "%s(blank=%d)\n",
> +	dev_dbg(info->device, "%s(blank=%d)\n",
>   		__func__, blank);
>   
>   	if (!par->fbtftops.blank)
> @@ -793,7 +793,7 @@ int fbtft_register_framebuffer(struct fb_info *fb_info)
>   	if (spi)
>   		sprintf(text2, ", spi%d.%d at %d MHz", spi->controller->bus_num,
>   			spi_get_chipselect(spi, 0), spi->max_speed_hz / 1000000);
> -	dev_info(fb_info->dev,
> +	dev_info(fb_info->device,
>   		 "%s frame buffer, %dx%d, %d KiB video memory%s, fps=%lu%s\n",
>   		 fb_info->fix.id, fb_info->var.xres, fb_info->var.yres,
>   		 fb_info->fix.smem_len >> 10, text1,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


