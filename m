Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EAF33D81
	for <linux-fbdev@vger.kernel.org>; Tue,  7 Oct 2025 07:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759822506; cv=none; b=pynd1zNUR0EiXxL526KTzrlxJ2fSxRZp5F1QKZB15eD4OkcyIxkyGUj4E5W/Q+D+YWkwqQqAGu+L/fbadbmIPc3W+BN6gvdQ9wL8Y5k449/4+zoEfqrh2FeIkaiWdTNfmiqaUiiCaNNRj6N6fpPnFfss/EUNJsZNMhXcJV0Wh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759822506; c=relaxed/simple;
	bh=4RQoSJwyG0CBoyUz4X7AO1wBYwylVJf97i1JKIe8RsA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TWKBiqnvJT80G3gD9j9YeX/0GsCe91u8VZbCGYZ7b5GfvY4Miyc1SPqN+bt55SIlQj8gKIJvRo+teOEEWDumzgcbLeGOs42FC/saUeLoAp809SO3kUSgwcOaD6q8acoXIRoyOxCR4kGr7c8bIj+vcmehLhtRaKGKm/arJv2ziWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F3IAZa9V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bfJwPtMS; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=F3IAZa9V; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bfJwPtMS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F3IAZa9V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bfJwPtMS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="F3IAZa9V";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bfJwPtMS"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 76B601F78F;
	Tue,  7 Oct 2025 07:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759822502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vvFbZ+0VV9H5Bhjv8F8h8LAAyhywyDVWF/24Dt4ofAg=;
	b=F3IAZa9VIUy/qQm2ohx7x6Ru8MkalPUc8i8waVw8yXLf9r3OLlt0rS19AyFeZmg/DkMle1
	sxB6b/C6cSkn8lBuKH12tGKfTCjXHXaKddrNl7kAOf3c62hCbbJUQcspmDULS8PBgo6xQn
	TPjkiQ1yRiF/rOb7w1FqyixAWp0xN4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759822502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vvFbZ+0VV9H5Bhjv8F8h8LAAyhywyDVWF/24Dt4ofAg=;
	b=bfJwPtMSQuCiWwwtyBJ2Mo3R5A0vYuUWSXFpUin4M94ZjZB+tlXIOrV/nhXNFTkPxFANbO
	h+rz6AIOPvqBZyDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759822502; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vvFbZ+0VV9H5Bhjv8F8h8LAAyhywyDVWF/24Dt4ofAg=;
	b=F3IAZa9VIUy/qQm2ohx7x6Ru8MkalPUc8i8waVw8yXLf9r3OLlt0rS19AyFeZmg/DkMle1
	sxB6b/C6cSkn8lBuKH12tGKfTCjXHXaKddrNl7kAOf3c62hCbbJUQcspmDULS8PBgo6xQn
	TPjkiQ1yRiF/rOb7w1FqyixAWp0xN4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759822502;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=vvFbZ+0VV9H5Bhjv8F8h8LAAyhywyDVWF/24Dt4ofAg=;
	b=bfJwPtMSQuCiWwwtyBJ2Mo3R5A0vYuUWSXFpUin4M94ZjZB+tlXIOrV/nhXNFTkPxFANbO
	h+rz6AIOPvqBZyDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0862913693;
	Tue,  7 Oct 2025 07:35:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7s1TAKbC5GisKQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 07 Oct 2025 07:35:01 +0000
Message-ID: <6b1f8366-7ec8-4c1f-9563-29e06a8060e2@suse.de>
Date: Tue, 7 Oct 2025 09:35:01 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fbdev: udlfb: make CONFIG_FB_DEVICE optional
To: Helge Deller <deller@gmx.de>, sukrut heroorkar <hsukrut3@gmail.com>,
 Mikulas Patocka <mpatocka@redhat.com>
Cc: David Hunter <david.hunter.linux@gmail.com>,
 kernel test robot <lkp@intel.com>, Bernie Thompson <bernie@plugable.com>,
 Arnd Bergmann <arnd@arndb.de>, Randy Dunlap <rdunlap@infradead.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zsolt Kajtar <soci@c64.rulez.org>,
 Gonzalo Silvalde Blanco <gonzalo.silvalde@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, skhan@linuxfoundation.org
References: <20250924175743.6790-1-hsukrut3@gmail.com>
 <202509272320.3K8kdDCw-lkp@intel.com>
 <bb9d90ca-aa4d-4168-bdc5-543109c74493@gmail.com>
 <CAHCkknrZ-ieNKeg-aj3-NVqgGSk770jJpUpCvn_SuffkPu+ZrQ@mail.gmail.com>
 <edccab86-321b-4e6e-998f-3ce320ee0193@gmx.de>
 <41ef536d-2399-43f8-8041-c6b0e642aba2@suse.de>
 <CAHCkknrAKGxzAYE-R3QX20W4faR9Wfjgn37peyHRJcZ6PRLENA@mail.gmail.com>
 <c1d86274-44e2-4ceb-b887-5c4af45d8b37@gmx.de>
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
In-Reply-To: <c1d86274-44e2-4ceb-b887-5c4af45d8b37@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,plugable.com,arndb.de,infradead.org,linaro.org,c64.rulez.org,vger.kernel.org,lists.freedesktop.org,lists.linux.dev,linuxfoundation.org];
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,redhat.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Spam-Score: -2.80

Hi

Am 03.10.25 um 21:50 schrieb Helge Deller:
> On 10/3/25 20:43, sukrut heroorkar wrote:
>> On Thu, Oct 2, 2025 at 8:52 AM Thomas Zimmermann 
>> <tzimmermann@suse.de> wrote:
>>> Am 02.10.25 um 08:41 schrieb Helge Deller:
>>>>>>> kernel test robot noticed the following build errors:
>>>>>>
>>>>>> Did you compile and test this code before submitting this patch?
>>>>>
>>>>> Yes, I had compiled & loaded the udlfb module with no errors. Please
>>>>> let me know how to proceed in this case.
>>>>
>>>> Look at the reported build error, which seems to happen in dev_dbg().
>>>> So, maybe in your testing you did not have debugging enabled?
>>>> The report contains the .config file with which you can test.
>>>
>>> Can we rather make an effort to remove the udlfb driver entirely? A few
>>> years back, there was one user who was still using it because of some
>>> problems with the DRM udl driver. But I think we've addressed them. The
>>> discussion is at [1].
>
> Would be good to know if they issues/crashes really have been solved.
> In [1] it seems the crashes still happened with DRM.

The thread at [1] was the original removal attempt. And that was 5 years 
ago. I think we could retry and take the reporter (Mikulas) into cc.

Best regards
Thomas

>
>> Should I send a patch series to completely remove udlfb, 
>
> No. (at least not yet)
>
>> since [1] echoed that DRM udl driver is good enough?
>>> [1] 
>>> https://lore.kernel.org/dri-devel/20201130125200.10416-1-tzimmermann@suse.de/
>
> Well, some people who do *NOT* actively use fbdev with the old
> cards say the DRM replacements are "good enough".
> For tThose people who really depend on fbdev and the speed it has
> over DRM, the DRM "basic-drivers" are simply a 
> nice-to-have-but-not-really-useable
> type of drivers.
> So, unless the really affected people say the DRM replacement
> is fully usable, we need to keep the fbdev driver.
>
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)


