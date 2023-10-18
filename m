Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE74CCDB47E
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 Oct 2023 12:18:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230125AbjJRMSd (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 Oct 2023 08:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjJRMSd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 Oct 2023 08:18:33 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099F698
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 05:18:31 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6073C433C9
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 12:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697631510;
        bh=XddDWpCWO5tLyj8aghLxovtfGpdl0eQkOQ4gQxKAP6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=M1TRXv0ylRsC/yszG2YZKRpcFRUhd/MZ7587TvZXTGC3G+v6vmiTfg6fCtJLKxORs
         HOifawjdmgLcbjL66C6Ag2NPY1NMrqkpZF1AvBcALssxSCrQ8UqW7XioO+Z/ukGmXZ
         tgxnHeW0ptBmydZ8V/0APXP/n4KS1YEoFQq/t07EaBCM3kXrDZLfy2zq35tRJRp3w9
         uEqnraFe+LjgT2tTWvp7F+U4zdXZtwh4Zxs6kZP80nMwuxYXwUDwER4EPPKkNLW3qf
         2FY97I4xewrgRm5877Pe8JHLy7Y3ra/91XE8L51vzUZehMv/wQg39LMeYvAZ5d8qCn
         Kt6MRmykVJcvg==
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-27d5fe999caso2468835a91.1
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 05:18:30 -0700 (PDT)
X-Gm-Message-State: AOJu0Yx4D07TO4QQocWYwBhmFd83g0UWKwR74cpUbezspEzkccC0k1zo
        9Qjc9GZl+UvYdVqC0bGbONkZD77TczJuYoawfE1lKA==
X-Google-Smtp-Source: AGHT+IGpzxfQ/eiGH5UAONVkzqwgA4ZNJ7XY3qL4FF7dmxIGHkuJPzxUPUUXxOtJ8pTEo6pp9k2UHUwrjXe1nAx5a98=
X-Received: by 2002:a17:90b:3749:b0:27d:882f:e6c5 with SMTP id
 ne9-20020a17090b374900b0027d882fe6c5mr4675714pjb.9.1697631510202; Wed, 18 Oct
 2023 05:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20231011143809.1108034-1-thierry.reding@gmail.com>
 <20231011143809.1108034-3-thierry.reding@gmail.com> <CAN6tsi462nsJ1x_Z-Mcy+MuyaWhwvyFSuG0Ey=Uvqy_Vd1L0xA@mail.gmail.com>
In-Reply-To: <CAN6tsi462nsJ1x_Z-Mcy+MuyaWhwvyFSuG0Ey=Uvqy_Vd1L0xA@mail.gmail.com>
From:   Robert Foss <rfoss@kernel.org>
Date:   Wed, 18 Oct 2023 14:18:19 +0200
X-Gmail-Original-Message-ID: <CAN6tsi7YTucSzsCgw53pde4cDbhU35XMmnjv_u5X+Meod2n-Mw@mail.gmail.com>
Message-ID: <CAN6tsi7YTucSzsCgw53pde4cDbhU35XMmnjv_u5X+Meod2n-Mw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fbdev/simplefb: Add support for generic power-domains
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, Helge Deller <deller@gmx.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Jon Hunter <jonathanh@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 18, 2023 at 12:35=E2=80=AFPM Robert Foss <rfoss@kernel.org> wro=
te:
>
> On Wed, Oct 11, 2023 at 4:38=E2=80=AFPM Thierry Reding <thierry.reding@gm=
ail.com> wrote:
> >
> > From: Thierry Reding <treding@nvidia.com>
> >
> > The simple-framebuffer device tree bindings document the power-domains
> > property, so make sure that simplefb supports it. This ensures that the
> > power domains remain enabled as long as simplefb is active.
> >
> > Signed-off-by: Thierry Reding <treding@nvidia.com>
> > ---
> >  drivers/video/fbdev/simplefb.c | 93 +++++++++++++++++++++++++++++++++-
> >  1 file changed, 91 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simpl=
efb.c
> > index 18025f34fde7..e69fb0ad2d54 100644
> > --- a/drivers/video/fbdev/simplefb.c
> > +++ b/drivers/video/fbdev/simplefb.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/of_clk.h>
> >  #include <linux/of_platform.h>
> >  #include <linux/parser.h>
> > +#include <linux/pm_domain.h>
> >  #include <linux/regulator/consumer.h>
> >
> >  static const struct fb_fix_screeninfo simplefb_fix =3D {
> > @@ -78,6 +79,11 @@ struct simplefb_par {
> >         unsigned int clk_count;
> >         struct clk **clks;
> >  #endif
> > +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> > +       unsigned int num_genpds;
> > +       struct device **genpds;
> > +       struct device_link **genpd_links;
> > +#endif
> >  #if defined CONFIG_OF && defined CONFIG_REGULATOR
> >         bool regulators_enabled;
> >         u32 regulator_count;
> > @@ -432,6 +438,83 @@ static void simplefb_regulators_enable(struct simp=
lefb_par *par,
> >  static void simplefb_regulators_destroy(struct simplefb_par *par) { }
> >  #endif
> >
> > +#if defined CONFIG_OF && defined CONFIG_PM_GENERIC_DOMAINS
> > +static void simplefb_detach_genpds(void *res)
> > +{
> > +       struct simplefb_par *par =3D res;
> > +       unsigned int i =3D par->num_genpds;
> > +
> > +       if (par->num_genpds <=3D 1)
> > +               return;
> > +
> > +       while (i--) {
> > +               if (par->genpd_links[i])
> > +                       device_link_del(par->genpd_links[i]);
> > +
> > +               if (!IS_ERR_OR_NULL(par->genpds[i]))
> > +                       dev_pm_domain_detach(par->genpds[i], true);
> > +       }
> > +}
> > +
> > +static int simplefb_attach_genpd(struct simplefb_par *par,
> > +                                struct platform_device *pdev)
> > +{
> > +       struct device *dev =3D &pdev->dev;
> > +       unsigned int i;
> > +       int err;
> > +
> > +       par->num_genpds =3D of_count_phandle_with_args(dev->of_node,
> > +                                                    "power-domains",
> > +                                                    "#power-domain-cel=
ls");
> > +       /*
> > +        * Single power-domain devices are handled by the driver core, =
so
> > +        * nothing to do here.
> > +        */
> > +       if (par->num_genpds <=3D 1)
> > +               return 0;
> > +
> > +       par->genpds =3D devm_kcalloc(dev, par->num_genpds, sizeof(*par-=
>genpds),
> > +                                  GFP_KERNEL);
> > +       if (!par->genpds)
> > +               return -ENOMEM;
> > +
> > +       par->genpd_links =3D devm_kcalloc(dev, par->num_genpds,
> > +                                       sizeof(*par->genpd_links),
> > +                                       GFP_KERNEL);
> > +       if (!par->genpd_links)
> > +               return -ENOMEM;
> > +
> > +       for (i =3D 0; i < par->num_genpds; i++) {
> > +               par->genpds[i] =3D dev_pm_domain_attach_by_id(dev, i);
> > +               if (IS_ERR(par->genpds[i])) {
> > +                       err =3D PTR_ERR(par->genpds[i]);
> > +                       if (err =3D=3D -EPROBE_DEFER) {
> > +                               simplefb_detach_genpds(par);
> > +                               return err;
> > +                       }
> > +
> > +                       dev_warn(dev, "failed to attach domain %u: %d\n=
", i, err);
> > +                       continue;
> > +               }
> > +
> > +               par->genpd_links[i] =3D device_link_add(dev, par->genpd=
s[i],
> > +                                                     DL_FLAG_STATELESS=
 |
> > +                                                     DL_FLAG_PM_RUNTIM=
E |
> > +                                                     DL_FLAG_RPM_ACTIV=
E);
> > +               if (!par->genpd_links[i])
> > +                       dev_warn(dev, "failed to link power-domain %u\n=
", i);
> > +       }
> > +
> > +       return devm_add_action_or_reset(dev, simplefb_detach_genpds, pa=
r);
> > +}
> > +#else
> > +static int simplefb_attach_genpd(struct simplefb_par *par,
> > +                                struct platform_device *pdev)
> > +{
> > +       return 0;
> > +}
> > +#endif
> > +
> >  static int simplefb_probe(struct platform_device *pdev)
> >  {
> >         int ret;
> > @@ -518,6 +601,10 @@ static int simplefb_probe(struct platform_device *=
pdev)
> >         if (ret < 0)
> >                 goto error_clocks;
> >
> > +       ret =3D simplefb_attach_genpd(par, pdev);
> > +       if (ret < 0)
> > +               goto error_regulators;
> > +
> >         simplefb_clocks_enable(par, pdev);
> >         simplefb_regulators_enable(par, pdev);
> >
> > @@ -534,18 +621,20 @@ static int simplefb_probe(struct platform_device =
*pdev)
> >         ret =3D devm_aperture_acquire_for_platform_device(pdev, par->ba=
se, par->size);
> >         if (ret) {
> >                 dev_err(&pdev->dev, "Unable to acquire aperture: %d\n",=
 ret);
> > -               goto error_regulators;
> > +               goto error_genpds;
> >         }
> >         ret =3D register_framebuffer(info);
> >         if (ret < 0) {
> >                 dev_err(&pdev->dev, "Unable to register simplefb: %d\n"=
, ret);
> > -               goto error_regulators;
> > +               goto error_genpds;
> >         }
> >
> >         dev_info(&pdev->dev, "fb%d: simplefb registered!\n", info->node=
);
> >
> >         return 0;
> >
> > +error_genpds:
> > +       simplefb_detach_genpds(par);
> >  error_regulators:
> >         simplefb_regulators_destroy(par);
>
> I saw an error on a rhel9.3 kernel build, it may or may not be hit on
> an upstream build.
>
> drivers/video/fbdev/simplefb.c: In function 'simplefb_probe':
> drivers/video/fbdev/simplefb.c:650:1: warning: label
> 'error_regulators' defined but not used [-Wunused-label]
>   650 | error_regulators:
>       | ^~~~~~~~~~~~~~~~
>
>

Scratch that. After applying on an upstream build, it builds cleanly.
