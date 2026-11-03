Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=79.135.106.102
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717162;
	b=lNCQaWm5MA8LUU4yJNxNvSHtLiv7bGS7IjBEI+FfHiJOPFmWhUOsT3f93VaHfit4gHXr
	 miJB+r589RjOUb0CazaOY9g7SnpGzHG3V8nA6EatrYCTz+wS3wdjw/QQkgB2MWxiSwA/j
	 IMmBjkDreEpxr/HyZfjAUk2J2JIVj9YYWal/GTWJNTRiohCcp2apbpK+FGz94MIzCJq9f
	 vwZc9tQw5e1XQhBknfM+HbBtb2P5ZVClUSw+oWM/z7GpqgPIlsE2jtfM3XaA8rWYtUHym
	 bqM6PXzCbUtml20NYMhC2j7Csw6C8hfpKuQ7p6YMMKySG3AdKmVLxbTyWmkz3DbMTEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717162;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=Y/W8sgknOe1isSMCBVbQa0yKLOZnnS++ptDkeWSy/v4=;
	b=Ezky+ifSdCQeamq7X+IBzePLdb9anNgF1hVippOhkIUTpjmbpHcPJmJldoExWZudH6il
	 1hdVjoB84a50L8hk4MYTWTA0sydm62AFke3Abd5+1eoRTxZ4PZh9w+zZI7H1tVHZqSfmF
	 xZ08BoeMrnwLUfDiuLLwUU6fdG41n7HW2mNe3o9KgGIbe3O7dyUhDQk41LQfbSUujUrvL
	 vmnNPwm3Ap56I8pH7LD0qbx/rjcKunGaalr+gvofhgh8bQXaxBZxnprNj/hCZhJzc81eo
	 m+ssZAU9jVfGUsw/xC5D8bWUQsA4lZaF4QG+MxJYhZ1Q6AcT1otp7hBpwWxllhQeNpA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=protonmail.com;
	spf=pass smtp.mailfrom=protonmail.com;
	dkim=pass header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b="nbXk/xck";
	arc=none smtp.remote-ip=79.135.106.102
