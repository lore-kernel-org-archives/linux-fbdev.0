Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E795488204
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789134277; cv=none; b=ech4di4B0gRhfIf/IIufTd1ZVHO1ttL/rxJ2cxeMhPIyU18z9HWFWSgMo8s9TMdkqEgJdkDSRBdwijTM1TpoSkZKIhoLF/gT90DWhGduxR76QhL8JigmFjajkcqo0ddElWgYBzc+ZmR6kGWFHjY1OHNDRFVZ/dj2JTpLTKD1WuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789134277; c=relaxed/simple;
	bh=Pt4h3NpVdFxgIyPdCiaqsfwIllKAbrQoe/JCPvMw2WI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fMCLN9i3hwoV0kQk4gNzDe6CkdyJ6YjlM/M4F1BA7JF2LOnhpSjc/TL0aAE6HPz3evYy8Qb+d2nISnKoZJ6MB07TXYVJ5ECnZ8GqaTVl2xvP/awbTgnEcndP+TAu/z4SUERXBhYtSXxQ6sq7PLkRbGuQ3I7ecB45hdJ/Tt5GHYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZX3Lsnab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZX3Lsnab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E281F000FF
	for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 13:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789134274;
	bh=EmV7xvDd8p7wDhHv2qGiIJwLxypfzLhq7lXIjcWfW4A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZX3LsnabMly/sYg4bEyhxtwsgHQ78//47mSglSJ4TJW/2X9Vrw/Cc+mxdBNUzVMJQ
	 WKXFWj0m/AmDoQ8c9xMPuAKtm7lrp48I0qdXbGeAvo+i8B9Smk+yzO7UK2KQsmB1lv
	 DHWjcasuQAkGOCLws1tCOMyiz2cx8f24JlgaetBVJChNd2oZKnfNQCh8v9OAKFitC8
	 qUhFGPR0yXGBA/cZ/ZkteIgUuh/Ry71FR5FImoHXxYLkW5Lj3A0i6W8tZxQphx48tR
	 Oen9SRWWhFSe5gQzflu2eiShO52g4LwVwG7F1AuKGF8jx7oqPGc8Sat5XzTMPjNHaH
	 wXyarS6MElyJA==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f1801fso1221216e87.2
        for <linux-fbdev@vger.kernel.org>; Fri, 11 Sep 2026 06:44:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxW0pWY7LHmJz9wbTmV2RSu967U/btOdaz3r+z0ka2iAfxM4BvmdKqlVjUqPWXAUl7xh9pkXEPxzYwnoQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kHyhh1GbGvM8pF7NC5JVe/UjVr5hwLIxsMu3PfQlCiAXj5p8et
	gp6pUMpSYfK2ELEzSRFJ1tQPlb8OQ7jAV2BAiqCHcmTHqDjCcP4NNCqF2cPM2GhkBqmuw9lBRKt
	eyUHaFVIyitgRbDAryzxkp6l8+aVd4WU=
X-Received: by 2002:a05:6512:1293:b0:5b6:183b:d20c with SMTP id
 2adb3069b0e04-5b8a032660amr1119488e87.51.1789133836636; Fri, 11 Sep 2026
 06:37:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908152808.3928630-1-arnd@kernel.org> <20260908152808.3928630-4-arnd@kernel.org>
 <CADkSEUjYhRk-ezaXZkHzFTFQnySFSisKtZfEP-_NtLnQF+6-1Q@mail.gmail.com>
 <CAD++jL=ysmPgs8yKH5KBobuv-eeCHHgZwvo1kvHOFuTwhkaOew@mail.gmail.com> <2144051c-268c-40b1-8c22-4be49f0edd17@acm.org>
In-Reply-To: <2144051c-268c-40b1-8c22-4be49f0edd17@acm.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 15:37:02 +0200
X-Gmail-Original-Message-ID: <CAD++jLmRZek7MjW5LuLUb=u5RmgOyHy4V1OcTv7asAZJpWogtA@mail.gmail.com>
X-Gm-Features: AcwNN1W6r513ollKEmEehDsh6aLwchGLVwxmCgwImDsptMKBPomLX6IK__6z0wQ
Message-ID: <CAD++jLmRZek7MjW5LuLUb=u5RmgOyHy4V1OcTv7asAZJpWogtA@mail.gmail.com>
Subject: Re: [PATCH 03/13] ARM: remove riscpc
To: Bart Van Assche <bvanassche@acm.org>
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Arnd Bergmann <arnd@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Drew Fustini <fustini@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Frank Li <Frank.Li@nxp.com>, 
	Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Fabio Estevam <festevam@gmail.com>, Vladimir Zapolskiy <vz@mleia.com>, Stefan Agner <stefan@agner.ch>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew@lunn.ch>, 
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
	Gregory Clement <gregory.clement@bootlin.com>, Robert Jarzmik <robert.jarzmik@free.fr>, 
	Kristoffer Ericson <kristoffer.ericson@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Alexander Sverdlin <alexander.sverdlin@siemens.com>, Shawn Guo <shawnguo@kernel.org>, 
	Karl Mehltretter <kmehltretter@gmail.com>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Nicolas Pitre <npitre@baylibre.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	Ian Molton <spyro@f2s.com>, Jens Axboe <axboe@kernel.dk>, Helge Deller <deller@gmx.de>, 
	Thomas Zimmermann <tzimmermann@suse.de>, "Paul E. McKenney" <paulmck@kernel.org>, linux-block@vger.kernel.org, 
	linux-serial@vger.kernel.org, linux-fbdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 3:26=E2=80=AFPM Bart Van Assche <bvanassche@acm.org=
> wrote:
> On 9/11/26 2:07 AM, Linus Walleij wrote:

> > The community has a built in tension around this:
> >
> > - One camp that are enthusiast like yourself. That kind of people
> >    are running the show inside arch/m68k on Amigas and Ataris.
> >
> > - One camp who get their paycheck from present day companies
> >    and constantly on top of the latest technology. As can be
> >    seen Qualcomm just taped out a brand new ARMv7 SoC
> >    named Kuno, for example.
> >
> > As you can see this leads to a bit of tension.
>
> That summary looks incomplete to me. Every time a kernel API is modified
> that is used by the RiscPC code, the RiscPC code has to be modified too.
> Removing the RiscPC code makes modifying kernel APIs easier. A recent
> example is available here: "[PATCH v5] scsi: core: Drop
> Scsi_Host.default_lock"
> (https://lore.kernel.org/linux-scsi/20260831095821.3486994-1-john.g.garry=
@oracle.com/).

Yes that is development churn, but this is the same whether the hardware
supported is old or brand new and doesn't really answer the question
whether it is to be supported or not.

That line of reasoning will always require a supportive hypothesis such as:

- We don't want to support stuff that is old (deprecation and deletionist
  stance, I don't want to hear yesterdays news)

- We don't want to support stuff that has very few users (utilitarism,
basically,
  the biggest common good for the biggest number of people take
  precedence)

This is implicit in many statements people make about this. What entusiasts
ask is a completely different question:

- Is this fun (for me/us), makes me feel good to work on etc.

NB: personally I don't take a clear stance here, I mostly want to break apa=
rt
the argument and clarify what it is all about.

Yours,
Linus Walleij
