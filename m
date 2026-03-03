Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28D235F5E5
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Mar 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542302; cv=none; b=iGgyzv5rugO1cbXMse5m2Faukr8a9tOVuRKS3cHIG3yznsYLbmj5UmurpCcPDLCQmzG2o2Gpf8u/LBMmxMO2GqsSLnZvPAlWE+KUf9duJmsmj2CLYwhBG89CJDCUytzyTs06sXGUmqsApmEBnmQVxWlvLd1Gvq85o4/q/ASkhTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542302; c=relaxed/simple;
	bh=RY20XxbCMPmXuKNszchSL13l+3Vrl7uBIPx54F4dbiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A1q5JzTlqJZzQfUWLHph5LPV/R1k+UWa2a0hDyxBaEc2ybWsf2vnCZrMR17HwX9hRKMdJchWgou0MXI0iDOcHXogh7Qt+Y9LHc3DjFdHFgI72AAk0B2U9ZGDipbkqy8DpgCvdDDIc0iAXp8EPMLyrKffLcoJ2A3P5ba3HYnozdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LovmQBHT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2ZDCwbpk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lPsJuzQR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=aAox4pgD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LovmQBHT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2ZDCwbpk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lPsJuzQR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="aAox4pgD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A95FE3E73E;
	Tue,  3 Mar 2026 12:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772542297; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iuEIkGzsfNKjeDkA2uWvlu3PhgLdIY1JStDr/M5ZIc8=;
	b=LovmQBHTa/w6ty5PRsslygi2GMnmaDjFJ9ULGFzDzKlhurNreprOh5lDrhUMYFI3OREBbD
	e6N+goRJS7BiqBXzEJ+W5Gv0d5fywIwTwJ5KEL6kdYbbdjivJiqKjo7icoHD4fdGhJnFfQ
	+R0PEqUgMyZ2x7EcVx4sUY1NjogUIsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772542297;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iuEIkGzsfNKjeDkA2uWvlu3PhgLdIY1JStDr/M5ZIc8=;
	b=2ZDCwbpkYntWZ0KpvGVpwODBPsBrfhhwVnNG7/9r5dRuhSykV5AkxtCUnS0MVW/oDeMpBT
	D1W4AQi7YFxbmzDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lPsJuzQR;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=aAox4pgD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772542296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iuEIkGzsfNKjeDkA2uWvlu3PhgLdIY1JStDr/M5ZIc8=;
	b=lPsJuzQRzQCl++Z5Ut0Rg8gevJp9L/RHD4mU18e4Sha6TtIA1j7nkZd9yqiphvYYwqalLm
	WvDPOLr7PP2IV4N9nzf9JjyBxfy03K60wHb0akx1Y6QyqCbQag4XxmwnNbl/UyLhysXMjV
	K6/8TdpRKfhy+5/+2xSLwlJaQLF1nLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772542296;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=iuEIkGzsfNKjeDkA2uWvlu3PhgLdIY1JStDr/M5ZIc8=;
	b=aAox4pgDH82h9pT/s8mkbAG66GSFOblwezLV3s5T3YdCRtY6/oZRfzHwA/FGvXNXsDXRHn
	+up0fLOHEPoDS1Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 837CD3EA69;
	Tue,  3 Mar 2026 12:51:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Pds6HljZpmmUKAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 03 Mar 2026 12:51:36 +0000
Message-ID: <2fb9b0fe-e63a-4b06-968d-3cb30383ba37@suse.de>
Date: Tue, 3 Mar 2026 13:51:36 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: goldfishfb: use devm_platform_ioremap_resource()
To: Amin GATTOUT <amin.gattout@gmail.com>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260303-master-v1-1-85eb5ff584b0@gmail.com>
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
In-Reply-To: <20260303-master-v1-1-85eb5ff584b0@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com,gmx.de];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid,suse.de:email,suse.com:url]
X-Rspamd-Queue-Id: A95FE3E73E
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 



Am 03.03.26 um 13:22 schrieb Amin GATTOUT:
> Replace the open-coded platform_get_resource() + ioremap() pair with
> devm_platform_ioremap_resource(), which requests the memory region and
> maps it in a single call, with automatic cleanup on device removal.
>
> Signed-off-by: Amin GATTOUT <amin.gattout@gmail.com>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

> ---
>   drivers/video/fbdev/goldfishfb.c | 14 +++-----------
>   1 file changed, 3 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
> index ffe33a36b944..c9871281bc1d 100644
> --- a/drivers/video/fbdev/goldfishfb.c
> +++ b/drivers/video/fbdev/goldfishfb.c
> @@ -174,7 +174,6 @@ static const struct fb_ops goldfish_fb_ops = {
>   static int goldfish_fb_probe(struct platform_device *pdev)
>   {
>   	int ret;
> -	struct resource *r;
>   	struct goldfish_fb *fb;
>   	size_t framesize;
>   	u32 width, height;
> @@ -189,14 +188,9 @@ static int goldfish_fb_probe(struct platform_device *pdev)
>   	init_waitqueue_head(&fb->wait);
>   	platform_set_drvdata(pdev, fb);
>   
> -	r = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (r == NULL) {
> -		ret = -ENODEV;
> -		goto err_no_io_base;
> -	}
> -	fb->reg_base = ioremap(r->start, PAGE_SIZE);
> -	if (fb->reg_base == NULL) {
> -		ret = -ENOMEM;
> +	fb->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(fb->reg_base)) {
> +		ret = PTR_ERR(fb->reg_base);
>   		goto err_no_io_base;
>   	}
>   
> @@ -273,7 +267,6 @@ static int goldfish_fb_probe(struct platform_device *pdev)
>   				fb->fb.fix.smem_start);
>   err_alloc_screen_base_failed:
>   err_no_irq:
> -	iounmap(fb->reg_base);
>   err_no_io_base:
>   	kfree(fb);
>   err_fb_alloc_failed:
> @@ -291,7 +284,6 @@ static void goldfish_fb_remove(struct platform_device *pdev)
>   
>   	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
>   						fb->fb.fix.smem_start);
> -	iounmap(fb->reg_base);
>   	kfree(fb);
>   }
>   
>
> ---
> base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
> change-id: 20260303-master-341e700a2699
>
> Best regards,

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


