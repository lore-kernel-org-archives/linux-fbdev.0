Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE351DBB13;
	Mon, 19 May 2025 20:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747685709; cv=none; b=d8PSympvZ9ld0ugD5dWUIwXxjG7N1kuTqqvoIl60v7shxnZZKUp7aPdkUx3TkyAWDOfHOFrLL2iYoQWqhIy64NHsj1/YlcI0ptSzEgcUUmjv8RCEFZHAx6zl5lknLq2VTgUVl+COlJBOtKm3nGt3ZOtsm+s4qYV0BdOsoguKMIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747685709; c=relaxed/simple;
	bh=ydl7IEuosPgNTSynArYsb5ZJn46GkS3mhACRb/LtaoU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pcH0s33oiwkVkaKm28enERXtWcf2hoH+xkVeBdVhlsXUT2amE7y2jUNzfYGUpDacVVByr4R/aKZ4Zr7hZ0Uv7XZ12BEEEiB3EwjrGiI0wZTXsUGS0MuiwW9q7wTEb1ZB1XfBRS5kIYcPyXLfbicgj+NXKHaL7aYJ8WblMKaC8pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LhMjZc/h; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LhMjZc/h"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 421C043A33;
	Mon, 19 May 2025 20:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1747685703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VWHzGM/W/wjUc/bgNZxqSEV2qgSI0H1pzntZFKFd7BY=;
	b=LhMjZc/hapeY3aN86R6FVZcQDp0vt8PRhYvnTZTktXkVbot+0eOGtK4PfH2gPUXl3/Qh8l
	zbPcnPS8ygiwADYj+PqSW4e7pOYTY35aPxxNwXyLMedfvirVXKv4vw5dNTop9m8hLIY5vS
	K6Oo83ObW3B39uuxiM/AVQqf9uEhr0ICppOas2ruivqerSTa7zALhqDZNCXYL/X4R/VHxU
	Lc7zj60lQNMpgE3N30trodZ1mikpXEtqtYhy3UXDRk5sTWf1rMA7YUhlaGE//Gcm0VgBNu
	9y0PJosTR4MjU63bWvswM2o5GdB1ZoC7ZMFOZwP9XdsxNt+7a0wCGkjV20m2kw==
Date: Mon, 19 May 2025 22:15:00 +0200
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>, Jingoo
 Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>, Tony Lindgren
 <tony@atomide.com>, Pavel Machek <pavel@ucw.cz>, Jean-Jacques Hiblot
 <jjhiblot@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Saravana Kannan
 <saravanak@google.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Daniel Thompson <daniel.thompson@linaro.org>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Sverdlin
 <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v5] backlight: led-backlight: add devlink to supplier
 LEDs
Message-ID: <20250519221500.1796d4be@booty>
In-Reply-To: <20250519174729.44fa1f7b@bootlin.com>
References: <20250519-led-backlight-add-devlink-to-supplier-class-device-v5-1-76d6fd4aeb2f@bootlin.com>
	<20250519174729.44fa1f7b@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefvddvfeduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefnuhgtrgcuvegvrhgvshholhhiuceolhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfetudeugfehheeliefhjeejuddvledtuddttdevledthfehgeeugfetheekgfffnecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppedvrgdtvdemieejtdemvddtvddtmegvrgdtudemsggvgedumeelhegvjeemfeegfeemledufegvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepvdgrtddvmeeijedtmedvtddvtdemvggrtddumegsvgegudemleehvgejmeefgeefmeeludefvgdphhgvlhhopegsohhothihpdhmrghilhhfrhhomheplhhutggrrdgtvghrvghsohhlihessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepudeipdhrtghpthhtohephhgvrhhvvgdrtghoughinhgrsegsohhothhlihhnrdgtohhmpdhrtghpthhtoheplhgvvgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghltheskhgvrhhnvghlrdhorhhgpdhrtghpt
 hhtohepjhhinhhgohhohhgrnhdusehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggvlhhlvghrsehgmhigrdguvgdprhgtphhtthhopehtohhnhiesrghtohhmihguvgdrtghomhdprhgtphhtthhopehprghvvghlsehutgifrdgtiidprhgtphhtthhopehjjhhhihgslhhothesthhirdgtohhm
X-GND-Sasl: luca.ceresoli@bootlin.com

Hi Herv=C3=A9,

On Mon, 19 May 2025 17:47:29 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

> Hi Luca,
>=20
> On Mon, 19 May 2025 17:16:39 +0200
> Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:
>=20
> ...
>=20
> > diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight=
/led_bl.c
> > index d2db157b2c290adc3a159023e9e2394fc877388c..8fe645b5b75447d009e1045=
dcf0c62d3bbc5425e 100644
> > --- a/drivers/video/backlight/led_bl.c
> > +++ b/drivers/video/backlight/led_bl.c
> > @@ -209,6 +209,19 @@ static int led_bl_probe(struct platform_device *pd=
ev)
> >  		return PTR_ERR(priv->bl_dev);
> >  	}
> > =20
> > +	for (i =3D 0; i < priv->nb_leds; i++) {
> > +		struct device_link *link;
> > +
> > +		link =3D device_link_add(&pdev->dev, priv->leds[0]->dev->parent, =20
>=20
> It should be priv->leds[i]->dev->parent instead of leds[0], shouldn't it?

Ah, well spotted, thanks!

My led-backlight device only uses one LED, so I hadn't noticed during
testing.

v6 on its way.

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
