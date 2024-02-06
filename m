Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99BAE469E
	for <linux-fbdev@vger.kernel.org>; Tue,  6 Feb 2024 16:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707237953; cv=none; b=HhhEe6YLoGnpMs5BTFQdWk46aq3INyWXTNLrdUQk9bpVwVhwE9VzUlQEWIeXaudnbwliShcmwvCslUMSfpH38LBFiBRtoOEYzMR6rxKY3sJNtP1W5z+q0oNtWV0thSR6QtofF4F3fPTbrGSAT0ItI8zWcAZA3H89GAgha9aScFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707237953; c=relaxed/simple;
	bh=8pVURm82IkZrihiTicl3k7ZaW7vBnojMHUrfIhQDQAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RMQatWpe3J4PWlrv1MmnQDzRM3B4fdYJ4oWoNYa6dxpBhjqBeuBI71FHV7vc0g4Mk1Vt2e14YfG9IGOLpw50PYdQbi8llhd7EPjqieNGrX/KeGAPZhxK62XLjcyznfoh3okGhoX672zAvlP9XovnzLawpXBo254GSZCiKNOHCO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H5qJjjG+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z6m+033T; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=H5qJjjG+; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z6m+033T; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H5qJjjG+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z6m+033T";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="H5qJjjG+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z6m+033T"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7E47E22019;
	Tue,  6 Feb 2024 16:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707237949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zgHAu9asULM1aTx78TZhPgRW5omwl8YiU0y5hbS5NMc=;
	b=H5qJjjG+8SlNQzlO+3DWeGWEANiNH3jvnFKeidI+raAwUpYQpbO0nzaLV/IdTbSTX3+vTd
	/2UvEGa0n1GjedGW+Vto8prwJUDdmTcVRArohPkatH9dn91DFVVmTgvnShVBsVcFCffSIz
	I51CMGcrMgFzo8MHS1sJtb293IHrBEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707237949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zgHAu9asULM1aTx78TZhPgRW5omwl8YiU0y5hbS5NMc=;
	b=z6m+033TUt6EpeDhQxG0Y1w5SKH3FzBZfyCJBuAEWB3PvSub4EYGNXWZCI0uKBVW6TXMQJ
	TiuboWpuTeYONWBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1707237949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zgHAu9asULM1aTx78TZhPgRW5omwl8YiU0y5hbS5NMc=;
	b=H5qJjjG+8SlNQzlO+3DWeGWEANiNH3jvnFKeidI+raAwUpYQpbO0nzaLV/IdTbSTX3+vTd
	/2UvEGa0n1GjedGW+Vto8prwJUDdmTcVRArohPkatH9dn91DFVVmTgvnShVBsVcFCffSIz
	I51CMGcrMgFzo8MHS1sJtb293IHrBEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1707237949;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zgHAu9asULM1aTx78TZhPgRW5omwl8YiU0y5hbS5NMc=;
	b=z6m+033TUt6EpeDhQxG0Y1w5SKH3FzBZfyCJBuAEWB3PvSub4EYGNXWZCI0uKBVW6TXMQJ
	TiuboWpuTeYONWBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4FF40139D8;
	Tue,  6 Feb 2024 16:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2vsuEj1iwmUdeAAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Tue, 06 Feb 2024 16:45:49 +0000
Message-ID: <5a31179a-e10f-441c-a06f-570c0ff5c0f2@suse.de>
Date: Tue, 6 Feb 2024 17:45:15 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v2,7/8] firmware/sysfb: Update screen_info for relocated EFI
 framebuffers
Content-Language: en-US
To: Sui Jingfeng <sui.jingfeng@linux.dev>, javierm@redhat.com,
 pjones@redhat.com, deller@gmx.de, ardb@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20240202120140.3517-8-tzimmermann@suse.de>
 <77dded7a-5643-4050-9121-f666d3b8d59e@linux.dev>
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
In-Reply-To: <77dded7a-5643-4050-9121-f666d3b8d59e@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=H5qJjjG+;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z6m+033T
X-Spamd-Result: default: False [-2.78 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 XM_UA_NO_VERSION(0.01)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 BAYES_HAM(-2.48)[97.67%];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
	 FREEMAIL_TO(0.00)[linux.dev,redhat.com,gmx.de,kernel.org];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7E47E22019
X-Spam-Level: 
X-Spam-Score: -2.78
X-Spam-Flag: NO

Hi

Am 02.02.24 um 19:00 schrieb Sui Jingfeng:
> Hi,
>
>
> On 2024/2/2 19:58, Thomas Zimmermann wrote:
>> +static inline void __screen_info_set_lfb_base(struct screen_info 
>> *si, u64 lfb_base)
>> +{
>> +    si->lfb_base = lfb_base & GENMASK_ULL(31, 0);
>> +    si->ext_lfb_base = (lfb_base & GENMASK_ULL(63, 32)) >> 32;
>
>
> I want to ask a trivial question: why not simply write it like below?
>
> si->lfb_base = (u32)lfb_base;
>
> si->ext_lfb_base = lfb_base >> 32;
>
> I'm asking because I feel it is a little bit complicated.

Admittedly it's a bit verbose. I've written it like this so that it's 
clear which bits go where.

Best regards
Thomas

>
>> +    if (si->ext_lfb_base)
>> +        si->capabilities |= VIDEO_CAPABILITY_64BIT_BASE;
>> +    else
>> +        si->capabilities &= ~VIDEO_CAPABILITY_64BIT_BASE;
>> +}
>> +

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstrasse 146, 90461 Nuernberg, Germany
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman
HRB 36809 (AG Nuernberg)

