Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0D13921EC
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 07:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792394649; cv=none; b=kFGtA3Lq8yL18xWYU9tE01XLd/ZAGX2T5Cp806HTztXmGKtjrAbhSheT2779dewj9OkxPNOcrVtjt4dxyG1KAmxwXh8N8FbZCdvrA/35NMvxafrspe0+zG2n1xdpUmR7ZIB2bCKIzEdH9+fZfGvuieYPZQqtUxiWcaW2qDcx7DY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792394649; c=relaxed/simple;
	bh=DVWaVtn1LGUgXd1scHZ13VwTmb+uHLWAEJvTnge2Rlk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MnAQ3wk4asmO5QTJCiIO+EtnLXRwXP0Z8U2k0uQzcJNrzSvQ/lm6TydhtxwW+J0p/r2Ir9tM+w2wOq6fupeKpDCj/RJ1cUA5hq7C+/aJ4gWLGKDho19yOG+lTCJaAUek9hfJzuDo0Yrv50HrMDqVQ5MvdQMFtEzuT8ZaAZoXCFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=C1qjR02F; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IDR+GW07; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EwmrhD0A; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=ehJ6Kr0c; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="C1qjR02F";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IDR+GW07";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EwmrhD0A";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ehJ6Kr0c"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3E8C01F7BD;
	Mon, 19 Oct 2026 07:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792394646; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X/2Kjoo/a5eGfK0HNZFMQdW7lR0A2kfejW8MU//7JDE=;
	b=C1qjR02FouHgH4jgWbipKIKW5V1zJ0IWA8oL2U+Dt3zC2cvl5m6qvnt9IovYz0N2+koylg
	vwbaL0PEHroqFI8gr3MN7yXPAG3evGrpQVPlZk0a3USg2PCKmx78VpxcSc3gEPCBMFfw+a
	2PEAAkwozvJ830AhUHizvFTXIu3v53w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792394646;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X/2Kjoo/a5eGfK0HNZFMQdW7lR0A2kfejW8MU//7JDE=;
	b=IDR+GW07HK2pJ1n8S5iBVB5WkP9AiQaM7mqp6I5B/Yxa1pFZoGQvkFC1Uv60w5ulJAC5vn
	bGq+g8lnb1FZT1Ag==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=EwmrhD0A;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ehJ6Kr0c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792394645; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X/2Kjoo/a5eGfK0HNZFMQdW7lR0A2kfejW8MU//7JDE=;
	b=EwmrhD0AzaoRHGrAY47RdsW0C9Xo6XB4h6Ta6VhOWNhZiC5aijZM/s1ZLIneJSfNCp3v59
	vsCAv8SiiIBeBUQ4YsOjq8PIZSNOmFYqAQ8/3VXAoGw0dM5cZ5T8Uwe3WEEUfvF0Rub+Hx
	25mumFuYiNLpu1XZsAuzOxmj9Yjc/hw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792394645;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=X/2Kjoo/a5eGfK0HNZFMQdW7lR0A2kfejW8MU//7JDE=;
	b=ehJ6Kr0cuibb+HIwS2SraKfbs0AA6H3KZUwCxXqM1F83+Hz+iDYs/Wm4LQ/lO/J3Nksi9R
	W2hqhTCS6B+Co5Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1BFA134B3;
	Mon, 19 Oct 2026 07:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id w4ZxM5TF1WrtHgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Mon, 19 Oct 2026 07:24:04 +0000
Message-ID: <33fd4c60-43f4-4055-838e-a37e58ab70dc@suse.de>
Date: Mon, 19 Oct 2026 09:24:04 +0200
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fbdev/au1100fb: Use FB blanking constants
To: Helge Deller <deller@gmx.de>, adaplas@gmail.com, michal.simek@amd.com
Cc: linux-fbdev@vger.kernel.org
References: <20261009161814.120480-1-tzimmermann@suse.de>
 <20261009161814.120480-2-tzimmermann@suse.de>
 <3ae4590b-c420-480f-a6a2-79700bf20a1a@gmx.de>
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
In-Reply-To: <3ae4590b-c420-480f-a6a2-79700bf20a1a@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3E8C01F7BD
X-Rspamd-Action: no action
X-Spam-Level: 
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
	FREEMAIL_TO(0.00)[gmx.de,gmail.com,amd.com];
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
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Spam-Flag: NO
X-Spam-Score: -4.50

Hi

