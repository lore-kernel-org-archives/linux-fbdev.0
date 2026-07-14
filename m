Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09A944CAFC
	for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784037438; cv=pass; b=vAWEEaWjVgIq3NAb6bnQo4V7yVCWBXmCV1QAHW30tQlAKT8LgnIWlsX3QB4YA4jNiRcqt08nyOdkUJLKNNxaAatrZRMU6TvRAW6U8jxjTBlwXQiNbimONqa5xVGKQhmaSJ+p+Z+1GF5c2PveIUtrhKXraZB11soiQtPkrmkk3rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784037438; c=relaxed/simple;
	bh=bKvQQ9NyV0Yy6KGpY/AypZO5tBgNBP9Y9pMaKUN8X+M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAr2r/xf/EtPRq88+Iyw2iZFQroke5zAPwzTpY4Y8cpCahXWAXL9TqPDkKUF7ufjUrLsIXxpLKNVi2//wKCTclpN0E2o3UKOYkD7dNP01fOxlMwahvnWXcJPhwBhx+3UWGcdrKMZXhKXFOLY5bSDToRvRF18w69bHkCxrpEaBBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gw5v5B9a; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gw5v5B9a"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-caf45fc5202so1935701a12.1
        for <linux-fbdev@vger.kernel.org>; Tue, 14 Jul 2026 06:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784037434; cv=none;
        d=google.com; s=arc-20260327;
        b=Eje8MFKwzjLu78kD5alFJ0UML4HTij+M73PgNKWXFejc25jDZlc0LSeMMK8Upou+GZ
         w306S8OxV7umZ0wH3Fv9Y9SNXpRjcb2icTFSI+tdx4T3Ck4CuZz4CDQisciRMw+teTWb
         SOhhsH8FEktLnBuKg8m6EUQt2r/G/1EOH/MQ8jhBZVw/xxRIs0PJjZBo3vfF4kEkJdSb
         iUXYvjn6WRtZAWx7qErs9DyX67bKavlv08XPGOCRDdAmr7YmoKhGS07+AOL1kg5YIljL
         w0Q8MKvnqJClV5c3aDmUytvvAg71JQEhgun09zXAFS7QwLtSWkrYA+BtMJjU1PFp5PtN
         G9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VcAm5FWbeAAldh2aF0FxQA9G6VAg7WY7Y57rM0IzDss=;
        fh=7UA/iU8LsU/vkpyagAXnGIp4CR31Kz6AHgb5BlxUdtY=;
        b=kWLcw7bzRnAUFMPRCjuD5femZVruX3ri1JNxDwfhtA/5N/Yu3GuXjHHeYKqSnkH1RK
         Ma/k5R8ajNorfArBskNUazvyuc4g+4ABqgDBBKARy4QxwiUu6YLY7yDqzM+NVOW5qzDb
         B9UDrd86BJifqRGK7Fxl3csEW33jTdLZ6NOdEfcZwBNmAU0aFBvKH9Aru83Y71RaXtnb
         1U1k0ca/ftYPv3DkRiqNGU6kxwe+mIpJLWXf1JLUL1CYJfKBCi8ynHlveqVEnoIvCstg
         /x7LCQ/2fpsxH7jlc0pcmI0rkv1RLUIFvEC24rmJBuDfoD41Bmed22kwer5yaUJ6kEzA
         kStg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784037434; x=1784642234; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VcAm5FWbeAAldh2aF0FxQA9G6VAg7WY7Y57rM0IzDss=;
        b=gw5v5B9abXRgCnZDTtA/wwLE0uCiZcGCN2q0OfODis1e3HxA/nn6LXMHLSlTAHB+Be
         mxHtPE8qdx+Id0TojFRNR2a/2vHrr9GcSIeCS02BzbKyJW38A3I8j1PUYfLoHjF+247S
         YhV53ayi7Delne0+BziQv/p+G9agJDwwPRmrJ0f5GplbNWj5gX7/ubjShi/r8dekxqFG
         YuANma9zniqCqm3mAfTYasQTE7ljYun7OruM4S0kxANBvHtfZx/gfozLcjCLOJ1Py6rM
         ztL9LX0+viwYRrCGc1KR9Lp0zZaDhTtxiPUmWNDd6+cmvZFJNsiBMkjex+O2j4cAZMwJ
         TgfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784037434; x=1784642234;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VcAm5FWbeAAldh2aF0FxQA9G6VAg7WY7Y57rM0IzDss=;
        b=qnY8fTOKeTeBBdOpjvbHZAfl/lA7TX9V8GnyTUvNnFhh69ij9SMb4zk4aZlJem457d
         A5D/GoC2/fFQMg5MzGfDD96CZsPxUrmJ1sfkxkZIIgnNMGrjY5On+rzxrcbYFin+//uc
         3RVQtc1vF3Dv6fZzPDxiQpvIF2raRumR9hRb+uu5gvP/SUfQsFjNLEqQFh6zq1m/CBzF
         fmlG6D4pQL+iq3ACFF96U7e38f80y6aF0hA/I0XbzCiA3ChboWWYFcSm8H2NJobcdNPS
         TkoFU3FVC1R0+amAa63ma8vDDQevhXk1UZiXrqMG5EJJ9TXspSS4z+jxtOR/37RWIOH8
         BUjg==
