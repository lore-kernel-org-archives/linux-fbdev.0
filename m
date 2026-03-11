Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A93B388C
	for <linux-fbdev@vger.kernel.org>; Wed, 11 Mar 2026 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773215621; cv=none; b=Avzu+eVjyVrfvUE4CHZ/saE+P3m0DrNYOEbW98k4puuuNVEno8s8/YBcMeEeXR6+Wq8VGMO80Ixs6rjvHRh+tyChTPOXyP/7F1lj1zuRvQ424IO7X9uyGFqaq3lOrELA+ifsSi3FxP6DIsxPYNVURiGaIa5UrCPn+nRNH43d7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773215621; c=relaxed/simple;
	bh=7vnZPk8NGeIZNJc0ggl020/c9S50KRSzOmSXqjidH3s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IwHzG+tMrK86zWrY3F5wd4cJgpjvrBXkS9l+7OIYKgn6vnh1a78Gw5p1CRChWN6RKuMpPdsAUeVqe3RoDimQa3PY4wxKgPLhOPhx2WpYuqKskgpNa8Z1J8xkbjivhtOyhE2EudsVjSJnDH7i23mqw2RpbD0tZi7gdvy8lT0s+WQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RiEUsmPs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v+0roBFW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RiEUsmPs; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=v+0roBFW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RiEUsmPs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v+0roBFW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RiEUsmPs";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="v+0roBFW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3D96F5BD41;
	Wed, 11 Mar 2026 07:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773215615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LAC9vV01sRfAtMD2WvhmJMp7yOlWCmcwLShrkHMcnno=;
	b=RiEUsmPstWIrAZ4o7fT3T27M9Y+W0td/L6QspbEp8IO1kCL6sfjRBfRLOKjBpb6YoMv02O
	CWwBRLNVWQshrHgLrC41XHkZOU90BBlnkaS1LNAfcZe9LoekYvpGVVbVGz6XqdLwewSatF
	TU7yqRYEPu7CLZoEd3CSV41RC4id1f8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773215615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LAC9vV01sRfAtMD2WvhmJMp7yOlWCmcwLShrkHMcnno=;
	b=v+0roBFWixB72lBfpxqn9ZC724LZ6oy9jBnI9jpCQZgFkIwasR/JphhW6dEPZIAOYO3hJ1
	AtLvrxOADIhMpVDw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RiEUsmPs;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=v+0roBFW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1773215615; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LAC9vV01sRfAtMD2WvhmJMp7yOlWCmcwLShrkHMcnno=;
	b=RiEUsmPstWIrAZ4o7fT3T27M9Y+W0td/L6QspbEp8IO1kCL6sfjRBfRLOKjBpb6YoMv02O
	CWwBRLNVWQshrHgLrC41XHkZOU90BBlnkaS1LNAfcZe9LoekYvpGVVbVGz6XqdLwewSatF
	TU7yqRYEPu7CLZoEd3CSV41RC4id1f8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1773215615;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=LAC9vV01sRfAtMD2WvhmJMp7yOlWCmcwLShrkHMcnno=;
	b=v+0roBFWixB72lBfpxqn9ZC724LZ6oy9jBnI9jpCQZgFkIwasR/JphhW6dEPZIAOYO3hJ1
	AtLvrxOADIhMpVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12C8B3F8E8;
	Wed, 11 Mar 2026 07:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id niBnA38fsWkDbwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 11 Mar 2026 07:53:35 +0000
Message-ID: <ec79f4e9-5482-4d9a-8ac4-8df6586083b4@suse.de>
Date: Wed, 11 Mar 2026 08:53:34 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] Fonts: Adding all Terminus fronts from 12 to 32 in
 bold, and normal versions
To: Helge Deller <deller@kernel.org>, Pavel Nikulin <pavel@noa-labs.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org
References: <20260226073404.13511-1-pavel@noa-labs.com>
 <aaIFr-GKG1qiJYwg@p100>
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
In-Reply-To: <aaIFr-GKG1qiJYwg@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 3D96F5BD41
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

