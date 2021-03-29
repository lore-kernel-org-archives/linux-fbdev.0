Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D972C433EC
	for <linux-fbdev@archiver.kernel.org>; Mon, 29 Mar 2021 13:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2820E6191B
	for <linux-fbdev@archiver.kernel.org>; Mon, 29 Mar 2021 13:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbhC2NrL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 29 Mar 2021 09:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbhC2NrC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 29 Mar 2021 09:47:02 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 441F0C0613D8;
        Mon, 29 Mar 2021 06:47:02 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id i26so18478677lfl.1;
        Mon, 29 Mar 2021 06:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/ZN6EMo52SbaQUsmKOCXmommiFRM5AB/xm3XewoiYhs=;
        b=Oeqyc89nK7UnF76eztri1XWlbwhf1LqxwgbhcM9yI/hhu1u6x6zmnZ4pTQEh4Qu2QJ
         VNe4qmDHvddpFurC0edRtdwKXXnwyISy/lF1QI7mFWAy/E37nYjRYOPWuiPKV+RAHjs9
         wpTNLXkRf1R/HBh4B9dzflVKia/LBF9qvfntHXLyz7z0WG4fkYZA3xYtavUP0DlbuN0j
         Sud0yBuNt5IzQyVcmvG8eKp8BBZqfJBWM+IGLDkp6rYJJAaCSum1c5CRx401QsOrYyaZ
         JTkWUShzmUjF1/Kdpb3yn1B906vNJ1Az8ghhJ3J8tlifMW+DDmFlIOzNEEptZQdFLI8l
         vZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/ZN6EMo52SbaQUsmKOCXmommiFRM5AB/xm3XewoiYhs=;
        b=EX0Y+gK98gKY8EoiUH1s8hoN53hAeg9BWE2Kkar2ibAkFqbSsKiogNyhPHR3nqVvlj
         KCqWn/5fZEawNYNXIVsXj7wcXp7/ExrdDrba06CAlBhuW+RGw1uUPANMUZ1Q/byGX82D
         q/xYsioAehElENpfrGmztVPt3i8tL+kDtXp5bcJktIzKAUyISsfAIedmlOiQowOeXuE9
         3aVCjx+8WckzLf1g6P6aKNI+Yq/3St4jqE6hYMPkhxFq3/5lLVK0wBJ42HZalaL+cwuN
         IgCMMPOwrkzz7UnToFhV743l6JBSayTHo8TayI3wo5Gz7tvG4OyNeXumLrfPTOajE6yV
         LSrg==
X-Gm-Message-State: AOAM530xvI+95A/lhPd2gz/QY5qmNj9JwZe3NJeIZevlRz7SEG162t7/
        XVPW8AIq/ApWmyaIY2gs9Te6tuowqeCT8jRXS3w=
X-Google-Smtp-Source: ABdhPJwlTFxxxoL8t/ryBWeJEvoDMU/sXt5+NYDNZCURvjifVPNLUJdBS/C8njMLX/RRBW8oiED2xNB9qFYS5yRZUdo=
X-Received: by 2002:a05:6512:1192:: with SMTP id g18mr15585545lfr.408.1617025620636;
 Mon, 29 Mar 2021 06:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <1616945059-8718-1-git-send-email-u0084500@gmail.com>
 <1616945059-8718-4-git-send-email-u0084500@gmail.com> <20210329102631.sh5ttefjvfsfg6tk@maple.lan>
In-Reply-To: <20210329102631.sh5ttefjvfsfg6tk@maple.lan>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Mon, 29 Mar 2021 21:46:48 +0800
Message-ID: <CADiBU3-2LvLzUZA08EKvzZ7qG8xKPbzbbFzTE3H-Z_8DMP=5OA@mail.gmail.com>
Subject: Re: [PATCH v6 4/4] backlight: rt4831: Adds support for Richtek RT4831 backlight
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        ChiYuan Huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi, Daniel:

Daniel Thompson <daniel.thompson@linaro.org> =E6=96=BC 2021=E5=B9=B43=E6=9C=
=8829=E6=97=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:26=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> On Sun, Mar 28, 2021 at 11:24:19PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Adds support for Richtek RT4831 backlight.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > since v6
> > - Fix Kconfig typo.
> > - Remove internal mutex lock.
> > - Add the prefix for max brightness.
> > - rename init_device_properties to parse_backlight_properties.
> > - Remove some warning message if default value is adopted.
> > - Add backlight property scale to LINEAR mapping.
> > - Fix regmap get to check NULL not IS_ERR.
> > ---
> >  drivers/video/backlight/Kconfig            |   8 ++
> >  drivers/video/backlight/Makefile           |   1 +
> >  drivers/video/backlight/rt4831-backlight.c | 203 +++++++++++++++++++++=
++++++++
> >  3 files changed, 212 insertions(+)
> >  create mode 100644 drivers/video/backlight/rt4831-backlight.c
> >
> > diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/=
Kconfig
> > index d83c87b..de96441 100644
> > --- a/drivers/video/backlight/Kconfig
> > +++ b/drivers/video/backlight/Kconfig
> > @@ -289,6 +289,14 @@ config BACKLIGHT_QCOM_WLED
> >         If you have the Qualcomm PMIC, say Y to enable a driver for the
> >         WLED block. Currently it supports PM8941 and PMI8998.
> >
> > +config BACKLIGHT_RT4831
> > +     tristate "Richtek RT4831 Backlight Driver"
> > +     depends on MFD_RT4831
> > +     help
> > +       This enables support for Richtek RT4831 Backlight driver.
> > +       It's common used to drive the display WLED. There're four chann=
els
>
> Nitpicking but I was expecting the original typo be converted to
> "commonly".
>
OK, I'll correct this typo in v7 next.
And will merge the reviewed-by line.
Thx.
>
> With that addressed:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
>
>
> Daniel.
