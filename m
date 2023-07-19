Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C7EB64DA
	for <linux-fbdev@archiver.kernel.org>; Wed, 19 Jul 2023 07:57:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjGSH5v (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 19 Jul 2023 03:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjGSH5v (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 19 Jul 2023 03:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58ECF9D
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 00:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689753427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0LSXzH9KgQuNIJHrVFvJ9YD/ZmxqwFC+Ci2ZGBbMwGk=;
        b=R/bSZ5mtXvrl69m0j2LPjtqiFDM2BSu5VOtMCs3305nuxWSEevRP1VvhXKuouidC+3A43t
        ACls23rYvAb3pbmab44FxRi02bzkfInG2Vp74Wp+RMyK9taDKcyza5CLaVAFhFpakZu//d
        1BqaJGu1ejaybMFF38L4/Gy6UJLRFWE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-488-bE-azvwzNcKI_tf5KcgW1w-1; Wed, 19 Jul 2023 03:57:06 -0400
X-MC-Unique: bE-azvwzNcKI_tf5KcgW1w-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fa8db49267so35482255e9.3
        for <linux-fbdev@vger.kernel.org>; Wed, 19 Jul 2023 00:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689753425; x=1690358225;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0LSXzH9KgQuNIJHrVFvJ9YD/ZmxqwFC+Ci2ZGBbMwGk=;
        b=HwEE17h3Sor/+8zgvo5KgfftKiaTPOBaE/B5X96wzU7ibrs7toNzFqzXNe7KojWbxM
         B0Kk4XVs1DSiw+IIML1l4wo1xFCi47sUry25J099mTXKCVD7s2GjlPTswBSzG+MMNGfM
         dB/4V5zEUYF115OnpK/6csh+yTOBuNViw0jIGKfLsILK36L+2GrLPZPbejeuT5l2nM37
         yf6hY72VKs3TDPfCjUALrj+K19J3AOoxZs8dBVgdMtaaGYCvmX+NkoJRIu//uBsSFLzM
         y0fRqLaFS4VKWyOhojoss40su0hZaZbBddcGrc5P3gVZxZbyrP8h0vVWV4qsCPMZXSWy
         55rg==
X-Gm-Message-State: ABy/qLY6K+EmHAV5dW05jxylN6jve/6jis+vblGBf77iUmFDtSAz/pEa
        Wq2/yymQnOQGUk6/2/BWTCK7s4ScAgi74J70v8bTXEE2ivsEDRnHTWt4/+IAKwfjpEo5VKJx4E6
        9hrG4HRx/14N6RvOgXJpdjJU=
X-Received: by 2002:a05:600c:cd:b0:3f7:f884:7be3 with SMTP id u13-20020a05600c00cd00b003f7f8847be3mr1334657wmm.4.1689753425238;
        Wed, 19 Jul 2023 00:57:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH74UgMTjLsFyK1xbqZGPblld9XHaIy+slQtfM8QvANl8wo4fumWmYeLIfxy+UY4GY0/K0oJw==
X-Received: by 2002:a05:600c:cd:b0:3f7:f884:7be3 with SMTP id u13-20020a05600c00cd00b003f7f8847be3mr1334641wmm.4.1689753424896;
        Wed, 19 Jul 2023 00:57:04 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x15-20020a05600c21cf00b003fbbe41fd78sm1046275wmj.10.2023.07.19.00.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 00:57:04 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v5 3/4] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <91486e8b-49ca-4a8a-8dd6-e9a2c6ed63ee@app.fastmail.com>
References: <20230714171642.91185-1-javierm@redhat.com>
 <20230714171642.91185-4-javierm@redhat.com>
 <91486e8b-49ca-4a8a-8dd6-e9a2c6ed63ee@app.fastmail.com>
Date:   Wed, 19 Jul 2023 09:57:03 +0200
Message-ID: <87o7k8ibao.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

"Arnd Bergmann" <arnd@arndb.de> writes:

> On Fri, Jul 14, 2023, at 19:16, Javier Martinez Canillas wrote:
>> Currently the CONFIG_FB option has to be enabled even if no legacy fbdev
>> drivers are needed (e.g: only to have support for framebuffer consoles).
>>
>> The DRM subsystem has a fbdev emulation layer, but depends on CONFIG_FB
>> and so it can only be enabled if that dependency is enabled as well.
>>
>> That means fbdev drivers have to be explicitly disabled if users want to
>> enable CONFIG_FB, only to use fbcon and/or the DRM fbdev emulation layer.
>>
>> This patch introduces a non-visible CONFIG_FB_CORE symbol that could be
>> enabled just to have core support needed for CONFIG_DRM_FBDEV_EMULATION,
>> allowing CONFIG_FB to be disabled (and automatically disabling all the
>> fbdev drivers).
>>
>> Nothing from fb_backlight.o and fbmon.o is used by the DRM fbdev emulation
>> layer so these two objects can be compiled out when CONFIG_FB is disabled.
>
> I gave this a spin in my randconfig build setup and found one small
> mistake:
>

Thanks for testing!

>> diff --git a/drivers/video/fbdev/core/Makefile 
>> b/drivers/video/fbdev/core/Makefile
>> index 9150bafd9e89..2cd213716c12 100644
>> --- a/drivers/video/fbdev/core/Makefile
>> +++ b/drivers/video/fbdev/core/Makefile
>> @@ -1,10 +1,10 @@
>>  # SPDX-License-Identifier: GPL-2.0
>>  obj-$(CONFIG_FB_NOTIFY)           += fb_notify.o
>> -obj-$(CONFIG_FB)                  += fb.o
>> -fb-y                              := fb_backlight.o \
>> -                                     fb_info.o \
>> -                                     fbmem.o fbmon.o fbcmap.o \
>> +obj-$(CONFIG_FB_CORE)             += fb.o
>> +fb-y                              := fb_info.o \
>> +                                     fbmem.o fbcmap.o \
>>                                       modedb.o fbcvt.o fb_cmdline.o 
>> fb_io_fops.o
>> +fb-$(CONFIG_FB)                   += fb_backlight.o fbmon.o
>
> With CONFIG_FB_CORE=y and CONFIG_FB=m, Kbuild does not include
> the fb_backlight.o and fbmon.o files in fb.ko because they are not
> set to =y, causing link failures for fbdev drivers later:
>
> ERROR: modpost: "of_get_fb_videomode" [drivers/video/fbdev/clps711x-fb.ko] undefined!
> ERROR: modpost: "fb_videomode_from_videomode" [drivers/video/fbdev/atmel_lcdfb.ko] undefined!
> ERROR: modpost: "of_get_fb_videomode" [drivers/video/fbdev/imxfb.ko] undefined!
> ERROR: modpost: "fb_destroy_modedb" [drivers/video/fbdev/udlfb.ko] undefined!
> ERROR: modpost: "fb_edid_to_monspecs" [drivers/video/fbdev/udlfb.ko] undefined!
> ERROR: modpost: "fb_destroy_modedb" [drivers/video/fbdev/smscufx.ko] undefined!
> ERROR: modpost: "fb_edid_to_monspecs" [drivers/video/fbdev/smscufx.ko] undefined!
> ERROR: modpost: "fb_destroy_modedb" [drivers/video/fbdev/uvesafb.ko] undefined!
> ERROR: modpost: "fb_validate_mode" [drivers/video/fbdev/uvesafb.ko] undefined!
> ERROR: modpost: "fb_get_mode" [drivers/video/fbdev/uvesafb.ko] undefined!
>

Right, sorry for missing that combination.

>
> Folding this fixup into the patch makes it work:
>
> diff --git a/drivers/video/fbdev/core/Makefile b/drivers/video/fbdev/core/Makefile
> index 2cd213716c12f..84ddc5d308b58 100644
> --- a/drivers/video/fbdev/core/Makefile
> +++ b/drivers/video/fbdev/core/Makefile
> @@ -4,7 +4,9 @@ obj-$(CONFIG_FB_CORE)             += fb.o
>  fb-y                              := fb_info.o \
>                                       fbmem.o fbcmap.o \
>                                       modedb.o fbcvt.o fb_cmdline.o fb_io_fops.o
> -fb-$(CONFIG_FB)                   += fb_backlight.o fbmon.o
> +ifdef CONFIG_FB
> +fb-y		                   += fb_backlight.o fbmon.o
> +endif
>  fb-$(CONFIG_FB_DEFERRED_IO)       += fb_defio.o
>  fb-$(CONFIG_FB_DEVICE)            += fb_chrdev.o \
>                                       fb_procfs.o \
>

Perfect, I'll squash your fix in v6. Thanks!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

