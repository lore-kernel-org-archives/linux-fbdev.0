Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938F93A7F70;
	Mon, 10 Aug 2026 09:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352531; cv=none; b=kgsnavBaAPxhbn5B5wH6EFc0GTSQhp4viqM43yxgPka1nAkOwnqB3MRfzqrN+SQCgCss9fB1QktYGP2/oT+KKUIZFpNzMsLqDwryWKBKDP1IOOgC0M3/lUu3OHXGoWOI6FMp6yRv6+9gN2vBMn13AnVUdQMk+SA4cw2O/Q9mhiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352531; c=relaxed/simple;
	bh=HdpBme/9t/xZqKfAX+GpR5irQSAM7NC/ySAMmoe/4aQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eg9YG+kbfMbVlkUYzdkH1XZooV19UYv7xmvBstKiTPVly0pL83QqqBFhkkWEa4V9lewo9vvNWRNXE6CwZJ4Msgs/XKdl240O6p9olEXCN0J6hMh/VIaBCrYiX5ShbQ3Moc1eZ8w5e8YjqBcnaM9c0XsCfnqt8CLPYtDg5rgbrO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRwl1wy6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRwl1wy6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F9F1F000E9;
	Mon, 10 Aug 2026 09:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786352530;
	bh=HdpBme/9t/xZqKfAX+GpR5irQSAM7NC/ySAMmoe/4aQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DRwl1wy6wJ8GczC3ap6xxrKWs6ZWkvS3tMC6pAb1FetOncUzJRQtKCIq8+lfKKBOX
	 g5fk/FmVLnywzijHBkrEdqvogicRLGraYhBoW5Q+Llea0yby+ZTm3zhEmvTVBm6uw9
	 RdjnDQIkhC7C5XVaot/kmNFo90CIWOu2tpgvpjyf5BDbuqO30IkFK+P5SUyq9EPDr0
	 JwDDCKgoux6qgWhqeMyxUFoM5iZT/lZSwE73c4gggOlk4/MqdWvxlIw9T3wVFrc3Dg
	 J8QhXDvQ/4d5GXMzUMS+5dmx+ggKza+XFObqYsmq8EZnfpUNjmdJT56EYNbGtSD2Bi
	 /XrrjrsbBJ0iA==
Date: Mon, 10 Aug 2026 11:02:07 +0200
From: Maxime Ripard <mripard@kernel.org>
To: =?utf-8?B?TcOgeGlt?= Pedraza Padilla <maximpedraza@gmail.com>
Cc: Helge Deller <deller@gmx.de>, 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
Message-ID: <20260810-devout-pig-of-performance-595ccc@houat>
References: <20260731215043.30392-1-maximpedraza@gmail.com>
 <am2mvECnCcO9IxuI@monoceros>
 <0219df57-06e3-4776-afb1-d167cad2e795@gmx.de>
 <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="jlvsv7mq5dpw6ycy"
Content-Disposition: inline
In-Reply-To: <CAEUXW=GUY+x1A72n99i1Cpgy03jTYv3FPAX5nY3DCHqmeq9YVg@mail.gmail.com>


--jlvsv7mq5dpw6ycy
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [RFC PATCH 0/6] Boot logo supplied by the device tree
MIME-Version: 1.0

Hi,

On Sun, Aug 02, 2026 at 12:01:58AM +0200, M=C3=A0xim Pedraza Padilla wrote:
> Uwe Kleine-K=C3=B6nig wrote:
> > My 0.02=E2=82=AC: Usually you want to use the display using drm and not=
 fb once
> > the machine is fully booted. If you're using fb during boot to display a
> > logo, it's hardly possible to switch to drm later in the boot process
> > without flicker.
> >
> > So my recommendation for your usecase is to not use the kernel boot logo
> > stuff, but something like https://github.com/pengutronix/platsch.
>=20
> Thanks for the pointer, I did not know platsch and it looks like a good
> fit for the problem it solves. It does not solve mine, though, and I
> think the reason is worth spelling out, because it is not about how the
> image gets drawn but about when.
>=20
> These are industrial units, and the requirement is time to first pixel
> after power is applied. If the panel stays dark for more than a moment
> the unit reads as dead, and that is a support call. Anything running in
> userspace is by construction later than the kernel: it needs the kernel
> booted, the rootfs mounted and init far enough along to exec it. I can
> measure the exact difference on our hardware if that is useful for the
> discussion.
>=20
> We do already paint a BMP from U-Boot, which is as early as we can
> possibly be. The problem is the gap that follows: once the display
> driver probes, the panel is cleared, and nothing puts anything back
> until userspace is running. Moving the logo further out into userspace
> widens that gap rather than closing it. The kernel boot logo is what
> fills it, and that is the whole reason this series exists.

If the sole reason for this series is to keep having something on the
display while the kernel boots until DRM catches up, then you probably
want to check

https://lore.kernel.org/r/20260629-drm-state-readout-v4-0-5966657980ed@kern=
el.org

Which also does what you're trying to achieve: keep the display running
with the same content while the DRM driver loads, and switch to whatever
comes next without a flicker (if we can).

Maxime

--jlvsv7mq5dpw6ycy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCanmTiAAKCRAnX84Zoj2+
dv6HAX9W/YXoO7mIxYM1dW13th4tADPga2R/eJrH9jUS2EpeZODDGQI35Bz22jXD
BzPgq0EBgITlzetN/7l5R6fMid4G29Yo7pdhJkE7hJygLXhy0ruNuW9u8AtJTfKp
9bLeQ/WtyQ==
=MPTn
-----END PGP SIGNATURE-----

--jlvsv7mq5dpw6ycy--
