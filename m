Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CED22A1D1
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404185; cv=none; b=V2+KrVPoWkDP7PKm45N1LOo1EgSx7wg6Fmoy6oM66oEpzvGC63u7JoVb9xFhzh48mmPrR8ABbNB36p6s8+fFtbAbQxp1RxEs9482OZeXiAHA86Uog4/WmwKVwAWIhGkmN7RF8hpA6GxGyp4fYX+tx0zx8VJgkrVaWn+5diBVZo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404185; c=relaxed/simple;
	bh=XW/p25AVjOrug/C46qiK7sG7S9mHFwNOpgTu++jUpmg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VQHPdAnlduDzKvWem2g2WEQGk2kTtu42b5mAWuWBbua1+DohgyKJ1LGxpzI2NUg/F4iLC3cETanJAwBlAxEFxhuJq3H1vBzHWNuYyj8wNCy5jYPWycnEXDkvwfrXUMVY1oYOtyaPtq53DcmpPfJKMUjBn6gpWzez2BJXyotCnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G1m8Ir9x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ECjl+sBf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=G1m8Ir9x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ECjl+sBf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G1m8Ir9x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ECjl+sBf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="G1m8Ir9x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ECjl+sBf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6709721CC4;
	Thu, 14 Mar 2024 08:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710404176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rWpPuQPikGoYGJEWcBdFa8DojQVaxQawuk3Q7k+XD3k=;
	b=G1m8Ir9xfNLy+Ppksrs6UYYG+v0J81hFycBxNWIZCVw5msIzwYiyYQTFrjnwVe5GssCsx3
	nkP1Czl6x86T2Cv4GHq6vDl9jUEkG/EkrzIDaThULeQy90HqrAjv8Uqu/cpCYy+Kj6JU1g
	DTKdYu501Pj2mdOGfkpM0aIKvbEzYsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710404176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rWpPuQPikGoYGJEWcBdFa8DojQVaxQawuk3Q7k+XD3k=;
	b=ECjl+sBfI758MLVyZSRhXPJauxxAF+ORcfqBoSJDNtOqhaYURaUZQJufG7TGAxeBvcbRvK
	9vF/4XbMAf66wWDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710404176; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rWpPuQPikGoYGJEWcBdFa8DojQVaxQawuk3Q7k+XD3k=;
	b=G1m8Ir9xfNLy+Ppksrs6UYYG+v0J81hFycBxNWIZCVw5msIzwYiyYQTFrjnwVe5GssCsx3
	nkP1Czl6x86T2Cv4GHq6vDl9jUEkG/EkrzIDaThULeQy90HqrAjv8Uqu/cpCYy+Kj6JU1g
	DTKdYu501Pj2mdOGfkpM0aIKvbEzYsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710404176;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rWpPuQPikGoYGJEWcBdFa8DojQVaxQawuk3Q7k+XD3k=;
	b=ECjl+sBfI758MLVyZSRhXPJauxxAF+ORcfqBoSJDNtOqhaYURaUZQJufG7TGAxeBvcbRvK
	9vF/4XbMAf66wWDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2ADB2139E7;
	Thu, 14 Mar 2024 08:16:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id q6QCCVCy8mVlIAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 14 Mar 2024 08:16:16 +0000
Message-ID: <bf7b7e88-a7b4-427d-b38c-d3c9cc568aaf@suse.de>
Date: Thu, 14 Mar 2024 09:16:15 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] backlight/omap1-bl: Replace FB_BLANK_ states with
 simple on/off
Content-Language: en-US
To: Sam Ravnborg <sam@ravnborg.org>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
 deller@gmx.de, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-4-tzimmermann@suse.de>
 <20240313180027.GB96726@ravnborg.org>
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
In-Reply-To: <20240313180027.GB96726@ravnborg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.09 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 URIBL_BLOCKED(0.00)[suse.de:email];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[8];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.09
X-Spam-Flag: NO

Hi

Am 13.03.24 um 19:00 schrieb Sam Ravnborg:
> Hi Thomas,
>
> On Wed, Mar 13, 2024 at 04:45:02PM +0100, Thomas Zimmermann wrote:
>> The backlight is on for fb_blank eq FB_BLANK_UNBLANK, or off for
>> any other value in fb_blank. But the field fb_blank in struct
>> backlight_properties is deprecated and should not be used any
>> longer.
>>
>> Replace the test for fb_blank in omap's backlight code with a
>> simple boolean parameter and push the test into the update_status
>> helper. Instead of reading fb_blank directly, decode the backlight
>> device's status with backlight_is_blank().
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> My biased opinion is that the approach in this patch is a little bit
> better:
> https://lore.kernel.org/lkml/20230107-sam-video-backlight-drop-fb_blank-v1-13-1bd9bafb351f@ravnborg.org/
>
> I never came around resending this series it seems.

Oh, that series has been around for over a year. I don't care about 
which patches go in as long as they remove the dependency on 
<linux/fb.h>. I saw that Dan has already r-b'ed the current patchset, 
but if you prefer I'll adopt yours.

Best regards
Thomas

>
> 	Sam

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

