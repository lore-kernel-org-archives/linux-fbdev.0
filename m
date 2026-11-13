Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794584486;
	b=MFA/7Yy+jLPBkaNGzNpZZs+mV6VCKL/CHBIXSlQbiI87TqA0Qsm3MQFnOpSbfUEE1jsv
	 xBGwV/LxuOBnFnEszdLUx7KHxUkiabJHfHBpVX2gM369JTP3woFG6EykI/3gcKt5dvNar
	 V+/5Mt1OtNFK+bi9ihLzLy6iCx6zLB/HqWyN8llhMSLVNhVNJPKkIf/Pfddlcpwt2FQtZ
	 GBqG+K2OHdsh783imr58Gt/0tI5UxKozDYKhO1Plgv38daLuxdFDRRNEH0WJbJBvRZxbL
	 gz2B3BazSIpjmHGzgQadAuo/OSe4ZvLaWCXVk+nPS/4vd1sCu+UxcrVXZCf2v3ar2Rg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ictCGGMxgCgpUNAPmSmusxCn54ZLVwNtSFzM9e1649k=;
	b=tF+DTb+Kgs52DT+oVIp2JmKp99y2N6AHQi+Q6lsKIOQ9OyY8rSTfT4YBnXIoGxEKmBrR
	 9TwDlCDN8wLRI1TwG+HNRcg+8kkyzlRVPqsQ0aeEG9GLl2PfG+muxpucn7E4fUT//T/tr
	 RV1KX/avDGAUKgYpNqpfwjW73aD5ZUnWxiQ8P249xkpbUPIXGpX4N+sWOEG2lSiBoGyMY
	 MXa9Xp5ZgpkonUhkfO77j+SotgtqlAmbWu5Hj7Qb+QV3+KXZt/K9KKFBf3ssOqpCQiC4d
	 volAi5mraT0sLQnai1H1wldh5Xuug+VPIlnjI6uCeivZQFC2avfmq0CBk05rUS2/BaQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNOq1xRc;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A5A606A323
	for <linux-fbdev@vger.kernel.org>; Fri, 13 Nov 2026 15:41:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1A5A606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNOq1xRc
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cdb628232d2so1417526a12.0
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Nov 2026 07:41:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794584485; cv=none;
        d=google.com; s=arc-20260327;
        b=fsc+WZ2F9599chsZBqPpBIirHMY5NnTXDVFbJaS+Omzys6c7o4B+PvqOQDtFCeG3Me
         0T2MFq9pPTb3DBLG5Otp0uDFjLHC+nLW9EuIh+TStbIIiJPU/iwvUvyhnH5mFfjuTZQX
         Cf1qdTskwrnZIGdrPVqng4lsh6T4VDhgXPS3fPZW68TEOq4faVbIMtt/6B9MkkGtQaDs
         8mkN6ODVfreHit4a1OR3n4jg+aBixu7uM3yb9S+7ieAoFFL7uh/vZPzkxu8BdlFUwHjz
         6U8kX5auQJnPOBm2DgaGTqT+WEhbiemrwmNFZ38UyeoinyDBiYx7M1T/aVXr9C6W1/sT
         NrIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ictCGGMxgCgpUNAPmSmusxCn54ZLVwNtSFzM9e1649k=;
        fh=3Cia7aFUqx8ouv6TnPR4ow+Z/SspMvvwnMJbK4op7bY=;
        b=I2mqPfyFmj4M37Hg4KnvBiG/Z3s95qXG3rz8l9N+ibJ080yPVZaW9XccGce0u1Ccly
         d34KSArK53vdCPcKpoObDqeup8ItqpTjiwF+sN8Mx92F5cKCbM7NoqZMGdzTEX1R9ehA
         XexaG+dLa1/7mOi5PgH4xRTOIm6oygQ+s8fwaj2YAcPCF/mCa4/nxPxJ4UKLjKBDGwhz
         pRr1+UCyQYpAYGDEd3ooMX2ZsLy3SmEAmkf7I8y6TaTLbdKoDvMa5hpl0UZvtkW31oiZ
         sOlaYJ2gvui4BunZJDepE5YNYlV430WkLdeMefGtq6oEmcBjEyVPV4lkFx4LxhEKRk+6
         LsGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794584485; x=1795189285; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ictCGGMxgCgpUNAPmSmusxCn54ZLVwNtSFzM9e1649k=;
        b=sNOq1xRcDaTvk+7CO2nvBE8Z92YdcWOwAoUU2WsLmQXn3aRQTdsouN+A+17mIBHvyv
         ek9nmlKYRePtkM1jqWVqyCzZ5e7REGB2jIA7RZ4Po0puoAl2kSpjjb4/bbmbcHlZilv+
         Yfuda8kgiIMAMySNkVFkwfpUHPgt0r7IDghT6TDt8M8KbAIsJZqjFhkcF8r+RioqqUDM
         JSimh3r9KFgmbJeytjGT/bSUshkZnDfw1LTJBTiHV2bTC/plBs5uoBTWFDRTReQii3uS
         0iC/+gpNBuZmhUXjLrazSfR7YqwPWZovxpMMPUa4F0dekmeMPx377iM8QFf1tcV134ld
         prdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794584485; x=1795189285;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ictCGGMxgCgpUNAPmSmusxCn54ZLVwNtSFzM9e1649k=;
        b=17F/23z3DloweBvs0OB5AkZ9X9SQetZy7ZYe4OR7CIbI3qZhN+lvCIMw58D63kESuG
         O8l+hEtvH7tNCf9FXi5UdLrfm5rzuvaLhFugh2HqUsotSCxVXTZ/1aHLDjH3ds2/p2zx
         TflCmO5hNh6m3xA1ltE4AOehWK2Qk/lpT4gsjMVBZP2yC+pS+AVE3qOXPCzQ238d8PSW
         upMMOh9ifQRbhT9PQQH9rnTbUunaa20sYGXfd9f+icxZZWDM+Ye3/gd5OHaaLIeY0LPZ
         pc0Sm7jYA0YAi4jUhp4vTt1YukiQHtan+Aoz20lznkrgiALWapEplumyehzDTsmS3Agq
         slwg==
