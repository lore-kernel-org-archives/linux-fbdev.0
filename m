Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795695621;
	b=KKjEu7Z8t8Dc+7adaSiyEhZOhNQIqIXFGKwJLGlK8e+lUSOfas0Cl4W0FljqMkoTP52g
	 Hdcff/MUcUPYYH0sdCQw95gRVaV4A+pQxfgPVRM8KKecCuU4lPpCe2Q9z/jzEGMt/dLAa
	 7DRyWqrZ3/nzvdVe7wG5Q5IVgkIvvuvZej7Hv0NqqFRb/PR4dhuOAsE0SeNG3hApb/9GF
	 7m6dO0iYI9B6zrpQow4+H34bFeH3gzmNnGkdDqbuwW8bgSvDqVipXy1KURojewZ+UqdhZ
	 JuaPPpHkx0PRwXTiAKaTOXuiShSNGc5LXSfZardshv24m8I6lqRh+y5bN8cGFyQYkHg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795695621;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+lSvuZp8Y17eXoO25lsbfQdbZJVTJnq/pMdU2BkHd48=;
	b=CbV0Ost3wzawSIEdUlyjYskZm8W8ClBXEGkt+Bmmb1hO1Lvp/ID59RXv2igg6xGWax3d
	 e2cmAu8b5TlajzriFZuT/YRhD54QdVcGYijCnOQ/DY3a8BVAVcTJxrZ5QacNe4IUzhSYl
	 vsWKTiGx0rX+GBSyxB871q/VyKKzIhUEwkeWTVEzz4S+xhNtSB/6EKmkwLvARguxPBnkq
	 yzYwwZkorXh0fKS8mM2NIqP6lEvA6Mi4OdSIjljU2LvxOjbHxpy9aUCqRTDgPbOyzHI68
	 2Zr3hDM1/c6yyh1KqkGH+wcOdkU9WcesJzaQwbeXfFKOLZSayYaviowYcbh/vPlSH/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UlaG+/e8";
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E2F9606A31E
	for <linux-fbdev@vger.kernel.org>; Thu, 26 Nov 2026 12:20:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E2F9606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UlaG+/e8
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3863db981d4so9794451eec.0
        for <linux-fbdev@vger.kernel.org>; Thu, 26 Nov 2026 04:20:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795695620; cv=none;
        d=google.com; s=arc-20260327;
        b=XZ3G0e7wL+Q5B/0AkdUVAZ3rWlpffn/WYlnQDc8+y7Ige9y8xuVSeaP//T0PLiKwOf
         LuS7LBfrF3kG+y/8qMehSTSL5EI6aSbc8mIQz7ykAuwwpSzbAEOXV9/PGgJhlPKnVtBB
         rz9dVczB7aMTpYHiJJpSIiOI+NUwHzt4my1/GCabmAXrcCBQ70B7+vqzHRC+7JgS+JXa
         Xirjvijcm4Cl7c9EA2HuwnUZ/3sQ5hOoVlvA/JoY1LZG5GwE/7rj7BT+0c1eG3E8xd70
         KhykksRaQtEsmMwW2neuQuG4eUyFZYNgg+qtOykzAhXlXtUWCOoboOr2yVAvRv01JWQx
         3Weg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+lSvuZp8Y17eXoO25lsbfQdbZJVTJnq/pMdU2BkHd48=;
        fh=iZ/357swq1KxocwpK2CKMUM/Jb1pp5TBcjYSHFQBdO0=;
        b=SDu4jciV36Eg5o1Ux0lQJSluzQyfphyfgkm43bGcCM0XBADCG7OZx49SN1qovRT8VA
         iEli6fW6aN4Z5M/quvop9nx+I3GStuz7Qtlu810cuzhry9sE0tc/szWu3pr/sQGmt9RP
         ALcbKVQUZumW220rbYg7sWTyOKsdK4oqsnFKf8oHBbTrrlGvJN3s7f+Hejk/B5QizZzJ
         +LE9jx6wmZRrGtD5nlZmqDI56QU1aSoh84eAqDPYODOsAeoLyJcFA9Sdoy/c0iIlfXgZ
         frQuaoDWP3JAMLz9TWXxFQbIrCVLO8N1zORk7tFogsLIJs299Jj+Mhbvd0btW5M75tpJ
         4X6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795695620; x=1796300420; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+lSvuZp8Y17eXoO25lsbfQdbZJVTJnq/pMdU2BkHd48=;
        b=UlaG+/e82l2AjomShygNKH/4y/HwtzYOoUI7zeBT0PWO6OWZm2i6LeI9evsqpKyp5b
         khnkoneCcNjZKC0QfqncH522M9OzVV9qSLcWDS2nP+dmA1u3GxFS5fSTAw5LnPe/VG+E
         N0L8KqiKbFAKzbttgM6OdAV3Lb9dhKETJkGfbu9nh5gsRWR7tBUe6WuKKIckaoJVOJ/L
         RHevXeFqAy7AxPANSVu9r08rWy/Tn/s8w1PBnC1LuVla8x9INDGxPnRsNYU/GOjif3EV
         rHHSKJmght1HjBB9PqlmGTvj+GNPlQ/B5K3EqNe7are3gkZVL0CWgx9kX8sM83Pf1ALC
         uDQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795695620; x=1796300420;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+lSvuZp8Y17eXoO25lsbfQdbZJVTJnq/pMdU2BkHd48=;
        b=ZH8K+YDUlAqps/FlgwXUD5ry86LRCAtfgbgMazqRfTDQrDG9Zox3suHiax543dVlzO
         2GXxIIDsJ+U5bjoKjxycIeIhXVUGeReI1BMtsKPWMqLrHRX9k+5xjEdEA1JQJa0ug4ms
         hPP/9jI5n/g1jMs4kB+nZewHmCzI5nYAIupM5R63vU+gWGkkn1/ivdvjh5zHACUcShvZ
         eX48N00uiv6H8ZIUj9BIaDeJv9o8eRoweTNH+v9aGVKT33asbkagVKY+3FU8VrbL8kUu
         f5eQtubb9J0cXLi0kh63UMbEQ24Nv9/36MT+yZ+XukHwYKCKOUTUIgf7IWE5dyORJhr0
         F76g==