Hi

Am 27.02.26 um 21:59 schrieb Helge Deller:
> Hi Pavel,
>
> please include the graphics mailing lists (fbdev, dri-devel).
>
> * Pavel Nikulin <pavel@noa-labs.com>:
>> This patch adds an option to compile-in all terminus fonts, and removed the old bold only terminus version
>>
>> These fonts were converted from Terminus psf files with the help of psftools and a script.
>>
>> This patch is non-intrusive, no options are enabled by default so most users won't notice a thing.
> Sure, but you add a whole lot of fonts.
> Why are both bold and non-bold fonts needed?
> Why do we need all in-kernel?
> They may be loaded after bootup via userspace too.
>
> What does other people think?

I'm strongly against adding more fonts to the kernel. Fonts can (and 
should) be loaded from user space.

AFAICT this patch is just about someone trying to get their favorite 
font merged. Doing that is not going to work out long term.

Best regards
Thomas

>
> Helge
>
>   
>> I am placing my changes under the GPL 2.0 just as source Terminus font.
>>
>> Signed-off-by: Pavel Nikulin <pavel@noa-labs.com>
>> ---
>>   V4 -> V5: Added changed font.h to the patch
>>
>>   include/linux/font.h       |   42 +-
>>   lib/fonts/Kconfig          |  142 +-
>>   lib/fonts/Makefile         |   15 +
>>   lib/fonts/font_ter10x18.c  | 6412 ++++++++----------------------------
>>   lib/fonts/font_ter10x18b.c | 1305 ++++++++
>>   lib/fonts/font_ter10x20.c  | 1305 ++++++++
>>   lib/fonts/font_ter10x20b.c | 1305 ++++++++
>>   lib/fonts/font_ter11x22.c  | 1561 +++++++++
>>   lib/fonts/font_ter11x22b.c | 1561 +++++++++
>>   lib/fonts/font_ter12x24.c  | 1561 +++++++++
>>   lib/fonts/font_ter12x24b.c | 1561 +++++++++
>>   lib/fonts/font_ter14x28.c  | 1817 ++++++++++
>>   lib/fonts/font_ter14x28b.c | 1817 ++++++++++
>>   lib/fonts/font_ter16x32.c  | 4107 +++++++++++------------
>>   lib/fonts/font_ter16x32b.c | 2073 ++++++++++++
>>   lib/fonts/font_ter6x12.c   |  537 +++
>>   lib/fonts/font_ter8x14.c   |  537 +++
>>   lib/fonts/font_ter8x14b.c  |  537 +++
>>   lib/fonts/font_ter8x16.c   |  537 +++
>>   lib/fonts/font_ter8x16b.c  |  537 +++
>>   lib/fonts/fonts.c          |   45 +
>>   21 files changed, 22124 insertions(+), 7190 deletions(-)
>>   create mode 100644 lib/fonts/font_ter10x18b.c
>>   create mode 100644 lib/fonts/font_ter10x20.c
>>   create mode 100644 lib/fonts/font_ter10x20b.c
>>   create mode 100644 lib/fonts/font_ter11x22.c
>>   create mode 100644 lib/fonts/font_ter11x22b.c
>>   create mode 100644 lib/fonts/font_ter12x24.c
>>   create mode 100644 lib/fonts/font_ter12x24b.c
>>   create mode 100644 lib/fonts/font_ter14x28.c
>>   create mode 100644 lib/fonts/font_ter14x28b.c
>>   create mode 100644 lib/fonts/font_ter16x32b.c
>>   create mode 100644 lib/fonts/font_ter6x12.c
>>   create mode 100644 lib/fonts/font_ter8x14.c
>>   create mode 100644 lib/fonts/font_ter8x14b.c
>>   create mode 100644 lib/fonts/font_ter8x16.c
>>   create mode 100644 lib/fonts/font_ter8x16b.c

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