Received: from mail-106102.protonmail.ch (mail-106102.protonmail.ch [79.135.106.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A3E606A326
	for <linux-fbdev@vger.kernel.org>; Tue,  3 Nov 2026 14:46:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85A3E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=protonmail.com header.i=@protonmail.com header.a=rsa-sha256 header.s=protonmail3 header.b=nbXk/xck
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1793717156; x=1793976356;
	bh=Y/W8sgknOe1isSMCBVbQa0yKLOZnnS++ptDkeWSy/v4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=nbXk/xckxNhHJNEZ+/CB7k6BzTxtoo6nsgRk0hqk+Ac+rOqSKGemxUxDvy7q0t0Yx
	 ZjFyVEYaCuhiD79oQPlkZ00N3zJp8OllInsqBjLqjwIxwQkNIG29V+rLStqKNBNQ9O
	 3ikEtc5v306/kEtYQHQYcnvBuAi7b4xWC/AY0RVP+217EA2qhos/IG6ItKyNcZrQla
	 SOLup+pNeA4wXFJyUAuimBBtb3FtxJAzXXjuipNFWYwWIIWPPbRzMlr1/gORmqEfGo
	 xfDzt3lA6k8l979pU9q2wGZWd8MR5OL53So+FjvCLdnE10ptpxuSfi0KcjnJz0xQfk
	 joh16VIuiXauQ==
Date: Tue, 03 Nov 2026 14:45:52 +0000
To: Daniel Thompson <danielt@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: add ktd3137 support
Message-ID: <1IItRacxO3yGApfxlr9c4eyKqir8AGxFAmGYXWKDS_spX5pByW6JP0hxMqthOs7_8j0cOzthZYeTyu2wA1LAwNWDqsw0B_E-WExI1IjjmRM=@protonmail.com>
In-Reply-To: <aunskqwg_CbpBL49@aspen.lan>
References: <20261102-6768-ktd3137-v1-0-b5b4f903c56e@protonmail.com> <20261102-6768-ktd3137-v1-2-b5b4f903c56e@protonmail.com> <aunskqwg_CbpBL49@aspen.lan>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 915c26afe2412af62bf2b0b808173180062f1df2
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tuesday, November 3rd, 2026 at 4:15 PM, Daniel Thompson <danielt@kernel.=
org> wrote:

> On Mon, Nov 02, 2026 at 09:58:49PM +0200, Roman Vivchar via B4 Relay wrot=
e:
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > Add support for the KTD3137 display backlight IC. It's used in various
> > Xiaomi phones, such as Xiaomi Redmi Note 9.

...

> > +static int ktd3137_init(struct ktd3137 *ktd)
> > +{
> > +=09u32 val =3D KTD3137_CONTROL_DEFAULT | KTD3137_CONTROL_LINEAR;
> > +=09int ret;
> > +
> > +=09ret =3D regmap_write(ktd->regmap, KTD3137_REG_CONTROL, val);
>=20
> Nitpicking but val seems a bit pointless here.

Agreed.

>=20
>=20
> > +=09if (ret)
> > +=09=09return ret;
> > +
> > +=09ret =3D regmap_write(ktd->regmap, KTD3137_REG_PWM, KTD3137_PWM_DEFA=
ULT);
> > +=09if (ret)
> > +=09=09return ret;

...

> > +
> > +=09props.type =3D BACKLIGHT_RAW;
> > +=09props.max_brightness =3D KTD3137_MAX_BRIGHTNESS;
> > +=09props.brightness =3D KTD3137_DEFAULT_BRIGHTNESS;
>=20
> No need for KTD3137_DEFAULT_BRIGHTNESS. Just use KTD3137_MAX_BRIGHTNESS.

Ack.

>=20
>=20
> > +=09props.scale =3D BACKLIGHT_SCALE_LINEAR;
> > +=09device_property_read_u32(ktd->dev, "default-brightness", &props.bri=
ghtness);
> > +
> > +=09backlight_dev =3D devm_backlight_device_register(ktd->dev,
> > +=09=09=09=09=09=09       "ktd3137-backlight",
> > +=09=09=09=09=09=09       ktd->dev, ktd,
> > +=09=09=09=09=09=09       &ktd3137_backlight_ops,
> > +=09=09=09=09=09=09       &props);
> > +=09if (IS_ERR(backlight_dev))
> > +=09=09return dev_err_probe(ktd->dev, PTR_ERR(backlight_dev),
> > +=09=09=09=09     "failed to register backlight device\n");
>=20
> dev_err_cast_probe()

Didn't know about this one, thanks.

>=20
>=20
> > +
> > +=09i2c_set_clientdata(client, backlight_dev);
> > +=09return backlight_update_status(backlight_dev);
> > +}
> > +
> > +static void ktd3137_remove(struct i2c_client *client)
> > +{
> > +=09struct backlight_device *backlight_dev =3D i2c_get_clientdata(clien=
t);
> > +=09struct ktd3137 *ktd =3D bl_get_data(backlight_dev);
> > +
> > +=09backlight_dev->props.brightness =3D 0;
> > +=09backlight_update_status(backlight_dev);
> > +
> > +=09gpiod_set_value_cansleep(ktd->enable_gpio, 0);
>=20
> Is this needed?

The datasheet says "When HWEN is set high, ... if SCL/SDA=E2=80=99s pull up=
 voltage
is much less than VIN voltage, it can cause a small leakage current ...,
there will be around 7uA additional leakage current from VIN in this standb=
y
mode."

It's better to put chip into shutdown mode, which won't cause power leakage
according to the datasheet, and ensures that I2C registers will be reset in
case chip needs to be cleanly re-initialized.

All other comments will be addressed in v2.

Best regards,
Roman

>=20
> > +}
>=20
>=20
> Daniel.
> 
