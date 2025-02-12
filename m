Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2FB26AEC;
	Wed, 12 Feb 2025 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739347251; cv=none; b=XTPH67ZxJT6hdGdDgYBMKfJjaNOl3NvZqkAXnqh/70LCWCbHw0iFBvZCzEwvMHzwnnZVn1U3ZIgRw4UaSoQZFFpej+5rCYPzlry7FkQe/WkGennwujn+RklmDDKKKQ4KmjzXQNdxFV5NOcd231OtBjDvXKCSLKBKGge2MXjyB7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739347251; c=relaxed/simple;
	bh=bixpMBuwKYzDyx9clsv4wYgY1daUXWR3gPgy0UrCtas=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UEtyKahmuAoSyp0xuCMXlnlU9ZlAM1RnAmZSGvs/IiRiILghqCrZrn9xQ40vBiOJIr8WixCxpqDJY8UdSlc74ynOE3hGWJ2nDnDgPlyix0YpZf8KKr+rW1QZCEaffwCvRmaVoUAEUPo9j5UtfPGsYlLFhkPFPi0zflMiikaJ1MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z0jRsKH0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j/fgVu9b; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Z0jRsKH0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=j/fgVu9b; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z0jRsKH0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j/fgVu9b";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Z0jRsKH0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="j/fgVu9b"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5E4951F387;
	Wed, 12 Feb 2025 08:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739347247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ABLupZVwpHeRErONSJ8n8zXCa8toCkM1y7FD+5WvAAk=;
	b=Z0jRsKH0WdvF5yu0al3xcdsIDTZllvMQ2uo2XArMlEJQuSpQJS71uZE8YgPyagV0da8V9V
	RwohJ+CMrF9swbKqYDkM1L0gv/udaDDtsge70AQpDx2qCejAJdLE+gOQtoBtS5cdhDHDYx
	qGLQOPn8lLSU5/YvoVkeW9tz3y6nIPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739347247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ABLupZVwpHeRErONSJ8n8zXCa8toCkM1y7FD+5WvAAk=;
	b=j/fgVu9bYHYKw9/N+/UmOr6sUdO+LtMu9vpW8WTtcY++KEqrATgCTDNPUVKvJFolVvCuin
	+v0Gi7mUZ+PWk/Aw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Z0jRsKH0;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="j/fgVu9b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1739347247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ABLupZVwpHeRErONSJ8n8zXCa8toCkM1y7FD+5WvAAk=;
	b=Z0jRsKH0WdvF5yu0al3xcdsIDTZllvMQ2uo2XArMlEJQuSpQJS71uZE8YgPyagV0da8V9V
	RwohJ+CMrF9swbKqYDkM1L0gv/udaDDtsge70AQpDx2qCejAJdLE+gOQtoBtS5cdhDHDYx
	qGLQOPn8lLSU5/YvoVkeW9tz3y6nIPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1739347247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=ABLupZVwpHeRErONSJ8n8zXCa8toCkM1y7FD+5WvAAk=;
	b=j/fgVu9bYHYKw9/N+/UmOr6sUdO+LtMu9vpW8WTtcY++KEqrATgCTDNPUVKvJFolVvCuin
	+v0Gi7mUZ+PWk/Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B5B513AEF;
	Wed, 12 Feb 2025 08:00:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id jX9FCS9VrGeDJQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 12 Feb 2025 08:00:47 +0000
Message-ID: <8ec292d5-86b8-4670-8990-91deb627ee0b@suse.de>
Date: Wed, 12 Feb 2025 09:00:46 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: sm750fb: fix checkpatch warning architecture
 specific defines should be avoided
To: Michael Anckaert <michael.anckaert@gmail.com>,
 Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
 Teddy Wang <teddy.wang@siliconmotion.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "open list:STAGING - SILICON MOTION SM750 FRAME BUFFER DRIVER"
 <linux-fbdev@vger.kernel.org>,
 "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
References: <Z6xREbLLtexX4_uh@michael-devbox>
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
In-Reply-To: <Z6xREbLLtexX4_uh@michael-devbox>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 5E4951F387
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com,siliconmotion.com,linuxfoundation.org,vger.kernel.org,lists.linux.dev];
	TAGGED_RCPT(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Hi

Am 12.02.25 um 08:43 schrieb Michael Anckaert:
> Replace architecture-specific defines with CONFIG_X86 checks to improve
> portability and adhere to kernel coding standards.
>
> Fixes checkpatch warning:
> - CHECK: architecture specific defines should be avoided.
>
> Changes made:
> - Using CONFIG_X86 instead of i386 and x86.
>
> Signed-off-by: Michael Anckaert <michael.anckaert@gmail.com>
> ---
>   drivers/staging/sm750fb/ddk750_chip.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/staging/sm750fb/ddk750_chip.c b/drivers/staging/sm750fb/ddk750_chip.c
> index 02860d3ec365..67a2f60440ca 100644
> --- a/drivers/staging/sm750fb/ddk750_chip.c
> +++ b/drivers/staging/sm750fb/ddk750_chip.c
> @@ -229,7 +229,7 @@ int ddk750_init_hw(struct initchip_param *p_init_param)
>   		reg |= (VGA_CONFIGURATION_PLL | VGA_CONFIGURATION_MODE);
>   		poke32(VGA_CONFIGURATION, reg);
>   	} else {
> -#if defined(__i386__) || defined(__x86_64__)
> +#ifdef CONFIG_X86
>   		/* set graphic mode via IO method */
>   		outb_p(0x88, 0x3d4);
>   		outb_p(0x06, 0x3d5);

Maybe move the '} else {' into the ifdef to avoid the possibly empty 
else branch. I also wonder why this is only being done on x86. There are 
other systems with VGA.

In any case

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Best regards
Thomas


-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

