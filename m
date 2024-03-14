Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215155D731
	for <linux-fbdev@vger.kernel.org>; Thu, 14 Mar 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710403774; cv=none; b=kNgN2aeX8IqbhCjxn1jZldr87TDblTr4UzuR7M6xvdO3gTFokpu1Vwqtoj54t/AnHZN6r7P0fQ9uEskj0SQQSMRy4I43kqHKx6u4t05mhDj+DAoSGVFDP9+LWB1aJ3EGyZG6JJc6JqYqCmY5OUE8LU7k2fuVTlkPpNS6vkuZKUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710403774; c=relaxed/simple;
	bh=jvA7Tf0gVyPqn9q/4raVbwh9AuaNLMla77yD1XR32JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n12saVj7Cz1yDefmt5OIO1QR+dXjif8LzjTtUznS+bWSkcfMCPIAmXD2jJBn88j2oGsENDQ238HnbVKm9nxJaofqv86/WyPMrranDouL7i96Ug+02PG4Qyref3RB47iPQqjnJT7GDMAHPod8ESwFBWePBCtV5yrNdY0YJNd8PrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w/frsO9v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YQJLL+pe; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=w/frsO9v; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YQJLL+pe; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w/frsO9v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YQJLL+pe";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w/frsO9v";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YQJLL+pe"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F97E1F813;
	Thu, 14 Mar 2024 08:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710403771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OXsoJdwthfxseiuRkEHlo9tV1JLIcCtYreIwZngMfH0=;
	b=w/frsO9viiD2WCPbq2chXoemepyvOfA/u9jsxljHGv1YLjLTFkzOwZicneRdpExJsza743
	hoxmb240/950sOMEeEjPS1GV9mjjMlatzjLRzLgx6qL8qyEqEHNNG963baREhC+SpjYWmD
	OTP5e8cARHnBNkbLno0HPuv1jxpcmVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710403771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OXsoJdwthfxseiuRkEHlo9tV1JLIcCtYreIwZngMfH0=;
	b=YQJLL+peahm2cmmQXdnHI4l2sbrkr0ml6SNAulegqUoD7swFNQDj/TDB3glNLmmZ2hiiOv
	t0tygG1h3bqCSJDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1710403771; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OXsoJdwthfxseiuRkEHlo9tV1JLIcCtYreIwZngMfH0=;
	b=w/frsO9viiD2WCPbq2chXoemepyvOfA/u9jsxljHGv1YLjLTFkzOwZicneRdpExJsza743
	hoxmb240/950sOMEeEjPS1GV9mjjMlatzjLRzLgx6qL8qyEqEHNNG963baREhC+SpjYWmD
	OTP5e8cARHnBNkbLno0HPuv1jxpcmVQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1710403771;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=OXsoJdwthfxseiuRkEHlo9tV1JLIcCtYreIwZngMfH0=;
	b=YQJLL+peahm2cmmQXdnHI4l2sbrkr0ml6SNAulegqUoD7swFNQDj/TDB3glNLmmZ2hiiOv
	t0tygG1h3bqCSJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 879AB139D0;
	Thu, 14 Mar 2024 08:09:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D/nEH7qw8mULHgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 14 Mar 2024 08:09:30 +0000
Message-ID: <f17e7660-ea10-4d5b-8234-79251c4c3483@suse.de>
Date: Thu, 14 Mar 2024 09:09:30 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] auxdisplay/ht16k33: Replace use of fb_blank with
 backlight helper
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
 deller@gmx.de, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Robin van der Gracht <robin@protonic.nl>,
 Miguel Ojeda <ojeda@kernel.org>
References: <20240313154857.12949-1-tzimmermann@suse.de>
 <20240313154857.12949-2-tzimmermann@suse.de>
 <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com>
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
In-Reply-To: <CANiq72=5V_XChzDhaaWNC+B4LP7gqivPZj5Y10qqS4SkQTGB_A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -0.44
X-Spamd-Result: default: False [-0.44 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MID_RHS_MATCH_FROM(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 BAYES_HAM(-0.65)[82.60%];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux-m68k.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[kernel.org,linaro.org,gmail.com,gmx.de,lists.freedesktop.org,vger.kernel.org,lists.linux.dev,protonic.nl];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

Hi

Am 13.03.24 um 17:08 schrieb Miguel Ojeda:
> Hi Thomas,
>
> Thanks for this!
>
> Cc'ing Andy and Geert -- the new maintainer and reviewer.

Ah, sorry. They are not yet in my MAINTAINERS file.

>
> Also, a couple quick notes below since I am here...
>
> On Wed, Mar 13, 2024 at 4:49 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Replace the use of struct backlight_properties.fb_blank with a
>> call to backlight_get_brightness(). The helper implement the same
>> logic as the driver's function.
> It is not exactly the same logic since `backlight_is_blank` accounts
> for `BL_CORE_SUSPENDED`.

As Sam already said, it doesn't seem to make different in practice. I'd 
mention it in the commit message and that's it. Ok?

Best regards
Thomas

>
>> -       int brightness = bl->props.brightness;
>> +       int brightness = backlight_get_brightness(bl);
> This can be `const` now (or even removed and have the call embedded below).
>
> Cheers,
> Miguel

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

