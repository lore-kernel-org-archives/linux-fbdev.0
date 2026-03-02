Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F387A3451A6
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Mar 2026 11:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772451237; cv=none; b=oVxRhKACMJW/ing9BXtV3w0GgxPckwtV+BMCaciPwHqQWwnACZYmRhI59h1FY2hAshNB3yFLnpNZkhxrFmcjS6pkHQKl3XCo9NhJoWYcTDpqvzFVmw11fWOqxuePWTbwV1iBhhsU3b0KdTKRNgc3qK7Qg/qxwfwxzfsx30hu4uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772451237; c=relaxed/simple;
	bh=+/BYTL7w1DUhdHjB1+f7JnsjI912ESJKxCsw57NIpHQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pws83GAZ9/8vY2LQTA+1AYasSEvFVNJe6wM63KePcCVAnVi5bUUYo4TUN3s5LfR83GpImMpllV6kIrgdA2DJ5zESYRp2tSFGq3jRT1hMJf8jJImIO+W/cvklcsh2tBiffERNSngUjdJmWpyxF33eTNxFLsqsM+e3Ctys1vql2ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ru/Nh//c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uf064QZo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ru/Nh//c; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uf064QZo; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ru/Nh//c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uf064QZo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ru/Nh//c";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uf064QZo"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 42BB05BD21;
	Mon,  2 Mar 2026 11:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772451234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RyR8g+26L+2uDNtNnUGYNiOWxmn4mzeayjiewIIWoSo=;
	b=ru/Nh//cwLWHIYoJfw/B+1QUu34HbQ/D9LF6wNmEmsfoK3WOja/G3oHeNLz1PERTkvw03B
	prbaLll8EJl06aux4akrCs1uMnS3t8Ton0Vj6ep3fXr0aOmwThx9aczv/NMpc0GK4BUXjx
	U5euRWVxfL3gDhnxqDeHenhV9B1HVCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772451234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RyR8g+26L+2uDNtNnUGYNiOWxmn4mzeayjiewIIWoSo=;
	b=uf064QZoew8xrbpNCsv7QWE8ynfx9Do8cKunlLF/jReim3giYTh01M/4GpR3UnvsE311gL
	hDnmvvH7pWeCKHCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772451234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RyR8g+26L+2uDNtNnUGYNiOWxmn4mzeayjiewIIWoSo=;
	b=ru/Nh//cwLWHIYoJfw/B+1QUu34HbQ/D9LF6wNmEmsfoK3WOja/G3oHeNLz1PERTkvw03B
	prbaLll8EJl06aux4akrCs1uMnS3t8Ton0Vj6ep3fXr0aOmwThx9aczv/NMpc0GK4BUXjx
	U5euRWVxfL3gDhnxqDeHenhV9B1HVCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772451234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=RyR8g+26L+2uDNtNnUGYNiOWxmn4mzeayjiewIIWoSo=;
	b=uf064QZoew8xrbpNCsv7QWE8ynfx9Do8cKunlLF/jReim3giYTh01M/4GpR3UnvsE311gL
	hDnmvvH7pWeCKHCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1312C3EA69;
	Mon,  2 Mar 2026 11:33:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +ps5A6J1pWnQewAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Mar 2026 11:33:54 +0000
Message-ID: <8772d571-43a9-45ea-9bd7-63928e357ab0@suse.de>
Date: Mon, 2 Mar 2026 12:33:53 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] fbcon: Fix out-of-bounds memory in fbcon_putcs
To: "chenjun (AM)" <chenjun102@huawei.com>, "simona@ffwll.ch"
 <simona@ffwll.ch>, "deller@gmx.de" <deller@gmx.de>,
 "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "linruifeng (A)" <linruifeng4@huawei.com>
References: <20260227144358.101173-1-chenjun102@huawei.com>
 <1c078618-7236-4ccb-ae99-376276369f36@suse.de>
 <e8e3b8182e124ac08cc33700d45772ce@huawei.com>
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
In-Reply-To: <e8e3b8182e124ac08cc33700d45772ce@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[huawei.com,ffwll.ch,gmx.de,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,suse.com:url]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi

Am 02.03.26 um 12:24 schrieb chenjun (AM):
> 在 2026/3/2 18:19, Thomas Zimmermann 写道:
>>
>> Am 27.02.26 um 15:43 schrieb Chen Jun:
>>> When a font is set on an invisible console, the screen will not update.
>>> However, the fontbuffer is not updated to match the new font dimensions.
>>>
>>> This inconsistency leads to out-of-bounds memory access when writing to
>>> the tty bound to fbcon, as demonstrated by the following KASAN report:
>>>
>>> BUG: KASAN: slab-out-of-bounds in fb_pad_aligned_buffer+0xdf/0x140
>>> Read of size 1 at addr ffff8881195a2280 by task a.out/971
>>> Call Trace:
>>>     <TASK>
>>>     fb_pad_aligned_buffer+0xdf/0x140
>>>     ud_putcs+0x88a/0xde0
>>>     fbcon_putcs+0x319/0x430
>>>     do_update_region+0x23c/0x3b0
>>>     do_con_write+0x225c/0x67f0
>>>     con_write+0xe/0x30
>>>     n_tty_write+0x4b5/0xff0
>>>     file_tty_write.isra.41+0x46c/0x880
>>>     vfs_write+0x868/0xd60
>>>     ksys_write+0xf2/0x1d0
>>>     do_syscall_64+0xfa/0x570
>>>
>>> Fix this by calling fbcon_rotate_font() if vc is invisible in
>>> fbcon_do_set_font().
>>>
>>> Signed-off-by: Chen Jun <chenjun102@huawei.com>
>> Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
> Hi Thomas,
>
> Thanks for your review.
>
> I'm not familiar with the fbcon module. Is there a better way to fix this?

Not really, I think. The whole module first needs a redesign to be 
easier to understand.

Best regards
Thomas

>
>>> ---
>>>     drivers/video/fbdev/core/fbcon.c | 5 +++++
>>>     1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
>>> index 666261ae59d8..d76100188bee 100644
>>> --- a/drivers/video/fbdev/core/fbcon.c
>>> +++ b/drivers/video/fbdev/core/fbcon.c
>>> @@ -2444,6 +2444,11 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
>>>     		rows = FBCON_SWAP(par->rotate, info->var.yres, info->var.xres);
>>>     		cols /= w;
>>>     		rows /= h;
>>> +		if (!con_is_visible(vc)) {
>>> +			ret = fbcon_rotate_font(info, vc);
>>> +			if (ret)
>>> +				goto err_out;
>>> +		}
>>>     		ret = vc_resize(vc, cols, rows);
>>>     		if (ret)
>>>     			goto err_out;
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


