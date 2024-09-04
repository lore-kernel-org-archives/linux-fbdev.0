Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395806A8D2
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Sep 2024 07:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433690; cv=none; b=mnD4G5BmKgGwYOSUc0pDMHoL5FvQQ7N3G4R3XU8lPpbRKcDH56JGtWBhLWUhzet2uKQNaIiOYZPvEdsSOGNwi8C+GnMAiOqxp0NdcfqAsO8SkMPCLZJrikdsUmOTXe1tDCLmQ+XwHDLJ8tvfQOC910yXC0bWtEQgqvbD3fAs19g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433690; c=relaxed/simple;
	bh=4IK6a34t5gmlSRO1CbQRgmx0uB0elL8T9Nwvrf7UDZc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7pEvPUFzWAmmV+O4Y99slEQ7JSfG3NTqFO/5RmbXeYssQSKsUEr+FFwMhwt4GM7hkkQmrCOs65iVot4aIql38KlBMq42T4zdVo5x9jqrb6aJdTAk5ZIyo9nmqNlCzPw5HhIN1PJSpegpsD0BPgcpy8q4D69WbBZGBe877Z9M9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fVQEU0Ib; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=BRE8apGw; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WUrY+jPe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yJvAjkK4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fVQEU0Ib";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="BRE8apGw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WUrY+jPe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yJvAjkK4"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 423BC1F79F;
	Wed,  4 Sep 2024 07:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725433686; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mUoYPAUhbHcU34iRTtFfMjbDkk3HdCevolF7T1T+bHo=;
	b=fVQEU0IbM+xRn4z0DIaZMCv4z9WcMs2WfcdD7fwHD97TkKW8tmoXwx0iJjhdFUBef8ddlH
	4NWoS7jnxP0Wg3v7kod8lrHsx5LHjAI1Nc8QRsCJB9SL5cLJkv4LKIZNqlzSITr02wozAL
	v1+GmYARaHuyJNngdstAiMG/vFNKt0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725433686;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mUoYPAUhbHcU34iRTtFfMjbDkk3HdCevolF7T1T+bHo=;
	b=BRE8apGwLFzERD9LAvuH5Udy57gV0QnlVTsx8zjxBqJm9h5R4rqBWE8OsfAwXkYrkqThaL
	JHdPOcO9BfTUBSDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1725433685; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mUoYPAUhbHcU34iRTtFfMjbDkk3HdCevolF7T1T+bHo=;
	b=WUrY+jPejDceJxM2NgTkx9DAJQwD1RDgMJTky+iOiXzAQsjI36qgzlcYcGi/kClV2iZCne
	+uowxlg66Nrq2XDNOkImknByhpaixtXID7lOEBz4dKlpBBVvic02pvteOOcRChbSluS9Aw
	KtqnkPKmQPF8c89RDX2OTm+TAQ3tMLk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1725433685;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mUoYPAUhbHcU34iRTtFfMjbDkk3HdCevolF7T1T+bHo=;
	b=yJvAjkK4xDHE6g5eyzrbP4de1icJM9cN0T9Oeyb7+cfQRLn6K+HRmPkPs4OBPZmTp8iO1f
	BMvfqTuUg0MSe5CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CBB4139E2;
	Wed,  4 Sep 2024 07:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /FrZAVUH2GYLaQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 04 Sep 2024 07:08:05 +0000
Message-ID: <4c7ebcda-bd71-4511-9275-79395a1e4809@suse.de>
Date: Wed, 4 Sep 2024 09:08:04 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/43] drm/fbdev-dma: Implement damage handling and
 deferred I/O
To: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Linus Walleij <linus.walleij@linaro.org>
Cc: dri-devel@lists.freedesktop.org, javierm@redhat.com, deller@gmx.de,
 airlied@gmail.com, daniel@ffwll.ch, linux-fbdev@vger.kernel.org
References: <20240419083331.7761-1-tzimmermann@suse.de>
 <12510239.O9o76ZdvQC@steina-w>
 <CACRpkdbJEv7pV_LOZO_2s_otSth9EYM7=fH9VPgxUyPom_BZ4Q@mail.gmail.com>
 <4596037.LvFx2qVVIh@steina-w>
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
In-Reply-To: <4596037.LvFx2qVVIh@steina-w>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[lists.freedesktop.org,redhat.com,gmx.de,gmail.com,ffwll.ch,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,tq-group.com:email,imap1.dmz-prg2.suse.org:helo,1.18.168.128:email]
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 04.09.24 um 08:43 schrieb Alexander Stein:
> Hi Linus,
>
> Am Mittwoch, 4. September 2024, 08:36:46 CEST schrieb Linus Walleij:
>> On Wed, Sep 4, 2024 at 8:09 AM Alexander Stein
>> <alexander.stein@ew.tq-group.com> wrote:
>>
>>> Can you please check in which memory zone this VRAM is located. In my case
>>> it's important CMA is located in Normal zone to trigger this problem.
>> dmesg says this:
>>
>> Reserved memory: created DMA memory pool at 0x18000000, size 8 MiB
>> OF: reserved mem: initialized node vram@18000000, compatible id shared-dma-pool
>> OF: reserved mem: 0x18000000..0x187fffff (8192 KiB) nomap non-reusable
>> vram@18000000
>> cma: Reserved 16 MiB at 0xef000000 on node -1
>> Zone ranges:
>>    Normal   [mem 0x0000000080000000-0x00000000efffffff]
>> Movable zone start for each node
>> Early memory node ranges
>>    node   0: [mem 0x0000000080000000-0x00000000efffffff]
>> Initmem setup node 0 [mem 0x0000000080000000-0x00000000efffffff]
>> percpu: Embedded 15 pages/cpu s39052 r0 d22388 u61440
>>
>> So at the top of the normal zone at 0xef000000 as I read it.
> Okay, so it is the same as for me. It seems you don't have any HighMem.
> On a different model having more memory there is also HighMem available:
>
> [    0.000000] Zone ranges:
> [    0.000000]   Normal   [mem 0x0000000010000000-0x000000003fffffff]
> [    0.000000]   HighMem  [mem 0x0000000040000000-0x000000004fffffff]

IIRC vram needs to be located in HighMem for the code to work. What is 
the difference between these zones?

Best regards
Thomas

>
> If I explicitly configure CMA in HighMem I don't have any issues.
> But the 512MiB models don't have enough memory for fixed allocation in HighMem.
>
> I was about to send a revert myself as I didn't get any feedback yet.
>
> Best regards,
> Alexander

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

