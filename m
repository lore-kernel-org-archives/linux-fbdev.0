Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44EEC433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 14:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E7EC610CB
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 May 2021 14:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237020AbhEROvP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 May 2021 10:51:15 -0400
Received: from mail-vk1-f171.google.com ([209.85.221.171]:42795 "EHLO
        mail-vk1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235434AbhEROvP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 May 2021 10:51:15 -0400
Received: by mail-vk1-f171.google.com with SMTP id m129so2102162vkh.9;
        Tue, 18 May 2021 07:49:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y10PWJw0DRQc++ZzVaFYO8op4Q+GioEhXZLxuqYRvPE=;
        b=UnOulr16jgijEefXo05lRFF94KK3WurxK3V1f+4popLSPAPTZnaEDoTviwf2Vqz/k5
         U3JV9FcyVswxDj8d9PA5Ln2v+AMN8YJ8SimTE4oYIEmOrfCXpojmkbvKveuAvdE1kQZz
         RZBp2CXJL7Nah64ug3whGyo+VHNSckuVH7v5FO6bC0aUwWJ60QYH0tGXHLBHSXG2k1nI
         X6k0wSqenluI8oja9khUvTVkvt+JAA+2l91+H8U6m8yYpTcDQxC2NeDslLm3uaC3ivQ0
         djwXNefGGop8SlzVxpXvFtu9+aFbCrs6e5C65YqOCWMUjynaWZRMEt522GbkmtxwSaKx
         rqXg==
X-Gm-Message-State: AOAM533VXfYnveJhuwdn3/837uBu54D4ly0PxT3FMooyi1l69krDhFHW
        VYZA1ku38SmiBhtrv27/bU8PpDsmEDA2AGFR/FI=
X-Google-Smtp-Source: ABdhPJxt3csEOJ+HZlUNZyI4+ozqFzhRSPkaymurZ7JCVflSiXGt84wNn+aIH/66rsKkPf6/JaIeeeHvYwGOSw2pHqA=
X-Received: by 2002:a1f:eac1:: with SMTP id i184mr6332144vkh.2.1621349396836;
 Tue, 18 May 2021 07:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210518075131.1463091-1-geert@linux-m68k.org> <20210518143317.yy2sxxnd7yt6cyrx@gilmour>
In-Reply-To: <20210518143317.yy2sxxnd7yt6cyrx@gilmour>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 18 May 2021 16:49:45 +0200
Message-ID: <CAMuHMdXKaLpLL5Q1FnjHJ5kbs=+9Mm-QHXZp1i3M4zNr7G=e_w@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: display: ssd1307fb: Convert to json-schema
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Maxime,

On Tue, May 18, 2021 at 4:33 PM Maxime Ripard <maxime@cerno.tech> wrote:
> On Tue, May 18, 2021 at 09:51:31AM +0200, Geert Uytterhoeven wrote:
> > Convert the Solomon SSD1307 Framebuffer Device Tree binding
> > documentation to json-schema.
> >
> > Fix the spelling of the "pwms" property.
> > Document default values.
> > Make properties with default values not required.
> >
> > Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > I have listed Maxime as the maintainer, as he wrote the original driver
> > and bindings.  Maxime: Please scream if this is inappropriate ;-)
>
> Fine by me :)

Thanks!

> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/solomon,ssd1307fb.yaml

> > +  solomon,dclk-div:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 1
> > +    maximum: 16
> > +    description:
> > +      Clock divisor. The default value is controller-dependent.
>
> I guess we could document the default using an if / else statement?

While clk-div has only two different defaults, dclk-frq has different
defaults for each of the 4 variants supported.

Do you think it's worthwhile doing that? All upstream DTS files lack
these properties, thus use the default values.

> Looks good otherwise :)

Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
