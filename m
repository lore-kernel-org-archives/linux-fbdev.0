Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B13C366DB0
	for <linux-fbdev@vger.kernel.org>; Mon,  2 Feb 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770038965; cv=none; b=LY0MACyAyPiVjgmEDiqxiAwicHEtF37QRK/vPJayrBcM6Hyt/YObybjnyAuHZUlHIMG1KYRyfcQjnYhuUXPCWrjofDPIpwc4cRTtZ2YElU/M9asDA64hIjo7PvS6GaYREL+DRRA2Fef4ipIwivo8Mp0fEh2mX0Akfmhye/lja8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770038965; c=relaxed/simple;
	bh=PYT3naHbLEwd34XTfkjHNZJP52DC+zxttzCNHEyUkfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Om9MdfvQ2LXx0qC4Jzwu57B/L9vT+DxzBmIUrLZlGaLKRB0jH1B7uIykJanIlH9c8RcVyC5UmJLBTwdTEuBm2MIAtoZmqzJ78cBspVkjcbaJwyMFsYOsuf4Su9xJ8zyBaCUPharR/PwDDpAjVIamLzj0KCx/64LF3sYfZefpBnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=aUBuO/ys; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ydNI9GTo; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=IB+MJIrb; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=weMPsq4h; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="aUBuO/ys";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ydNI9GTo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="IB+MJIrb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="weMPsq4h"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 5A93E5BCFE;
	Mon,  2 Feb 2026 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770038962; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9A6sDWqtJn023lRBDIjzT9/LsqXqap9EwFj16VEPuA=;
	b=aUBuO/ysRVYHCN5MwGNKAU5CECgxHhY1ebZfafTwCuCjwgYpagknosEZ9Cd1zLBrxGKGlw
	lLC+f9R0Nr0iVntHoYfHrouWwKju6dwiadyxuYDhFJyNGJgYNE6P6ToH2rIoadn1HRzGAa
	rqlYjEXK6P1TGbbZk5eEuUuD+nKnD1w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770038962;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9A6sDWqtJn023lRBDIjzT9/LsqXqap9EwFj16VEPuA=;
	b=ydNI9GTohElkkwxaDFy26hDg0VXc1QwZ4mg4JPSfZ2+ARwrPmfhE+fUTpgJR9/kytUs26N
	+b4dZyM9KQ5W6eDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1770038961; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9A6sDWqtJn023lRBDIjzT9/LsqXqap9EwFj16VEPuA=;
	b=IB+MJIrb1/jb9Fo8irwnU3LM5/la8Oq1oVSADHL1eAH45t9wQ1Cb4nfqnETmFTw11sHRoc
	OfRhHfN/xEIp266/6z9NYaIgs758JYbeCvpd4m6uBwGPBritZskGsp7FzdjpYwBwipJ5TP
	6d1cGgnAkygC+1gPZ4nqZRsX4B56A4s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1770038961;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=d9A6sDWqtJn023lRBDIjzT9/LsqXqap9EwFj16VEPuA=;
	b=weMPsq4hJ/FQ+n2GOCQMP8sCYj1hwe57dgd58T5iTamYAWCkPRoelCyFMCNoo3hTvM7hTw
	BIfx7q/aSMNoF9Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A49B43EA62;
	Mon,  2 Feb 2026 13:29:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dakcJrCmgGmkNQAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 02 Feb 2026 13:29:20 +0000
Message-ID: <72a9614d-95a1-43b7-a557-6d0c724d1934@suse.de>
Date: Mon, 2 Feb 2026 14:29:20 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] staging: fbtft: fix dev_info() device arguments
To: Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
 Noralf Tronnes <notro@tronnes.org>, Chintan Patel <chintanlike@gmail.com>
Cc: Abdun Nihaal <abdun.nihaal@gmail.com>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Matthew Wilcox <willy@infradead.org>, Jianglei Nie
 <niejianglei2021@163.com>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260202095743.1309162-1-arnd@kernel.org>
 <6580aa60-5f9d-49c7-8482-83bed12dfb0c@suse.de>
 <3384db41-0ddb-4c00-9af1-f194ec5dccc4@app.fastmail.com>
 <9de86cc9-a72a-4f84-9cc6-127fc0dbe006@gmx.de>
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
In-Reply-To: <9de86cc9-a72a-4f84-9cc6-127fc0dbe006@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_ENVRCPT(0.00)[163.com,gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_RCPT(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linaro.org,infradead.org,163.com,lists.freedesktop.org,vger.kernel.org,lists.linux.dev];
	FREEMAIL_TO(0.00)[gmx.de,arndb.de,kernel.org,linuxfoundation.org,free-electrons.com,tronnes.org,gmail.com];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,suse.com:url,patchwork.freedesktop.org:url]
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 

Hi

Am 02.02.26 um 14:11 schrieb Helge Deller:
> On 2/2/26 13:12, Arnd Bergmann wrote:
>> On Mon, Feb 2, 2026, at 12:32, Thomas Zimmermann wrote:
>>> Hi,
>>>
>>> there's already
>>>
>>> https://patchwork.freedesktop.org/series/160468/
>>>
>>> which no one picked up yet. This needs to go into the fbdev tree, but I
>>> can also take into drm-misc-fixes.
>>
>> Ok, that looks fine as well. The output is of course
>> different, but I don't think that matters either way.
>
> I picked it up into fbdev now.

Thanks a lot!

Best regards
Thomas

> There might have been some conflicts with staging tree, which I haven't
> done so earlier. Let's see...
>
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


