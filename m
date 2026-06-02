Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E153E6DC5
	for <linux-fbdev@vger.kernel.org>; Tue,  2 Jun 2026 13:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408230; cv=pass; b=cUiQyNv9Begm4IxsoNTXseZ1TFAMyEXu3Oliuz0HOBxMVI8mjWnpJImSZLzeSg866XunMQjeJPEQMRERR3SV6kIqA58EEAKDS4v1pGVdgDqBKBYsSVcvKr8fgXqK08bxy82LO2pSw0/px8Nn/KGl2Mu2kAAIXPaclda7eU6E1c8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408230; c=relaxed/simple;
	bh=NVI4xF0q0eE4RXQugggAMrzJxldQ0dmIPoc43HTpsWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q9LtVU4BfCqWSjPXbjogBt6DY1sqa6YWz1H1HRj59uLDf6VRb+qWoaDOJCj/klDEsQcb5U1l3L3B+dBXk0HvRfcE5krP1eMa0dNlDQ10LWLljaWpC1nIqowus2U/z/GQCsvodhbAAW5N6F28UgJ0o6eAXBOEQT5b/xZ/euJtOf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpZfRNzI; arc=pass smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpZfRNzI"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-304545f5206so15600572eec.0
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Jun 2026 06:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780408228; cv=none;
        d=google.com; s=arc-20240605;
        b=f2Fbh40EHdzsNh8Nr196krnf4XJMd5ljBMsReYzbtQTTUItPWJXUJgDm2FNufRPIsi
         AmJpKAFnIR3m1xLI9PxSiRon0Q7J4auxU47lUKA5KKipfh3tglgS8aKqkxIqxMrlqNTs
         lKX/Dlskf1w5hEs62y+2EVFAg9gat510xSYdlKaEoC/JUKlKZ6EFygmazltf0FCk0PmI
         bs11V0v63uuKGT64dyRw8VX6524VnbPEfL0fdjmKRMDXXj/Ms/p+st3O+NV06FxHRbbc
         hDfXP1n8oCltJSlH4cIc5zVb0DBVgGoGc7gGsxRW7Us7Alke24Z/vIpI21Ry4zr/uMRR
         0ujg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
        fh=eKvTqUuJEiRV+cICB/qIhQmQ+WGbhc/w1TaLGBn2uTM=;
        b=FK3VKcF5ItfSERtt2Wb9mu1B0LW8CS88agNckRZXKkG1yEM9LvAHmLmEDQT2OFkG5J
         FPQNihKoOMPelJS5GMEbsXDMwKzqfN2qtiPL6T7RyCMi8X6eHPKBctUUqjQuMI2ZawDA
         9sZyp6WvDfnPXzzhQSsUUy1Dwpk4ircjsTlqgGcPUpwkS2i1oIRSNzIeHm6MJ6CV4yaT
         lArDxk4Vd4p3MdFuDrEyjkKGfvtF/dRyPWFZt0N70PFgIo1Ncz1A8OeCIMvtTe/IuC8k
         nVGien6ZSFIGLi3l9rg9Jq1Oher+JMhY0Fvn7JOqLOaU6At3GJB6W8CyrRpLt7+WqeSK
         JGRg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780408228; x=1781013028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
        b=WpZfRNzII18pq3ZL6sObbH7QWDzG/lwUsSm8R/EAPn49vOM6x1YnRY6lU1kTrje/+r
         eH1unkYQWCB+UfaNlov/e1KTvzTuYaFPA/pPk64cte29X9zLnBYnEWHGNcXZ7rm1fUBj
         5IUcMifVOylKCBkbih3OuxCp3VDepMzqAIzuShWO23K0Sl/eNKptkHdhvBYNtrBbh5fc
         q2MDTkpjchmjAFZSofQzH/erjQ3z/41mVDrlemVKUXyyopDZCB2gMWNpwOWUGIQkbGe+
         Z/sbV+NH1e9evdm/MEbXdTxdYzmfDPlZVjnWqpv3JHvuBqaqk5ZKEKMqK4gFCmuQmsex
         Ijgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780408228; x=1781013028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXMEIdkpX0PMnnSFu3HxJtEnPHLXb+fgf1w6HULmKpc=;
        b=SY+M43mn5f4KotEi0INMGEAc2+Zqt30k1x7Nuna941h8eGqw7V0x7+bUEb8AFJvgbE
         TQIIIRmvouUQXhVQq7QyKiFIBPXMafsod0BRuoIblK6Dt6QFV+mWHsexsw/HNEXz0oKD
         B164lzu+/az6eNwT3WEkmNs8y13Et9+NeA9UOKF2wHDoeyXthcnki7AgIaT6h7FVhK5q
         T5DekRXtAnzK75buHN871uHSqEXmRv4SZJXkQ0U6aH9W3BRb063EzJ+lUjb7JvhL3E6Z
         mnEnyZELqhCZ2LpSU2mfSKBDg+4q7KIUSo55IxqwYFOLXwsKaUKzz5j12O/xQPhssTS8
         pcMg==
