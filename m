Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667963890E3
	for <linux-fbdev@vger.kernel.org>; Wed,  4 Mar 2026 07:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610709; cv=none; b=kWrTnwXZB/JvjOeZGgqHN6CXxcPKNSjFqKDOw+iPyOk3bEyZ7JXYLn/PvJMMwgQg2Oe5QYqfdaOkzpDThBh4sLeSFX1S8iLwdFfbRtAIwR7yufbXMPu36iV67twSJEaYAdRKk45prIAXNeH/a/6BnpnaZ0EfGYM7vcXUP/KIoSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610709; c=relaxed/simple;
	bh=WOneXutEbAvNGCjppopYI//xZ0hTnAyW8JyxWhuu5GA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pH/wep6/CQKBDnCnIDsLgGyB4dHI03dQicgOM96h1kF0uWEJLatwHV0VmLfds6soI15qGVt6iTGANOkfIwQrQK9GwVDCiXBVsEL9eJiCeIoKZ2HinlgnFnzBjOwQovigIYho8fkiYuGRlpz3GAHPuGrdbFhcv72r2Wh9XEU6s3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KSJbRWF2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H9CZbAJO; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=KSJbRWF2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=H9CZbAJO; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KSJbRWF2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H9CZbAJO";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="KSJbRWF2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="H9CZbAJO"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8613D3F7A8;
	Wed,  4 Mar 2026 07:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MhqjPcnbjyRtwEewpOQWPleMb8Nu4Rjvtge6/Tpp48g=;
	b=KSJbRWF2QSI3I4LatZTAWShzTzNlnnRx1CEFVA/W7gNcnZz5nsUls//UM5yj1gtA0aAGdz
	Nk3Uo5Yu9b2gWTwwioafzPYwbDkqKEOgsFE2dTs4xpeQi8YJ8/o+Leh98IY+Q4WuSTkPZT
	JwrNHLfr/ZC/jLDxDnH2cYGorBtu6Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MhqjPcnbjyRtwEewpOQWPleMb8Nu4Rjvtge6/Tpp48g=;
	b=H9CZbAJOPsFkh8l+qOtMAVAgNWwdoYJzZYnJmHlSMWTXGPgTco1/ZA0zLaJlBXmhtY1OQa
	054UMwyQadsPLTBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772610703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MhqjPcnbjyRtwEewpOQWPleMb8Nu4Rjvtge6/Tpp48g=;
	b=KSJbRWF2QSI3I4LatZTAWShzTzNlnnRx1CEFVA/W7gNcnZz5nsUls//UM5yj1gtA0aAGdz
	Nk3Uo5Yu9b2gWTwwioafzPYwbDkqKEOgsFE2dTs4xpeQi8YJ8/o+Leh98IY+Q4WuSTkPZT
	JwrNHLfr/ZC/jLDxDnH2cYGorBtu6Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772610703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=MhqjPcnbjyRtwEewpOQWPleMb8Nu4Rjvtge6/Tpp48g=;
	b=H9CZbAJOPsFkh8l+qOtMAVAgNWwdoYJzZYnJmHlSMWTXGPgTco1/ZA0zLaJlBXmhtY1OQa
	054UMwyQadsPLTBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5490F3EA69;
	Wed,  4 Mar 2026 07:51:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Qz5PE4/kp2k0ZgAAD6G6ig
	(envelope-from <tzimmermann@suse.de>); Wed, 04 Mar 2026 07:51:43 +0000
Message-ID: <61da73e3-c0b9-4221-ac85-3f7abc181b78@suse.de>
Date: Wed, 4 Mar 2026 08:51:42 +0100
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/13] lib/fonts: Store font data as font_data_t;
 update consoles
To: Helge Deller <deller@gmx.de>, gregkh@linuxfoundation.org, sam@ravnborg.org
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260302141255.518657-1-tzimmermann@suse.de>
 <20260302141255.518657-8-tzimmermann@suse.de>
 <b0a688dc-c613-4cb0-9858-56d8720487c2@gmx.de>
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
In-Reply-To: <b0a688dc-c613-4cb0-9858-56d8720487c2@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmx.de,linuxfoundation.org,ravnborg.org];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmx.de];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,suse.com:url,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO

Hi