X-Forwarded-Encrypted: i=1; AL+hErHWkVVbvaYrJl4UH4PBvEAa7mz4OgKP9Tyg7JQoraSmVV/PbIb6Irvn7Zpzc9eqCzAe4H0SI8DeCd6lHQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z8iZOTKSxvw+5BTe/T0+NXoXGMvqTT6t/WdrVMK+nx2eWF7l5r4
	+PveAvRLHU9PpheyhfNkY4/utJgbSNPNfS8UbC2Zwp8AKsHobQ0muNy5V60zW3hi7wQmGKIZYzs
	0gWCbfaDUFiJyIIsGlAibihYBMxW6mZM3P3h6
X-Gm-Gg: AZFdTZe55Jnoayov5aB0EsxSCcSB1UbN1dDgBxVqJt1ldpjl6LxiBNRlMHxKzNjUKTR
	Zx/TrhSiHeSw9r510kRybYGc97pDaCs6/bitccLxNcv0ox6FHhT6EsVFBJZtpdnOHOaPeWTJuEb
	lUPr9Md3rS2HRhas6Gig5KtQ9E1NLYZRETveIc48r5Emr1JYby5aRpO19WEK6RSxpa2tLUDl0t5
	sTsyMTqTpJkTzC7SsFVO2gkqfH7nExSTLfNkUIL/QM/gJlNgL8kk99S6O6yKCriDmdi3xe0h/Rw
	a3XsTANrqZ2JCh+OGhk5M9oGUrPj+pAeGZffnn8XOx+8416popRzxQ+eRaumxhJQ6EDOIkccHKp
	vi9/tEFscNeErEFyYZOeoFRsXojKAWpce1SAy2q4ko6kozQDxOkLLrTMycTxeQizTlOrdOQNqTs
	4PxjC0pbbxgQFGD6YIaCD2GY/kO9QIoywIejTVwyKXfdCJufI/oeY=
X-Received: by 2002:a05:7301:929:b0:376:37a2:87f3 with SMTP id
 5a478bee46e88-38570f25262mr19450186eec.31.1795695620162; Thu, 26 Nov 2026
 04:20:20 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115085155.80043-1-clamor95@gmail.com> <20261126114506.GF38590@joneslee-macbookpro.roam.internal>
