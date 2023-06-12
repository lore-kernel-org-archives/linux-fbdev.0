Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A656CC7EE25
	for <linux-fbdev@archiver.kernel.org>; Mon, 12 Jun 2023 10:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjFLKzU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 12 Jun 2023 06:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbjFLKzI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 12 Jun 2023 06:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B844A11D8A
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jun 2023 03:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686566424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=75rPdiK8vy0+hfZPm4hKQMMWAw1iiTrCWzbw47oqQ3o=;
        b=devhSDfFl7afV/GsX9Eflm7alVxFNX2LCigk39Xs3nGuOZJTpVXRmywi08eBJQ+yekwxCz
        Ahy6ROZrbta2SZzjjfMFMRC0P3ZLNcmv4Ge00PPJEmksZrNsKFK+4sxSUoV23PJDdXoQ0v
        0TFlWsW8x0elr6fytz6Q8s5O1p7Ss4I=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-HsmWlpdJOKuFkqBAFoOJUA-1; Mon, 12 Jun 2023 06:40:22 -0400
X-MC-Unique: HsmWlpdJOKuFkqBAFoOJUA-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-3f7e6582938so80549945e9.0
        for <linux-fbdev@vger.kernel.org>; Mon, 12 Jun 2023 03:40:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686566421; x=1689158421;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=75rPdiK8vy0+hfZPm4hKQMMWAw1iiTrCWzbw47oqQ3o=;
        b=IDmx91CpyrOwhzKBvLxXoI0g1yU1PUwIwApQSbG0cHYyjNHQo3seWn9/XUnfRuuL7k
         wRpcMkRA8JXquV7DIF6uTk+p9l5DqUPp5tlnWI/CcQD8fiXd1C+/m4K5NxyWjce1ALU7
         fHF8DOo8Mp9o/N2jOcv5hs91Iyjto7eGo6ezmG8DD2sMMgVNPCPkArwBVrh9jh4Iwonh
         J5o+GVhxcFS6rAFnjSA3G9frNcDlYXJF9oCZY0XepHts8K7JByPbbSPyQ1z2YObZ5R6V
         AO+5b8cwH6rClx+TTODbwzmLi7YwCJIXvS0JjU/MxgaSq1DU+7OrV+YxM2QdLWMR/XH2
         fSSA==
X-Gm-Message-State: AC+VfDyCooi4G7iplOhSR9wVyvQ+npgtx2DehPS+qoHEtqmSfJnWBjIx
        O2qeA0d9z2hp59zSa4dX1RYmwAERoVh6RetlYx8+i0MpUDheyXyaeYp3dub7ZpnPWLxsEhnQX9/
        5zCk/RG30jCCswj49fIyWlJc=
X-Received: by 2002:a7b:ca51:0:b0:3f8:1e00:5a62 with SMTP id m17-20020a7bca51000000b003f81e005a62mr1113951wml.38.1686566421734;
        Mon, 12 Jun 2023 03:40:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MsqRGgveHsuNkfrpDC1Y5y2oZ/Wv2tvp//EQrR0fI03+Glf+TK6KJrHQIoCgU/ovDWpctCw==
X-Received: by 2002:a7b:ca51:0:b0:3f8:1e00:5a62 with SMTP id m17-20020a7bca51000000b003f81e005a62mr1113932wml.38.1686566421434;
        Mon, 12 Jun 2023 03:40:21 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o7-20020adfeac7000000b002fed865c55esm12153178wrn.56.2023.06.12.03.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jun 2023 03:40:21 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     Steve Glendinning <steve.glendinning@shawell.net>,
        linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 22/30] fbdev/smscufx: Detect registered fb_info from
 refcount
In-Reply-To: <7f62aa10-bc6f-96e2-d2cc-d42f0fad9e32@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-23-tzimmermann@suse.de>
 <87edmmewuk.fsf@minerva.mail-host-address-is-not-set>
 <7f62aa10-bc6f-96e2-d2cc-d42f0fad9e32@suse.de>
Date:   Mon, 12 Jun 2023 12:40:20 +0200
Message-ID: <87mt152cbv.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

Hello Thomas,

> Hi Javier
>
> Am 08.06.23 um 00:22 schrieb Javier Martinez Canillas:
>> Thomas Zimmermann <tzimmermann@suse.de> writes:
>> 
>>> Detect registered instances of fb_info by reading the reference
>>> counter from struct fb_info.read. Avoids looking at the dev field
>>> and prepares fbdev for making struct fb_info.dev optional.
>>>
>>> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
>>> Cc: Steve Glendinning <steve.glendinning@shawell.net>
>>> ---
>>>   drivers/video/fbdev/smscufx.c | 4 ++--
>>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
>>> index 17cec62cc65d..adb2b1fe8383 100644
>>> --- a/drivers/video/fbdev/smscufx.c
>>> +++ b/drivers/video/fbdev/smscufx.c
>>> @@ -1496,7 +1496,7 @@ static int ufx_setup_modes(struct ufx_data *dev, struct fb_info *info,
>>>   	u8 *edid;
>>>   	int i, result = 0, tries = 3;
>>>   
>>> -	if (info->dev) /* only use mutex if info has been registered */
>>> +	if (refcount_read(&info->count)) /* only use mutex if info has been registered */
>> 
>> The struct fb_info .count refcount is protected by the registration_lock
>> mutex in register_framebuffer(). I think this operation isn't thread safe ?
>
> It's an atomic read.
>
> https://elixir.bootlin.com/linux/latest/source/include/linux/refcount.h#L147
>

Yes, is an atomic read but by reading [0] my understanding is that does
not provide memory ordering guarantees. Maybe I misunderstood though...

[0]: https://www.kernel.org/doc/html/latest/core-api/refcount-vs-atomic.html

> And that function is only being called from the USB probe callback 
> before registering the framebuffer. It's not clear to me how the value 
> could be anything but zero. I'd best leave it as is with the ref counter.
>

Yes, I'm OK with that and as mentioned I don't think that's less safe
than the previous info->dev check with regard to race conditions.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

