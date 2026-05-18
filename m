Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012F3242B1
	for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779097885; cv=pass; b=r2DPDeLxZigS0BaxduIl8rwvQNp+Adh5KghsMCERWlPN6fBCCwT0CSi4Tb1i4J2MYNcmyP3yxqWo+I6u9sfXzWgqoB2eZJrZjQC85WpHEOSLeL0BzKHtAHrIJfeW8L+D2g2ZaUGZeNMuHYrSk1hmIMr1KmBizl7lfM6hK8QI9cA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779097885; c=relaxed/simple;
	bh=JOqNYOpYniKiLryaD7Q8FBNSmyt01Ujzp39DKCKBG8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vo8ci7eD3frLtyeYACGGylmFcslfUVzYQ9WJ2qpTe5qONEP6aneTZFA44ohMmBZGOLE32wZRAzk//15CRC7TyOnqmnsGhwihtYIyGijetXCzXsW4K2FCDMcUB0XyymbFx1o79p6nfnvV6Dx1/zV6UabJBoN4lJazXFriVFjYVew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RhE3wCQ0; arc=pass smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RhE3wCQ0"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2f33ae12f97so7672559eec.1
        for <linux-fbdev@vger.kernel.org>; Mon, 18 May 2026 02:51:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779097882; cv=none;
        d=google.com; s=arc-20240605;
        b=BZkvz2nI9Qw5/fx3Y8OD6WsB1i6AFweQ/M4PEo2EgfS4niMYEvgvTfMUkkl4jZd/2l
         MkoVg2BDm5B8p1w7djYulXBO0ZPwRfhk1RTK0svKDeAh0maINFe1OwWPjVWxOmPtpI0n
         ePfiZ/Ap2M2Gc+SF91yQ5pZVAW2O1N1GiMHqMq+RKlrpDmZ5cH5nSYkiJ+zCPK8MWuvG
         JaGL5WQUC2x1J49sAbpd06Dmuj/b8T5MPHV8eKEIwGwARw993B/SiFHzBNSyj7/ze3lJ
         B1Mk+5r0M23gfhAaFNP+A/KK0XWnUMrnPMJE0588IUE7uk54q5gx5OU5EnvQgPrlb6I2
         3+vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
        fh=2O91HluKHIKU/4hmTtulrbGyZ0Pxx7pg0lAuOZciQuQ=;
        b=jJsNTX5jngU6hyigfYzFOyWJ2a4UMQcP0hPKeZ97ylBPd8S3Qo0XXdv8X0Rv71Xwlg
         t2fI6Yz/tWVhZGoZj89+oQNhW/KSvCKsepI3eHKENJSXDFVuSHa6n6EDD0wiTJfrqsqT
         Du7Hd4o5gccKTn448vDf8oiPoIITJFF+F7gDTpSE9PC4XDfL8LfmS0NJ5/Yd7b5UvGX4
         bYQ2dexl14qtJFVUbmA5vfreC3JTsZjkRjFAU56xz6eih7t0YDRnPn6/FIOuQmMdHJZa
         k2Lz13ObVpVLVb3FOjOqU/unPLOsH0epHy8mgeB0xlKd9NPIKRXl5mZ4RjsoS2KmNIHf
         e3Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779097882; x=1779702682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
        b=RhE3wCQ0oOeMN7MfcDrswyUcIWD9pJ8hEEqNNEgJej/v03XZnbisRVNEy21JsCAuD0
         O8CxKVFumIUtF+3uQ42UOVYIEi9wcMc90cwHYSLxyl0xRa744xAIoEE5Y2woX468sbfQ
         joafHnsz88TeQiWFZphoG2hZe1jTfZ2M2c/EvAomXv5hGvDNOrTAm9a9cUQ5F0UyXc+4
         Y9e2nHtcfkeOc2QgqvUwDB0EjbUFovCSm0koR2rNlmWrWoAVCBDGmOf7mrt1TYTRNJ8f
         TKCMRz0QYzqBYw8vKS9d42QrF3+gYazrH5JsmMPeUdzsrOfVqCvrLwdAx9rwkkBXd3Uo
         Aqyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779097882; x=1779702682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FePX2WL11b5dRW+WYbo5NswoFP4g/thJvtgtY1wXay8=;
        b=PwoN8UKIPhHVUYaM/WZ7eiFaoWjGiQB9iCaNLggQLgYgns9B8W2A7yDiu+CDtDW1Vv
         hfg8kThNdzWvO0IiY4eM85NHC78rmb0CoON58loonhby1zF3IybO9x5ax1g2gXVz++vt
         Fhh8U7s1e6+Uc57q0yC30prigR477wDIBBBrXuEA7620ke3N3Z7DqRxPV48HhBBrqqb0
         dOSwm5f4NlvPexivxM+z2ibOE8Afuxokk9nNPyyx1YkUSXO3mU8FXksInZ2pYYko+8QN
         pJq2vlhD5c0l7sYBAMdpq8NFN9ZVm1QUddumwrPXeevn86M68uBQ4yUl6yocuHS5QYwC
         SKAQ==
