Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0B4EBAF8
	for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792409200; cv=pass; b=NW7ey0X5BthVejNXGgU2Y3IWQElcvmhIwQEAscZi80pCTxK+J6/CXRS3xvO1txKxx9njTMmsCqju34ize2EBAbwQazNIy/MReg7aKgI0fQ5L2LJiGgGyHIB8tFIEagrQQa5KVJLzVWrXLggDedLJrbKJRc6GB+4SiecVB6VtzMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792409200; c=relaxed/simple;
	bh=NjvtDbKF6HXkZCMqwsd9sCUJNo+Nw1euiIQvE/sseso=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=poGyN7P1ko8X42fED7U8f+d067GdKVdhi5ZZ/lTr2d1f3PVZTLNjkJPc3y9U69vi2n4r86Hml774/Irkl6qRzVJ4mYeHs+ZNrzL4+vZK0MCHkorbJ5qE4KkLb6epiUrukLTp88R8LNuvtZ9i/GmbP+QwMsZ5pKRSeQ7CqRsDLwk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ssd6Y/nB; arc=pass smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ssd6Y/nB"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67990a45e02so1684611d50.3
        for <linux-fbdev@vger.kernel.org>; Mon, 19 Oct 2026 04:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792409193; cv=none;
        d=google.com; s=arc-20260327;
        b=pHOMFfUol0M0I3hdzrV1z4ylwOoIAX0TmL9hgSUGEhgVCfFlaV+e3+cpFPfBOpTrsl
         +gyXOA2FH8VxJ6ueh5FYWPiKmimqd0JSPH7EOxF76kmWZlum6cloIWHaKqUol0GgxYGP
         3E1KD3ccUMyhMq4G1Z1H38LxDpY8fzK2ijuMAl7Aju6fefvXCcuSfa/OtZn+Ex/9T8JJ
         sHEQM/He8y86qvGi8nGHX83Ua1f5Uv2pPa65201GeRFcid1+HMcdVUuPWrwpk/XbFoDU
         KVv1KUC0htA4odxw0KsqoXwmPT6gvql3GIKvJwfRHqyRdWeh3shUmwV5SNhIcSt605u8
         GpUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GTD0jeXtR60aME/UdLAfLsdgVjEQHvE/dqZ2xHjZShQ=;
        fh=31kxy/B2Y85rVd8UT/p0j00+T+wxC9R51+OlltNEWcA=;
        b=GbLR2CUHLq+EJqN/jy0n7MOkPdF3KdzMslhC0nd8TeMzKuS8c/mPxF/aJchqVsuj2F
         L4xk1mPnJFf5KxfwiMJFWmAabcawtSQD97PTu9I3IvxjBMGbY3Apg6eYekrT/IZLYJf7
         bX8+y2+G8HyzN1fPU0wk4gkVdpxfK4iq+m/iP3A8QzStW298van+qNaBjZ8p5+Iiudb7
         VB1i8b5flQbJQ4Z75G7CuP/mKs3W6EmcSXnsLC9SEucS928758XrdVeCfK+pvCtXKDQc
         Ct48dqD/j41w7DdPicQY9VxC3gkKUgda37GfVO7rcQJ6fwcnnFFt9UuwM8NvqYPlBGe2
         /5Zw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792409193; x=1793013993; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GTD0jeXtR60aME/UdLAfLsdgVjEQHvE/dqZ2xHjZShQ=;
        b=ssd6Y/nBvfJvDOfmw9GbWVfK+EMhqsz9McPRkD5JUSmZ+2Ed9ks2F9ubV7Ej/z+tb9
         hDQCLvyXuy4pnFgRijHBV/OOogv8Sx2Rq5+tS4dz3nV9E25s4Phvt0XlfTYlytCrY4XX
         vvXvUS9RJX9UluxSCXWAKjtIQydA+y4TJk9kWihk0NXcXrDCS/qbAv6qjjRGrL/gZKqi
         1vrqZgEUr783H7a0H2nYAPTVM/92mQ4UCh22MxD96dGJj7sX7b6X1eZ8C6Kyh6jXzekU
         UrRm2HdvpnubIym5el1kHku9uFoJBbT/vka/nMAwpdquDkxkm1kMHEDhtVzucDtVeD/w
         /YLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792409193; x=1793013993;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GTD0jeXtR60aME/UdLAfLsdgVjEQHvE/dqZ2xHjZShQ=;
        b=Vco0ket7XM55E/iGGYZkpfyJx9fUFb6GgESl/mm6lb2/HHR+CukcQIHlJtdjr8CROs
         R0y+CStmDZt0bxgTbNNoojA9RsvsTwOBEronr2HEjxAdtpirFaVQ0u5k5x2EfXekC7uu
         rZjhMQkXjs24ERiU4OCgosRGITk+H16FacPX9yPKe3EzCwsPsJVTn2FlD9FBV8nnUcx7
         1x2aLIEbv2WrKoiXalEsBnTck8hdHZn0e3vL36VDvuHWKd7ypTKZDNtcICHS7qP9Rpim
         LYhJl7SsC7nwbJLm2Wvs9FGNdciL/alN6wXMXCy3ac7yoV7iay5NVJYWCY5omR5AAiAe
         vgjQ==
