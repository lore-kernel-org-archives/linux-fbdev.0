Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E68838A703
	for <linux-fbdev@vger.kernel.org>; Tue, 10 Mar 2026 11:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773143378; cv=none; b=R1YShJKSiooaT9ZJ6IZexSjMxGtOeNUqymPv0x9CFQaCGPb1F6KVvbjPUCt+P6ywhCKL+LEhof6nf1uiNqLC63A6Z8E7SI7fhOB4L5g9XkC+5mwevHoZoEkvFb1JPTRoZgwbOZHjBe61/aL4Kpe7CDRs3r/99zPH3diZeDcOKG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773143378; c=relaxed/simple;
	bh=rajQbJNd14KZQEx+qZLoWeRUbHwOGhvfquP82UeS5sY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SF6WjfcybtdN3+JJOxKzP2Q4K5Bvvgb6g3cNxdYzUbb7AliEj5f53I2G6HRgSLx3Pqn7Mihc2r8hkk2a6ynL6HPfkvQHlvsFZPtUErQDHztH+f3/KSXSpqmCLVSzxep1IRKRnJDcHHYEfB0RghtiJox2fXwsx0044dcw9Ij6QAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NBt7uX8O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CPyFWBz2; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=NBt7uX8O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CPyFWBz2; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NBt7uX8O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CPyFWBz2";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="NBt7uX8O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CPyFWBz2"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4F8F44D1FD;
	Tue, 10 Mar 2026 11:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773143374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1TvUYm6lmcZ4VfSU+oRglTEUz1kUGphpmt3Scsve+0=;
	b=NBt7uX8OFyXoWfUj0tPjm1bvrrQcZ6cE6SOFeoFwMHHEE5fwjnfd77k8W4bYj6raPXJd9x
	dGncN7WmY89aAvgVXetl9RXQu6VY1rbNCzW/imqmZ023tVLgOViZ98PByEdL5sMW6LmIAc
	0qiQ+GAwJOQupKECsS5im6uhGDSN3h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773143374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1TvUYm6lmcZ4VfSU+oRglTEUz1kUGphpmt3Scsve+0=;
	b=CPyFWBz29cdQ4Do50DCLKJPMP+mm0CsbOOIBmGzHD5aPFrdj+ibQ/bPONp8MNOp5s7RCTD
	HxR0voz6MLl4vsBg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NBt7uX8O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CPyFWBz2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773143374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1TvUYm6lmcZ4VfSU+oRglTEUz1kUGphpmt3Scsve+0=;
	b=NBt7uX8OFyXoWfUj0tPjm1bvrrQcZ6cE6SOFeoFwMHHEE5fwjnfd77k8W4bYj6raPXJd9x
	dGncN7WmY89aAvgVXetl9RXQu6VY1rbNCzW/imqmZ023tVLgOViZ98PByEdL5sMW6LmIAc
	0qiQ+GAwJOQupKECsS5im6uhGDSN3h0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773143374;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=T1TvUYm6lmcZ4VfSU+oRglTEUz1kUGphpmt3Scsve+0=;
	b=CPyFWBz29cdQ4Do50DCLKJPMP+mm0CsbOOIBmGzHD5aPFrdj+ibQ/bPONp8MNOp5s7RCTD
	HxR0voz6MLl4vsBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 073DE3F433;
	Tue, 10 Mar 2026 11:49:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rRRwAE4FsGmtaAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 10 Mar 2026 11:49:34 +0000
Message-ID: <ec635591-c861-4aa8-a259-718690ddaa4e@suse.de>
Date: Tue, 10 Mar 2026 12:49:33 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] fbdev/hga: Request memory region before ioremap
To: Hardik Phalet <hardik.phalet@pm.me>,
 Ferenc Bakonyi <fero@drama.obuda.kando.hu>, Helge Deller <deller@gmx.de>
Cc: Shuah Khan <skhan@linuxfoundation.org>,
 Brigham Campbell <me@brighamcampbell.com>, linux-nvidia@lists.surfsouth.com,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260310113810.789575-1-hardik.phalet@pm.me>
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
In-Reply-To: <20260310113810.789575-1-hardik.phalet@pm.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FREEMAIL_TO(0.00)[pm.me,drama.obuda.kando.hu,gmx.de];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,pm.me:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4F8F44D1FD

Hi

Am 10.03.26 um 12:38 schrieb Hardik Phalet:
> The driver calls ioremap() on the HGA video memory at 0xb0000 without
> first reserving the physical address range. This leaves the kernel
> resource tree incomplete and can cause silent conflicts with other
> drivers claiming the same range.
>
> Add a devm_request_mem_region() call before ioremap() in
> hga_card_detect() to reserve the memory region.
>
> Signed-off-by: Hardik Phalet <hardik.phalet@pm.me>
> ---
> Changes in v2:
> - Used devm_request_mem_region instead of request_mem_region, based on a
> 	review comment by Thomas [1].
>
> v1: https://lore.kernel.org/all/20260310064124.602848-1-hardik.phalet@pm.me/
> [1]: https://lore.kernel.org/all/5f9749ba-18a8-4b6b-a6e7-a011a3871bfb@suse.de/
>
>   drivers/video/fbdev/hgafb.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
> index 14418aa3791a..fffd34141f8d 100644
> --- a/drivers/video/fbdev/hgafb.c
> +++ b/drivers/video/fbdev/hgafb.c
> @@ -276,7 +276,7 @@ static void hga_blank(int blank_mode)
>   	spin_unlock_irqrestore(&hga_reg_lock, flags);
>   }
>   
> -static int hga_card_detect(void)
> +static int hga_card_detect(struct platform_device *pdev)
>   {
>   	int count = 0;
>   	void __iomem *p, *q;
> @@ -284,6 +284,11 @@ static int hga_card_detect(void)
>   
>   	hga_vram_len  = 0x08000;
>   
> +	if (!devm_request_mem_region(&pdev->dev, 0xb0000, hga_vram_len, "hgafb")) {
> +		pr_err("hgafb: cannot reserve video memory at 0xb0000\n");

dev_err() with pdev->dev please.

The rest looks good.

Best regards
Thomas

> +		return -EBUSY;
> +	}
> +
>   	hga_vram = ioremap(0xb0000, hga_vram_len);
>   	if (!hga_vram)
>   		return -ENOMEM;
> @@ -568,7 +573,7 @@ static int hgafb_probe(struct platform_device *pdev)
>   	struct fb_info *info;
>   	int ret;
>   
> -	ret = hga_card_detect();
> +	ret = hga_card_detect(pdev);
>   	if (ret)
>   		return ret;
>   

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


