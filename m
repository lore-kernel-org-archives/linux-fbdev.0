Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020C44CCDC7;
	Tue,  8 Sep 2026 11:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868080; cv=none; b=T1DQqBJsMVLGTd4cKDTzaor95mJPnULfXdablyjDcO8EbkldKVB7n6kQv/6zNTPphE16GsD5oYNUJpRyogEtbLda/hGJo+cXt95MgyJ0LOUz0RswnFnmMcCjHKwyPP0Zz0wF+prmKvzpt7gR49j+vBeFbB+vMhtTptLP10dxA2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868080; c=relaxed/simple;
	bh=MMS9ycnEFoV860wmEcOmm/CkFmLwrL1OPG0OCwnHV38=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=J7RdAm96OSrLeU8lcPhEhsTa0qdoff6vGnzA7kjsU9RC/u0Wz+ceEzJZjicwb0osfBaKsmsZ1HUwHY0NW/43lZo7DzCl5ORkIM9f01oq9Bc2u+auvMsSiO5skvnBIiyNHRW0BxpCygfST0YotiH75pc5rEjuLJMOK/96zKWaP60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrwask4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrwask4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6594A1F00A3D;
	Tue,  8 Sep 2026 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788868069;
	bh=tFqlxS0VAJUS1eYBmNpsy+dfqGlk6k7GW17X4HTW28c=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=Zrwask4N3j51yTltiB/mAq4qaOdIeMraUZsUz5Ls8bSfm7rcPvdE1RKC4nsb2ec3r
	 SHKYRO7l2cVsLvKvwr7aAv6tqdshJRerMmC+kdkjk1yet+kY5czRmLjXIeHQK70y4p
	 JkRs3Vsy0kK1W1xcDm0uOq0Rh2t51tEVYzZ220IlX2o6xjmgDL5RJQWaAuRq5wucv8
	 rzzImm1aqyGT37N4xIGW3yBv0/gaNUmU51JqCVG5+VBUZFUE+QtVz/EsoM8fGqRS+/
	 MYjYz1E/Yjr2yEevd/KD/VMzK3s2nXeEntc5tdJhy87XkeYLIFj9T8WNUoRIQWSzVC
	 sLgUXq0Xtxfbw==
Message-ID: <3f8b2fbfcaf3185caf8a833375b335a5@kernel.org>
Date: Tue, 08 Sep 2026 11:47:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 61/74] drm/tests: bridge: Set supported HDMI version
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-61-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-61-bc12954a0688@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, "Algea
 Cao" <algea.cao@rock-chips.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Andy
 Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Daniel
 Stone" <daniels@collabora.com>, "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Dmitry Baryshkov" <lumag@kernel.org>,
 =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Helge Deller" <deller@gmx.de>, "Jernej
 Skrabec" <jernej.skrabec@gmail.com>, "Jonas Karlman" <jonas@kwiboo.se>, "Laurent
 Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu Ying" <victor.liu@nxp.com>, "Luca
 Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maxime
 Ripard" <mripard@kernel.org>, =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, "Neil
 Armstrong" <neil.armstrong@linaro.org>, "Phong LE" <ple@baylibre.com>, "Raphael
 Gallais-Pou" <rgallaispou@gmail.com>, "Raspberry Pi Kernel Maintenance" <kernel-list@raspberrypi.com>, "Robert
 Foss" <rfoss@kernel.org>, "Samuel Holland" <samuel@sholland.org>, "Sandy
 Huang" <hjc@rock-chips.com>, "Simona Vetter" <simona@ffwll.ch>, "Thomas
 Zimmermann" <tzimmermann@suse.de>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Tue, 1 Sep 2026 21:51:25 +0300, Cristian Ciocaltea wrote:
> Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
> supported HDMI version.  This is not yet enforced, but will become
> mandatory once the migration to the new HDMI connector initialization API
> is completed.
>=20
>=20
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
