Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3450EB64D9
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Jul 2023 07:57:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjGDH5i (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Jul 2023 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDH5g (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Jul 2023 03:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444A01AC
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Jul 2023 00:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688457413;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yfSuLMbi885ncjU/SXY8s5ylufowrHraHlPM4HxykdE=;
        b=jIFJXYM6fW7El3De/2Yvvuq+hWe65ojtisOEtoODFHowpAZlFG6beIMUzcH8fz9fB8cldO
        TFf31PKAmYcG+ulTbjNxvk0y6hdf8bd0iI/qqWgksT5h0ufij1r6pGdXPUK9r9WmGhILBq
        AfYvMg52wldWjNjZ6yq0LGocjf83CNc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-JnMqtrW5Pra8MlhZVLd77w-1; Tue, 04 Jul 2023 03:56:52 -0400
X-MC-Unique: JnMqtrW5Pra8MlhZVLd77w-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-313e6020882so2152063f8f.1
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Jul 2023 00:56:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457411; x=1691049411;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yfSuLMbi885ncjU/SXY8s5ylufowrHraHlPM4HxykdE=;
        b=lRC6BqS4QPxQbaqnbhBpmGeMwB5btLryHltHkegC/goSpjgi+VCZP7p9eRpADxJg9/
         r/97FU7u6LRo0ENpCeLfHZyxi+4kVX3ogslKoHhf5iXQE8Q19TvB321fBGI/NLvL+Pp3
         0hPDe4NoU4+cTGfBbFuBrqXozOBI6Hk4mlvgwo/wVV67APN26Z7UvftBYII1cUB5OHbR
         5lQ28KX5CuG6DrFCPgjyFL/6WWKNmNk/81v98lVSKb9KWRCTasgk5p81XBrlBlqS8/M6
         PjrWI2M75UPp/2jkrGRFHSQSXTYY9qiUuXgkiB9rxW7ePqtC7gVzuUKlYs0ghIZ4VSna
         L5yw==
X-Gm-Message-State: ABy/qLY1b9VpQ/yALnWKEAzKZA6aSlNyD7ij61/YJVNiUdN5iU8jgCT2
        a1Dw94Z1i/+9Zvu0V3OjuV4jMHmMWjwkzW6829IYaBHk7gGAN/EUYTPIN0JAd16QIlEvWEBJvwh
        reYErjPDHJsIrgGJ0Butp+NA=
X-Received: by 2002:a5d:464a:0:b0:314:17ac:5bac with SMTP id j10-20020a5d464a000000b0031417ac5bacmr11844924wrs.33.1688457411271;
        Tue, 04 Jul 2023 00:56:51 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFU3Enu3ZhJIcLl8uDKqbLIoqK9rspavgFUf3CsZtMjrcO2FgaiIgTbGO0/u6yb7XYsnrsZMQ==
X-Received: by 2002:a5d:464a:0:b0:314:17ac:5bac with SMTP id j10-20020a5d464a000000b0031417ac5bacmr11844900wrs.33.1688457410930;
        Tue, 04 Jul 2023 00:56:50 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b002fb60c7995esm27613884wrs.8.2023.07.04.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 00:56:50 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v4 4/5] fbdev: Split frame buffer support in FB and
 FB_CORE symbols
In-Reply-To: <ZKPIQngz6WkzASqa@smile.fi.intel.com>
References: <20230703230534.997525-1-javierm@redhat.com>
 <20230703230534.997525-5-javierm@redhat.com>
 <ZKPIQngz6WkzASqa@smile.fi.intel.com>
Date:   Tue, 04 Jul 2023 09:56:49 +0200
Message-ID: <87edloyuri.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


Hello Andy,

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Tue, Jul 04, 2023 at 01:05:28AM +0200, Javier Martinez Canillas wrote:
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
> ...
>
> Wondering if
>
>   if FB_CORE
>   ...
>   endif
>
> makes Kconfig looking better instead of replacing all these "depends on" lines.
>

Yes, I discussed that with Arnd and he said that the if / endif is just
syntax sugar so I didn't do that change to keep the patches simpler. But
is something that you could change as a follow-up if you prefer that way.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