X-Forwarded-Encrypted: i=1; AHgh+RqyaNVw7M1rqatt/lKc2sptlTCs77nvJXYysKWzCnHWBOmHnmjvjG12VxnpmpugbYNJkvVAUsXU10Dy0Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwVIiriu+lnIVnfei7eT1DqOajaypzvxLdDJNDkAvcC4AlZk4yr
	4zicVSX5g7wY0u2SduCUNtj5lqD8RyYV3vbgLI/VBZsvFxt+OtNJxO3E90gVyQjdL1XhZSl8WZZ
	u6x/e5+Q0iDb0oZrVqO1ZsreZRpPc9zw=
X-Gm-Gg: AfdE7cl+u00VU4/Mc9+BclbLxa7Lfc3mSkbQMXWXXfDFAYkTinemtctz6tzMomHfEll
	EhYFsGs/Htfd/4IDzHhekWKsBuwYMdydgrqw6Yv4vKhPuhrozOjarpWsch+4R7aFOYAfMRdmve4
	11b86EIgWgSlb9JBp9aZtPxnPceAIW5+nbRzEiC9gwIGQgLz50HgOAlqywoIf2FT3YA5c7lJfFF
	OG3h0Idqz1a0D4KkP9ca80hZwGC594vfHL5z1DrfEzsg11ODTmmRUH8covpgBXbGvDaTOgpEJRE
	v5AMcHKLFP3SdPayI1j62bsJSQGTV3RIsJ8KPTJJ
X-Received: by 2002:a05:6a20:2587:b0:3bf:63af:855 with SMTP id
 adf61e73a8af0-3c356f75e8emr3100956637.1.1784037434067; Tue, 14 Jul 2026
 06:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260617080031.99156-1-clamor95@gmail.com> <20260617080031.99156-9-clamor95@gmail.com>
 <akeXAOpb13hupUGM@hovoldconsulting.com>
