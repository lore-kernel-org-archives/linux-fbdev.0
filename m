Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A4253FD5D;
	Tue,  8 Sep 2026 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871693; cv=none; b=lfQJabuTPXHLV2sZDR4alw8yrGlE3FwIXhxMxP+3PkOZRXZrB5E4Gi8rHkOYGkfrEyChTVZr9vNWWjDKSI+9znRR1RahMvzqfS5+OIW3ph6YlEWd2tG7dV3kQ1ENEmFRK6ALH55vM64jNWz/hU4tTt9K7E71eikdnqA7vac3jdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871693; c=relaxed/simple;
	bh=ukfQ4JwDAm7uKL/op1I6LUojlIkkTkm39NAWrvGtK8E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IsMfugV2BAX+XsVAlVEzQjvLMy5QYugVMve8kiUejDhr7Dp1vlmn+W8NWQrOl2SVd+Rf9eg4to3j2G2bQQXOKJMKEEWHu/CvHaY/w0jUYPutDfwZx2yCa9nMgcVv28OCqm6Xpk9GcVt/rGDA6QQ57DCShY7X63+JrWwT1fbdG5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MksgKu6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MksgKu6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14E11F00A3D;
	Tue,  8 Sep 2026 12:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871692;
	bh=feEGDyi6VU/sb4agsQYzpOSCawLfSkaWQda6dgDR2p4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MksgKu6uyO2Gguiv8Rq3+UUSn2sYyMCbhn4A5JnjyzKXKmkqOedfI2gppAaqvEHVJ
	 rRBAhiB6rGjwR0JoGODhOBOECe7zcNNFUAE05c7DWeacbZyEK8RvbCTIJ4/16HMzEC
	 MAnNAqV2snxIOSOtuDgsFsxtmJKNKBAA9zpkOrukWnWmtp5+S6BDLredgM5cXzEJvd
	 GrZU6s8B9QoHqrr0WyNgI1+Mi+Y/yMljhQDkmq6uaj2bB8HnRD6KR9uUEUDSa+/2fr
	 YZq56+cUDFuTrIXKNi5nF6fbD6tGEDBJbJzecf28OwddCE6o5k8iS0jArCktqp12lv
	 2X7cUZTftHpfQ==
Date: Tue, 8 Sep 2026 14:48:08 +0200
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
	linux-fbdev@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>, 
	Diederik de Haas <diederik@cknow-tech.com>
Subject: Re: [PATCH v11 30/74] drm/bridge: dw-hdmi-qp: Provide
 dw_hdmi_qp_hpd_notify() helper
Message-ID: <aqAD7Imd8VyYgaYr@houat>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
 <20260901-dw-hdmi-qp-scramb-v11-30-bc12954a0688@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
	protocol="application/pgp-signature"; boundary="7br5rkaa3pyhecrc"
Content-Disposition: inline
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-30-bc12954a0688@collabora.com>


--7br5rkaa3pyhecrc
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v11 30/74] drm/bridge: dw-hdmi-qp: Provide
 dw_hdmi_qp_hpd_notify() helper
MIME-Version: 1.0

On Tue, Sep 01, 2026 at 09:50:54PM +0300, Cristian Ciocaltea wrote:
> Export dw_hdmi_qp_hpd_notify() for platform drivers to report hot-plug
> detection events.  Unlike drm_helper_hpd_irq_event() which polls all
> connectors, this helper targets only the affected connector and ensures
> .detect_ctx() is invoked on reconnection events to trigger SCDC state
> recovery.
>=20
> Note that this helper may sleep, so it must only be called from a
> threaded HPD interrupt handler or a work function.
>=20
> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
> Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, R=
ock 5B
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> ---
>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 37 ++++++++++++++++++++++=
++++++
>  include/drm/bridge/dw_hdmi_qp.h              |  1 +
>  2 files changed, 38 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/d=
rm/bridge/synopsys/dw-hdmi-qp.c
> index ee74266b7aa9..a2277531182c 100644
> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
> @@ -28,6 +28,7 @@
>  #include <drm/drm_edid.h>
>  #include <drm/drm_modes.h>
>  #include <drm/drm_print.h>
> +#include <drm/drm_probe_helper.h>
> =20
>  #include <media/cec.h>
> =20
> @@ -163,6 +164,8 @@ struct dw_hdmi_qp {
>  	struct regmap *regm;
>  	int main_irq;
> =20
> +	/* Written by the atomic enable/disable hooks, read locklessly by HPD */
> +	struct drm_connector *curr_conn;
>  	unsigned long tmds_char_rate;
>  	bool no_hpd;
>  };
> @@ -785,6 +788,8 @@ static void dw_hdmi_qp_bridge_atomic_enable(struct dr=
m_bridge *bridge,
>  	dw_hdmi_qp_mod(hdmi, op_mode, OPMODE_DVI, LINK_CONFIG0);
> =20
>  	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +
> +	WRITE_ONCE(hdmi->curr_conn, connector);

You need to take a reference to the connector, and you really should use
a mutex here.

Maxime

--7br5rkaa3pyhecrc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaqAECAAKCRAnX84Zoj2+
dkkDAYC+AWGm80pVYEp640sKNhCVwlFRg0NA45EvZymN4J4AhE4kXnPASU52wEFN
x6mrzgIBgN7eoUGtFrPVC1JlZqSlVzCPzTRW2tTeI5qXVl4QpF/Mbac11+3SSsJp
N9wlWFp5OQ==
=XLln
-----END PGP SIGNATURE-----

--7br5rkaa3pyhecrc--
