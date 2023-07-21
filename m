Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79BC0C001DC
	for <linux-fbdev@archiver.kernel.org>; Fri, 21 Jul 2023 11:09:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGULJQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 21 Jul 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232290AbjGULIh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 21 Jul 2023 07:08:37 -0400
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388B535BE
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jul 2023 04:07:46 -0700 (PDT)
Received: by mail-ua1-x92f.google.com with SMTP id a1e0cc1a2514c-799a451ca9cso741907241.2
        for <linux-fbdev@vger.kernel.org>; Fri, 21 Jul 2023 04:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1689937665; x=1690542465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r5tB76GjvqrYC+DTRCo2UQKFWIgvLZ4XI2pYbsVGhys=;
        b=s8I6ZrL/nSmSOh9gkg0xEc4qZagaDjutE3xd71QcIAObHXuZykrTAcjoDNIXBituuI
         HfWx90BqkwyI2tmkd4+4t2d0qvVkPcI1SCuYhkbCYwC4t/HXUkjJS+nLT3ZsI1BdxJXg
         mzzCGAV3b64Pwwl1dViRpl330WXavnDX/B+vZqT0QTHiHBuOBE77zkRjBSeele2dVpNn
         ZYDxjjev13elrGGo9CRNfZtuWdLytrcXtf6/zgMxxjdJwCsZQm9flKvxcWws3e+iAHYX
         SVkbDdsTg5RziOdyfdZGrrsI6tqgfTCMf8oo4whzYo2tQAG+gnfTcBIz5g3q8zdfHdoD
         ribA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689937665; x=1690542465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r5tB76GjvqrYC+DTRCo2UQKFWIgvLZ4XI2pYbsVGhys=;
        b=Zq0hhjf1DokTe7LZK91nPnY7cLMN3GWiaxu5Mu9YfK1VAAiydO0Iv9JROpfx3zlpju
         1izZxA08hoBtFE23eWa/XkS5bZfpamDSgORnkpxgU+pA3LtxaaAIgpEGPx/bLla+2Qdo
         9HzVjvEzrNc+mOAYQ1WTSmoxW0WHrVBnwx4OaumOJN9pEJWRgUHiP4WxnYexYMkEgnxd
         nT1ncWClmMleJ/SKndnnpe6BR0EGgzAYHs9NOHMCKaPHbgeaXploHfAwHhAxHeIu/Vq5
         h+F/Y0RwfzTYn1o4r+K60oUwBcFE03SMDu9MrhFmM2b3KpWzkwGH5cfTjQ7F8eokUQ7Y
         cezw==
X-Gm-Message-State: ABy/qLaQRIgM+vlyiG7xdDt5EczQjlM7ejogCLONc1l9QoqN7QAtVzpv
        /IhtHhgfKfsWluUqC4LbzN6P87fPIqgr8yDRhN4H6Q==
X-Google-Smtp-Source: APBJJlFUir/tUCGBKYIaKDI8tzxMysdIpDY7h5Mgngyxia5S6KeG3LorcA/vbJOB1C3s1aEGCGCbVEXRwmusmkxxOc8=
X-Received: by 2002:a67:b34a:0:b0:446:bf73:771a with SMTP id
 b10-20020a67b34a000000b00446bf73771amr659018vsm.20.1689937665364; Fri, 21 Jul
 2023 04:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230721093342.1532531-1-victor.liu@nxp.com>
In-Reply-To: <20230721093342.1532531-1-victor.liu@nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 21 Jul 2023 13:07:34 +0200
Message-ID: <CAMRc=MfPKQuEGrFXuPNOKchE_Fj+obOheDoemoF9rxtRWYiFCg@mail.gmail.com>
Subject: Re: [PATCH v4] backlight: gpio_backlight: Drop output GPIO direction
 check for initial power state
To:     Ying Liu <victor.liu@nxp.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lee@kernel.org" <lee@kernel.org>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "deller@gmx.de" <deller@gmx.de>,
        "andy@kernel.org" <andy@kernel.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jul 21, 2023 at 11:29=E2=80=AFAM Ying Liu <victor.liu@nxp.com> wrot=
e:
>
> If GPIO pin is in input state but backlight is currently off due to
> default pull downs, then initial power state is set to FB_BLANK_UNBLANK
> in DT boot mode with phandle link and the backlight is effectively
> turned on in gpio_backlight_probe(), which is undesirable according to
> patch description of commit ec665b756e6f ("backlight: gpio-backlight:
> Correct initial power state handling").
>
> Quote:
> ---8<---
> If in DT boot we have phandle link then leave the GPIO in a state which t=
he
> bootloader left it and let the user of the backlight to configure it furt=
her.
> ---8<---
>
> So, let's drop output GPIO direction check and only check GPIO value to s=
et
> the initial power state.
>
> Fixes: 706dc68102bc ("backlight: gpio: Explicitly set the direction of th=
e GPIO")
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> ---
> v3->v4:
> * Capitalize words 'gpio' in patch description. (Andy)
> * Capitalize word 'gpio' in patch title.
> * Quote appropriately in patch description. (Andy)
>
> v2->v3:
> * Add Fixes tag. (Daniel)
>
> v1->v2:
> * Improve patch description. (Daniel, Bartosz, Andy)
>
>  drivers/video/backlight/gpio_backlight.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/video/backlight/gpio_backlight.c b/drivers/video/bac=
klight/gpio_backlight.c
> index 6f78d928f054..38c46936fdcd 100644
> --- a/drivers/video/backlight/gpio_backlight.c
> +++ b/drivers/video/backlight/gpio_backlight.c
> @@ -87,8 +87,7 @@ static int gpio_backlight_probe(struct platform_device =
*pdev)
>                 /* Not booted with device tree or no phandle link to the =
node */
>                 bl->props.power =3D def_value ? FB_BLANK_UNBLANK
>                                             : FB_BLANK_POWERDOWN;
> -       else if (gpiod_get_direction(gbl->gpiod) =3D=3D 0 &&
> -                gpiod_get_value_cansleep(gbl->gpiod) =3D=3D 0)
> +       else if (gpiod_get_value_cansleep(gbl->gpiod) =3D=3D 0)
>                 bl->props.power =3D FB_BLANK_POWERDOWN;
>         else
>                 bl->props.power =3D FB_BLANK_UNBLANK;
> --
> 2.37.1
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
