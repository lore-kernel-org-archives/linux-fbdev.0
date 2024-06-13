Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E515D146A74
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718290762; cv=none; b=dAlnR5eK5nNDIo6iqCjZ/UkrvAOuOyH7EKKvW1dbKMFQC9MoRA54Iq/EJN+a9plm+yF5rvf5fJZSRa8FDY1/WUzlrvEit3MiYurUlNBDBu72MXEDSV6UHYtLVnSFJf5A72wutHgcfB9fQEO0/bNroQ43B2o2l+MGgMthT7nIrtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718290762; c=relaxed/simple;
	bh=3rN4Mdlz0e4/0Hht3mzm3v2jETtdNTaD6lwFIecbVMA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NZgRzbgI/hDNro1IesJ6PmzELokrPA+vdOehZ7Hy8EiUzXosTEnUuwam5yd2cWM32hFexQRWWVFKzIlkeo5XUxxI3yvAbSVMebtr0AWL9azIGgOCk+b1j2A3wthxcm1d1APIl7HX71I2hHN5qxDlF9u6tV7UfWj27OE7qy+2b7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X/l0lt1b; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vEiiTgbn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xAZTqlV/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=13MWEPAF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X/l0lt1b";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vEiiTgbn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xAZTqlV/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="13MWEPAF"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B7070372DC;
	Thu, 13 Jun 2024 14:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718290759; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KGPgZXYIBZJPJfkwdvE6QSHnkTFlSy50zdON7aG8MG0=;
	b=X/l0lt1bu+Dzxb8l4mIxiczlctWTYWtY7NBqJ5pO1Gmef4QwraZ0JClVDRWiQp7g+dWjWI
	5tD35J/iKCdZA1waimiUrfCN0hFIcfhU+xgdi4JncicM8oM3+Q+1MRmJY00EgOsapjmfGi
	+kwhbKzzmoE4WTItBWZdXT81vIgOzJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718290759;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KGPgZXYIBZJPJfkwdvE6QSHnkTFlSy50zdON7aG8MG0=;
	b=vEiiTgbn+AGFGUyhXEc9Pg3cxJ4wloptKkv5sil/+aC/GHKeilb8mzb4zUc46zPphWtqFA
	9gx0y5zTaLccHgCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="xAZTqlV/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=13MWEPAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1718290758; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KGPgZXYIBZJPJfkwdvE6QSHnkTFlSy50zdON7aG8MG0=;
	b=xAZTqlV/hFSZws+Tv7RcGsOHUaExFlip2hBsGglgBoWh3eGwhTHpAWtVFWBpS8rX1wZwao
	WC7r8DwRFIx/oXK2O+S10YpQd+gx60G7IwKEm+ssB4kEPSbSvMdZqp/Vz6Jk4wge/eOQbi
	qze+BXfEgbJ4MWkiMtXB7uflJo8Q+pA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1718290758;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=KGPgZXYIBZJPJfkwdvE6QSHnkTFlSy50zdON7aG8MG0=;
	b=13MWEPAFt7s0f8B1i1NquMCgJSaD5nfExoCSfbuzCuQS61D+Jwf5JdJOEe9MRxkp4TPDtw
	yb21wKG+g0uNX9Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 714F813A7F;
	Thu, 13 Jun 2024 14:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EBQjGkUJa2ZqWQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Thu, 13 Jun 2024 14:59:17 +0000
Message-ID: <845642ff-ba16-4066-aad0-f0d68a47d865@suse.de>
Date: Thu, 13 Jun 2024 16:59:17 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: "firmware/sysfb: Set firmware-framebuffer parent device" breaks
 lightdm on Ubuntu 22.04 using amdgpu
To: =?UTF-8?B?TWFyZWsgT2zFocOhaw==?= <maraeo@gmail.com>
Cc: javierm@redhat.com, pjones@redhat.com, deller@gmx.de, ardb@kernel.org,
 dri-devel <dri-devel@lists.freedesktop.org>, linux-fbdev@vger.kernel.org,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 amd-gfx mailing list <amd-gfx@lists.freedesktop.org>
References: <CAAxE2A7qK1-b5g1RR-GJ+QTLEr_OxEr9vcZGEOkZY9yLOFLb5w@mail.gmail.com>
 <CAAxE2A6971oJ3r-8UWhL0BUZBiYxq4K0-Q39MJnb7ZozX3da-A@mail.gmail.com>
 <eb8223e2-9bea-416d-a412-0a291523a0ff@suse.de>
 <CAAxE2A5vFuN1R0dALT60Uf-Bt3QVMTE0W35TGEq2k7ep2FhxQw@mail.gmail.com>
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
In-Reply-To: <CAAxE2A5vFuN1R0dALT60Uf-Bt3QVMTE0W35TGEq2k7ep2FhxQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B7070372DC
X-Spam-Score: -4.50
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmx.de,kernel.org,lists.freedesktop.org,vger.kernel.org,amd.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

Hi

Am 13.06.24 um 16:20 schrieb Marek Olšák:
> On Thu, Jun 13, 2024 at 3:23 AM Thomas Zimmermann <tzimmermann@suse.de> wrote:
>> Hi
>>
>> Am 13.06.24 um 08:00 schrieb Marek Olšák:
>>> +amd-gfx
>>>
>>> On Thu, Jun 13, 2024 at 1:59 AM Marek Olšák <maraeo@gmail.com> wrote:
>>>> Hi Thomas,
>>>>
>>>> Commit 9eac534db0013aff9b9124985dab114600df9081 as per the title
>>>> breaks (crashes?) lightdm (login screen) such that all I get is the
>>>> terminal. It's also reproducible with tag v6.9 where the commit is
>>>> present.
>>>>
>>>> Reverting the commit fixes lightdm. A workaround is to bypass lightdm
>>>> by triggering auto-login. This is a bug report.
>> I see. Do you know why it crashes? Or have any logs.
> How to debug this? I only know it's run through systemctl somehow.

IDK what Ubuntu supports, but 'systemctl status' or 'journalctl' might 
turn up something.

https://unix.stackexchange.com/questions/225401/how-to-see-full-log-from-systemctl-status-service

 From there, maybe with additional fprintf(stderr) output.

Best regards
Thomas

>
> Marek

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

