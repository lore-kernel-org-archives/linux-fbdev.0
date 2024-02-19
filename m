Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DA623741
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Feb 2024 09:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708335068; cv=none; b=LnqqoG+wFh5YRygn1nSPj1OZ8jv8sE7WrFbucNxZedA6ue3x/JI4ZzwVet5ABe/wh1vqnFBZUjLXrfXiPDfnBAlqeTQE1HYGJ+lahOO2z/ZpXO/mLdJQH1NauhPL/WrxMfVHMBSBN0Ra7YGSfcIRY5+bHENeDYueJgzGRbGsRfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708335068; c=relaxed/simple;
	bh=9N8TmD3r/XO2d7eSLrCMuYRQLdR88FTfA84Blpq13Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hruWOwJfRwuQA+COhSD0Cj1iyHMPErIIUvKy19rDesBkHeAexrkS/+RQg74BNxp+ffpd0l0Br7FoWjj7Nd2us2PM184LlWW/W9l2MXii4mooT243Kd4m9eRf+vf9DRGJjwjGuR7sa9wgmldRKv4tgg+FmL5oYgvpP6GVOAHbgiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=lfOkbKCi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g1FYU3iW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=blwaylYH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vKF5NHZD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="lfOkbKCi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g1FYU3iW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="blwaylYH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vKF5NHZD"
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 393342206A;
	Mon, 19 Feb 2024 09:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y/D66OSEdyzmFopZiKMpHruDnoXXVOF3XH6nd8SJXkQ=;
	b=lfOkbKCi4ahpqMn+NeVOrzi1OsiafPu9Xy36QJEQlYn3DM3Omk59Vgi+htm7PMrwIEyB42
	1VJhr298RqVH06Ubyz6eSHrLM7YLMF332e6cALEP3/r8WGGWSokftgWSoMQJMOqhRNt7AQ
	z7/0+8bqxK65KJlB8SGF7IW/lQy1nXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335064;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y/D66OSEdyzmFopZiKMpHruDnoXXVOF3XH6nd8SJXkQ=;
	b=g1FYU3iWx/6/NotX9cm6OVa9xXjz8/MJqeGLBr7c24b/9F+8265u5CZ3GBYt8pyTEiPn9F
	cQTyCq1sgY+pcHAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1708335062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y/D66OSEdyzmFopZiKMpHruDnoXXVOF3XH6nd8SJXkQ=;
	b=blwaylYHeCH2C5R4qFf0n2eJOKCodP93xLcP5FClM09wXP9ER00fpqDK1rw1V9l0rbhTVy
	lBECg1qCnH0J50J9VoYYlxs6jQGa0879MCs99IB0C54IPLuPuhUdSt3O7IhgFh8YvvS/+X
	Zd1Ge/vZHwnzCphIRVYVEblZHqtBZYg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1708335062;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=y/D66OSEdyzmFopZiKMpHruDnoXXVOF3XH6nd8SJXkQ=;
	b=vKF5NHZD1dp07F/XhgD8zKRTBAD9GeDARvJz4hhD0cCWIp1ycOKx6HLszxOAvsLlYZgEQ2
	4Sm8wGGJcMuMDlBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D4E9613585;
	Mon, 19 Feb 2024 09:31:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id OnqEMtUf02XBTgAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Feb 2024 09:31:01 +0000
Message-ID: <4c25b689-ab92-4e84-b54c-e80f511e10c7@suse.de>
Date: Mon, 19 Feb 2024 10:31:01 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/8] fbdev: Clean up include dependencies in header
Content-Language: en-US
To: deller@gmx.de, kherbst@redhat.com, lyude@redhat.com, dakr@redhat.com,
 jani.nikula@linux.intel.com, daniel@ffwll.ch, airlied@gmail.com,
 gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-staging@lists.linux.dev
References: <20240213084403.20995-1-tzimmermann@suse.de>
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
In-Reply-To: <20240213084403.20995-1-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=blwaylYH;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vKF5NHZD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.82 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 TO_DN_NONE(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 BAYES_HAM(-0.32)[75.68%];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[12];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[gmx.de,redhat.com,linux.intel.com,ffwll.ch,gmail.com,linuxfoundation.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.82
X-Rspamd-Queue-Id: 393342206A
X-Spam-Flag: NO

A-b'd by Helge via email

Acked-by: Helge Deller <deller@gmx.de>

Am 13.02.24 um 09:42 schrieb Thomas Zimmermann:
> Remove unnecessary dependencies in the include statements of the
> header file <linux/fb.h>. Several files throughout the kernel include
> the fbdev header, so reducing dependencies positively affects other
> subsystems as well. Also fix up nouveau and fbtft, which need backlight.h
> in some their source files.
>
> v2:
> 	* include backlight.h in fbtft (kernel test robot)
>
> Thomas Zimmermann (8):
>    drm/nouveau: Include <linux/backlight.h>
>    staging/fbtft: Include <linux/backlight.h>
>    fbdev: Do not include <linux/backlight.h> in header
>    fbdev: Do not include <linux/fs.h> in header
>    fbdev: Do not include <linux/notifier.h> in header
>    fbdev: Do not include <linux/slab.h> in header
>    fbdev: Clean up forward declarations in header file
>    fbdev: Clean up include statements in header file
>
>   drivers/gpu/drm/nouveau/dispnv50/disp.c |  1 +
>   drivers/staging/fbtft/fb_ssd1351.c      |  2 ++
>   include/linux/fb.h                      | 24 +++++++++++++-----------
>   3 files changed, 16 insertions(+), 11 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

