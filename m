Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D1843C7DF;
	Tue,  8 Sep 2026 11:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867983; cv=none; b=C0RXTMUA/iNd+9CSYD3mtaN8TJJFsyJ54G6Yf5y1nwiWwwQ9ggnXjTSkP/7GuSIfZo/o9hzl8nMAeewga2iS5BdWtdiqWxu/9gtNWTjy/s2E2DP2c/kU0GY+RthkQFOpeczHtbnPPxXfpU7slxwpQHkRBnZ2WB5C0Y7RK//sKj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867983; c=relaxed/simple;
	bh=KKQMxQUSlcIQGgrglSxBrfydwyh1DyHqfBU/q6byNVA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=P19LaFAPZmys5Ne3w3aRMKZN1W5F3GIeo6apKfUKFygILVhGPNrDpZ49AxBShqg/XxNk4pDq4W7iF81kAJh5IAVzFe4SGr89Ewzw1JnE1YsC+oFqW1jA4vTzz3y/7c78+LBZ6C7sRsGbs+b3ndah8Urw2m0O+7BnQqz8ZPpVpx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CWQLX09K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CWQLX09K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 389BD1F00A3A;
	Tue,  8 Sep 2026 11:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867972;
	bh=f2ufdAi6iSu3pTvcPoy0tUq5hT+a+J5hPm89qRLVaWU=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=CWQLX09KEKr34PuO3/HiRT5ISYG38N8NpIa3CLmXmDeuN0C4dJlz7vbqGR7Zc/XsZ
	 xkpnTFUYk7ffVxkEnwiDTSylk3JeWcsofNntzt13HtYEZQvGQKCpQuGYJsQgJeNBPs
	 0OeihzwkhTXazSwXZc2mOvlRR4ZHjCXYzyt9n0GZ/ERplaG9DuQ7EAsLjtCwWD8fms
	 3VLWTm60madjw/6IlaWP8w7Suhs+ShCkpzi2YbomcUfa2KHTqEk4OPx75SPJ5ve+rk
	 sQh6PYTK0eqpN0g9iWeqxHOBzYgWsd7M0zOFQVmAP6Mk3N1UKCBEVgxxOiFid2lwhK
	 f5OKrDJFI2GKw==
Message-ID: <5cd4202585d5d6a87a8614520efd0ed0@kernel.org>
Date: Tue, 08 Sep 2026 11:46:09 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 54/74] drm/bridge: ite-it66121: Advertise HDMI 1.2
 capabilities
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-54-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-54-bc12954a0688@collabora.com>
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
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>

On Tue, 1 Sep 2026 21:51:18 +0300, Cristian Ciocaltea wrote:
> Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
> supported HDMI version.  This is not yet enforced, but will become
> mandatory once the migration to the new caps-based HDMI connector
> initialization API is completed.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
