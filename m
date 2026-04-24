Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F00D312803
	for <linux-fbdev@vger.kernel.org>; Fri, 24 Apr 2026 07:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777014072; cv=none; b=jTBbdoctqOGKu0bwiclHe2//ry3pFYOViIDSuc20mv+9G+nbbEfspCwKGUMi+DV2U2hYW/tif5hZosAIuR2fHcnlgOzXgLk3c8vF5RJm2CcL8kjXIXJIBcIFl3Ngms2qPK/0OCg/xW2YQVvd7frYgIG2DM3DOKWxvz9rAu1f0+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777014072; c=relaxed/simple;
	bh=TK9hRTBEkO6agBB511nJ67+WB1RNKeYPlyRhTDeMSiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cfCf6tdMVVWc8OhQBF/05IS9X5QEQbqNTZ5MMdu1poidfo1ReLPoDKDRFJQrcGNcXHNH7/a9qAoFFnbwuK+K1YoZwPv/KyWVUsFudQhJIrS3ajWXcxg2SGmUTJ/qp+6Xm/fYacBOb0pfbAEZNFYdzJoZnz56GCpVDqWBQZ9hNa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ud1fMhXP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JoN43IzU; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Ud1fMhXP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=JoN43IzU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ud1fMhXP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JoN43IzU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Ud1fMhXP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JoN43IzU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C2A66A868;
	Fri, 24 Apr 2026 07:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777014068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcDw3SmHn6azaUYd/HnTWiFfP8SiOlim6taDP1r8Nv4=;
	b=Ud1fMhXPms6im4si/dXQzqkOPSlI+srn7dRjCkTCRQz5UUSiakM25pgMEJ/dLEmRDu8BIg
	b7ZH27WIhze6cbRHbJQEXETDKKq8QTgcNvJWyd9LFFZLkdYKLWd1ax8DYFOfm5j9CnPTgy
	Is1Bj+CQ6btTKfsfyw9umQg7yIxt62U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777014068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcDw3SmHn6azaUYd/HnTWiFfP8SiOlim6taDP1r8Nv4=;
	b=JoN43IzUzgIOMQ9xHX5VXtfIcR7yk2qBhLXlqGRau9tM9FCFrnAbSg9CXVXaV9E+u6TK65
	rvKGm/6QMSQu24BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1777014068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcDw3SmHn6azaUYd/HnTWiFfP8SiOlim6taDP1r8Nv4=;
	b=Ud1fMhXPms6im4si/dXQzqkOPSlI+srn7dRjCkTCRQz5UUSiakM25pgMEJ/dLEmRDu8BIg
	b7ZH27WIhze6cbRHbJQEXETDKKq8QTgcNvJWyd9LFFZLkdYKLWd1ax8DYFOfm5j9CnPTgy
	Is1Bj+CQ6btTKfsfyw9umQg7yIxt62U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1777014068;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GcDw3SmHn6azaUYd/HnTWiFfP8SiOlim6taDP1r8Nv4=;
	b=JoN43IzUzgIOMQ9xHX5VXtfIcR7yk2qBhLXlqGRau9tM9FCFrnAbSg9CXVXaV9E+u6TK65
	rvKGm/6QMSQu24BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 619F8593AE;
	Fri, 24 Apr 2026 07:01:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eGs5FjQV62k6LQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Fri, 24 Apr 2026 07:01:08 +0000
Message-ID: <39ecf9f1-fd8d-4946-bb09-1041150d99eb@suse.de>
Date: Fri, 24 Apr 2026 09:01:07 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/todo: Drop todo item to request memory regions in all
 fbdev drivers
To: Geert Uytterhoeven <geert@linux-m68k.org>, Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20260423205531.49971-1-deller@gmx.de>
 <CAMuHMdVOk3ejrM5EkOBRjc0rQsSGU7TP+Kgd4=DzYuiF8m8Mzw@mail.gmail.com>
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
In-Reply-To: <CAMuHMdVOk3ejrM5EkOBRjc0rQsSGU7TP+Kgd4=DzYuiF8m8Mzw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[linux-m68k.org,gmx.de];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.30
X-Spam-Level: 

Hi

>> -Contact: Thomas Zimmermann <tzimmermann@suse.de>
>> -
>> -Level: Starter
> I am not really against keeping this item. But as the related changes
> are not pure refactorings, and cause a change in behavior, they _must_
> be tested on actual hardware.  I guess making that explicit would be a
> bit silly (heck, all changes should be tested).  And bumping the level
> to intermediate might send the wrong message, too (starters don't need
> to test? Doh...)
>
> Thomas: do we still any hardware for which there exist both DRM and
> fbdev drivers, and the resource management is missing in the fbdev
> drivers?

See my other reply on why this item exists. It's also about hand-over 
during boot up, which could affect any/most driver.

We can remove the item now, if that helps, but it might lead to other 
bug reports later on.

Best regards
Thomas



>
>> -
>>   Remove driver dependencies on FB_DEVICE
>>   ---------------------------------------
>>
> Gr{oetje,eeting}s,
>
>                          Geert
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