X-Forwarded-Encrypted: i=1; AKwUvBzh27pq7E634k1IuduX3AV7cQzQiz+dB3nOCCHPpODoB3eCqc5HhD9mjmJSr2tHzXxjAYALjD8grs7zqQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYIdNbOrxMxjCLhR+IITUyNLQc4Spj6M1HctBuuUDIn5d0nvIZu5
	UPUwrY1QhMTenPiIOhh9thDAZVlL5a9HTAyMTNjQB5BRz2cEGMeoUAtIG9r/g6flFiYIpJgwWPD
	3B/4ERSEBo58Zzbe0A80BVOjgmYK7ero=
X-Gm-Gg: AYBFou1tVsm8tnPVtYYSjkciRzndmSJpI0NnusNYmJEiDtkdJoKPbRdIbE8sIquy7l7
	Ko1tuHsQsN4AjcNrmyjRcUsrUo/P5zYikjl25fgvWKN7CxsqYElPKyNYQdWH5nX2rjV8vIYfet5
	A0T/+x335czMqxmnM5KolY7tL00EI0cImzjo0EdRFA4qEXvOi33jVmtMuQmq8fEWVpvWkmYqr+l
	GGNKlBl5ccpxdyLmQ3FdSYCw7Ga6so5zJ8D2HnZRDLkJQ0uOnMOKqi3YdRjdPKACzYTIa2nDh4r
	nnC5dMddXHaBb8264Kv+K7c3imPE5dw6EL8z6eZE89Sw9P6Wy6wc5BQ9ILT+c0QXXi7AO9jKr89
	aCGXpPKKPJd1ZjuMzExaJ7eKQFwtRa+xLJuM18oL6JqpO8dx3ve8vttVzy7jYvoPwmQZAP8uLxZ
	wTjovXBg==
X-Received: by 2002:a05:690e:1347:b0:675:66f1:5ed9 with SMTP id
 956f58d0204a3-679ca90ed21mr2347287d50.101.1792409192148; Mon, 19 Oct 2026
 04:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261016162912.64581-1-lukapanio@gmail.com>
In-Reply-To: <20261016162912.64581-1-lukapanio@gmail.com>
From: Luka Panio <lukapanio@gmail.com>
Date: Mon, 19 Oct 2026 13:26:21 +0200
X-Gm-Features: AclHuK8NAOp_nRQSq-Iz-AG3DYdUQ7KXnVtQSaGV8OFLCu20HF33SdrAf0b1-9c
Message-ID: <CACi=Ov6Jg5eUxskBbmtWOS03jta90RK0nByhWf4EQs1PNhvuKQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] backlight: Add Awinic AW99703 driver
To: lee@kernel.org, danielt@kernel.org, jingoohan1@gmail.com, pavel@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, deller@gmx.de, 
	daniel@riscstar.com, krzk@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, junjie.cao@linux.dev, mitltlatltl@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel, Krzysztof,

Thanks for the reviews. Before reworking this for v2 I'd like to agree
on the approach.

Following Daniel's suggestion I'll add AW99703 support to the aw99706
driver using per-chip data instead of adding a new driver. The register
maps differ almost entirely, so most of the DT properties stay
per-chip (dim-mode/UVLO/ramp-ctl on AW99706, OVP/OCP/inductor on
AW99703).

Following Krzysztof's review, the AW99703 binding will drop the
ramp/transition timing and mapping properties and use the standard
led-sources and led-max-microamp properties.

That leaves the one common property, the maximum LED current,
spelled differently in a single driver: awinic,iled-max-microamp for
AW99706 and led-max-microamp for AW99703. To avoid that I'd like to:

  - add led-max-microamp to awinic,aw99706.yaml and mark
    awinic,iled-max-microamp as deprecated
  - have the driver read led-max-microamp for both chips, falling back
    to awinic,iled-max-microamp on AW99706 so existing DTs keep working

Does that sound acceptable?

Thanks,
Luka

On Fri, Oct 16, 2026 at 6:29=E2=80=AFPM Luka Panio <lukapanio@gmail.com> wr=
ote:
>
> The Awinic AW99703 is a high-efficiency 3-channel WLED driver with an
> integrated boost converter and 11-bit brightness control over I2C,
> optionally combined with a PWM input. It is used as an LCD backlight
> driver in some mobile devices.
>
> This series adds the devicetree binding and a driver for it.
>
> Tested on the Nexphone by Nex Computers.
>
> A board DTS using it will follow separately.
>
> Luka Panio (2):
>   dt-bindings: leds: backlight: Add Awinic AW99703 backlight
>   backlight: Add Awinic AW99703 backlight driver
>
>  .../leds/backlight/awinic,aw99703.yaml        | 131 ++++
>  MAINTAINERS                                   |   6 +
>  drivers/video/backlight/Kconfig               |  11 +
>  drivers/video/backlight/Makefile              |   1 +
>  drivers/video/backlight/aw99703.c             | 583 ++++++++++++++++++
>  5 files changed, 732 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/backlight/awin=
ic,aw99703.yaml
>  create mode 100644 drivers/video/backlight/aw99703.c
>
>
> base-commit: d419d682257d813f6cb7a28e42b35d0edf4ad038
> --
> 2.55.0
>