X-Forwarded-Encrypted: i=1; AL+hErE7Hu2Sz3B3Y36mwyAI1qiGUJduEqZil847ZrzDk16u2Fg+DkCF3c3ub/9D1JcaAQMpEZ+J7zerpyXRCQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/UjntzyFjGDZpuyE+VsOLaMsymnbf9Pyou8zACkUz0S7/n0ekI
	eNx2i0ZZ6ASuw/vheT4e3lr+ZkUedWLVRFMZ7Ehj6WSZ7VEqHtBnLhifh/RrcTPA3PjqrWDEQOI
	VWFa73h494xQaIPxHoU2yI+vQ5D9Xy3A=
X-Gm-Gg: AYBFou0pnVhmpwg0DHDnwVott5CHsm5/n6pE+I3pkTWm2GtnLp914RCS0/mTmoIg/HG
	Bb7m5FXAr3i060IinbM9YQ4PQClqlr/tPtTzGhcgL4QweMYPoVXtzyixHWOBukL9zr49bUNJv+2
	dHweaMnxH/ulhBNwEU72emhm8AUgTwWWaYUR4n4UBni2f/Zc+V1xhu5x+Wu7mLJMzSzsj1u+GWX
	R6ic5vCbOwz56YskAZBCEdIFG7ptkZlH3b9H0c2x12EiMFi2Hp1/AjRVzrKHGzX3tNqtGpEjZmf
	dC8fKO4sOzC90mSUOjE9fVZaNVTG3FF2U4tCBlduQcvnSYHI9avk8WRxUOHMKZfrsn9wmPtE0WV
	+MC3mZRJrNWt2i0OkiCNUl+ABi2MszMS7KJ2WeQOGcEROmJAvMZgrb4AK9S8SkG2bVOE6kkOUBA
	zOxV0zCXyutJwyxNvhzNtYaQvXOXMiXg==
