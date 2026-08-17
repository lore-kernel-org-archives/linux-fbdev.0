Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903B83B3C19;
	Mon, 17 Aug 2026 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786953491; cv=none; b=CiZnqA6LGDhYZ16C0tIRm1umsDKXR2tyJNfGD7YFZXGn3PoB3mJTff7ZMvx3tUnDfRkVoM4YyJXGkS1DyX1t5XaloU1QHAU47d0UGmY6U9MJv2CCewfR46jH45DERrnHSE+AFQDjiTaBun/lVj0YyEkCnHIkQVxIubsiZrgeR0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786953491; c=relaxed/simple;
	bh=3jmP7mcybDu+HtA55K6XJ9e6IlnMBRcRAeIHTDqch0I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EMWqoVmfs+l6SO0HAQBuDUofv2HtXNVOE6+agGWuubbQaWjJAsPAWjajq4JvNeBTj3rxoRtwiDXTBfOv5Trfh5oAYQTAvTIsVNqJOH/2aPzBvE6P3rKdq++LeefuC5BPJbb7yRbC/myVvkGaPlqc+WwukDKMOruBi4F9QDSU51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xpn3Qz6U; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SO2En7k5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qrbt3TEj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=C3RV1qBi; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xpn3Qz6U";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SO2En7k5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qrbt3TEj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="C3RV1qBi"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2EC6283ECB;
	Mon, 17 Aug 2026 07:57:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786953483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fCWQbgUrTl+K5qOE1OiT5i8dv6xzKU0hbCmxiTeIcls=;
	b=xpn3Qz6UYw8nYeayh3eU8yprK3EKMIgiwbDAfthinjjW55DfigP0i4HHh8rQNf0IfTlZHG
	dFP1ZNvMf1dEuGjgJbdtuccShrBg1DEVaT6emUqOJphGVfUm+xiyd7/1VUGqnRkDHbYHgi
	phLd1qvrQxZ69gZtH9FNWCxPZ3AxUxg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786953483;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fCWQbgUrTl+K5qOE1OiT5i8dv6xzKU0hbCmxiTeIcls=;
	b=SO2En7k5GVOuthVaVxVVjawbsj3vEx24UIm+lF20IsYjUZnHg/Ivn6RQrBKackTdmM1wyG
	LuYWqt8yFb75mNDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786953479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fCWQbgUrTl+K5qOE1OiT5i8dv6xzKU0hbCmxiTeIcls=;
	b=qrbt3TEjhlwBp6brKXWSVhIIOA6BVJsNnAk2JXo2DdotdcssJgPV/0w3c9HOgEl+fM7Kz9
	NiBCKnt+146IbTCMC8WYulZo2b56wIShGGLepi+nqbXWyt5aXIZp5Rz10AWI+KXPdmuo2P
	YzHJhmXftoYVTpG+oU8IHhNVqYPruQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786953479;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fCWQbgUrTl+K5qOE1OiT5i8dv6xzKU0hbCmxiTeIcls=;
	b=C3RV1qBiaCEFleh+mdhgE5RZpZ+vE882BKqh78YPLq9bnoNoFW8yM/sIntiaQnmVt7CgLs
	IxzPZcOoRlr0ioDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06FB27936A;
	Mon, 17 Aug 2026 07:57:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EuyFAAe/gmoOZQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 17 Aug 2026 07:57:59 +0000
Message-ID: <3347106a-f0f9-415a-94e4-94bc9b8182ef@suse.de>
Date: Mon, 17 Aug 2026 09:57:58 +0200
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
 <a486820d-8500-41b1-bc32-a23d908c9f86@suse.de>
 <5a2d0139-84db-cab8-c7fb-7806a71c53b2@gmail.com>
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
In-Reply-To: <5a2d0139-84db-cab8-c7fb-7806a71c53b2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,linux-m68k.org];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo]



Am 17.08.26 um 09:49 schrieb Michael Schmitz:
> Hi Thomas,
>
> Am 17.08.2026 um 18:34 schrieb Thomas Zimmermann:
>> Hi
>>
>> Am 16.08.26 um 09:37 schrieb Michael Schmitz:
>>> From: Miro Kropacek <miro.kropacek@gmail.com>
>>>
>>> The atafb fb device registers no parent, causing a missing symlink
>>> (/sys/class/graphics/fb0/device). Xorg fbdevhw driver looks for that
>>> symlink when scanning for devices, so add a parent node for atafb.
>>
>> Do you really have these devices to test with?
>
> Not the particular hardware that patches 3 and 4 add support for, but 
> the 'normal' Videl that is found in every Falcon, yes.
>
>> If so, could you also replace the hard coded fb_info with a call to
>> framebuffer_alloc()?
>
> Can't see how that would work - fb_info isn't passed to all functions 
> that need to use it, especially in the hardware detection phase (hence 
> the use of a static fb_info struct)?

You'd have to modify the driver to pass the allocated instance, of 
course. It's not a trivial oneliner, but if this driver is still 
relevant, it might be worth improving it.

Best regards
Thomas

>
> Cheers,
>
>     Michael
>
>>>
>>> Signed-off-by: Miro Kropacek <miro.kropacek@gmail.com>
>>> Reviewed-by: Michael Schmitz <schmitzmic@gmail.com>
>>> Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
>>> Cc: <linux-fbdev@vger.kernel.org>
>>> Link: https://lists.debian.org/debian-68k/2026/08/msg00000.html
>>> ---
>>>   drivers/video/fbdev/atafb.c | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
>>> index b8ed1c537293..3d540803dc2b 100644
>>> --- a/drivers/video/fbdev/atafb.c
>>> +++ b/drivers/video/fbdev/atafb.c
>>> @@ -3101,6 +3101,11 @@ static int __init atafb_probe(struct
>>> platform_device *pdev)
>>>   #endif /* ATAFB_EXT */
>>>     //    strcpy(fb_info.mode->name, "Atari Builtin ");
>>> +    /* Parent the fb device properly: without this fb0 registers as a
>>> +     * virtual sysfs device with no /sys/class/graphics/fb0/device 
>>> link,
>>> +     * which makes Xorg's fbdevhw reject it ("No devices detected").
>>> +     */
>>> +    fb_info.device = &pdev->dev;
>>
>> Because this is supposed to happen in framebuffer_alloc() and keeping it
>> there would be preferable.
>>
>> Best regards
>> Thomas
>>
>>>       fb_info.fbops = &atafb_ops;
>>>       // try to set default (detected; requested) var
>>>       do_fb_set_var(&atafb_predefined[default_par - 1], 1);
>>
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