In-Reply-To: <akeXAOpb13hupUGM@hovoldconsulting.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 14 Jul 2026 16:57:01 +0300
X-Gm-Features: AUfX_mwRKo_fn2QnMJVDLqeS1xafc50cBPMDBnXkRpNqiMp3WbdmnWFo0iH0owY
Message-ID: <CAPVz0n2trouADTziWXnpt=-hwKdsZWGQib+-nVCLaSLibTbATg@mail.gmail.com>
Subject: Re: [PATCH v5 08/14] mfd: lm3533: Convert to use OF bindings
To: Johan Hovold <johan@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, 
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 3 =D0=BB=D0=B8=D0=BF. 2026=E2=80=AF=D1=80. =D0=BE 14:03 Johan=
 Hovold <johan@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Wed, Jun 17, 2026 at 11:00:25AM +0300, Svyatoslav Ryhel wrote:
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backl=
ight
> > ---
> >  drivers/iio/light/lm3533-als.c      |  67 +++++---
> >  drivers/leds/leds-lm3533.c          |  50 ++++--
> >  drivers/mfd/lm3533-core.c           | 236 ++++++++++++----------------
> >  drivers/mfd/lm3533-ctrlbank.c       |   5 -
> >  drivers/video/backlight/lm3533_bl.c |  55 +++++--
> >  include/linux/mfd/lm3533.h          |  52 +-----
> >  6 files changed, 220 insertions(+), 245 deletions(-)
>
> >  static int lm3533_als_probe(struct platform_device *pdev)
> >  {
> > -     const struct lm3533_als_platform_data *pdata;
> >       struct lm3533 *lm3533;
> >       struct lm3533_als *als;
> >       struct iio_dev *indio_dev;
> > @@ -803,12 +817,6 @@ static int lm3533_als_probe(struct platform_device=
 *pdev)
> >       if (!lm3533)
> >               return -EINVAL;
> >
> > -     pdata =3D dev_get_platdata(&pdev->dev);
> > -     if (!pdata) {
> > -             dev_err(&pdev->dev, "no platform data\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*als));
> >       if (!indio_dev)
> >               return -ENOMEM;
> > @@ -817,25 +825,27 @@ static int lm3533_als_probe(struct platform_devic=
e *pdev)
> >       indio_dev->channels =3D lm3533_als_channels;
> >       indio_dev->num_channels =3D ARRAY_SIZE(lm3533_als_channels);
> >       indio_dev->name =3D dev_name(&pdev->dev);
> > -     iio_device_set_parent(indio_dev, pdev->dev.parent);
>
> Why are you reparenting the iio device here?
>

Because every cell has its own binding now and using phandle to parent
when device has its own node is not a good practice.

> That's an ABI break.
>

This driver does not have any active users in the kernel and no
activity for more then 2 years.

> > +static const struct of_device_id lm3533_als_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533-als" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, lm3533_als_match_table);
> > +
> >  static struct platform_driver lm3533_als_driver =3D {
> >       .driver =3D {
> >               .name   =3D "lm3533-als",
> > +             .of_match_table =3D lm3533_als_match_table,
> >       },
> >       .probe          =3D lm3533_als_probe,
> >       .remove         =3D lm3533_als_remove,
>
> You should also remove the platform module alias below.
>

Why?

> > diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> > index 0cb0585eb960..ed810c23f30f 100644
> > --- a/drivers/leds/leds-lm3533.c
> > +++ b/drivers/leds/leds-lm3533.c
> > @@ -10,8 +10,10 @@
> >  #include <linux/module.h>
> >  #include <linux/leds.h>
> >  #include <linux/mfd/core.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/mutex.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >
> > @@ -50,6 +52,9 @@ struct lm3533_led {
> >       struct mutex mutex;
> >       unsigned long flags;
> >
> > +     u32 max_current;
> > +     u32 pwm;
> > +
> >       bool have_als;
> >  };
> >
> > @@ -616,22 +621,20 @@ static const struct attribute_group *lm3533_led_a=
ttribute_groups[] =3D {
> >       NULL
> >  };
> >
> > -static int lm3533_led_setup(struct lm3533_led *led,
> > -                                     struct lm3533_led_platform_data *=
pdata)
> > +static int lm3533_led_setup(struct lm3533_led *led)
> >  {
> >       int ret;
> >
> > -     ret =3D lm3533_ctrlbank_set_max_current(&led->cb, pdata->max_curr=
ent);
> > +     ret =3D lm3533_ctrlbank_set_max_current(&led->cb, led->max_curren=
t);
> >       if (ret)
> >               return ret;
> >
> > -     return lm3533_ctrlbank_set_pwm(&led->cb, pdata->pwm);
> > +     return lm3533_ctrlbank_set_pwm(&led->cb, led->pwm);
> >  }
> >
> >  static int lm3533_led_probe(struct platform_device *pdev)
> >  {
> >       struct lm3533 *lm3533;
> > -     struct lm3533_led_platform_data *pdata;
> >       struct lm3533_led *led;
> >       int ret;
> >
> > @@ -641,12 +644,6 @@ static int lm3533_led_probe(struct platform_device=
 *pdev)
> >       if (!lm3533)
> >               return -EINVAL;
> >
> > -     pdata =3D dev_get_platdata(&pdev->dev);
> > -     if (!pdata) {
> > -             dev_err(&pdev->dev, "no platform data\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       if (pdev->id < 0 || pdev->id >=3D LM3533_LVCTRLBANK_COUNT) {
> >               dev_err(&pdev->dev, "illegal LED id %d\n", pdev->id);
> >               return -EINVAL;
> > @@ -659,8 +656,6 @@ static int lm3533_led_probe(struct platform_device =
*pdev)
> >       led->regmap =3D lm3533->regmap;
> >       led->have_als =3D lm3533->have_als;
> >
> > -     led->cdev.name =3D pdata->name;
> > -     led->cdev.default_trigger =3D pdata->default_trigger;
> >       led->cdev.brightness_set_blocking =3D lm3533_led_set;
> >       led->cdev.brightness_get =3D lm3533_led_get;
> >       led->cdev.blink_set =3D lm3533_led_blink_set;
> > @@ -668,6 +663,15 @@ static int lm3533_led_probe(struct platform_device=
 *pdev)
> >       led->cdev.groups =3D lm3533_led_attribute_groups;
> >       led->id =3D pdev->id;
> >
> > +     led->cdev.name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d"=
,
> > +                                     pdev->name, led->id);
>
> Is "led-2", etc. unique enough here?
>

lm3533-leds-2

> > +     if (!led->cdev.name)
> > +             return -ENOMEM;
> > +
> > +     led->cdev.default_trigger =3D "none";
> > +     device_property_read_string(&pdev->dev, "linux,default-trigger",
> > +                                 &led->cdev.default_trigger);
> > +
> >       mutex_init(&led->mutex);
> >
> >       /* The class framework makes a callback to get brightness during
> > @@ -680,15 +684,22 @@ static int lm3533_led_probe(struct platform_devic=
e *pdev)
> >
> >       platform_set_drvdata(pdev, led);
> >
> > -     ret =3D led_classdev_register(pdev->dev.parent, &led->cdev);
> > +     ret =3D led_classdev_register(&pdev->dev, &led->cdev);
>
> Here too you appear to be reparenting the class devices.
>
> >       if (ret) {
> > -             dev_err(&pdev->dev, "failed to register LED %d\n", pdev->=
id);
> > +             dev_err(&pdev->dev, "failed to register LED %d\n", led->i=
d);
>
> This does not seem to be necessary.
>

Agreed.

> >               return ret;
> >       }
> >
> >       led->cb.dev =3D led->cdev.dev;
> >
> > -     ret =3D lm3533_led_setup(led, pdata);
> > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > +                              &led->max_current);
> > +     led->max_current =3D clamp(led->max_current, LM3533_MAX_CURRENT_M=
IN,
> > +                              LM3533_MAX_CURRENT_MAX);
>
> Why clamp instead of having lm3533_led_setup() fail below?
>

According to OF schema default lower margin is set to
LM3533_MAX_CURRENT_MIN so clamping seems a good option here, even
though it will clamp max value.

> > +
> > +     device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->=
pwm);
> > +
> > +     ret =3D lm3533_led_setup(led);
> >       if (ret)
> >               goto err_deregister;
> >
> > @@ -725,9 +736,16 @@ static void lm3533_led_shutdown(struct platform_de=
vice *pdev)
> >       lm3533_led_set(&led->cdev, LED_OFF);            /* disable blink =
*/
> >  }
> >
> > +static const struct of_device_id lm3533_led_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533-leds" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, lm3533_led_match_table);
> > +
> >  static struct platform_driver lm3533_led_driver =3D {
> >       .driver =3D {
> >               .name =3D "lm3533-leds",
> > +             .of_match_table =3D lm3533_led_match_table,
> >       },
> >       .probe          =3D lm3533_led_probe,
> >       .remove         =3D lm3533_led_remove,
>
> Remove platform alias below as well.
>

Why?

> > diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
> > index b03a3ae96c10..a5aa7da9668b 100644
> > --- a/drivers/mfd/lm3533-core.c
> > +++ b/drivers/mfd/lm3533-core.c
> > @@ -14,19 +14,26 @@
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/i2c.h>
> >  #include <linux/mfd/core.h>
> > +#include <linux/mod_devicetable.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/seq_file.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/units.h>
> >
> >  #include <linux/mfd/lm3533.h>
> >
> >
> >  #define LM3533_BOOST_OVP_MASK                0x06
> >  #define LM3533_BOOST_OVP_SHIFT               1
> > +#define LM3533_BOOST_OVP_MIN         (16 * MICRO)
> > +#define LM3533_BOOST_OVP_MAX         (40 * MICRO)
> >
> >  #define LM3533_BOOST_FREQ_MASK               0x01
> >  #define LM3533_BOOST_FREQ_SHIFT              0
> > +#define LM3533_BOOST_FREQ_MIN                (500 * HZ_PER_KHZ)
> > +#define LM3533_BOOST_FREQ_MAX                (1000 * HZ_PER_KHZ)
> >
> >  #define LM3533_BL_ID_MASK            1
> >  #define LM3533_LED_ID_MASK           3
> > @@ -35,6 +42,7 @@
> >
> >  #define LM3533_HVLED_ID_MAX          2
> >  #define LM3533_LVLED_ID_MAX          5
> > +#define LM3533_CELLS_MAX             7
> >
> >  #define LM3533_REG_OUTPUT_CONF1              0x10
> >  #define LM3533_REG_OUTPUT_CONF2              0x11
> > @@ -42,44 +50,6 @@
> >
> >  #define LM3533_REG_MAX                       0xb2
> >
> > -
> > -static struct mfd_cell lm3533_als_devs[] =3D {
> > -     {
> > -             .name   =3D "lm3533-als",
> > -             .id     =3D -1,
> > -     },
> > -};
> > -
> > -static struct mfd_cell lm3533_bl_devs[] =3D {
> > -     {
> > -             .name   =3D "lm3533-backlight",
> > -             .id     =3D 0,
> > -     },
> > -     {
> > -             .name   =3D "lm3533-backlight",
> > -             .id     =3D 1,
> > -     },
> > -};
> > -
> > -static struct mfd_cell lm3533_led_devs[] =3D {
> > -     {
> > -             .name   =3D "lm3533-leds",
> > -             .id     =3D 0,
> > -     },
> > -     {
> > -             .name   =3D "lm3533-leds",
> > -             .id     =3D 1,
> > -     },
> > -     {
> > -             .name   =3D "lm3533-leds",
> > -             .id     =3D 2,
> > -     },
> > -     {
> > -             .name   =3D "lm3533-leds",
> > -             .id     =3D 3,
> > -     },
> > -};
> > -
> >  /*
> >   * HVLED output config -- output hvled controlled by backlight bl
> >   */
> > @@ -301,125 +271,91 @@ static const struct attribute_group *lm3533_attr=
ibute_groups[] =3D {
> >       NULL,
> >  };
> >
> > -static int lm3533_device_als_init(struct lm3533 *lm3533)
> > -{
> > -     struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> > -     int ret;
> > -
> > -     if (!pdata->als)
> > -             return 0;
> > -
> > -     lm3533_als_devs[0].platform_data =3D pdata->als;
> > -     lm3533_als_devs[0].pdata_size =3D sizeof(*pdata->als);
> > -
> > -     ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_als_devs, 1, NULL,
> > -                           0, NULL);
> > -     if (ret) {
> > -             dev_err(lm3533->dev, "failed to add ALS device\n");
> > -             return ret;
> > -     }
> > -
> > -     lm3533->have_als =3D 1;
> > -
> > -     return 0;
> > -}
> > -
> > -static int lm3533_device_bl_init(struct lm3533 *lm3533)
> > -{
> > -     struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> > -     int i;
> > -     int ret;
> > -
> > -     if (!pdata->backlights || pdata->num_backlights =3D=3D 0)
> > -             return 0;
> > -
> > -     if (pdata->num_backlights > ARRAY_SIZE(lm3533_bl_devs))
> > -             pdata->num_backlights =3D ARRAY_SIZE(lm3533_bl_devs);
> > -
> > -     for (i =3D 0; i < pdata->num_backlights; ++i) {
> > -             lm3533_bl_devs[i].platform_data =3D &pdata->backlights[i]=
;
> > -             lm3533_bl_devs[i].pdata_size =3D sizeof(pdata->backlights=
[i]);
> > -     }
> > -
> > -     ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_bl_devs,
> > -                           pdata->num_backlights, NULL, 0, NULL);
> > -     if (ret) {
> > -             dev_err(lm3533->dev, "failed to add backlight devices\n")=
;
> > -             return ret;
> > -     }
> > -
> > -     lm3533->have_backlights =3D 1;
> > -
> > -     return 0;
> > -}
> > -
> > -static int lm3533_device_led_init(struct lm3533 *lm3533)
> > -{
> > -     struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> > -     int i;
> > -     int ret;
> > -
> > -     if (!pdata->leds || pdata->num_leds =3D=3D 0)
> > -             return 0;
> > -
> > -     if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
> > -             pdata->num_leds =3D ARRAY_SIZE(lm3533_led_devs);
> > -
> > -     for (i =3D 0; i < pdata->num_leds; ++i) {
> > -             lm3533_led_devs[i].platform_data =3D &pdata->leds[i];
> > -             lm3533_led_devs[i].pdata_size =3D sizeof(pdata->leds[i]);
> > -     }
> > -
> > -     ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
> > -                           pdata->num_leds, NULL, 0, NULL);
> > -     if (ret) {
> > -             dev_err(lm3533->dev, "failed to add LED devices\n");
> > -             return ret;
> > -     }
> > -
> > -     lm3533->have_leds =3D 1;
> > -
> > -     return 0;
> > -}
> > -
> >  static int lm3533_device_init(struct lm3533 *lm3533)
> >  {
> > -     struct lm3533_platform_data *pdata =3D dev_get_platdata(lm3533->d=
ev);
> > +     struct device *dev =3D lm3533->dev;
> > +     struct mfd_cell *lm3533_devices;
> > +     u32 count =3D 0, reg, nchilds;
>
> Don't mix multiple declarations with initialisation like this.
>

Checkpatch does not complain on style issue, hence this is not prohibited.

> >       int ret;
> >
> > -     dev_dbg(lm3533->dev, "%s\n", __func__);
> > +     nchilds =3D device_get_child_node_count(dev);
> > +     if (!nchilds || nchilds > LM3533_CELLS_MAX)
> > +             return dev_err_probe(dev, -ENODEV,
> > +                                  "num of child nodes is not supported=
\n");
> >
> > -     if (!pdata) {
> > -             dev_err(lm3533->dev, "no platform data\n");
> > -             return -EINVAL;
> > -     }
> > +     lm3533_devices =3D devm_kcalloc(dev, nchilds, sizeof(*lm3533_devi=
ces),
> > +                                   GFP_KERNEL);
> > +     if (!lm3533_devices)
> > +             return -ENOMEM;
> >
> > -     lm3533->hwen =3D devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW)=
;
> > -     if (IS_ERR(lm3533->hwen))
> > -             return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen), =
"failed to request HWEN GPIO\n");
> > -     gpiod_set_consumer_name(lm3533->hwen, "lm3533-hwen");
> > +     device_for_each_child_node_scoped(dev, child) {
> > +             if (count >=3D nchilds)
> > +                     break;
>
> How could count be larger than nchilds?
>

Only if the tree is malformed, hence this check was added.

> > +
> > +             if (fwnode_device_is_compatible(child, "ti,lm3533-als")) =
{
> > +                     lm3533_devices[count].name =3D "lm3533-als";
> > +                     lm3533_devices[count].of_compatible =3D "ti,lm353=
3-als";
> > +                     lm3533_devices[count].id =3D PLATFORM_DEVID_NONE;
> > +
> > +                     lm3533->have_als =3D true;
> > +                     count++;
> > +             } else if (fwnode_device_is_compatible(child, "ti,lm3533-=
backlight")) {
> > +                     ret =3D fwnode_property_read_u32(child, "reg", &r=
eg);
> > +                     if (ret || reg >=3D LM3533_HVLED_ID_MAX) {
> > +                             dev_err(dev, "invalid backlight node %pfw=
\n", child);
> > +                             continue;
> > +                     }
> > +
> > +                     lm3533_devices[count].name =3D "lm3533-backlight"=
;
> > +                     lm3533_devices[count].of_compatible =3D "ti,lm353=
3-backlight";
> > +                     lm3533_devices[count].id =3D reg;
> > +                     lm3533_devices[count].of_reg =3D reg;
> > +                     lm3533_devices[count].use_of_reg =3D true;
> > +
> > +                     lm3533->have_backlights =3D true;
> > +                     count++;
> > +             } else if (fwnode_device_is_compatible(child, "ti,lm3533-=
leds")) {
> > +                     ret =3D fwnode_property_read_u32(child, "reg", &r=
eg);
> > +                     if (ret || reg < LM3533_HVLED_ID_MAX ||
> > +                         reg > LM3533_LVLED_ID_MAX) {
> > +                             dev_err(dev, "invalid LED node %pfw\n", c=
hild);
> > +                             continue;
> > +                     }
> > +
> > +                     lm3533_devices[count].name =3D "lm3533-leds";
> > +                     lm3533_devices[count].of_compatible =3D "ti,lm353=
3-leds";
> > +                     lm3533_devices[count].id =3D reg - LM3533_HVLED_I=
D_MAX;
> > +                     lm3533_devices[count].of_reg =3D reg;
> > +                     lm3533_devices[count].use_of_reg =3D true;
> > +
> > +                     lm3533->have_leds =3D true;
> > +                     count++;
> > +             }
> > +     }
>
> Why do you need the above at all? Shouldn't you be able to just use
> of_platform_populate().
>

of_platform_populate() is not a part of mfd framework.

> >
> >       lm3533_enable(lm3533);
> >
> >       ret =3D regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> >                                LM3533_BOOST_FREQ_MASK,
> > -                              pdata->boost_freq << LM3533_BOOST_FREQ_S=
HIFT);
> > +                              lm3533->boost_freq << LM3533_BOOST_FREQ_=
SHIFT);
> >       if (ret) {
> > -             dev_err(lm3533->dev, "failed to set boost frequency\n");
> > +             dev_err(dev, "failed to set boost frequency\n");
> >               goto err_disable;
> >       }
> >
> >       ret =3D regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
> >                                LM3533_BOOST_OVP_MASK,
> > -                              pdata->boost_ovp << LM3533_BOOST_OVP_SHI=
FT);
> > +                              lm3533->boost_ovp << LM3533_BOOST_OVP_SH=
IFT);
> >       if (ret) {
> > -             dev_err(lm3533->dev, "failed to set boost ovp\n");
> > +             dev_err(dev, "failed to set boost ovp\n");
> >               goto err_disable;
> >       }
> >
> > -     lm3533_device_als_init(lm3533);
> > -     lm3533_device_bl_init(lm3533);
> > -     lm3533_device_led_init(lm3533);
> > +     ret =3D mfd_add_devices(dev, 0, lm3533_devices, count, NULL, 0, N=
ULL);
> > +     if (ret) {
> > +             dev_err(dev, "failed to add MFD devices: %d\n", ret);
> > +             goto err_disable;
> > +     }
> >
> >       return 0;
> >
> > @@ -504,7 +440,26 @@ static int lm3533_i2c_probe(struct i2c_client *i2c=
)
> >               return PTR_ERR(lm3533->regmap);
> >
> >       lm3533->dev =3D &i2c->dev;
> > -     lm3533->irq =3D i2c->irq;
> > +
> > +     lm3533->hwen =3D devm_gpiod_get_optional(lm3533->dev, "enable",
> > +                                            GPIOD_OUT_LOW);
> > +     if (IS_ERR(lm3533->hwen))
> > +             return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
> > +                                  "failed to get HWEN GPIO\n");
>
> Please use brackets around multline statements for readability
> throughout.
>

