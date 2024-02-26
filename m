Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FDB7F7D0
	for <linux-fbdev@vger.kernel.org>; Mon, 26 Feb 2024 12:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708951714; cv=none; b=IUoQiALGKZSWXBgkDnJ41rUnUcvinB3J/aYN9h+Go6g66AE0UqBLBcMCmcPZqQk65u+4C15a3gumOBLDPEulACx/DA6FNMmrW/g30vRzbAbqDaVXSngeXVwrmv9Yyqjk6IqMuerfqKJf5RqO3QbZD5eIARFgDvgVPmRuAAi5IJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708951714; c=relaxed/simple;
	bh=+3SSREt7+QPaoxVoW24m1Ju+wFzu9FS3G5fdc8m4/o8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O2QKtXSB1eekyKmgjP1SI4bMRh5O6Yt+dK45WXRT77IVE5FH0fOISvo0xm7yvx/WF2Wzlz+QS7FL82+aBxMKlohfRnrfOGljF6FEZTOHJ4WWLXQoDKqIeG+SbosQZLSTrpFtUC6jHax4Czp6ipjAwVeFCfZGzrzwfIQkrB/+lDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1BgsPHXk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uANRUQk/; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1BgsPHXk; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=uANRUQk/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1BgsPHXk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uANRUQk/";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1BgsPHXk";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="uANRUQk/"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 406721FB57;
	Mon, 26 Feb 2024 12:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708951711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hKEJigZRazKV8h2ggpYZOZoxQt9rD8CsSODsHh0tjGA=;
	b=1BgsPHXk5blf0Xvh3FJgGsCLagIHaojQgm0WJPscjPMXlr+14BNxy56ADfAZOqtE+vLM4L
	0Iq5kjcn0J5D33JZmlI3O/GgxJ0VIaER+WoJ4kBZCah6OmoqUw47keU0vIOzPCZv7yFvfY
	p23X3Bu2dwApvBUfdyeNYA7iSLmHlXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708951711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hKEJigZRazKV8h2ggpYZOZoxQt9rD8CsSODsHh0tjGA=;
	b=uANRUQk/6Wuu9ZvtHQTFQ6v2BHmz9qXvCYwwmvGNMhfsfx1t8RAYsXkrAOuoau1rrIVOm9
	ss1YODVb78nv6TBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708951711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hKEJigZRazKV8h2ggpYZOZoxQt9rD8CsSODsHh0tjGA=;
	b=1BgsPHXk5blf0Xvh3FJgGsCLagIHaojQgm0WJPscjPMXlr+14BNxy56ADfAZOqtE+vLM4L
	0Iq5kjcn0J5D33JZmlI3O/GgxJ0VIaER+WoJ4kBZCah6OmoqUw47keU0vIOzPCZv7yFvfY
	p23X3Bu2dwApvBUfdyeNYA7iSLmHlXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708951711;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=hKEJigZRazKV8h2ggpYZOZoxQt9rD8CsSODsHh0tjGA=;
	b=uANRUQk/6Wuu9ZvtHQTFQ6v2BHmz9qXvCYwwmvGNMhfsfx1t8RAYsXkrAOuoau1rrIVOm9
	ss1YODVb78nv6TBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C2B5E1329E;
	Mon, 26 Feb 2024 12:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id ZFVqLZ6I3GUdSAAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 26 Feb 2024 12:48:30 +0000
Message-ID: <62ad32cb-3fd1-4c21-ab2c-a194e559d12a@suse.de>
Date: Mon, 26 Feb 2024 13:48:29 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] backlight/corgi-lcd: Include <linux/backlight.h>
Content-Language: en-US
To: Lee Jones <lee@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>
Cc: deller@gmx.de, kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
 daniel@ffwll.ch, airlied@gmail.com, gregkh@linuxfoundation.org,
 Daniel Thompson <daniel.thompson@linaro.org>,
 Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-staging@lists.linux.dev
References: <20240219093941.3684-1-tzimmermann@suse.de>
 <20240219093941.3684-2-tzimmermann@suse.de>
 <1e577f18-c6f7-44e7-b50f-720915f257eb@suse.de>
 <20240223105652.GT10170@google.com> <874jdvo3ia.fsf@intel.com>
 <20240226123313.GA23065@google.com>
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
In-Reply-To: <20240226123313.GA23065@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -4.29
X-Spamd-Result: default: False [-4.29 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-3.00)[100.00%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[15];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 FREEMAIL_CC(0.00)[gmx.de,redhat.com,ffwll.ch,gmail.com,linuxfoundation.org,linaro.org,vger.kernel.org,lists.freedesktop.org,lists.linux.dev];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Flag: NO

Hi

Am 26.02.24 um 13:33 schrieb Lee Jones:
> On Mon, 26 Feb 2024, Jani Nikula wrote:
>
>> On Fri, 23 Feb 2024, Lee Jones <lee@kernel.org> wrote:
>>> On Wed, 21 Feb 2024, Thomas Zimmermann wrote:
>>>
>>>> cc'ing backlight maintainers
>>> I cannot review/accept patches like this.
>>>
>>> Please submit a [RESEND].
>> I bounced the original [1] to you. Please consider acking to merge the
>> one-line #include addition via fbdev so we don't have to respin the
>> series for no good reason.
> The "good reason" would be that it was not sent properly in the first
> place.  My kernel.org mail is filtered by the recipients headers.  If
> the original wasn't sent to me, bouncing won't work either.  I've since
> reviewed the patch and seen the set on LORE.  This is non-optimal.
> Please use get_maintainer.pl next time.
>
> This time only, patch is:
>
> Acked-by: Lee Jones <lee@kernel.org>

No problem, I'll send out another series. I just didn't get to do it.

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

