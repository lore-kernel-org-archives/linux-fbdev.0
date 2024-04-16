Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393FC129E89
	for <linux-fbdev@vger.kernel.org>; Tue, 16 Apr 2024 12:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713269242; cv=none; b=cmtZ+UA7ldo07EN+I6PqJQpaNAp0jinyeSs+dNZxzzE9vvyfPcgd7O2JEk/TUshgYhjzGRvAklsQp7Z8HvWFkp1MX8ExRM1DbeXAI7tKv/SODcskGzpFQE1EEUvU4xMHSnBtfjJ1xSq8d9kdh08hrV14E48mTG/nPQkkOpn8Geo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713269242; c=relaxed/simple;
	bh=IEZzt5z/yvZh0OOvo73OMO89ytO4Lnnl/zuZVNx5FGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NE99LqUIxPQe9RwcPYxH6v8MX0GW96+DIA41B6v+HsCz0fYMG5AzzhqlxR/vqPFiPWj/jxcabhL2MAER7PzqZ3lVb4T8qSlez7c+cxZdPMCTIxGCZdc3QK4frNlzrr7MtBXlpnbTViNO1jM2BjHlA6b2wvHuQSNRvEkgcbHqsRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYPJIDWE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Y70xhOe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oYPJIDWE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0Y70xhOe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYPJIDWE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Y70xhOe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oYPJIDWE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0Y70xhOe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id BB1CA5F79D;
	Tue, 16 Apr 2024 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713269232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CQRsttenWR+yCpfv2OHDZEDLtYSnmtGRachIux62ZYY=;
	b=oYPJIDWE3hf2T0hxS31RDPwKCvdmExTRksMnbrkVFQVbjawWZmGS2ksV06pZuXVLsQ88Lv
	DojnDtuZMOyk/YOoicEDelKLAs3Eme/H2i5e8BdoretYRyWmkXzLbbpwDsqVI3xG9YPbs/
	C3BJKFgOvcXWUwDBqxzQ1m34X/OTcfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713269232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CQRsttenWR+yCpfv2OHDZEDLtYSnmtGRachIux62ZYY=;
	b=0Y70xhOeotdKoA4KIcuiHcMsCFRdfKZ96Mg7Frep0zCCiKg1sTd1IM0TMKaBvu+GBiBfZE
	4YjOHrNE21b9LRBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oYPJIDWE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0Y70xhOe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1713269232; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CQRsttenWR+yCpfv2OHDZEDLtYSnmtGRachIux62ZYY=;
	b=oYPJIDWE3hf2T0hxS31RDPwKCvdmExTRksMnbrkVFQVbjawWZmGS2ksV06pZuXVLsQ88Lv
	DojnDtuZMOyk/YOoicEDelKLAs3Eme/H2i5e8BdoretYRyWmkXzLbbpwDsqVI3xG9YPbs/
	C3BJKFgOvcXWUwDBqxzQ1m34X/OTcfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1713269232;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CQRsttenWR+yCpfv2OHDZEDLtYSnmtGRachIux62ZYY=;
	b=0Y70xhOeotdKoA4KIcuiHcMsCFRdfKZ96Mg7Frep0zCCiKg1sTd1IM0TMKaBvu+GBiBfZE
	4YjOHrNE21b9LRBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90A4B13931;
	Tue, 16 Apr 2024 12:07:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UokRIvBpHma7OQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 16 Apr 2024 12:07:12 +0000
Message-ID: <6cdccec9-e1a1-477b-a41a-4fb9d94d3238@suse.de>
Date: Tue, 16 Apr 2024 14:07:12 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/43] drm/fbdev: Add fbdev-shmem
To: Javier Martinez Canillas <javierm@redhat.com>, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240410130557.31572-1-tzimmermann@suse.de>
 <20240410130557.31572-9-tzimmermann@suse.de>
 <87r0f54kir.fsf@minerva.mail-host-address-is-not-set>
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
In-Reply-To: <87r0f54kir.fsf@minerva.mail-host-address-is-not-set>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -5.50
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: BB1CA5F79D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-5.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	DWL_DNSWL_LOW(-1.00)[suse.de:dkim];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_TO(0.00)[redhat.com,gmx.de,gmail.com,ffwll.ch];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:email]

Hi Javier

Am 16.04.24 um 13:25 schrieb Javier Martinez Canillas:
> Thomas Zimmermann <tzimmermann@suse.de> writes:
>
> Hello Thomas,
>
>> Add an fbdev emulation for SHMEM-based memory managers. The code is
>> similar to fbdev-generic, but does not require an addition shadow
> "additional" I think ?

Yes.

>
>> buffer for mmap(). Fbdev-shmem operates directly on the buffer object's
>> SHMEM pages. Fbdev's deferred-I/O mechanism updates the hardware state
>> on write operations.
>>
>> v2:
>> - use drm_driver_legacy_fb_format() (Geert)
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
> Patch looks good to me.
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Thanks for reviewing.

>
> Just a couple of questions below:
>
>>   drivers/gpu/drm/Makefile          |   1 +
>>   drivers/gpu/drm/drm_fbdev_shmem.c | 316 ++++++++++++++++++++++++++++++
> Should fbdev-generic then be renamed to fbdev_shmem_shadow or something
> like that ?

We'll do that in patch 42. :)

>
> [...]
>
>> +
>> +	/* screen */
>> +	info->flags |= FBINFO_VIRTFB; /* system memory */
>> +	if (!shmem->map_wc)
>> +		info->flags |= FBINFO_READS_FAST; /* signal caching */
>> +	info->screen_size = sizes->surface_height * fb->pitches[0];
>> +	info->screen_buffer = map.vaddr;
>> +	info->fix.smem_len = info->screen_size;
>> +
> Do I understand correctly that info->fix.smem_start doesn't have to be set
> because that's only used for I/O memory?

It's the start of the framebuffer memory in physical memory. Setting 
smem_start only makes sense if the framebuffer is physically continuous, 
which isn't the case here.

>
> Since drm_fbdev_shmem_fb_mmap() calls fb_deferred_io_mmap() which in turn
> sets vma->vm_ops = &fb_deferred_io_vm_ops and struct vm_operations_struct
> fb_deferred_io_vm_ops .fault function handler is fb_deferred_io_fault()
> that calls fb_deferred_io_page() which uses info->fix.smem_start value.

Right, except in this case, which we don't trigger. Patch 5 adds an 
additional check to ensure this.

>
> I guess is OK because is_vmalloc_addr() is always true for this case ?

It's not a vmalloc'ed address, but see patch 7. Fbdev-shmem uses a new 
get_page callback in fb_defio. It provides the necessary page directly 
to fb_defio.


>
> This also made me think why info->fix.smem_len is really needed. Can't we
> make the fbdev core to only look at that if info->screen_size is not set ?

The fbdev core doesn't use smem_len AFAICT. But smem_len is part of the 
fbdev UAPI, so I set it. I assume that programs use it to go to the end 
of the framebuffer memory.

Best regards
Thomas

>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

