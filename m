Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47EB5C4332F
	for <linux-fbdev@archiver.kernel.org>; Wed,  8 Nov 2023 21:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjKHVHI convert rfc822-to-8bit (ORCPT
        <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 8 Nov 2023 16:07:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjKHVHH (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 8 Nov 2023 16:07:07 -0500
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E642580
        for <linux-fbdev@vger.kernel.org>; Wed,  8 Nov 2023 13:07:05 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-5be8f04585cso1858197b3.1
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Nov 2023 13:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699477625; x=1700082425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sL/n+QudcGCkNuxCd3XtrLBrT7hbO9/4Gzcez5s8RY8=;
        b=C1KmukrC6nVC2OLDOZe8/8oUUh0TvTDog0p85pNgfzCb3N5gGWiy9ewzcknKzuqCLb
         K79HP7P75jtqf0o798U95EEzKPlEgQcuZPplULdOXa+w/eDw+sHCDj8VGvk8asydwgcN
         fuZLJjdtceXgeebGzK+IJsksNhNnuEgfTgQNfy+HIs6v0lHGi+TiHPByWKP4306jYGd8
         St/EMCNuv08c2ObEWjoh9aW7iTKq8mrQcA1glWu32nhN4TIv3AArypYRagbIubz+0Kzv
         iFdoYtvkD9cbZp7WiXbLfmuKKxxtvpD+OQwcpZMLyGmoHUnTqHDOsG3WtfJttrtgwZ7j
         6M9g==
X-Gm-Message-State: AOJu0YwDB1BH6s8GeYhNsyo4Z55X5BU5/MXSkhT1eVG/5Z4jAc4ki2NL
        w9v2ARpXW4stmncYCvFf2YL78K8ULYFaDg==
X-Google-Smtp-Source: AGHT+IH5LwzybO7gICcTD3z3630XUEDsCvXtoENOIjMGEJbm/rmeBOWIspbz3b3e+4FIwGmHsOmK+w==
X-Received: by 2002:a0d:d4d7:0:b0:5a7:dad3:cd21 with SMTP id w206-20020a0dd4d7000000b005a7dad3cd21mr2453637ywd.10.1699477624683;
        Wed, 08 Nov 2023 13:07:04 -0800 (PST)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id en6-20020a05690c2b8600b0057a44e20fb8sm7223823ywb.73.2023.11.08.13.07.04
        for <linux-fbdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 13:07:04 -0800 (PST)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5a8628e54d4so2056107b3.0
        for <linux-fbdev@vger.kernel.org>; Wed, 08 Nov 2023 13:07:04 -0800 (PST)
X-Received: by 2002:a81:4954:0:b0:5a7:b914:34c1 with SMTP id
 w81-20020a814954000000b005a7b91434c1mr5194330ywa.18.1699477624084; Wed, 08
 Nov 2023 13:07:04 -0800 (PST)
MIME-Version: 1.0
References: <20231107091740.3924258-1-u.kleine-koenig@pengutronix.de> <20231107091740.3924258-2-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20231107091740.3924258-2-u.kleine-koenig@pengutronix.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 8 Nov 2023 22:06:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVaaH_ZJT+jAyxZxnVYT3L=b4B-LEMTP4PqQH2TE0nH6g@mail.gmail.com>
Message-ID: <CAMuHMdVaaH_ZJT+jAyxZxnVYT3L=b4B-LEMTP4PqQH2TE0nH6g@mail.gmail.com>
Subject: Re: [PATCH 01/22] fb: amifb: Stop using platform_driver_probe()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Atul Raut <rauji.raut@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, kernel@pengutronix.de,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Uwe,

On Tue, Nov 7, 2023 at 10:20 AM Uwe Kleine-König
<u.kleine-koenig@pengutronix.de> wrote:
> On today's platforms the benefit of platform_driver_probe() isn't that
> relevant any more. It allows to drop some code after booting (or module
> loading) for .probe() and discard the .remove() function completely if
> the driver is built-in. This typically saves a few 100k.

Which is a lot on platforms with only a few MiBs of RAM...

> The downside of platform_driver_probe() is that the driver cannot be
> bound and unbound at runtime which is ancient and also slightly
> complicates testing. There are also thoughts to deprecate
> platform_driver_probe() because it adds some complexity in the driver
> core for little gain. Also many drivers don't use it correctly. This
> driver for example misses to mark the driver struct with __refdata which
> is needed to suppress a (W=1) modpost warning:
>
>         WARNING: modpost: drivers/video/fbdev/amifb: section mismatch in reference: amifb_driver+0x4 (section: .data) -> amifb_remove (section: .exit.text)
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for your patch!

> --- a/drivers/video/fbdev/amifb.c
> +++ b/drivers/video/fbdev/amifb.c
> @@ -3530,7 +3530,7 @@ static inline void chipfree(void)
>          * Initialisation
>          */
>
> -static int __init amifb_probe(struct platform_device *pdev)
> +static int amifb_probe(struct platform_device *pdev)

noreply@ellerman.id.au reported the following build failure for
e.g. m68k-defconfig in next-20231108:

WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x15c (section: .text) -> ami_modedb (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x17a (section: .text) -> amifb_hfmin (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x188 (section: .text) -> amifb_hfmax (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x190 (section: .text) -> amifb_vfmin (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x198 (section: .text) -> amifb_vfmax (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x1ba (section: .text) -> ami_modedb (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x1c4 (section: .text) -> ami_modedb (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x1ca (section: .text) -> mode_option (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x1ee (section: .text) -> ami_modedb (section: .init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x398 (section: .text) -> amifb_hfmin (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x39e (section: .text) -> amifb_hfmax (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x3a4 (section: .text) -> amifb_vfmin (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x3aa (section: .text) -> amifb_vfmax (section:
.init.data)
WARNING: modpost: vmlinux: section mismatch in reference:
amifb_probe+0x3f0 (section: .text) -> mode_option (section:
.init.data)
ERROR: modpost: Section mismatches detected.

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
