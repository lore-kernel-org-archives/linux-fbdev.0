Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EFA3ECBD5
	for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 14:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781102083; cv=pass; b=CJQta9vIwKv/gxpdN8E6zg0JxlTlWX19q+U6ARV+E71rsBWb/1GYZ/jX2s4FvyuG0okAUdApl6wW/Bou2T66Hd/hZUqGIFfPPU0GpP9RNSmLNlychXXgwEaP73Nr/x6wguVjW9orRh0OESWvI2g1fD/uvdhECdzmh5dhihCS4t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781102083; c=relaxed/simple;
	bh=eHGHo1CpzP+Lhry2jDKXXEgAfPF4V1nf1rNJycM0IZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tkxN5NS8avpbr4OB7k/SYA8GHyQ4NNwW26IUvLv4qd9GRyvzpd3896RDLGSr+KT0XfoQAW3JzgTf/PQ6ErKm59wpR8Pruld0Jj+IP3IkYMw/sS8fV+m8aeF315a128eLM7VMOsk+kMpHle+pvtFMvO5K+Bsg8MKeTg+ZAdLwRB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEDQcYYX; arc=pass smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEDQcYYX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-304c520fe9aso2192236eec.0
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Jun 2026 07:34:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781102077; cv=none;
        d=google.com; s=arc-20240605;
        b=S5BjYJDR/T1gnySA+iFAcZtKkghEjB4VjBZbZTVBC/3OxtDUSj8hgLc/DzLvKhBSQy
         lu5esqHtqxcViOy+HXaVrHh2rprhhNpTIMK+t6aG0gY4/3CELXjvu0JsuNKWwH+s0sZh
         gEEp5iTRAe6hgFqbPWxFFuzDXnd20BgLhCrY9N7Ibv7mha+CXvclD1tMsBqVvDHouvBK
         NrWWEs6yKHrqt2TbBw7IxWJtcCS6PoxXcuD8OiR3MpK014t4fhSnVWclbunitWR9FYsB
         pzs/R6g1v5UQgmxykQpkvMS7+Uw+aL1zH0vw6wnETYiAljnAAub7a3vZCTahB+NExRbM
         v6zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
        fh=LJv8As/ib+8Ux/Bn/VW3lmOMfdONTGQcNqFmJOc/VtU=;
        b=Vsxe97a67HGKjVx8hWAjH9slQOsFCYdcLwKcHYbVlSiKvhqmR/Yu2GztZAO0do76BJ
         ++f8Nm+S6oUab25iJzul5Fr7isJNLRg0rEX7X6Q0cCxdZbDlryPyTXwxOQNe+H7KCI6C
         VHtlRDW0/+9V/t6WibA2a/yC/74s2AqVjeTy+jdivxl8pA6TSE04Qa+Jbl6GHlsBqzAR
         IrpikImgMpCTu1T68R7c9XgoS+Sp2GNFjmDjUjxw7Ap4nAvXQUmFISX4u7J6SP/0QLUD
         +mNv0ZGES+zjnvSP43TDduAKQz30gRHTCNfvNmYj79WO/D6B50UXF7o6Rp+7gAhSBbXw
         umYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781102077; x=1781706877; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
        b=GEDQcYYXmyqDTIeTwRUeJGjkgrgVo4QvCPnJpFto2PCMedbmf6U86eQL8mQzXpK7KB
         VIcIsjPFjnPZtqjm+frmahsCAFcV/Tpc/oitHdYuiF0Ffi+0cRZmuqrXDUcf+G6s9TGC
         /bzSIVTtAwpbDrFirH3japNOGBYg3M1htuK759cGRP60+yjTFW5fLes48bA0LLAa+XcY
         4kzfilYX1T+jE4SR2K1U8f2SUC6TvKPwYZBok08tpVVWloEVr2vFsnhxHQ40EbNbde1m
         atKqXT/ycgTAmLOV5EyI56oWW2pd/Ulhw2vv2HgWj1rkJdpLctB+8zAWCHnjTUXQUrzg
         0Uzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781102077; x=1781706877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y4QsNr9+C2sksb8f9hiRst13xYKm9uscJWoJD0+yoDM=;
        b=C/LFHnShqmIcwVsau+kFeHdvcruVhH9sGF/95EMFgTFeYHviY1g3wxY+bLL+QptC/5
         i1gSzM0u/bxEzsbgq97IQMzc0RkolHmaeFfQUvJR5q/c1st9t+42BCvXWEGJf4clLoOa
         vd9ETbeSrp5YSm+UupRO2VERkkj0bAqTG0CZ+qXmxnQsszz71eRqQ2wJ2OB5H+JaorA7
         VuLyoECrGAdafpkAW+z7OpCBGcgq3voz40NFiZ4qPuUaMaXSiH03RDLFIPNKF2QvZXCl
         nB0I/IkZ+seRBBkJxr1LujDmTbEan0I02Wj58Fx8TzDCu4GnZXc8vdI+4ta84pk2YHoT
         woIg==
