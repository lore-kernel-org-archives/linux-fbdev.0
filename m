Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13729C77B7F
	for <linux-fbdev@archiver.kernel.org>; Mon,  8 May 2023 20:55:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbjEHUza (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 8 May 2023 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233235AbjEHUz3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 8 May 2023 16:55:29 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75FDE65B6
        for <linux-fbdev@vger.kernel.org>; Mon,  8 May 2023 13:54:58 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 3f1490d57ef6-b9a6d9dcbebso4467488276.2
        for <linux-fbdev@vger.kernel.org>; Mon, 08 May 2023 13:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683579297; x=1686171297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebgkfCiodiKcun60kKBUwZij72grfP4UOmjlc+G6i8I=;
        b=k0YYa/u76d7Ieqtnsvy/Saa1HPB4iaH1dWzUdUuvpcLGfYYlTzbXgK21e8GZZqfZ7i
         YE+F+MB9zyXtiARKsPNIiY9f3Yvt1HVWAVLTf6t6yhR5GOODuvZu3luqlcRMbLYDDKCC
         QpsnZEqepGgE18Mu6mcHcKTrkO/b+Iy6POYKLn7fB3mza3FUb79uQ3OyDUmYLPLGyrU9
         yFfOpdYmElLihnmMJxGsSFbxtufg1vlUdp39zLnUMxZA1zevF+Nwgewq67DDlHNDL6rq
         W1tR4tE5bhj81NA+/5pweLJQAC6rL4aL5pDyC8sWhOEqEyQUW98xARAg6p4xXnZCWIp9
         mDsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579297; x=1686171297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebgkfCiodiKcun60kKBUwZij72grfP4UOmjlc+G6i8I=;
        b=i6v5HqMr5I2++VmuLTQMRr1RA9e6Fk2lDLGlod8AIj0sWq37KuycxPV9gc8geYPh+5
         h1o/uKPzkJdeYokvYd1SrWBP0fzQJ77nufZEkDL+Nd9T5bhd2rtSFayyqK28H7riA9Zb
         AIiQk3s9o+LRsG15Hasl2Jh5kNsca8WPaI9wo1nIvjeeRysslI+AP/H646w8OF5oOtdF
         32tfKaTW8fq/f7OtVUCZbLmdZrpaDYyCZGIAkx0rFdHP2o7Zi3VvoBFKP2tQ3I7J4Sdy
         qK7qIYZxhq1g4sxj79Yi+xdryCGGEkgf8PKhBm8tdKfKMrOZZV5uwdnHWAiDCilUxTjO
         y2pg==
X-Gm-Message-State: AC+VfDynJh4ORubHLebEF2L3DQ8uqpq6egbT7jbYayqK+p6wDWptbuM6
        SjO7VrR3eHu/s0oki3ek+KDN9s/4gpaoeGAFNZGIjA==
X-Google-Smtp-Source: ACHHUZ61Co9c2vfFGtG+tpLFRQ4UHj1QYb0g4ygOt03JqCB/lCRGyKCa19BWVLj8Nu27zbXZko10yxza9yB0luPTCMc=
X-Received: by 2002:a25:54b:0:b0:b99:f279:10dc with SMTP id
 72-20020a25054b000000b00b99f27910dcmr12394809ybf.28.1683579297026; Mon, 08
 May 2023 13:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230430-nokia770-regression-v3-0-a6d0a89ffa8b@linaro.org>
 <20230430-nokia770-regression-v3-1-a6d0a89ffa8b@linaro.org> <ZFkSMBhw5UaWdpsM@surfacebook>
In-Reply-To: <ZFkSMBhw5UaWdpsM@surfacebook>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 8 May 2023 22:54:45 +0200
Message-ID: <CACRpkda8zbR3CnRp5w=NvRder1rYTs+DYZN0QyhneDwR1E_qUA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] Input: ads7846 - Convert to use software nodes
To:     andy.shevchenko@gmail.com
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
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

On Mon, May 8, 2023 at 5:16=E2=80=AFPM <andy.shevchenko@gmail.com> wrote:
> Fri, May 05, 2023 at 01:16:55PM +0200, Linus Walleij kirjoitti:

> > The Nokia 770 is using GPIOs from the global numberspace on the
> > CBUS node to pass down to the LCD controller. This regresses when we
> > let the OMAP GPIO driver use dynamic GPIO base.
(...)

> >  #include <linux/gpio.h>
>
> Do we need it after this patch?

Yes, but it is finally removed in patch 3/3!

Fixed the rest, thanks!

Yours,
Linus Walleij
