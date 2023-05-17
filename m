Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0CEC7EE22
	for <linux-fbdev@archiver.kernel.org>; Wed, 17 May 2023 21:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjEQVgl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 17 May 2023 17:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjEQVgk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 17 May 2023 17:36:40 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F78DA
        for <linux-fbdev@vger.kernel.org>; Wed, 17 May 2023 14:36:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-56186035b61so15608967b3.3
        for <linux-fbdev@vger.kernel.org>; Wed, 17 May 2023 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684359398; x=1686951398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cY/eQ57fs7dlsVatS+jhyTGHg7yG2gHeDPH1M03tXUo=;
        b=irhJRAZwAa+Gz1ebjP8wNR2BRjZ5Zj07hEtQe4UvjcUFgzjGovspvZeA/w3QdqXsS+
         lJJbkj+3CaoQ+fAEvdkw4718cc3C3dx6NYhWfOJ1i8oYKYlkR9TPkLuiYZLgdW8hsG8t
         XWe9WwmmeT20MQwLbZ6Q3D3vHXl93BrmscrfPN0tDA1Tx+CkAI/aN+Ci8Ak6Rl0iS9Pn
         idxE4AUkf+FVu7lfpHsVt+wtoFI81duKbgfNn3xHbH5V+Me84d6ISJVf37U5UU+1m4AU
         ieEV8WtukMZAEkzoJzomR6uwI8vYg8OVdyOorRQU3YNGZ11A8/p8eTt9YQEojj4/AEWh
         F5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684359398; x=1686951398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cY/eQ57fs7dlsVatS+jhyTGHg7yG2gHeDPH1M03tXUo=;
        b=a+mxood+Y18+OjVV0iHs6YU3JCo6vHpQ5Zb2rXq0o16Kuu/+qT5vVoPUt8KHhOhW4p
         2elvLMcaTBSc6trU33zwVyq8dt0YaFg4SBcDyP8PCwwcqxlLqOZYm/XBahrLZZdmHxkb
         gEDMVLbJMAjuTVP/gSYISXOKDd/MKU6eT+2C55bdaehmCv/EX+XIKClXcbBEhVJN4ev8
         G7iMBnavGgkjf45TWQVLUgg0C8ZgD7+7JjX0bVLnRVJU12KfzMHWpohMwK9gcLjzU35Z
         71Eqf8bqn4JhFtOj6Vje/+M4APskqMId8ENFzP8EcPnyuNII2Kd136YPH1IclCZc9Twp
         hOjw==
X-Gm-Message-State: AC+VfDwVKF+WZdY3CBtV3OE+2A99QtvVebSFB9g2k1WNBTUs63QXyk7m
        Ita4MmO4PAcMXep9EoBxRwIxHtaqNxkPXy4O89i36A==
X-Google-Smtp-Source: ACHHUZ4pIBn19+BLD6UElqlgO1dKdZPd0Ga1Aky4aWI+i3dEfXBJQZ1abYF5itannmQlr0DCkYCOVvzdFktxBrZVq/A=
X-Received: by 2002:a0d:cc56:0:b0:561:e7bb:1b20 with SMTP id
 o83-20020a0dcc56000000b00561e7bb1b20mr1351592ywd.34.1684359398379; Wed, 17
 May 2023 14:36:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v4-0-9b6dc5536b17@linaro.org>
 <20230430-nokia770-regression-v4-2-9b6dc5536b17@linaro.org> <20230517203011.GH271152@darkstar.musicnaut.iki.fi>
In-Reply-To: <20230517203011.GH271152@darkstar.musicnaut.iki.fi>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 17 May 2023 23:36:26 +0200
Message-ID: <CACRpkdb0uSkfQZxZ_mpesGSjvf0gZzaZyw5iV1haAovH8cfngA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] ARM/mmc: Convert old mmci-omap to GPIO descriptors
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Andreas Kemnade <andreas@kemnade.info>,
        Helge Deller <deller@gmx.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-input@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mmc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, May 17, 2023 at 10:30=E2=80=AFPM Aaro Koskinen <aaro.koskinen@iki.f=
i> wrote:

> This one has some issue as mmci-omap is unable to find the GPIOs on 770.
>
> On Mon, May 08, 2023 at 11:20:07PM +0200, Linus Walleij wrote:
> > +static struct gpiod_lookup_table nokia770_mmc_gpio_table =3D {
> > +     .dev_id =3D "mmci-omap",
>
> Changing this to "mmci-omap.1" helped, not sure if that is a correct way.
> Most likely N800 and N810 are broken as well.

Yep looked over it, OMAP1 has mmci-omap.1 and OMAP2 has
mmci-omap.0.

Yours,
Linus Walleij