X-Forwarded-Encrypted: i=1; AFNElJ9XI0tpLTvamNqv9w87Y+WtYruigRPpHeaASbW9hTFo/eD1CBmKLqxQ/pdW2Zvf09cut7f4PpHOJiaBLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyvCb1bcxqV+JrFZJzM5j2E/FYgJDhPXKETopeK++Yp4wV2jtBg
	GfYEb0nmM8I0/GXs8hGbToNY8AkCPJX2+WTETNV+KiwdAO4LlG8LCEeWm4QByns6iQIUDulLsoZ
	fvKKG2ABwP445I+2KQyUdSp8YRWmESJA=
X-Gm-Gg: Acq92OFUCkKDHA42xQTypqKMnpQCdNR+WKnBV0TYYGhNh1zkC9cR2ReouRHQTuB7sT1
	XTmc/vFbaNwWilXjuy6qpY6E3tTHiXaWt/hTaajcwMFh39GGrqwBNbeVPVuNzlXt3nqZXsUTUws
	bRU8LrwP1EGfnYFCQjkn2DqVeQfWbe9KBiy9yCZDb6aID7iyLzOiPFbMM4WYB4W6JCZl/DsSRk5
	kGlv5PM9tT+7Bw4feDF6OWd2BNlxDjHs+xklyrI3HzA79TjPyyTHg2C0cZuJuvHgrJFDeEWScLL
	G6L73kt5z/ZCY4afW7I=
X-Received: by 2002:a05:7301:1f0d:b0:2ed:e14:42e9 with SMTP id
 5a478bee46e88-304fa693628mr8033250eec.34.1780408227938; Tue, 02 Jun 2026
 06:50:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601151831.76350-1-clamor95@gmail.com> <20260601151831.76350-6-clamor95@gmail.com>
 <20260602144640.433b4d35@jic23-huawei>
In-Reply-To: <20260602144640.433b4d35@jic23-huawei>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 2 Jun 2026 16:50:16 +0300
X-Gm-Features: AVHnY4KYcv6nkoqF49he0KoddQyJUPiBV8YuVyKK6U5KG-s9hQUTG1_wCFFBKFE
Message-ID: <CAPVz0n1r97d8-uzhPGBx0LFSp75A3_2mMXDQQ30utT-6NtpHNA@mail.gmail.com>
Subject: Re: [PATCH v3 05/11] mfd: lm3533: Convert to use OF bindings
To: Jonathan Cameron <jic23@kernel.org>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 2 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 16:46=
 Jonathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Mon,  1 Jun 2026 18:18:25 +0300
> Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>
> > Since there are no users of this driver via platform data, remove the
> > platform data support and switch to using Device Tree bindings.
> >
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>
>
> > index 52136ca1abc9..55b35467a722 100644
> > --- a/drivers/iio/light/lm3533-als.c
> > +++ b/drivers/iio/light/lm3533-als.c
> > @@ -16,16 +16,19 @@
> >  #include <linux/module.h>
> >  #include <linux/mutex.h>
> >  #include <linux/mfd/core.h>
> > +#include <linux/mod_devicetable.h>
> >  #include <linux/platform_device.h>
> > +#include <linux/property.h>
> >  #include <linux/regmap.h>
> >  #include <linux/slab.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/units.h>
> >
> >  #include <linux/mfd/lm3533.h>
> >
> >
> > -#define LM3533_ALS_RESISTOR_MIN                      1
> > -#define LM3533_ALS_RESISTOR_MAX                      127
> > +#define LM3533_ALS_RESISTOR_MIN                      1575
> > +#define LM3533_ALS_RESISTOR_MAX                      200000
> >  #define LM3533_ALS_CHANNEL_CURRENT_MAX               2
> >  #define LM3533_ALS_THRESH_MAX                        3
> >  #define LM3533_ALS_ZONE_MAX                  4
> > @@ -57,6 +60,9 @@ struct lm3533_als {
> >
> >       atomic_t zone;
> >       struct mutex thresh_mutex;
> > +
> > +     bool pwm_mode;
> > +     u32 r_select;
> >  };
> >
> >
> > @@ -411,7 +417,7 @@ static ssize_t show_thresh_either_en(struct device =
*dev,
> >       int enable;
> >       int ret;
> >
> > -     if (als->irq) {
> > +     if (als->irq > 0) {
> >               ret =3D lm3533_als_get_int_mode(indio_dev, &enable);
> >               if (ret)
> >                       return ret;
> > @@ -716,30 +722,34 @@ static const struct attribute_group lm3533_als_at=
tribute_group =3D {
> >       .attrs =3D lm3533_als_attributes
> >  };
> >
> > -static int lm3533_als_setup(struct lm3533_als *als,
> > -                         const struct lm3533_als_platform_data *pdata)
> > +static int lm3533_als_setup(struct lm3533_als *als)
> >  {
> >       struct device *dev =3D &als->pdev->dev;
> >       int ret;
> >
> > +     als->pwm_mode =3D device_property_read_bool(dev, "ti,pwm-mode");
> > +
> >       ret =3D regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CO=
NF,
> >                                LM3533_ALS_INPUT_MODE_MASK,
> > -                              pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_=
MASK : 0);
> > +                              als->pwm_mode ? LM3533_ALS_INPUT_MODE_MA=
SK : 0);
> >       if (ret)
> >               return dev_err_probe(dev, ret, "failed to set input mode =
%d\n",
> > -                                  pdata->pwm_mode);
> > -
> > +                                  als->pwm_mode);
> >
> >       /* ALS input is always high impedance in PWM-mode. */
> > -     if (!pdata->pwm_mode) {
> > -             if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> > -                 pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
> > -                     dev_err(&als->pdev->dev, "invalid resistor value\=
n");
> > -                     return -EINVAL;
> > -             }
> > +     if (!als->pwm_mode) {
> > +             ret =3D device_property_read_u32(dev, "ti,resistor-value-=
ohms",
> > +                                            &als->r_select);
> > +             if (ret)
> > +                     return dev_err_probe(dev, ret,
> > +                                          "failed to ger resistor valu=
e\n");
> > +
> > +             als->r_select =3D clamp(als->r_select, LM3533_ALS_RESISTO=
R_MIN,
> > +                                   LM3533_ALS_RESISTOR_MAX);
>
> If we are getting garbage from DT I think I'd rather error out that paper=
 over
> that problem.  So similar to before, check valid value and if not fail pr=
obe
> so that hopefully someone goes and fixes it!
>

sure

> > +             als->r_select =3D DIV_ROUND_UP(2 * MICRO, 10 * als->r_sel=
ect);
> Why do we need this when we didn't before?  The range checks are the same
> so it smells like it shouldn't need transforming. I'd also rather we didn=
't do
> rewriting of the meaning of r_select like this.  Just use a local variabl=
e for
> the intermediate result.
>

before pdata passed resistor value as actual register value, not we
are getting the actual resistance in ohms from the tree and must
convert it into register value.

> >
> >               ret =3D regmap_write(als->lm3533->regmap, LM3533_REG_ALS_=
RESISTOR_SELECT,
> > -                                pdata->r_select);
> > +                                als->r_select);
> >               if (ret)
> >                       return dev_err_probe(dev, ret, "failed to set res=
istor\n");