Checkpatch does not complain on style issue, hence this is not prohibited.

> > +
> > +     device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
> > +                              &lm3533->boost_ovp);
> > +
> > +     lm3533->boost_ovp =3D clamp(lm3533->boost_ovp, LM3533_BOOST_OVP_M=
IN,
> > +                               LM3533_BOOST_OVP_MAX);
> > +     lm3533->boost_ovp =3D lm3533->boost_ovp / (8 * MICRO) - 2;
> > +
> > +     device_property_read_u32(lm3533->dev, "ti,boost-freq-hz",
> > +                              &lm3533->boost_freq);
> > +
> > +     lm3533->boost_freq =3D clamp(lm3533->boost_freq, LM3533_BOOST_FRE=
Q_MIN,
> > +                                LM3533_BOOST_FREQ_MAX);
> > +     lm3533->boost_freq =3D lm3533->boost_freq / (500 * KILO) - 1;
>
> Again, why clamp instead of failing probe?
>

According to OF schema default lower margin is set to
LM3533_BOOST_FREQ_MIN so clamping seems a good option here, even
though it will clamp max value.

> >       return lm3533_device_init(lm3533);
> >  }
> > @@ -518,6 +473,12 @@ static void lm3533_i2c_remove(struct i2c_client *i=
2c)
> >       lm3533_device_exit(lm3533);
> >  }
> >
> > +static const struct of_device_id lm3533_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, lm3533_match_table);
> > +
> >  static const struct i2c_device_id lm3533_i2c_ids[] =3D {
> >       { "lm3533" },
> >       { }
> > @@ -528,6 +489,7 @@ static struct i2c_driver lm3533_i2c_driver =3D {
> >       .driver =3D {
> >                  .name =3D "lm3533",
> >                  .dev_groups =3D lm3533_attribute_groups,
> > +                .of_match_table =3D lm3533_match_table,
> >       },
> >       .id_table       =3D lm3533_i2c_ids,
> >       .probe          =3D lm3533_i2c_probe,
> > diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlban=
k.c
> > index 91e13cfa3cf0..3aab8ece4e8c 100644
> > --- a/drivers/mfd/lm3533-ctrlbank.c
> > +++ b/drivers/mfd/lm3533-ctrlbank.c
> > @@ -13,11 +13,6 @@
> >
> >  #include <linux/mfd/lm3533.h>
> >
> > -
> > -#define LM3533_MAX_CURRENT_MIN               5000
> > -#define LM3533_MAX_CURRENT_MAX               29800
> > -#define LM3533_MAX_CURRENT_STEP              800
> > -
> >  #define LM3533_PWM_MAX                       0x3f
> >
> >  #define LM3533_REG_PWM_BASE          0x14
> > diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backli=
ght/lm3533_bl.c
> > index 9ef171d3aaea..2c24647fc17a 100644
> > --- a/drivers/video/backlight/lm3533_bl.c
> > +++ b/drivers/video/backlight/lm3533_bl.c
> > @@ -9,7 +9,9 @@
> >
> >  #include <linux/module.h>
> >  #include <linux/init.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/backlight.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> > @@ -29,6 +31,9 @@ struct lm3533_bl {
> >       struct backlight_device *bd;
> >       int id;
> >
> > +     u32 max_current;
> > +     u32 pwm;
> > +
> >       bool have_als;
> >  };
> >
> > @@ -242,25 +247,25 @@ static const struct attribute_group *lm3533_bl_at=
tribute_groups[] =3D {
> >       NULL,
> >  };
> >
> > -static int lm3533_bl_setup(struct lm3533_bl *bl,
> > -                                     struct lm3533_bl_platform_data *p=
data)
> > +static int lm3533_bl_setup(struct lm3533_bl *bl)
> >  {
> >       int ret;
> >
> > -     ret =3D lm3533_ctrlbank_set_max_current(&bl->cb, pdata->max_curre=
nt);
> > +     ret =3D lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current)=
;
> >       if (ret)
> >               return ret;
> >
> > -     return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
> > +     return lm3533_ctrlbank_set_pwm(&bl->cb, bl->pwm);
> >  }
> >
> >  static int lm3533_bl_probe(struct platform_device *pdev)
> >  {
> >       struct lm3533 *lm3533;
> > -     struct lm3533_bl_platform_data *pdata;
> >       struct lm3533_bl *bl;
> >       struct backlight_device *bd;
> >       struct backlight_properties props;
> > +     char *name =3D NULL;
> > +     u32 default_brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> >       int ret;
> >
> >       dev_dbg(&pdev->dev, "%s\n", __func__);
> > @@ -269,12 +274,6 @@ static int lm3533_bl_probe(struct platform_device =
*pdev)
> >       if (!lm3533)
> >               return -EINVAL;
> >
> > -     pdata =3D dev_get_platdata(&pdev->dev);
> > -     if (!pdata) {
> > -             dev_err(&pdev->dev, "no platform data\n");
> > -             return -EINVAL;
> > -     }
> > -
> >       if (pdev->id < 0 || pdev->id >=3D LM3533_HVCTRLBANK_COUNT) {
> >               dev_err(&pdev->dev, "illegal backlight id %d\n", pdev->id=
);
> >               return -EINVAL;
> > @@ -292,13 +291,21 @@ static int lm3533_bl_probe(struct platform_device=
 *pdev)
> >       bl->cb.id =3D lm3533_bl_get_ctrlbank_id(bl);
> >       bl->cb.dev =3D NULL;                      /* until registered */
> >
> > +     name =3D devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> > +                           pdev->name, pdev->id);
>
> Unique enough (e.g. backlight-0)?
>

lm3533-backlight-0

> > +     if (!name)
> > +             return -ENOMEM;
> > +
> > +     device_property_read_u32(&pdev->dev, "default-brightness",
> > +                              &default_brightness);
> > +
> >       memset(&props, 0, sizeof(props));
> >       props.type =3D BACKLIGHT_RAW;
> >       props.max_brightness =3D LM3533_BL_MAX_BRIGHTNESS;
> > -     props.brightness =3D pdata->default_brightness;
> > -     bd =3D devm_backlight_device_register(&pdev->dev, pdata->name,
> > -                                     pdev->dev.parent, bl, &lm3533_bl_=
ops,
> > -                                     &props);
> > +     props.brightness =3D default_brightness;
> > +
> > +     bd =3D devm_backlight_device_register(&pdev->dev, name, &pdev->de=
v,
> > +                                         bl, &lm3533_bl_ops, &props);
>
> Here too you are reparenting, which results in an ABI break.
>
> >       if (IS_ERR(bd)) {
> >               dev_err(&pdev->dev, "failed to register backlight device\=
n");
> >               return PTR_ERR(bd);
> > @@ -309,12 +316,19 @@ static int lm3533_bl_probe(struct platform_device=
 *pdev)
> >
> >       platform_set_drvdata(pdev, bl);
> >
> > -     backlight_update_status(bd);
> > +     device_property_read_u32(&pdev->dev, "led-max-microamp",
> > +                              &bl->max_current);
> > +     bl->max_current =3D clamp(bl->max_current, LM3533_MAX_CURRENT_MIN=
,
> > +                             LM3533_MAX_CURRENT_MAX);
>
> Clamping instead of failing.
>
> >
> > -     ret =3D lm3533_bl_setup(bl, pdata);
> > +     device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->p=
wm);
> > +
> > +     ret =3D lm3533_bl_setup(bl);
> >       if (ret)
> >               return ret;
> >
> > +     backlight_update_status(bd);
> > +
> >       ret =3D lm3533_ctrlbank_enable(&bl->cb);
> >       if (ret)
> >               return ret;
> > @@ -366,11 +380,18 @@ static void lm3533_bl_shutdown(struct platform_de=
vice *pdev)
> >       lm3533_ctrlbank_disable(&bl->cb);
> >  }
> >
> > +static const struct of_device_id lm3533_bl_match_table[] =3D {
> > +     { .compatible =3D "ti,lm3533-backlight" },
> > +     { }
> > +};
> > +MODULE_DEVICE_TABLE(of, lm3533_bl_match_table);
> > +
> >  static struct platform_driver lm3533_bl_driver =3D {
> >       .driver =3D {
> >               .name   =3D "lm3533-backlight",
> >               .pm     =3D &lm3533_bl_pm_ops,
> >               .dev_groups =3D lm3533_bl_attribute_groups,
> > +             .of_match_table =3D lm3533_bl_match_table,
> >       },
> >       .probe          =3D lm3533_bl_probe,
> >       .remove         =3D lm3533_bl_remove,
>
> Drop platform module alias below.
>
> Johan