X-Forwarded-Encrypted: i=1; AFNElJ8UcUmp3ClBs+xhoiACeazoP4IP0hPHhXhzimQ6gfGaE9kvVC0MUuyn3338xSGyLWATZ64Bg0np4zPV/Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzmOhRWlpw++4mRt8oX9YSrFvmoYYNXMf5B9xexLHOJQVD4rr
	0rHnJcTw/ecr8JS5AVZcZU6ZXyeL4wiltn8WtUa24mFs2TmNUiPDeJIJILMRuEK0tBEgOPIapKf
	qLE34aRelEAri0eVChzKQ9DQ4NQflbfQ=
X-Gm-Gg: Acq92OHsam8/DyN/+EsgJd6VtLPNpZeDy8ZOY9ZKDmC80JYBQQdcUm5AEfQTNVDIzwU
	ZuJpcyWC7VwV0tmh0XXREBe+zN904epupu/OGL+0Kd7tZuKsOjDJCdHIkW/nADA9wysYXtuUmTt
	CIzBQmv6QBsROLinaIyNrmdT6c6YFx0iwVEyPa03P1/nNv6LitgunV9w84KzeLipn2ElatCJrXA
	NA87uM7VjdjfC7i8CvCfXaPsIb714OR8Ce/i0NkX9uwixw4k/SFMK/leuoULjUUrmRrOoSZXoHb
	sQtT1cGWXXG5zbbOy7U=
X-Received: by 2002:a05:7300:4311:b0:304:d32e:65f5 with SMTP id
 5a478bee46e88-3077b7d84c8mr15465647eec.26.1781102076873; Wed, 10 Jun 2026
 07:34:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606045738.21050-1-clamor95@gmail.com> <20260606045738.21050-5-clamor95@gmail.com>
 <aihkNekrgfu6-6Q_@ashevche-desk.local>
In-Reply-To: <aihkNekrgfu6-6Q_@ashevche-desk.local>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Wed, 10 Jun 2026 17:34:25 +0300
X-Gm-Features: AVVi8CdXjWV2Xn6oo1ydHrhUl2T2tO1QvChE8BglKpS9ooBB10CdbUEM-do5fqk
Message-ID: <CAPVz0n2WG=35W7Z8USDck+xQ4sQSxkfhJR9oeYGe_vBkkXGKFg@mail.gmail.com>
Subject: Re: [PATCH v4 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, 
	Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>, Johan Hovold <johan@kernel.org>, 
	dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 9 =D1=87=D0=B5=D1=80=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 22:06=
 Andy Shevchenko <andriy.shevchenko@intel.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On Sat, Jun 06, 2026 at 07:57:28AM +0300, Svyatoslav Ryhel wrote:
> > Instead of passing the entire lm3533 core data structure, only pass the
> > regmap and the light sensor presence flag to child devices.
>
> ...
>
> >  struct lm3533_als {
> > -     struct lm3533 *lm3533;
> > +     struct regmap *regmap;
> >       struct platform_device *pdev;
>
> And this pdev is probably not needed. But I haven't checked the whole lot=
 of
> the patches yet.
>

It is needed since it holds childs pdev (dev would be better, but not
in this patchset), you cannot get childs dev from regmap since regmap
holds cores dev.

> >       unsigned long flags;
>
> ...
>
> >  struct lm3533_ctrlbank {
> > -     struct lm3533 *lm3533;
> > +     struct regmap *regmap;
> >       struct device *dev;
>
> Ditto.
>

Same here, dev holds either LEDs dev or backlight dev.

> >       int id;
> >  };
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