X-Received: by 2002:a05:7022:3c87:b0:16c:4eef:a526 with SMTP id
 a92af1059eb24-1b5030e2ee9mr2671578c88.15.1794584484844; Fri, 13 Nov 2026
 07:41:24 -0800 (PST)
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101142435.130520-1-clamor95@gmail.com> <179370032880.793788.4424159880220279586@kernel.org>
In-Reply-To: <179370032880.793788.4424159880220279586@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Fri, 13 Nov 2026 17:41:12 +0200
X-Gm-Features: AclHuK_BgAPnek8SSBsS7xD29UnkVImGVLvK3G9PVowz-sB26JLAqdiA-Cf1RLY
Message-ID: <CAPVz0n1E2bLOzKEC6_2iiPM5ZZ6-NOXuOkwx+jQYn8BRvPXwSw@mail.gmail.com>
Subject: Re: [PATCH v1] video: leds: backlight: lm3533: Support getting LED
 sources from DT
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Griffin Kroah-Hartman <griffin@kroah.com>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, 
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 13 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 16:5=
3 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> Drop the 'video: ' part of the subject line.
>
> Please review, explain or fix the Sashiko review(s).
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
> > ---
> >  drivers/leds/leds-lm3533.c          | 60 +++++++++++++++++++++++++++++
> >  drivers/video/backlight/lm3533_bl.c | 45 ++++++++++++++++++++++
>
> Why are these being bundled up?
>
> What is the dependency?  If none, please separate.
>
> >  2 files changed, 105 insertions(+)
> >
> > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> > index 7259097bd6a71..a1aeff70a90fc 100644
> > --- a/drivers/leds/leds-lm3533.c
> > +++ b/drivers/leds/leds-lm3533.c
> > @@ -26,6 +26,11 @@
> >  #define LM3533_ALS_CHANNEL_LV_MIN    1
> >  #define LM3533_ALS_CHANNEL_LV_MAX    2
> >
> > +#define LM3533_REG_OUTPUT_CONF1                      0x10
> > +#define   OUTPUT_CONF1_SHIFT                 2
> > +#define   OUTPUT_LVLED_MASK                  0x3
> > +#define LM3533_REG_OUTPUT_CONF2                      0x11
> > +#define   OUTPUT_CONF2_SHIFT                 6
> >  #define LM3533_REG_CTRLBANK_BCONF_BASE               0x1b
> >  #define LM3533_REG_PATTERN_ENABLE            0x28
> >  #define LM3533_REG_PATTERN_LOW_TIME_BASE     0x71
> > @@ -54,6 +59,9 @@ struct lm3533_led {
> >       u32 max_current;
> >       u32 pwm;
> >
> > +     int num_leds;
> > +     u32 leds[LM3533_LVCTRLBANK_MAX];
> > +
> >       bool have_als;
> >  };
> >
> > @@ -622,8 +630,36 @@ static const struct attribute_group *lm3533_led_at=
tribute_groups[] =3D {
> >
> >  static int lm3533_led_setup(struct lm3533_led *led)
> >  {
> > +     u32 output_cfg_shift =3D 0;
> > +     u32 output_cfg_val =3D 0;
> > +     u32 output_cfg_mask =3D 0;
> >       int ret;
> >
> > +     if (led->num_leds) {
> > +             for (int i =3D 0; i < led->num_leds; i++) {
> > +                     if (led->leds[i] >=3D LM3533_LVCTRLBANK_MAX)
> > +                             continue;
> > +
> > +                     output_cfg_shift =3D led->leds[i] * 2;
> > +                     output_cfg_val |=3D led->id << output_cfg_shift;
> > +                     output_cfg_mask |=3D OUTPUT_LVLED_MASK << output_=
cfg_shift;
> > +             }
> > +
> > +             /* LVLED1, LVLED2 and LVLED3 */
> > +             ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT=
_CONF1,
> > +                                      output_cfg_mask << OUTPUT_CONF1_=
SHIFT,
> > +                                      output_cfg_val << OUTPUT_CONF1_S=
HIFT);
> > +             if (ret)
> > +                     return ret;
> > +
> > +             /* LVLED4 and LVLED5 */
> > +             ret =3D regmap_update_bits(led->regmap, LM3533_REG_OUTPUT=
_CONF2,
> > +                                      output_cfg_mask >> OUTPUT_CONF2_=
SHIFT,
> > +                                      output_cfg_val >> OUTPUT_CONF2_S=
HIFT);
> > +             if (ret)
> > +                     return ret;
> > +     }
> > +
> >       ret =3D lm3533_ctrlbank_set_max_current(&led->cb, led->max_curren=
t);
> >       if (ret)
> >               return ret;
> > @@ -698,6 +734,30 @@ static int lm3533_led_probe(struct platform_device=
 *pdev)
> >
> >       device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->=
pwm);
> >
> > +     /*
> > +      * If led-sources property is not set then either this Control Ba=
nk uses
> > +      * its default LVLED or is not linked to any LVLED at all.
> > +      */
> > +     led->num_leds =3D device_property_count_u32(&pdev->dev, "led-sour=
ces");
> > +     if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
> > +             dev_err(&pdev->dev, "num of LED sources exceeds max %d: %=
d\n",
>
> "Number "
>
> > +                     LM3533_LVCTRLBANK_MAX, led->num_leds);
> > +             ret =3D -EINVAL;
> > +             goto err_deregister;
> > +     }
>
> Could we move the 'led-sources' parsing above led_classdev_register(),
> or convert the driver to devm_led_classdev_register() and use 'return
> dev_err_probe()' here?
>