X-Forwarded-Encrypted: i=1; AFNElJ/ET9P+9cwyxHfx78e4B1conyFrsb7fv7z1o5uOiaUeD1xFIkFIDHXTV8SnkWRvtz/d3rddHitsmJ5AmA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZDtUQ5ce9Gir+6//N/Xg7aKBux4HLIcCtx4PMvXD3MM4dUPHN
	1zHC6Ma86La6h+R7ZkmN18rgz1I+QmIwgjmz1LXtdUJ1g8yRcfzJwmpySnQYdzkHd3BhQ8Kwppc
	GYFHAywx6bahktXpurCM8alOWCvf7sts=
X-Gm-Gg: Acq92OFHn/dsOf10FaDhM7GPkJFMm6cOOcqA5gP8zNwb1X3H3Qx/gtJ7UZmaNQGTpWA
	WnXFed+bk96BrvUR65SVfhggtSKTOxZkb2F9DZJ2A9wP4LjF/kQcQkPj3047nf/Pc2iCN8OjNnB
	NxadjFMPQqBay6eFmvfuZTl/qTWrJCUxbE1mdTrvW3LXRushhQpbR/p4hdp/Gq3+Sz4VZ2Tp6yH
	SuNmBwaITCf8QpfHcIZ6xMbuIbndGTnXJlkuj+wV74NZ+J+ye4oPoL9hCTuRHmbEJqGtWRqcBf/
	Z4X8HeUnfg9KLqgbyNgnF47ZBrpWag==
X-Received: by 2002:a05:7301:688:b0:2ed:e16:6b4a with SMTP id
 5a478bee46e88-3039869b963mr6436744eec.32.1779097882266; Mon, 18 May 2026
 02:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260517074306.30937-1-clamor95@gmail.com> <20260517074306.30937-3-clamor95@gmail.com>
 <CAPVz0n3gLYXab4H+DihfTkdBkGPqTvmoFVY1Cwuafd70KPtYbA@mail.gmail.com> <20260518092833.GR305027@google.com>
In-Reply-To: <20260518092833.GR305027@google.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 18 May 2026 12:51:11 +0300
X-Gm-Features: AVHnY4IgFlUyRpln1URXZyQyooZBVQu7rOOaMkPI7Cfdheurgkdm_oeKquAVOyE
Message-ID: <CAPVz0n3QAGk_iebCQdEnv_fG2nnGdM1xm__=wG+4KqVJzs-T_g@mail.gmail.com>
Subject: Re: [PATCH v1 2/6] mfd: lm3533: Convert to use OF bindings
To: Lee Jones <lee@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Rob Herring <robh@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 18 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 12:2=
8 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sun, 17 May 2026, Svyatoslav Ryhel wrote:
>
> > =D0=BD=D0=B4, 17 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE =
10:43 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > Since there are no users of this driver via platform data, remove the
> > > platform data support and switch to using Device Tree bindings.
> > > Additionally, optimize functions used only by platform data.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/iio/light/lm3533-als.c      | 123 +++++--------
> > >  drivers/leds/leds-lm3533.c          |  60 ++++---
> > >  drivers/mfd/lm3533-core.c           | 257 +++++++++-----------------=
--
> > >  drivers/video/backlight/lm3533_bl.c |  52 ++++--
> > >  include/linux/mfd/lm3533.h          |  51 +-----
> > >  5 files changed, 202 insertions(+), 341 deletions(-)
>
> Please snip replies.
>
> [...]
>
> > > -static int lm3533_device_led_init(struct lm3533 *lm3533)
> > > -{
> > > -       struct lm3533_platform_data *pdata =3D dev_get_platdata(lm353=
3->dev);
> > > -       int i;
> > > -       int ret;
> > > -
> > > -       if (!pdata->leds || pdata->num_leds =3D=3D 0)
> > > -               return 0;
> > > -
> > > -       if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
> > > -               pdata->num_leds =3D ARRAY_SIZE(lm3533_led_devs);
> > > -
> > > -       for (i =3D 0; i < pdata->num_leds; ++i) {
> > > -               lm3533_led_devs[i].platform_data =3D &pdata->leds[i];
> > > -               lm3533_led_devs[i].pdata_size =3D sizeof(pdata->leds[=
i]);
> > > +               dev_err(dev, "failed to set boost ovp\n");
> > > +               goto err_disable;
> > >         }
> > >
> > > -       ret =3D mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
> > > -                             pdata->num_leds, NULL, 0, NULL);
> > > +       ret =3D devm_mfd_add_devices(dev, 0, lm3533_child_devices,
> > > +                                  ARRAY_SIZE(lm3533_child_devices),
> > > +                                  NULL, 0, NULL);
> >
> > Question to Lee Jones. Would you find acceptable if the driver will
> > build cell list dynamically based on the nodes in the device tree?
> > This is LED controller after all, not all leds can be populated and
> > same LED control bank can be linked to all LVLEDs for example.
> >
> > If you are ok, would this implementation satisfy you?
>
> Generally not.  Create the non-dynamical information statically
> (obviously not 'const'), then you can add dynamic data as you go.
>

