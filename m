Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3012D4D6C4A
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577419; cv=none; b=PSLe1VRX76Ow2muuj7JkmCsdS9N6Gxtkxcms6/QszWXveclu66MqEMGuuBHbSukf43VkTHG8/tcsWUmWeUFWgWY3vYmOAf/y4/r6E2CzZQuuU4RELCPaRpe33VnUIgoqZg5RPgehYHVOiSqqHHClsMacCKeLWmkYtNk/F6rJx1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577419; c=relaxed/simple;
	bh=L7Nv3D+LAVl5eGsM7/8TZo2OXjqL6TT+3lXEOOWeVno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iMKunAIg8XxeugqazPTbmlf/tm9hJsitT9t7Luu+w5BllvA/Qonq01kUjUY+Ubq+mz9c1RCQNLWDh9R/pcTRrB96XDyAFVoTjNZ7fHgB4ZYFU8Z9GIxbWTcOc6j0Gb671W2+OKJRHG0c7qTm7ISQ2MZo0QmIf+CntPPQ1I0wYr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRfWJMYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRfWJMYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 515031F00923
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 16:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577409;
	bh=L7Nv3D+LAVl5eGsM7/8TZo2OXjqL6TT+3lXEOOWeVno=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JRfWJMYb32Rm+IxTGvWpJpVsMLrjJ68BqhbJ1lGRrYsTjhE1OZfZj1qbzkB0veld6
	 aydd8hcy346Zxb6783g1qefug17abCGHwEEP5EzN/vTF6tUlqT5ZPT9NonaNcBN6Mm
	 iFHRI8HRf+oFvcyk19LmsMR/ieQvjycJb8CfLWsfTiXI1BT7/RcsPiDeyUeP4sl6Te
	 lG7eTE1DFCyEJnR2F3YWWd+EREGj4zAlFNo6xxzQLZbMu98CG5M/4U6F5hTA659o1r
	 atcvb2ngG2XHrNfqUI5igAlUejpBaeyRareRjXW7WalzRDlX5tkNV+y19q3/HKoiYf
	 MIIkl+PwLwMGg==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f13d7aso1616659e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 09:50:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxQqLUEoFCkpuJWNG8Kvie3loeZ9h/iGPeymDrxQR0dZIHrrtNg8wnNw0boiAIYG1u1cvWBaMLVrdM44A==@vger.kernel.org
X-Gm-Message-State: AFuF++kNFSjVfXAKfY4RybzUgt0sN9AsCpYuhaF8B0MNDH72SIR4riXx
	mZTIS5DeUbOxf7ys5z9UJ5+aDs5ypOiOzs+48IviWz5rCrZVqQOAdVuNukVj18zlCvonWeZZmSC
	vMTQPk1T2qmh0N5GQrNgOF2FgCvy2v7c=
X-Received: by 2002:a05:6512:a91:b0:5b5:edd1:471f with SMTP id
 2adb3069b0e04-5b8b660ce5dmr1007964e87.11.1789577407936; Wed, 16 Sep 2026
 09:50:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-4-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-4-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:49:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLm-AwYYyJ9s2MTa7r_raesRar36Hugyf1R1Ny0zCqL5_A@mail.gmail.com>
X-Gm-Features: AcwNN1UmqUhvwRMmw62XliPfw_HgO3-Fmrm9oMts4wPzbRxPuRqcz84S4okTZmg
Message-ID: <CAD++jLm-AwYYyJ9s2MTa7r_raesRar36Hugyf1R1Ny0zCqL5_A@mail.gmail.com>
Subject: Re: [PATCH 03/14] mfd: remove unused si476x driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:22=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The si476x driver was added in linux-3.9 without devicetree
> support, and has always failed the probe function in the
> absence of a si476x_platform_data definition.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
