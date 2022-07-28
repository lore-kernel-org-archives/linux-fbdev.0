Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 056DAC04A68
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jul 2022 11:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbiG1LbW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 28 Jul 2022 07:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235647AbiG1LbR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 28 Jul 2022 07:31:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF1A26AE8
        for <linux-fbdev@vger.kernel.org>; Thu, 28 Jul 2022 04:31:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id v5so816650wmj.0
        for <linux-fbdev@vger.kernel.org>; Thu, 28 Jul 2022 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=SMC59iUGEUeIWikaYVLjy2odSUsf6J1BxrN5JwfwEpY=;
        b=I2LvfwRSLT0FBLkzKL97tXa0j3AxOgqK4JwBDMsSM+Z8HGBr1Hsl+SUU8HPYMLz66e
         8uwZd7/fPyOTDqCE8CpYD1EB4BMYrqBICeOrQcRtAgtcyK1eE/L39avZt/VLlWPC4Uor
         LoRGhJiBQNR/hDNsANtNPDEqnDWOhfwEJTmwgA0Cv1jj23KAfdmGOY1sasEYVFjLX/YX
         ZlPZ2zhQiq7NYJ6LHAqKNcChUNlEupakqOtGb+CZPupdBgaFq1mBMgBamPwT1GZ2CiGh
         Xxn5YMmbVopGqmz+InpOVGDvq/m/bhIDEUtdkMhmWHk2Kp5mn0bff3ZHplSxHO3nCLJd
         f6Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=SMC59iUGEUeIWikaYVLjy2odSUsf6J1BxrN5JwfwEpY=;
        b=qra+Sw4a9s6NmEhjoI0CH+o7hRM4GhxN12dA/rjHVGG3QCe4/Z7M+6es5lHExvbz3J
         CMJFshnsnnLUJg5UqY0zAlAcQ+8RXrAN5BmdKaJLMgL27mzIuvwCm7bIXfmN4jRNBHyT
         3gINBFy+UodouXnOllvpNgTdZfqWCH76yccU2ryAAy+vhLUWjujEhRUlLty9N44vi9tN
         HTsYK/8cGfFm++bqHXuQFLeYGFRaUXXma181rXRxPd2Ut1MVYIyIwNNdOZN11rHuMWSg
         yf6LqcKbJhZx+UU5XuQLhHTUVHenVoHAfhxBYeMJqJhYfJ9mGW2XHPoMbQ4u3tVddUCu
         ep2A==
X-Gm-Message-State: AJIora/IIG8e/bZgBELmJpvFOltGVLMCdbLWoppQXIGXiNO91u/O1Vat
        tYQzY382ZRZLB/xdZ3PKi9O0xQ==
X-Google-Smtp-Source: AGRyM1vjIPgxwYbMk8BsnZlSouB9NDyINH+vUJA52rfBsJa1/epNS6uEmdrCNjJkZQ9qNZQU8kklUA==
X-Received: by 2002:a05:600c:3556:b0:3a3:2a9c:f26 with SMTP id i22-20020a05600c355600b003a32a9c0f26mr6221269wmq.58.1659007873312;
        Thu, 28 Jul 2022 04:31:13 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z22-20020a1cf416000000b003a35516ccc3sm937306wma.26.2022.07.28.04.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 04:31:12 -0700 (PDT)
Date:   Thu, 28 Jul 2022 12:31:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ChiaEn Wu <peterwu.pub@gmail.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>,
        Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Alice Chen <alice_chen@richtek.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        USB <linux-usb@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        szuni chen <szunichen@gmail.com>
Subject: Re: [PATCH v6 13/13] video: backlight: mt6370: Add MediaTek MT6370
 support
Message-ID: <20220728113109.7gf3b36mqjxlhcq3@maple.lan>
References: <20220722102407.2205-1-peterwu.pub@gmail.com>
 <20220722102407.2205-14-peterwu.pub@gmail.com>
 <20220725103128.xtaw2c4y5fobowg7@maple.lan>
 <CABtFH5LUKTZenTktq3v1JZ9xe-yJFsMvCZuwDhmxdT87k0O-zA@mail.gmail.com>
 <20220726093058.2fz2p2vg7xpfsnfe@maple.lan>
 <CABtFH5+in-+=6r3wOvQ8-78DT9CXaMursJukhx+kdwMvvP3djw@mail.gmail.com>
 <20220726115954.kpkmidrk3zo3dpbq@maple.lan>
 <CABtFH5K3LLw9ZqY0Qrrx_8xs+3ioJpzP0=_HptmoDY6tvu2JVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABtFH5K3LLw9ZqY0Qrrx_8xs+3ioJpzP0=_HptmoDY6tvu2JVg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jul 27, 2022 at 02:24:46PM +0800, ChiaEn Wu wrote:
> On Tue, Jul 26, 2022 at 7:59 PM Daniel Thompson
> <daniel.thompson@linaro.org> wrote:
> > > > > So should we make all 16384 steps of MT6372 available to users?
> > > >
> > > > Yes.
> > > >
> > > >
> > > > > Does that mean the DTS needs to be modified as well?
> > > >
> > > > Yes... the property to set initial brightness needs a 14-bit range.
> > > >
> > > > It would also be a good idea to discuss with the DT maintainers whether
> > > > you should introduce a second compatible string (ending 6372) in order
> > > > to allow the DT validation checks to detect accidental use of MT6372
> > > > ranges on MT6370 hardware.

[snip]

> > > > I'd be curious what the compatiblity reasons are. In other words what
> > > > software breaks?
> > >
> > > The reason is as above. We just hope the users who use this series SubPMIC can
> > > directly apply this driver to drive the backlight device without
> > > knowing the underlying hardware.
> > > Not software breaks.
> >
> > As above, ignoring the max_brightness property is a bug in the
> > userspace. I'm still unclear why sending faked ranges to userspace
> > it a better solution than fixing the userspace.
>
> Ok, I got it!
> If I add a second compatible string (like 'mediatek,mt6372-backlight')
> in the DT section,
> and append 'if-then-else' to determine the correct maximum value of
> 'default-brightness' and 'max-brightness',
> Also, I will append 'bled exponential mode' to make user control using
> linear or exponential mode.

I'd be very pleased to see support for exponential mode added: it's a
much better way to control LEDs and backlights.


> These changes I will explain to DT's maintainer again.

Excellent. I know DT maintainers are copied into this thread but they
will probably not be following this patch's thread so it is better to
discuss in the mail thread for the DT bindings!


> Back to the driver section,
> do I still need to use the register to confirm again whether this
> SubPMIC used now is MT6372 and record this information? (using
> 'mt6370_check_vendor_info()')
> I am afraid that the user who uses the MT6370 hardware, but the DT
> compatible string is set to 'mediatek,mt6372-backlight'.
> This may cause errors when update/get brightness values.
> So I hope the driver here can check again to make sure the
> 'default-brightness', 'max-brightness', can be updated/got correctly.
> I don't know if this will make you feel redundant if I do this??

Yes, it's good idea to check the hardware model during probe. I'd
suggest just reporting this as an error ("Buggy DT, wrong compatible
string") rather than trying to re-intepret the parameters.


Daniel.
