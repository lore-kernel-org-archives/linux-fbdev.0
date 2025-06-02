Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CDC2C325A
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Jun 2025 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748849392; cv=none; b=TAwQvZA+dQVxK9nrzMLmIvLzninElMt7qJX94eQOvAf3cQQPuZ1tTuhuq+M+1+NEQUYuoE38+qA+hyoxFyMQS0V+RzXt+JxAPw+b+p4RzXpm3xY6KjYc67O1oylGt/rkIFMgYx1dv8B09linqos6mKtLvBsXlsmfzRDdjk+wxJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748849392; c=relaxed/simple;
	bh=pM039BViAxCx8erb2hyXy+yNtK3pPboqLhl9F9ulcNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=mUXq9LRhO0q+2kQI3/+7db16HapgmFZsPZ1LoBbpGAn0JjmldE5+1yVoBIb/SaipOn69XWKCIcLX/jtRvBrjkde9L5qtJZeXAQqAZPvr+2iiDTV1ne0B0rEkS06Qdfj1cxNBoV0LiRm7OzGE52Pnv9uw6Ne8qJ7ZKBVxFpqPxQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eHk0Egdq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d+yJEQGe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=eHk0Egdq; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=d+yJEQGe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eHk0Egdq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d+yJEQGe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="eHk0Egdq";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="d+yJEQGe"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A0F691F796;
	Mon,  2 Jun 2025 07:29:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748849388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jCGrlM10fsk3VQtijBydgK0+1DcHQ2nYLlNFCipSOvg=;
	b=eHk0Egdq0GhFzPk30GZZESbPO4JFGNGMkDnWZw9x/rEJAiahE94mmn9DaOB8aFMiTtDYj6
	6S68vQIv6rZwQluUsjD1XHab9XzLTvvhCn6yAZkoBv/vcgbxQq/Tsk8XS0jR2+xJYr+y1S
	2y3WinY0tFLn2zz5gh+bzslejRMcZno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748849388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jCGrlM10fsk3VQtijBydgK0+1DcHQ2nYLlNFCipSOvg=;
	b=d+yJEQGeXv8M2Hq5cpnPEZtlfB1oQd9PJWsYQKJ6iQSgScqt/otbFcveP3FrQKijzpgRYC
	s8JJHa3JbRuo+eDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1748849388; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jCGrlM10fsk3VQtijBydgK0+1DcHQ2nYLlNFCipSOvg=;
	b=eHk0Egdq0GhFzPk30GZZESbPO4JFGNGMkDnWZw9x/rEJAiahE94mmn9DaOB8aFMiTtDYj6
	6S68vQIv6rZwQluUsjD1XHab9XzLTvvhCn6yAZkoBv/vcgbxQq/Tsk8XS0jR2+xJYr+y1S
	2y3WinY0tFLn2zz5gh+bzslejRMcZno=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1748849388;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=jCGrlM10fsk3VQtijBydgK0+1DcHQ2nYLlNFCipSOvg=;
	b=d+yJEQGeXv8M2Hq5cpnPEZtlfB1oQd9PJWsYQKJ6iQSgScqt/otbFcveP3FrQKijzpgRYC
	s8JJHa3JbRuo+eDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 867E513A63;
	Mon,  2 Jun 2025 07:29:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dvslH+xSPWg7WAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Jun 2025 07:29:48 +0000
Message-ID: <77a6b233-6fd6-4c49-ac1d-d2b4c351500d@suse.de>
Date: Mon, 2 Jun 2025 09:29:48 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issues with vgacon with kernels >= 6.13
To: Adam Stylinski <kungfujesus06@gmail.com>, linux-fbdev@vger.kernel.org
References: <aDt4pp9NE85BuAec@thinkpad>
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
In-Reply-To: <aDt4pp9NE85BuAec@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

Hi

Am 31.05.25 um 23:46 schrieb Adam Stylinski:
> I apologize in advance if this is the wrong tree to be barking up but I'm hitting a wall on this and I'm hoping someone on this ML can point me in the right direction.  Ever since kernel 6.13 (I've not yet bisected but that may be my next step) I've been unable to get my potato system booting up via the any of the simple framebuffer consoles.  The kernel simply hangs right after loading the disk IO schedulers (which, looking at my dmesg logs from 6.12 is _just_ before the vga framebuffer is supposed to take over).  The system is definitely in the realm of antique, with a Core 2 Quad Q9650 and a pre EFI boot stage. I've tried simplefb set as the default console, I've tried vesafb, and I've tried vga=normal, all of these seem to fail just before the GPU handoff.
>
> The major change I do see around 6.13 was a change to support the DRM friendly panic message and I'm tempted to maybe think that's where the regression lives. I also realize I may be one of maybe 6 people affected by this by keeping this system limping along, but I do use it regularly to test SIMD related performance, as it's the last CPU family in Intel's line that actually has the unaligned load penalty.
>
> This is the last kernel message I see prior to boot (hopefully LKML doesn't flag me for adding a URL, but I figured attaching an image would be worse):
> https://imgur.com/a/3QkVs2O

Try booting the kernel with fb.lockless_register_fb=1 on the kernel 
command line. With might give more output when the display driver loads.

Best regards
Thomas

>
> Does anyone know of any major changes that might have caused this and anything I should try? My previous configuration is actually to use uvesafb, of which has been failing due to v86d being missing from my distribution for some time now, but it would gracefully fallback. I have an nvidia GPU in this system so the nicer fb options aren't really a thing.  The builtin nvidia modeset is a thing and it does work but that doesn't happen until much later in the boot process. For all intents and purposes, I'm relying on VBE right until that module is loaded, but it hangs much much earlier than that.
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