Am 18.10.26 um 15:52 schrieb Helge Deller:
> Hi Thomas,
>
> On 10/9/26 18:05, Thomas Zimmermann wrote:
>> Fbdev and its drivers use FB_BLANK constants for controlling the
>> display's blanking state. Semantics differ to similar VESA blanking
>> constants.
>>
>> Replace the VESA constants in au1100fb with FB_BLANK.
>
> I understand that this series drops the VESA constants.
> That seems logical and correct, but....
>
>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/video/fbdev/au1100fb.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/video/fbdev/au1100fb.c 
>> b/drivers/video/fbdev/au1100fb.c
>> index 39f86ffb1ae3..6c375f389fbd 100644
>> --- a/drivers/video/fbdev/au1100fb.c
>> +++ b/drivers/video/fbdev/au1100fb.c
>> @@ -424,15 +424,15 @@ static int au1100fb_fb_blank(int blank_mode, 
>> struct fb_info *fbi)
>>         switch (blank_mode) {
>>   -    case VESA_NO_BLANKING:
>> +    case FB_BLANK_UNBLANK:
>>           /* Turn on panel */
>>           fbdev->regs->lcd_control |= LCD_CONTROL_GO;
>>           wmb(); /* drain writebuffer */
>>           break;
>> -
>> -    case VESA_VSYNC_SUSPEND:
>> -    case VESA_HSYNC_SUSPEND:
>> -    case VESA_POWERDOWN:
>> +    case FB_BLANK_NORMAL:
>> +    case FB_BLANK_VSYNC_SUSPEND:
>> +    case FB_BLANK_HSYNC_SUSPEND:
>> +    case FB_BLANK_POWERDOWN:
> I don't understand (this is not the fault of this/your patch),
> how this enum in fb.h works:
>
> enum {
>         /* screen: unblanked, hsync: on,  vsync: on */
>         FB_BLANK_UNBLANK       = VESA_NO_BLANKING,
>
>         /* screen: blanked,   hsync: on,  vsync: on */
>         FB_BLANK_NORMAL        = VESA_NO_BLANKING + 1,
>
>         /* screen: blanked,   hsync: on,  vsync: off */
>         FB_BLANK_VSYNC_SUSPEND = VESA_VSYNC_SUSPEND + 1,
>
>         /* screen: blanked,   hsync: off, vsync: on */
>         FB_BLANK_HSYNC_SUSPEND = VESA_HSYNC_SUSPEND + 1,
>
>         /* screen: blanked,   hsync: off, vsync: off */
>         FB_BLANK_POWERDOWN     = VESA_POWERDOWN + 1
>
>
> In vesa.h we have:
> /* VESA Blanking Levels */
> enum vesa_blank_mode {
>         VESA_NO_BLANKING        = 0,
> #define VESA_NO_BLANKING        VESA_NO_BLANKING
>         VESA_VSYNC_SUSPEND      = 1,
> #define VESA_VSYNC_SUSPEND      VESA_VSYNC_SUSPEND
>         VESA_HSYNC_SUSPEND      = 2,
> #define VESA_HSYNC_SUSPEND      VESA_HSYNC_SUSPEND
>         VESA_POWERDOWN          = VESA_VSYNC_SUSPEND | 
> VESA_HSYNC_SUSPEND,
> #define VESA_POWERDOWN          VESA_POWERDOWN
>         VESA_BLANK_MAX          = VESA_POWERDOWN,
>
>
> for example this one:
>         /* screen: blanked,   hsync: on,  vsync: off */
>         FB_BLANK_VSYNC_SUSPEND = VESA_VSYNC_SUSPEND + 1,
> which is effectively:
>         FB_BLANK_VSYNC_SUSPEND = VESA_HSYNC_SUSPEND,
> which seems wrong.
>
> Am I missing something?

No worries, it's super-confusing.

- FB_BLANK_ describes CRTC state plus monitor state. VESA_ only 
describes monitor state and assumes that the CRTC is off.

- FB_BLANK_UNBLANK means "monitor on and send pixels".  There is no VESA 
equivalent for this mode, because all VESA constants assume that the 
stream if pixel data has been disabled.

- FB_BLANK_NORMAL means "monitor on, but do not send pixels". This 
corresponds to VESA_BLANK_NO_BLANKING, but has a different integer value.

- The FB_BLANK_*_SUSPEND and _POWERDOWN constants correspond to the VESA 
constants of similar name. But they are all off by one.

Therefore some of the drivers (au1100fb) use VESA_NO_BLANKING when they 
mean FB_BLANK_UNBLANK. Others (xilinxfb) get it wrong and use 
VESA_POWERDOWN when they should use FB_BLANK_POWERDOWN.

Best regards
Thomas


>
> Helge
>

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)


