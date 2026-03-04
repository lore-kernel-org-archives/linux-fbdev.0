Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03834390996
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 07:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610569; cv=none; b=V8I+u37LVQAPTG24bpbUDeEnNhaVwHzqV2JJo8UJ/HKPllM7kMqbdn1wpgAXxGBC0DPVXhCSmKa0q7j4zfVKw5n2cnjK79aeuEFSZDzRHvOmTdANoTDL29XaswmJLJxK9hmwn5fveiF7WKNp9Z48C1igi9G4IbFi4ii0JHYDkJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610569; c=relaxed/simple;
	bh=Ptsooa83S1CASfyjl/UZrkjOoYYkIJfl/OgydCG8jTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+Kd5lOnJBHINWlYVSYIfbrxpbJn5r/9Xdt9wZF1pnm3SKG+mTAtK+BjcTOdwsA3K8UDS29bL1rjbiKOcRXocx0eZ20ZXyBfkpvkMSfYwJPegQL29CtYNTd6tBimTcIlicbb34i7jDEBqIRvzsdEkzI+yFDSlUXo8sLFXhLafVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JOHzt8Pk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YpT2lgvP; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=JOHzt8Pk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YpT2lgvP; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JOHzt8Pk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YpT2lgvP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="JOHzt8Pk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YpT2lgvP"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 31A5F5BCFF;
	Wed,  4 Mar 2026 07:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9GcoHhdz57AKUi73i1HZyMwQhjboDOatIKwOp2x820=;
	b=JOHzt8PktrvAmVh3rT44nBIJcW5RRtjlV9pkLEEpc33nnInoCzsoX2qgV3Lhg1GWiXlR+k
	yE92Ule1wLkFI92g9AiBud+9IQXTjo00+IXxsatOPVQDYcuWNKJwv2rhJtsW9I0/49MlIL
	G56zkLxOX4ulwl/zr2pilMXMRlEeQQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9GcoHhdz57AKUi73i1HZyMwQhjboDOatIKwOp2x820=;
	b=YpT2lgvPKLnq6hVt++dgXP0xWpQcBFJPL9NGqCtXikHI+mT+aAdulVgtYd9yOUHmwEIUEk
	N4UfTvlqiiol/TDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9GcoHhdz57AKUi73i1HZyMwQhjboDOatIKwOp2x820=;
	b=JOHzt8PktrvAmVh3rT44nBIJcW5RRtjlV9pkLEEpc33nnInoCzsoX2qgV3Lhg1GWiXlR+k
	yE92Ule1wLkFI92g9AiBud+9IQXTjo00+IXxsatOPVQDYcuWNKJwv2rhJtsW9I0/49MlIL
	G56zkLxOX4ulwl/zr2pilMXMRlEeQQc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=n9GcoHhdz57AKUi73i1HZyMwQhjboDOatIKwOp2x820=;
	b=YpT2lgvPKLnq6hVt++dgXP0xWpQcBFJPL9NGqCtXikHI+mT+aAdulVgtYd9yOUHmwEIUEk
	N4UfTvlqiiol/TDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 017813EA69;
	Wed,  4 Mar 2026 07:49:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kRiJOgDkp2lWYwAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 04 Mar 2026 07:49:20 +0000
Message-ID: <4aa49437-04ac-4789-8d10-9234ac596cc6@suse.de>
Date: Wed, 4 Mar 2026 08:49:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/13] vt: Store font in struct vc_font
To: Helge Deller <deller@gmx.de>, gregkh@linuxfoundation.org, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260302141255.518657-1-tzimmermann@suse.de>
 <20260302141255.518657-4-tzimmermann@suse.de>
 <7e17139f-47bf-4fec-b13f-d4a1b3a7a62d@gmx.de>
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
In-Reply-To: <7e17139f-47bf-4fec-b13f-d4a1b3a7a62d@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,ravnborg.org];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

Hi

Am 03.03.26 um 15:31 schrieb Helge Deller:
> On 3/2/26 15:08, Thomas Zimmermann wrote:
>> Replace struct console_font with struct vc_font for the type of the
>> vc_font field of struct vc_data. Struct console_font is UAPI, which
>> prevents further changes. Hence a new data type is required.
>>
>> Struct console_font has a documented vertical pitch of 32 bytes. This
>> is not the case after the font data has been loaded into the kernel.
>> Changing the type of vc_font addresses this inconsistency.
>>
>> The font data is now declared as constant, as it might come from the
>> kernel's read-only section. There's some fallout throughout the console
>> code where non-const variables refer to it. Fix them. A later update
>> will declare the font data to a dedicated data type.
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/video/fbdev/core/bitblit.c | 11 +++++------
>>   drivers/video/fbdev/core/fbcon.c   |  4 ++--
>>   drivers/video/fbdev/core/fbcon.h   |  4 ++--
>>   include/linux/console_struct.h     | 29 +++++++++++++++++++++++++++--
>>   4 files changed, 36 insertions(+), 12 deletions(-)
>>
> ....
>> diff --git a/include/linux/console_struct.h 
>> b/include/linux/console_struct.h
>> index ebdb9750d348..7fdcae6ed49c 100644
>> --- a/include/linux/console_struct.h
>> +++ b/include/linux/console_struct.h
>> @@ -13,8 +13,9 @@
>>   #ifndef _LINUX_CONSOLE_STRUCT_H
>>   #define _LINUX_CONSOLE_STRUCT_H
>>   -#include <linux/wait.h>
>> +#include <linux/math.h>
>>   #include <linux/vt.h>
>> +#include <linux/wait.h>
>>   #include <linux/workqueue.h>
>>     struct uni_pagedict;
>> @@ -58,6 +59,30 @@ struct vc_state {
>>       bool        reverse;
>>   };
>>   +/**
>> + * struct vc_font - Describes a font
>> + * @width: The width of a single glyph in bits
>> + * @height: The height of a single glyph in scanlines
>> + * @charcount: The number of glyphs in the font
>> + * @data: The raw font data
>> + *
>> + * Font data is organized as an array of glyphs. Each glyph is a 
>> bitmap with
>> + * set bits indicating the foreground color. Unset bits indicate 
>> background
>> + * color. The fields @width and @height store a single glyph's 
>> number of
>> + * horizontal bits and vertical scanlines. If width is not a 
>> multiple of 8,
>> + * there are trailing bits to fill up the byte. These bits should 
>> not be drawn.
>> + *
>> + * The field @data points to the first glphy's first byte. The value 
>> @charcount
>> + * gives the number of glyphs in the font. There are no empty 
>> scanlines between
>> + * two adjacent glyphs.
>> + */
>> +struct vc_font {
>> +    unsigned int width;
>> +    unsigned int height;
>> +    unsigned int charcount;
>
> I wonder if we shouldn't declare width and height as "u8" or "short 
> int" type?
> And charcount as u16 or "short int" ?
> Makes later calculations shorter & easier.

That would be a change to vt and possibly affect a lot of consoles. In 
any case, I'd rather do this separately.

Best regards
Thomas

>
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