In-Reply-To: <20261126114506.GF38590@joneslee-macbookpro.roam.internal>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 26 Nov 2026 14:20:08 +0200
X-Gm-Features: Aa3M54qVnLT4LX9aypLg829C8Q--H88cVFtiIS6wh8smfquZHuMzs0sW-CXGNDk
Message-ID: <CAPVz0n1QApS9Y67WH1xJ34wg9AWz+RQ0DXEd5jAPEnAw=cTd2g@mail.gmail.com>
Subject: Re: [PATCH v3] video: leds: backlight: lm3533: Support getting LED
 sources from DT
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 26 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 13:4=
5 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 15 Nov 2026, Svyatoslav Ryhel wrote:
>
> > Add Control Bank to HVLED/LVLED muxing support based on the led-sources
> > defined in the device tree.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
> > ---
> > This was part of the original LM3533 controller DT/OF conversion patchs=
et,
> > but it appears to have been accidentally separated during the final ite=
ration.
> > Therefore, I am sending it as a follow-up.
> >
> > Changes in v2:
> > - leds: switch to macros in regmap_update_bits() calls to apply 0xff ma=
sk
> >   since regmap writes may cause unwanted writing.
> >
> > Changes in v3:
> > - leds part moved into a separate patchset
> > - switched to dev_err_probe()
> > - for loop moved out of if condition
> > ---
> >  drivers/video/backlight/lm3533_bl.c | 44 +++++++++++++++++++++++++++++
> >  1 file changed, 44 insertions(+)
> >
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index fd6e7f4f1f61c..cb9df6ff73001 100644
> > --- a/drivers/video/backlight/lm3533_bl.c
> > +++ b/drivers/video/backlight/lm3533_bl.c
> > @@ -7,6 +7,7 @@
> >   * Author: Johan Hovold <jhovold@gmail.com>
> >   */
> >
> > +#include <linux/bits.h>
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> >  #include <linux/platform_device.h>
> > @@ -21,6 +22,7 @@
> >  #define LM3533_HVCTRLBANK_COUNT              2
> >  #define LM3533_BL_MAX_BRIGHTNESS     255
> >
> > +#define LM3533_REG_OUTPUT_CONF1              0x10
> >  #define LM3533_REG_CTRLBANK_AB_BCONF 0x1a
> >  #define   CTRLBANK_AB_BCONF_ALS(n)   BIT(2 * (n))
> >  #define   CTRLBANK_AB_BCONF_MODE(n)  BIT(2 * (n) + 1)
> > @@ -35,6 +37,9 @@ struct lm3533_bl {
> >       u32 max_current;
> >       u32 pwm;
> >
> > +     int num_leds;
> > +     u32 led_strings[LM3533_HVCTRLBANK_COUNT];
> > +
> >       bool have_als;
> >       bool linear;
> >  };
> > @@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attr=
ibute_groups[] =3D {
> >  static int lm3533_bl_setup(struct lm3533_bl *bl)
> >  {
> >       int ctrlbank =3D lm3533_bl_get_ctrlbank_id(bl);
> > +     u32 output_cfg_val =3D 0;
> > +     u32 output_cfg_mask =3D 0;
> >       int ret;
> >
> >       ret =3D regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCO=
NF,
> > @@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
> >       if (ret)
> >               return ret;
> >
> > +     for (int i =3D 0; i < bl->num_leds; i++) {
> > +             if (bl->led_strings[i] >=3D LM3533_HVCTRLBANK_COUNT)
> > +                     continue;
> > +
> > +             output_cfg_val |=3D ctrlbank << bl->led_strings[i];
> > +             output_cfg_mask |=3D BIT(bl->led_strings[i]);
> > +     }
> > +
> > +     if (bl->num_leds) {
> > +             ret =3D regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_=
CONF1,
> > +                                      output_cfg_mask, output_cfg_val)=
;
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       ret =3D lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current)=
;
> >       if (ret)
> >               return ret;
> > @@ -320,6 +342,28 @@ static int lm3533_bl_probe(struct platform_device =
*pdev)
> >
> >       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->p=
wm);
> >
> > +     /*
> > +      * If led-sources property is not set then either this Control Ba=
nk uses
> > +      * its default HVLED or is not linked to any HVLED at all.
> > +      */
> > +     bl->num_leds =3D device_property_count_u32(&pdev->dev, "led-sourc=
es");
> > +     if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
> > +             return dev_err_probe(&pdev->dev, -EINVAL,
> > +                                  "num of LED sources %d exceeds max %=
d\n",
>
> Nit: As I mentioned before, this is user-documentation - should be number=
?
>

Daniel Thompson was fine with num

> > +                                  bl->num_leds, LM3533_HVCTRLBANK_COUN=
T);
> > +
> > +     if (bl->num_leds < 0)
> > +             bl->num_leds =3D 0;
> > +
> > +     if (bl->num_leds > 0) {
> > +             ret =3D device_property_read_u32_array(&pdev->dev, "led-s=
ources",
> > +                                                  bl->led_strings,
> > +                                                  bl->num_leds);
> > +             if (ret)
> > +                     return dev_err_probe(&pdev->dev, ret,
> > +                                          "failed to get led-sources\n=
");
> > +     }
> > +
> >       ret =3D lm3533_bl_setup(bl);
> >       if (ret)
> >               return ret;
> > --
> > 2.53.0
> >
>
> --
> Lee Jones
