Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35B350AC1E;
	Tue,  8 Sep 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859470; cv=none; b=dzivAMfHUiZaALqYlMFXKVir2H/1aP5xCKsKNPQVqZEX8MSQ4nnXuPd9PJmhF/bVw1888svYRbDf0S1aUyJgnQp6oxXerNQgVq77v+rwTS/PbKp14UisOpWm4+2yO3R6gCvcnwaYTTtSVXn6ZtjOqVzodCLKwS3vyxYaSNo1kBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859470; c=relaxed/simple;
	bh=h/T7ycLMSDC3a2kr6DgdOAzHxcYYnc5NhlAyE3UitFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gF/hy/aXwtJ59SfOWZs7f5dk5jkAcnfFZqk1N2LcSqbTkmWVl/MdCpAXnuZGTXAQkouU7rIsVvu4bWKHOhYd9wDzb4EeGrhvghUH7h03K/chWCtcogZZxdFG2jZugUcdUospaKXCjOzX8JbZ4lSFaC002lGVi56FDcj9KyOugZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdump79V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdump79V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8522F1F00A3A;
	Tue,  8 Sep 2026 09:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788859469;
	bh=nwt4MSvg+/6zRv8Vcf7XT0o+MS+vnu26qoTN+G3zanc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hdump79Vw5fEgXFJ9VugGGr5h6P63z5Rb/y5Hg0yODT+xkwe1X9g+jFlOkv7xQ2AQ
	 uoCqpfp3P4EELicYSY5xFxcScIgnN41HJE9Hv+IxmdZE3UxokuQE7yocbQixaPW1bD
	 BW578Iwlzn0eG3XZClR5mMtu1brAknhWLvs7GumecG1XFVYvsexzXf5BQLuUikEodO
	 6U91vturj452mofL9n1U1GBjg37Vl2/FSlgkBctDhnEQTdhaEBWmhcv5aTHVRUL7ID
	 Ek2bZXURLjsVrHEStEywjsO0iimjIlhQPJW7MDJgN3QgLd7fwNXC4iMlsT1e/eY3bc
	 gi7qJpbxFcf3Q==
Date: Tue, 8 Sep 2026 11:24:25 +0200
From: Maxime Ripard <mripard@kernel.org>
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Dave Stevenson <dave.stevenson@raspberrypi.com>, 
	Dmitry Baryshkov <lumag@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
	=?utf-8?B?TWHDrXJh?= Canal <mcanal@igalia.com>, Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Sandy Huang <hjc@rock-chips.com>, 
	Heiko =?utf-8?Q?St=C3=BCbner?= <heiko@sntech.de>, Andy Yan <andy.yan@rock-chips.com>, 
	Algea Cao <algea.cao@rock-chips.com>, Daniel Stone <daniels@collabora.com>, 
	Liu Ying <victor.liu@nxp.com>, Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>, 
	kernel@collabora.com, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
	linux-fbdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v11 13/74] drm/bridge: Fix NULL deref in drm_bridge_add()
 for legacy bridges
Message-ID: <ap_Tr_Viqy29f515@houat>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-13-bc12954a0688@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="ygj36ay46abkkslu"
Content-Disposition: inline
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-13-bc12954a0688@collabora.com>


--ygj36ay46abkkslu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 13/74] drm/bridge: Fix NULL deref in drm_bridge_add()
 for legacy bridges
MIME-Version: 1.0

On Tue, Sep 01, 2026 at 09:50:37PM +0300, Cristian Ciocaltea wrote:
> Legacy bridge drivers that embed struct drm_bridge in a zero-initialized
> allocation, rather than obtaining it from devm_drm_bridge_alloc(), never
> run INIT_LIST_HEAD() on bridge->list, leaving next and prev NULL.
> list_empty() compares next against &bridge->list, so it reports such a
> list head as non-empty.  list_del_init() therefore runs and dereferences
> the NULL pointers, panicking the kernel during probe.  Only builds with
> CONFIG_DEBUG_LIST survive, with a list corruption report.
>=20
> This affects rk3066_hdmi and the i.MX8 LDB bridges, which still embed a
> bridge in a devm_kzalloc()'d struct.
>=20
> Initialize the list head when it is found to be NULL, so that the bridge
> ends up with a valid empty list head and list_del_init() is only reached
> for bridges that can actually be linked.
>=20
> Fixes: 17805a15d175 ("drm/bridge: add list of removed refcounted bridges")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260731175016.C5D591F00AC4@smtp.kern=
el.org/
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/drm_bridge.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
> index 2c457ad74f3b..a8b6df5c13ea 100644
> --- a/drivers/gpu/drm/drm_bridge.c
> +++ b/drivers/gpu/drm/drm_bridge.c
> @@ -453,9 +453,16 @@ void drm_bridge_add(struct drm_bridge *bridge)
>  	 * If the bridge was previously added and then removed, it is now
>  	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
>  	 * corrupted when adding this bridge to bridge_list below.
> +	 *
> +	 * Legacy drivers that allocate the bridge with kzalloc() rather than
> +	 * devm_drm_bridge_alloc() leave list.next NULL. Such a bridge cannot
> +	 * be on any list, and list_del_init() would dereference NULL, so
> +	 * initialize the list head first.

"legacy" bridges are ambigous and was also used for non-atomic bridges.
That being said, it's now *required* that bridges use
devm_drm_bridge_alloc() instead of kzalloc, and we warn in
drm_bridge_add if it hasn't.

So I don't think we should merge this patch.

Maxime

--ygj36ay46abkkslu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCap/USAAKCRAnX84Zoj2+
dvfBAX9Xat1E7rHDo5AwoQwclzUX6gFePTOLCX7JzUTlJj4v+JVqzvUmXYfX2MVE
CDhj71EBf2f48qg8uxY+jSn8HuuECyGRZX1EJkTYg9OjYG+JlhXy81xPlHXuun/i
wRZxh6EhmA==
=t0EL
-----END PGP SIGNATURE-----

--ygj36ay46abkkslu--