I will convert to devm_led_classdev_register() as precursor to this patch.

> > +     if (led->num_leds < 0)
> > +             led->num_leds =3D 0;
> > +
> > +     if (led->num_leds > 0) {
> > +             ret =3D device_property_read_u32_array(&pdev->dev, "led-s=
ources",
> > +                                                  led->leds, led->num_=
leds);
> > +             if (ret) {
> > +                     dev_err(&pdev->dev, "failed to get led-sources\n"=
);
> > +                     goto err_deregister;
> > +             }
>
> dev_err_probe()
>
> > +     }
> > +
> >       ret =3D lm3533_led_setup(led);
> >       if (ret)
> >               goto err_deregister;
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index adcd6ac7cf229..e8164c8528577 100644
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
> > +     if (bl->num_leds) {
> > +             for (int i =3D 0; i < bl->num_leds; i++) {
> > +                     if (bl->led_strings[i] >=3D LM3533_HVCTRLBANK_COU=
NT)
> > +                             continue;
> > +
> > +                     output_cfg_val |=3D ctrlbank << bl->led_strings[i=
];
> > +                     output_cfg_mask |=3D BIT(bl->led_strings[i]);
> > +             }
>
> This for loop doesn't need to be in the if statement.
>

It is in if statement because if node has no "led-sources"
LM3533_REG_OUTPUT_CONF1 should not be touched and must be left in its
default state.

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
> > @@ -320,6 +342,29 @@ static int lm3533_bl_probe(struct platform_device =
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
> > +     if (bl->num_leds > LM3533_HVCTRLBANK_COUNT) {
> > +             dev_err(&pdev->dev, "num of LED sources %d exceeds max %d=
\n",
> > +                     bl->num_leds, LM3533_HVCTRLBANK_COUNT);
> > +             return -EINVAL;
> > +     }
>
> dev_err_probe()
>
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

Other suggestions are valid, I will apply them in v3

> --
> Lee Jones