Am 03.03.26 um 15:57 schrieb Helge Deller:
> On 3/2/26 15:08, Thomas Zimmermann wrote:
>> Store font data as pointer to font_data_t instead of unsigned char.
>> Update consoles.
>>
>> Pointers to font data refer to the raw data. There is a hidden header
>> before the data that contains additional state. Document the existing
>> layout and semantics of font_data_t.
>>
>> The data field in struct vc_font can be used by any console. Therefore
>> it still points to plain data without the additional header. Fbcon sets
>> its value from struct fbcon_display.fontdata. Hence, update the size
>> test in fbcon_resize() to use struct fbcon_display.fontdata instead of
>> struct vc_font.data.
>>
>> v2:
>> - 'Font lookup' -> 'Font description' in <linux/font.h>
>>
>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>> ---
>>   drivers/video/console/newport_con.c | 17 ++++++-----
>>   drivers/video/fbdev/core/fbcon.c    | 44 ++++++++++++++++-----------
>>   drivers/video/fbdev/core/fbcon.h    |  3 +-
>>   include/linux/font.h                | 47 ++++++++++++++++++++++++++++-
>>   4 files changed, 84 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/video/console/newport_con.c 
>> b/drivers/video/console/newport_con.c
>> index e2922caa8685..9b9ed1940404 100644
>> --- a/drivers/video/console/newport_con.c
>> +++ b/drivers/video/console/newport_con.c
>> @@ -33,9 +33,9 @@
>>     #define NEWPORT_LEN    0x10000
>>   -#define FONT_DATA ((unsigned char *)font_vga_8x16.data)
>> +#define FONT_DATA font_vga_8x16.data
>>   -static unsigned char *font_data[MAX_NR_CONSOLES];
>> +static font_data_t *font_data[MAX_NR_CONSOLES];
>>     static struct newport_regs *npregs;
>>   static unsigned long newport_addr;
>> @@ -370,9 +370,9 @@ static void newport_clear(struct vc_data *vc, 
>> unsigned int sy, unsigned int sx,
>>   static void newport_putc(struct vc_data *vc, u16 charattr, unsigned 
>> int ypos,
>>                unsigned int xpos)
>>   {
>> -    unsigned char *p;
>> +    const unsigned char *p;
>>   -    p = &font_data[vc->vc_num][(charattr & 0xff) << 4];
>> +    p = &font_data_buf(font_data[vc->vc_num])[(charattr & 0xff) << 4];
>>       charattr = (charattr >> 8) & 0xff;
>>       xpos <<= 3;
>>       ypos <<= 4;
>> @@ -400,7 +400,7 @@ static void newport_putcs(struct vc_data *vc, 
>> const u16 *s,
>>                 unsigned int count, unsigned int ypos,
>>                 unsigned int xpos)
>>   {
>> -    unsigned char *p;
>> +    const unsigned char *p;
>>       unsigned int i;
>>       u16 charattr;
>>   @@ -424,7 +424,7 @@ static void newport_putcs(struct vc_data *vc, 
>> const u16 *s,
>>                    NPORT_DMODE0_L32);
>>         for (i = 0; i < count; i++, xpos += 8) {
>> -        p = &font_data[vc->vc_num][(scr_readw(s++) & 0xff) << 4];
>> +        p = &font_data_buf(font_data[vc->vc_num])[(scr_readw(s++) & 
>> 0xff) << 4];
>>             newport_wait(npregs);
>>   @@ -503,7 +503,8 @@ static int newport_set_font(int unit, const 
>> struct console_font *op,
>>       int h = op->height;
>>       int size = h * op->charcount;
>>       int i;
>> -    unsigned char *new_data, *data = op->data, *p;
>> +    font_data_t *new_data;
>> +    unsigned char *data = op->data, *p;
>>         /* ladis: when I grow up, there will be a day... and more 
>> sizes will
>>        * be supported ;-) */
>> @@ -519,7 +520,7 @@ static int newport_set_font(int unit, const 
>> struct console_font *op,
>>       REFCOUNT(new_data) = 0;    /* usage counter */
>>       FNTSUM(new_data) = 0;
>>   -    p = new_data;
>> +    p = (unsigned char *)font_data_buf(new_data);
>>       for (i = 0; i < op->charcount; i++) {
>>           memcpy(p, data, h);
>>           data += 32;
>> diff --git a/drivers/video/fbdev/core/fbcon.c 
>> b/drivers/video/fbdev/core/fbcon.c
>> index 103e91c8d874..8d7840b9ebad 100644
>> --- a/drivers/video/fbdev/core/fbcon.c
>> +++ b/drivers/video/fbdev/core/fbcon.c
>> @@ -1019,8 +1019,10 @@ static const char *fbcon_startup(void)
>>                           info->pixmap.blit_y);
>>           vc->vc_font.width = font->width;
>>           vc->vc_font.height = font->height;
>> -        vc->vc_font.data = (void *)(p->fontdata = font->data);
>> +        vc->vc_font.data = font_data_buf(font->data);
>>           vc->vc_font.charcount = font->charcount;
>> +
>> +        p->fontdata = font->data;
>>       }
>>         cols = FBCON_SWAP(par->rotate, info->var.xres, info->var.yres);
>> @@ -1078,11 +1080,12 @@ static void fbcon_init(struct vc_data *vc, 
>> bool init)
>>           if (t->fontdata) {
>>               struct vc_data *fvc = vc_cons[fg_console].d;
>>   -            vc->vc_font.data = (void *)(p->fontdata =
>> -                            fvc->vc_font.data);
>> +            vc->vc_font.data = fvc->vc_font.data;
>>               vc->vc_font.width = fvc->vc_font.width;
>>               vc->vc_font.height = fvc->vc_font.height;
>>               vc->vc_font.charcount = fvc->vc_font.charcount;
>> +
>> +            p->fontdata = t->fontdata;
>>               p->userfont = t->userfont;
>>                 if (p->userfont)
>> @@ -1097,8 +1100,10 @@ static void fbcon_init(struct vc_data *vc, 
>> bool init)
>>                               info->pixmap.blit_y);
>>               vc->vc_font.width = font->width;
>>               vc->vc_font.height = font->height;
>> -            vc->vc_font.data = (void *)(p->fontdata = font->data);
>> +            vc->vc_font.data = font_data_buf(font->data);
>>               vc->vc_font.charcount = font->charcount;
>> +
>> +            p->fontdata = font->data;
>>           }
>>       }
>>   @@ -1409,11 +1414,12 @@ static void fbcon_set_disp(struct fb_info 
>> *info, struct fb_var_screeninfo *var,
>>       svc = *default_mode;
>>       t = &fb_display[svc->vc_num];
>>   -    if (!vc->vc_font.data) {
>> -        vc->vc_font.data = (void *)(p->fontdata = t->fontdata);
>> +    if (!p->fontdata) {
>> +        vc->vc_font.data = font_data_buf(t->fontdata);
>>           vc->vc_font.width = (*default_mode)->vc_font.width;
>>           vc->vc_font.height = (*default_mode)->vc_font.height;
>>           vc->vc_font.charcount = (*default_mode)->vc_font.charcount;
>> +        p->fontdata = t->fontdata;
>>           p->userfont = t->userfont;
>>           if (p->userfont)
>>               REFCOUNT(p->fontdata)++;
>> @@ -2047,7 +2053,7 @@ static int fbcon_resize(struct vc_data *vc, 
>> unsigned int width,
>>       struct fb_var_screeninfo var = info->var;
>>       int x_diff, y_diff, virt_w, virt_h, virt_fw, virt_fh;
>>   -    if (p->userfont && FNTSIZE(vc->vc_font.data)) {
>> +    if (p->userfont && FNTSIZE(p->fontdata)) {
>>           unsigned int size = vc_font_size(&vc->vc_font);
>>             /*
>> @@ -2057,7 +2063,7 @@ static int fbcon_resize(struct vc_data *vc, 
>> unsigned int width,
>>            * charcount can change and cannot be used to determine the
>>            * font data allocated size.
>>            */
>> -        if (!size || size > FNTSIZE(vc->vc_font.data))
>> +        if (!size || size > FNTSIZE(p->fontdata))
>>               return -EINVAL;
>>       }
>>   @@ -2281,7 +2287,8 @@ static bool fbcon_blank(struct vc_data *vc, 
>> enum vesa_blank_mode blank,
>>     static int fbcon_get_font(struct vc_data *vc, struct console_font 
>> *font, unsigned int vpitch)
>>   {
>> -    const u8 *fontdata = vc->vc_font.data;
>> +    struct fbcon_display *p = &fb_display[vc->vc_num];
>> +    font_data_t *fontdata = p->fontdata;
>>       u8 *data = font->data;
>>       int i, j;
>>   @@ -2406,16 +2413,18 @@ static void set_vc_hi_font(struct vc_data 
>> *vc, bool set)
>>   }
>>     static int fbcon_do_set_font(struct vc_data *vc, int w, int h, 
>> int charcount,
>> -                 const u8 * data, int userfont)
>> +                 font_data_t *data, int userfont)
>>   {
>>       struct fb_info *info = fbcon_info_from_console(vc->vc_num);
>>       struct fbcon_par *par = info->fbcon_par;
>>       struct fbcon_display *p = &fb_display[vc->vc_num];
>>       int resize, ret, old_userfont, old_width, old_height, 
>> old_charcount;
>> +    font_data_t *old_fontdata = p->fontdata;
>>       const u8 *old_data = vc->vc_font.data;
>>         resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
>> -    vc->vc_font.data = (void *)(p->fontdata = data);
>> +    p->fontdata = data;
>> +    vc->vc_font.data = font_data_buf(p->fontdata);
>>       old_userfont = p->userfont;
>>       if ((p->userfont = userfont))
>>           REFCOUNT(data)++;
>> @@ -2448,12 +2457,12 @@ static int fbcon_do_set_font(struct vc_data 
>> *vc, int w, int h, int charcount,
>>           update_screen(vc);
>>       }
>>   -    if (old_userfont && (--REFCOUNT(old_data) == 0))
>> -        kfree(old_data - FONT_EXTRA_WORDS * sizeof(int));
>> +    if (old_userfont && (--REFCOUNT(old_fontdata) == 0))
>> +        kfree(old_fontdata - FONT_EXTRA_WORDS * sizeof(int));
>>       return 0;
>>     err_out:
>> -    p->fontdata = old_data;
>> +    p->fontdata = old_fontdata;
>>       vc->vc_font.data = old_data;
>>         if (userfont) {
>> @@ -2483,7 +2492,8 @@ static int fbcon_set_font(struct vc_data *vc, 
>> const struct console_font *font,
>>       int h = font->height;
>>       int size, alloc_size;
>>       int i, csum;
>> -    u8 *new_data, *data = font->data;
>> +    font_data_t *new_data;
>> +    u8 *data = font->data;
>>       int pitch = PITCH(font->width);
>>         /* Is there a reason why fbconsole couldn't handle any 
>> charcount >256?
>> @@ -2522,13 +2532,13 @@ static int fbcon_set_font(struct vc_data *vc, 
>> const struct console_font *font,
>>       if (!new_data)
>>           return -ENOMEM;
>>   -    memset(new_data, 0, FONT_EXTRA_WORDS * sizeof(int));
>> +    memset((u8 *)new_data, 0, FONT_EXTRA_WORDS * sizeof(int));
>>         new_data += FONT_EXTRA_WORDS * sizeof(int);
>>       FNTSIZE(new_data) = size;
>>       REFCOUNT(new_data) = 0;    /* usage counter */
>>       for (i=0; i< charcount; i++) {
>> -        memcpy(new_data + i*h*pitch, data +  i*vpitch*pitch, h*pitch);
>> +        memcpy((u8 *)new_data + i * h * pitch, data + i * vpitch * 
>> pitch, h * pitch);
>>       }
>>         /* Since linux has a nice crc32 function use it for counting 
>> font
>> diff --git a/drivers/video/fbdev/core/fbcon.h 
>> b/drivers/video/fbdev/core/fbcon.h
>> index 3f4386a40237..d26ee7860cf5 100644
>> --- a/drivers/video/fbdev/core/fbcon.h
>> +++ b/drivers/video/fbdev/core/fbcon.h
>> @@ -11,6 +11,7 @@
>>   #ifndef _VIDEO_FBCON_H
>>   #define _VIDEO_FBCON_H
>>   +#include <linux/font.h>
>>   #include <linux/types.h>
>>   #include <linux/vt_buffer.h>
>>   #include <linux/vt_kern.h>
>> @@ -25,7 +26,7 @@
>>     struct fbcon_display {
>>       /* Filled in by the low-level console driver */
>> -    const u_char *fontdata;
>> +    font_data_t *fontdata;
>>       int userfont;                   /* != 0 if fontdata kmalloc()ed */
>>   #ifdef CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION
>>       u_short scrollmode;             /* Scroll Method, use 
>> fb_scrollmode() */
>> diff --git a/include/linux/font.h b/include/linux/font.h
>> index d929c5fa32ca..f19abd112c18 100644
>> --- a/include/linux/font.h
>> +++ b/include/linux/font.h
>> @@ -13,12 +13,57 @@
>>     #include <linux/types.h>
>>   +/*
>> + * font_data_t and helpers
>> + */
>> +
>> +/**
>> + * font_data_t - Raw font data
>> + *
>> + * Values of type font_data_t store a pointer to raw font data. The 
>> format
>> + * is monochrome. Each bit sets a pixel of a stored glyph. Font data 
>> does
>> + * not store geometry information for the individual glyphs. Users 
>> of the
>> + * font have to store glyph size, pitch and characer count separately.
>> + *
>> + * Font data in font_data_t is not equivalent to raw u8. Each 
>> pointer stores
>> + * an additional hidden header before the fotn data. The layout is
>
> typo: fotn -> font
>
>
>>   struct font_desc {
>>       int idx;
>>       const char *name;
>>       unsigned int width, height;
>>       unsigned int charcount;
>
> FYI - maybe type of width, height, charcount would need update here if 
> it's
> changed as I proposed in the other patch?

There are places like [1] that use font_desc and I honestly don't dare 
touching this code.

[1] 
https://elixir.bootlin.com/linux/v6.19.3/source/arch/m68k/kernel/asm-offsets.c#L83

Best regards
Thomas

>
> Helge

-- 
--
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)


