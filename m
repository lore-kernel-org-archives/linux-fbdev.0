Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BC5361654
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Feb 2026 12:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851055; cv=none; b=ksY8tMyQBjuDPUc6ghuxcjP5oKPYullUv5vBdy9gN5kOQBHCKMNpWWqfqvz+2SDLVimQVLLDxpZk5kz1a4mJXKZvuzWrebqc8adzmfavfZIIaCPnOEkt7q39kujr27oPR60KJxRcEUOQnp12hVVKneSgcQtpG2zOArRipl7emJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851055; c=relaxed/simple;
	bh=U1zrwXzl7s33sh7khhK7QgxCh+qW7AeG7hmzaugD5E4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CIMw3qE19lsurD7R8674aTRMGEpcTnNhl3sxmBaS/Ef4MdWeo+7oIVMkmtG4HG8O/3e89ieYdyeedgJpXmxldnVK3lTwZgSlF3u1Wp9gU2vvSMaiSrnMAyvmWbfVcxRWTjoU9t22lBEdPHZaScDcq9/tefR5xeHSr6M0T75qdbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OD8Ue7PE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGBNZT4Z; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=OD8Ue7PE; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hGBNZT4Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OD8Ue7PE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGBNZT4Z";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OD8Ue7PE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hGBNZT4Z"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C2BCD3EC9B;
	Mon, 23 Feb 2026 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771851052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=apw//bbHl+6HtIYypxcsVubkXJ1SaDNZkpxt6R5SX/I=;
	b=OD8Ue7PEAhZf8tByHTBHvPAwhFt9YXpLlHUn0qClh3SXKlIZhwWIRejbFkiTE9hySxcBnC
	SMG/LskoqeVI0GDGptBGiP722zM42c6lOnqnWdOgLlztW1mejItN9ZGgPZK4gH7IS6VUYK
	H0DwecmzcqqEMbhoSQ5uXZaalftLZew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771851052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=apw//bbHl+6HtIYypxcsVubkXJ1SaDNZkpxt6R5SX/I=;
	b=hGBNZT4ZhBaJ2c07/2KNYHCOhTIefQ0IEppqqRL61ZN9LtLqwYoD426VrBZykHUySC1BKI
	fowFet9uLBwhr/Ag==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OD8Ue7PE;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hGBNZT4Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1771851052; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=apw//bbHl+6HtIYypxcsVubkXJ1SaDNZkpxt6R5SX/I=;
	b=OD8Ue7PEAhZf8tByHTBHvPAwhFt9YXpLlHUn0qClh3SXKlIZhwWIRejbFkiTE9hySxcBnC
	SMG/LskoqeVI0GDGptBGiP722zM42c6lOnqnWdOgLlztW1mejItN9ZGgPZK4gH7IS6VUYK
	H0DwecmzcqqEMbhoSQ5uXZaalftLZew=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1771851052;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=apw//bbHl+6HtIYypxcsVubkXJ1SaDNZkpxt6R5SX/I=;
	b=hGBNZT4ZhBaJ2c07/2KNYHCOhTIefQ0IEppqqRL61ZN9LtLqwYoD426VrBZykHUySC1BKI
	fowFet9uLBwhr/Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 81F243EA68;
	Mon, 23 Feb 2026 12:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6Df/HSxNnGlpAQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 23 Feb 2026 12:50:52 +0000
Message-ID: <2afb371d-ce4f-46b6-bbd6-7b3554807a6e@suse.de>
Date: Mon, 23 Feb 2026 13:50:52 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] fbdev: defio: Protect against device/module removal
To: deller@gmx.de, simona@ffwll.ch, jayalk@intworks.biz
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260122131213.992810-1-tzimmermann@suse.de>
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
In-Reply-To: <20260122131213.992810-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de,ffwll.ch,intworks.biz];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: C2BCD3EC9B

ping for review

Am 22.01.26 um 14:08 schrieb Thomas Zimmermann:
> There's a long-standing bug in defio where the framebuffer device or
> module gets removed while mmap'ed areas of the framebuffer memory
> persists in userspace. Page faults in the area then operate on defined
> state.
>
> Patches 1 and 2 fix these problems. Patches 3 and 4 build upon the fix
> and put defio state into the correct places.
>
> Thomas Zimmermann (4):
>    fbdev: defio: Disconnect deferred I/O from the lifetime of struct
>      fb_info
>    fbdev: defio: Keep module reference from VMAs
>    fbdev: defio: Move variable state into struct fb_deferred_io_state
>    fbdev: defio: Move pageref array to struct fb_deferred_io_state
>
>   drivers/video/fbdev/core/fb_defio.c | 266 ++++++++++++++++++++--------
>   include/linux/fb.h                  |   9 +-
>   2 files changed, 195 insertions(+), 80 deletions(-)
>
>
> base-commit: a3ecd278f9a05323fab7471760a7ea10081251d6

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


