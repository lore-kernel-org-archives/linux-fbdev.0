Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792506013;
	b=PC9nPN1OdKkIjjCjg0hzClE+4Y+jxVH0KAv0TvwdYv4T+hO2GrPOLyV0m0k44fL6tfff
	 7pc2MynVdl3g1UEIhzp8ou42idoBGIYKWp+Xa7gjeTFHkr7PuTjZHY2ad+5+u9WPWc1Dn
	 fUx4Sefji/9ZMKiK3IA16EOB+Q0xI6cUAVIfISz+RII5vKPEOmrGtXwFtyx0acPegS0gn
	 zDctRSd8xjqyLTU0EDo7bbcFeosNLYye62c14eH7akVNL2K+WU7uQ0weLkwxpxl70eHb7
	 WB7rACyAW7n5Ppm/hXfmJvDAm0OVx5TnqcPgHEJUuygnWu48X53lfzvqIRrD5FHzdqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792506013;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:Autocrypt:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Rspamd-Action:
	 X-Spam-Score:X-Spam-Flag:X-Spamd-Result:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Server;
	bh=SmACJ5ImeA4jhsWaSnzEwpEiAY21R9/zUYMOxhaTCq8=;
	b=XWWBbgOQUEs40R0PNelXbGwoZ3RsN9E2xL/tUUGFnsBQcRUreeP4CXS6+ItezgYcgaPd
	 LMNeY6bWrBEg4hNV38IWR1Hc2KkRd/Zc13HlwVEcAnGEHeuS13bmrEmojJA8QsqAkUMRY
	 K/4bWM0yHjytKr9RvJxEZybkErE0jAvAXxlQPyGJ7offmOdiybtTf2N0AG1/rlmWA5tSY
	 MVe3wONHXlKGbbvEn065nGsESFKIl7DTUi56YO987S7k5LJ1XKTPt9ajsiZ4ALJGPll2x
	 p7beHoG9ig5xn66mCO5f3a9h1LhjpxEQmtG3WPkW4UmvkIzTldOoGksr1CJ54lfeZaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XRrgZtb9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hOeOixJY;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XRrgZtb9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hOeOixJY;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5781606AA3A;
	Tue, 20 Oct 2026 14:20:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5781606AA3A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XRrgZtb9;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hOeOixJY;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=XRrgZtb9;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hOeOixJY
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B77B91F7BF;
	Tue, 20 Oct 2026 14:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792506010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SmACJ5ImeA4jhsWaSnzEwpEiAY21R9/zUYMOxhaTCq8=;
	b=XRrgZtb9byCiA7gg9YsBW8YDREYicc870ibHP/Yn+nAX0RL7RilZvZs7EQcwqALYvofrxC
	6qLnKx2aRBDL00rYxi5FGIS1im1TiPoCd4I2apRSq0wS1D63xE/k9FYBdITGxGlnCGo6xb
	U1qd2aDnU4Dwx9xk6hzOUScPySwFVJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792506010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SmACJ5ImeA4jhsWaSnzEwpEiAY21R9/zUYMOxhaTCq8=;
	b=hOeOixJYNInJ4c82kb2caxt1dSgPvdVzw1xJKGQYwlIiPApLHTYqpx/pbqJg11HZBII6Ft
	PPpLF6h7TbL89ZAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XRrgZtb9;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=hOeOixJY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792506010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SmACJ5ImeA4jhsWaSnzEwpEiAY21R9/zUYMOxhaTCq8=;
	b=XRrgZtb9byCiA7gg9YsBW8YDREYicc870ibHP/Yn+nAX0RL7RilZvZs7EQcwqALYvofrxC
	6qLnKx2aRBDL00rYxi5FGIS1im1TiPoCd4I2apRSq0wS1D63xE/k9FYBdITGxGlnCGo6xb
	U1qd2aDnU4Dwx9xk6hzOUScPySwFVJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792506010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=SmACJ5ImeA4jhsWaSnzEwpEiAY21R9/zUYMOxhaTCq8=;
	b=hOeOixJYNInJ4c82kb2caxt1dSgPvdVzw1xJKGQYwlIiPApLHTYqpx/pbqJg11HZBII6Ft
	PPpLF6h7TbL89ZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 62EB1136C6;
	Tue, 20 Oct 2026 14:20:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id D46CBpp412pvNQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 20 Oct 2026 14:20:10 +0000
Message-ID: <83bd672d-69d8-4362-beb2-9dc1fb64fa72@suse.de>
Date: Tue, 20 Oct 2026 16:20:09 +0200
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/3] fbcon: fix rotated font buffer handling on font
 change
To: Yao Yiqi <yyaqia@gmail.com>, deller@gmx.de, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaoyiqi3@huawei.com
References: <20261019094331.1128871-1-yyaqia@gmail.com>
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
In-Reply-To: <20261019094331.1128871-1-yyaqia@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spam-Score: -4.50
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_TO(0.00)[gmail.com,gmx.de,ffwll.ch];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Rspamd-Queue-Id: B77B91F7BF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

Hi,

for the series:

Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

although I cannot claim to understand fbcon code in its entirety.

Best regards
Thomas


Am 19.10.26 um 11:43 schrieb Yao Yiqi:
> Fix out-of-bounds reads of the rotated font buffer when the console
> font changes on a rotated console (fbcon=rotate:N). KDFONTOP installs
> the new geometry and vc_resize() redraws before par->rotated.buf is
> updated, so the old buffer is indexed with the new cell size.
>
> Patch 1 keys the rotated font cache on the font geometry. Patch 2
> rebuilds it on font changes, saving and restoring the whole cache if
> the change fails. Patch 3 retries a failed allocation.
>
> Changes since v4: save, clear and restore the entire par->rotated
> state instead of only the buffer; restoring just the buffer left the
> cache key describing the rejected font, which could make a later
> switch skip the rebuild and index the smaller buffer with the larger
> font's geometry (found by the Sashiko review).
>
> v4: https://lore.kernel.org/all/20261019090206.1094958-1-yyaqia@gmail.com/
> v1: https://lore.kernel.org/all/20261014085102.497789-1-yaoyiqi3@huawei.com/
>
> Yao Yiqi (3):
>    fbcon: Include font geometry in the rotated font cache
>    fbcon: Rebuild rotated font buffer on font change
>    fbcon: Retry rotated font allocation after failure
>
>   drivers/video/fbdev/core/fbcon.c        | 46 ++++++++++++++++++++++++++
>   drivers/video/fbdev/core/fbcon.h        | 19 ++++++----
>   drivers/video/fbdev/core/fbcon_rotate.c | 10 ++++++-
>   3 files changed, 68 insertions(+), 7 deletions(-)
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


