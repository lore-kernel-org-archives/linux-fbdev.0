Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8A741B36D
	for <linux-fbdev@vger.kernel.org>; Mon, 20 Jul 2026 12:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784552051; cv=none; b=tXsUa02CUB0SLwuJiRpx2tiGX6jcB4KirFFdNMPIO88v9/qAflI6+MJ3jbFtkOy4NL5UOy3UKxEPhwBUtVSbvrX51ADWdL+dS9WBIzgg+bb5a+JyMoCcyucwpiQhzAwJRzZ2zQlNbNoxgh/P7t2Ip7X9JcpJ6eXlj5HzgTV1vks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784552051; c=relaxed/simple;
	bh=3BXpfUn1GcNUGBvgl/Za+gVq96XyatWLFY3TTnu82lY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JYjqfldwOK+FCu+ZE/pOoqXSLR5wU2jWpKEkF7c3gS8JV0EzEQ1VggHxC+ZSDd28kbSwAiRGFBe8a2jTu8y+0C6Sh/DFlRAdOqDLmo1ieFkw6tTAq3+paqb1RyOIITFOc1bLwOIadcfvPerd3Y07GK1uVOQ4ez3GQgms1/j5dYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WYY/+mA9; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=yMjSEUZb; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=afmOYx48; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=tBCU2I2O; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WYY/+mA9";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="yMjSEUZb";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="afmOYx48";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tBCU2I2O"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F1DEE3E18;
	Mon, 20 Jul 2026 12:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784552044; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nu3HVN4UCPqGvSnbqRZyKknycEPtWdY/cFAQumZSAZQ=;
	b=WYY/+mA9gK/eaLkt20F8CpGx+RuvG8Nrxd8XFxluP1mmNo3p1gqR1nsquvknzxdyH4HACT
	Z+4REy11Wb8qfS8aVveD74Hf2D8sJxY0mv2M90eX1sDleS/P9F70RiD26a+SaZ/A0qbQaj
	DG3DJH6796PjfzkO7Ocn441qrSSQEfo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784552044;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nu3HVN4UCPqGvSnbqRZyKknycEPtWdY/cFAQumZSAZQ=;
	b=yMjSEUZbhFWjs/wa61mmFA/oE8FMk+FHDTEx3vBaaZyRR3+vgc8KZgap5R0ftIlRFghEgR
	Of8EjNQpz2fCpbAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=afmOYx48;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=tBCU2I2O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784552043; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nu3HVN4UCPqGvSnbqRZyKknycEPtWdY/cFAQumZSAZQ=;
	b=afmOYx48quxDVRFBjuswy3o+BgHT9dZZgh5AtPQAFxiC2o+mJa2GFnn+daUdHfS0AFBuMW
	g/dneCHFaXa6h7yIeGuQbz/Mn2bvw14bZhLzlb/5L6Sr5RZSivqB794Y6BaWdky7OVRE5X
	4su+BeSrGZ8jLi/uQwfl/sNiuDhg9YU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784552043;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Nu3HVN4UCPqGvSnbqRZyKknycEPtWdY/cFAQumZSAZQ=;
	b=tBCU2I2OUXTAZLg7VbfznJNS9/rWwQMW0IeuRrDry14NZVE6/T28EiNNCLxwj5gP5Jhtq5
	my9vRpSKKtVmZ1Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA025779AB;
	Mon, 20 Jul 2026 12:54:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id oqQfMGsaXmrEbgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 20 Jul 2026 12:54:03 +0000
Message-ID: <4e6880b7-0d25-458c-acec-9afce925ce01@suse.de>
Date: Mon, 20 Jul 2026 14:54:03 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fonts: fixup font.h kernel-doc warnings
To: Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org
Cc: Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org
References: <20260718191326.1907423-1-rdunlap@infradead.org>
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
In-Reply-To: <20260718191326.1907423-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[gmx.de,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,infradead.org:email,gmx.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:url]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F1DEE3E18
X-Spam-Score: -4.51



Am 18.07.26 um 21:13 schrieb Randy Dunlap:
> Use the typedef keyword when describing a typedef.
> Add the missing function return value for font_glyph_size().
>
> Warning: include/linux/font.h:84 cannot understand function prototype:
>    'typedef const unsigned char font_data_t;'
> Warning: include/linux/font.h:53 No description found for return value
>    of 'font_glyph_size'
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>

Thanks a lot for the bug fix.

> ---
> Cc: Helge Deller <deller@gmx.de>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: linux-fbdev@vger.kernel.org
>
>   include/linux/font.h |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> --- linux-next-20260717.orig/include/linux/font.h
> +++ linux-next-20260717/include/linux/font.h
> @@ -49,6 +49,8 @@ static inline unsigned int font_glyph_pi
>    * scanlines, which is usually the glyph's height in scanlines. Fonts
>    * coming from user space can sometimes have a different vertical pitch
>    * with empty scanlines between two adjacent glyphs.
> + *
> + * Returns: the number of bytes per glyph
>    */
>   static inline unsigned int font_glyph_size(unsigned int width, unsigned int vpitch)
>   {
> @@ -60,7 +62,7 @@ static inline unsigned int font_glyph_si
>    */
>   
>   /**
> - * font_data_t - Raw font data
> + * typedef font_data_t - Raw font data
>    *
>    * Values of type font_data_t store a pointer to raw font data. The format
>    * is monochrome. Each bit sets a pixel of a stored glyph. Font data does

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, (HRB 36809, AG Nürnberg)