Hm, code I have proposed below creates mfd_cell structure with 7 cells
(max amount of children), and fills each slot with devices described
in the device tree. This seems to fit your expectation. LM3533 is
basically a LED controller but it is set as mfd and IMHO would be
undesirable to create dummy devices.

> >         struct mfd_cell lm3533_cells[LM3533_CELLS_MAX];
> >         u32 count =3D 0, reg;
> >         int ret;
> >
> >         device_for_each_child_node_scoped(lm3533->dev, child) {
> >                 if (!fwnode_device_is_available(child))
> >                         continue;
> >
> >                 if (count >=3D LM3533_CELLS_MAX)
> >                         break;
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-als")=
) {
> >                         lm3533_cells[count].name =3D "lm3533-als";
> >                         lm3533_cells[count].id =3D PLATFORM_DEVID_NONE;
> >                         lm3533_cells[count].of_compatible =3D "ti,lm353=
3-als";
> >
> >                         lm3533->have_als =3D true;
> >                 }
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-backl=
ight")) {
> >                         ret =3D fwnode_property_read_u32(child, "reg", =
&reg);
> >                         if (ret || reg > LM3533_HVLED_ID_MAX) {
> >                                 dev_err(dev, "invalid backlight reg %d\=
n", reg);
> >                                 continue;
> >                         }
> >
> >                         lm3533_cells[count].name =3D "lm3533-backlight"=
;
> >                         lm3533_cells[count].id =3D reg;
> >                         lm3533_cells[count].of_compatible =3D
> > "ti,lm3533-backlight";
> >
> >                         lm3533->have_backlights =3D true;
> >                 }
> >
> >                 if (fwnode_device_is_compatible(child, "ti,lm3533-leds"=
)) {
> >                         ret =3D fwnode_property_read_u32(child, "reg", =
&reg);
> >                         if (ret || reg < LM3533_HVLED_ID_MAX ||
> >                             reg > LM3533_LVLED_ID_MAX) {
> >                                 dev_err(dev, "invalid LED reg %d\n", re=
g);
> >                                 continue;
> >                         }
> >
> >                         lm3533_cells[count].name =3D "lm3533-leds";
> >                         lm3533_cells[count].id =3D reg - LM3533_HVLED_I=
D_MAX;
> >                         lm3533_cells[count].of_compatible =3D "ti,lm353=
3-leds";
> >
> >                         lm3533->have_leds =3D true;
> >                 }
> >
> >                 count++;
> >         }
> >
> > >         if (ret) {
> > > -               dev_err(lm3533->dev, "failed to add LED devices\n");
> > > -               return ret;
> > > -       }
> > > -
> > > -       lm3533->have_leds =3D 1;
> > > -
> > > -       return 0;
> > > -}
>
> [...]
>
> --
> Lee Jones
