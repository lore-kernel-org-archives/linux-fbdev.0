Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DEB558038A
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577809; cv=none; b=NbDh6EZTpvWlh2nEd7CGawLu+2r5kAl4gEmoXL8Q3NI+DBhNSN3eYONjY+254IlY9Y81gG9AxkOQSaivADPYB63cRc7mxknqL4tx8uR6y0WG5uiG7syK40k0MtBlt1oirfzgUj/eRntwPoanN32qSjLnnkmg4Ym8vEgbTh5zsKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577809; c=relaxed/simple;
	bh=fuqbMSXmKaVksZQ0mp9Ucbs7t4/StAc7bwI5H6qAaCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gSk8B2tf/gG9EuzTeUXs7IKY0u/2NcqGEb0c+pdE6zry3mm7BqABdgostXhdPdMfXp2ZWdnVoqDop2/uFAywOonL/Y9cl/FLD1/NkEThZOWaRRrkOBrwcmBpgTM5HruZH8miaVEaINnSSSjQ97pCoi9E/uNR0rSxjeUC6MjQooU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg/A8+VC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg/A8+VC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98BB1F00906
	for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577791;
	bh=fuqbMSXmKaVksZQ0mp9Ucbs7t4/StAc7bwI5H6qAaCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cg/A8+VC9E080TzyvTpxu0YnPUmsHYmEPc7xtw8lOlwVWQFVXT213KsByPqqSIU2I
	 YKezTVvqkqyFj8RCV6X6z796z+cgGL3/V6KKfDg+c71b1lvwwgWiG1EI1uwu/m3Th0
	 3PiWWmOGjEHneUgz6Si80Fbz7NLf7VJpVq/lxnf4hkRztmLGONXApvwq5Bj6ihxbnh
	 2DEb0f9/ARGDI62c/9rCPp7kYe7gh6X3Np4O26+gdKgWFKq9/xbV2rRVt1oCMkC32O
	 lt6rPATnGQ4rlLkFzK27Q7Nts5BzFzoK5WLviocUhwMjzceCEZEyQbrc9KdJxu4ARU
	 QjSSuos16jzVg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15cfdso1222082e87.3
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Sep 2026 09:56:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByYKcD+ScYiFi4HmU3vzZVUGtXO5vnVjuasOaiSKjs7/4agE8jZ5TEXgI4pLyRG3iHBeoPUATRhFKRQjg==@vger.kernel.org
X-Gm-Message-State: AFuF++nXu594UqpUqVRvx8wn/ea4rOHxQy8PQikmg6J8AqBmHsWZWBPZ
	+keDJaz1ahvBYLJhayzNMikSS6Ii5U1Em4o8rHHArBHjqvnIfcRs+aNQgUXZjTlnd6SAE/GeZ0g
	+/m0PMGJbU6Tl7Pr7K8WxpH+vEKH21Jk=
X-Received: by 2002:a05:6512:3a96:b0:5b6:1a7c:59dc with SMTP id
 2adb3069b0e04-5b8b66504bdmr1056044e87.54.1789577790547; Wed, 16 Sep 2026
 09:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-12-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:56:17 +0200
X-Gmail-Original-Message-ID: <CAD++jL=LM2agPEcCxjtQuCNx4q7zqutFA6oDb61kKEDAADR4Vw@mail.gmail.com>
X-Gm-Features: AcwNN1Uahpnh6JEjJOB4HtYt7IIRQWlpnYcwXmBiixUkMQ8clPYYJyQ4xy80br8
Message-ID: <CAD++jL=LM2agPEcCxjtQuCNx4q7zqutFA6oDb61kKEDAADR4Vw@mail.gmail.com>
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
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

On Wed, Sep 9, 2026 at 3:23=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
