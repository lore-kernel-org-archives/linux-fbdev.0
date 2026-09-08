Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1053C3CB57B;
	Tue,  8 Sep 2026 09:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861532; cv=none; b=RthWylrO5rdVKvpxOAMrE8F06d/W3ZmEOejpSRJTXEGbNIhEx+w0yJtFtwoiysHjLWlZQXDqPerjHxI7UKsVRsv04xI/wk570IukxLrKL8x9vG6ydkl0szp941QEYaCy0WfYx+GRvIZ3Ik9EMI+ZxjWKwWVrUtEdbRyqESjT4K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861532; c=relaxed/simple;
	bh=J221TgZMfSARyG5x1do9FyaaAAuwRypeD+B6QQubkwo=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Gd/EZKXnMs6981K6atNLBUAiSk3hRXIS4ft/a5s0/JJ30y9LLa4RJdQjDDBeIvoqjAzWP5JmJ2W9ljiQgOuXniBYr2K4hGImn/XZ4Sts4lZvMw8iiCOq28hnId/HnqS1JqiwKljv3oU7S4m/Brjyg1rkHbZjgSV2eNvTx/rLw40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URYU6/qi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URYU6/qi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A8F1F00A3F;
	Tue,  8 Sep 2026 09:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861530;
	bh=cE2GIGpzCoTJfok5ialF83+vS2toupukOH7Ha7eEy2A=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=URYU6/qiDVZf8Bnwa3wJeFRuNJbuks2TgRJWOal//UegZQVZZMGJnvJ4ixFtBRVON
	 nkt9ubX3XDXScngwGHC9n7WJbZdAtFApQF5wKSAcAicX6j8ag4qkUyPDCWduJxFvNO
	 i9c5ik2MQso1iHtJXP3j4JKoyXmEf2f0DK27PAozWDIkrsp1rau7+i2UHOjACydIki
	 YbIibC+9eXiSHVBCEcB9FVbm4GSjnGg6qqFdYJnvaAMGosJkIuMEDG9kNnT/w+G6/m
	 LoxEc/UkkscsQjMDfpX/2JEbGaAIotd9v+xK924GpPZ2GEDxoHSr0RR/h8M9QBOAoG
	 sboGsRJqI2FAg==
Message-ID: <dbd7ce5178e8e3049486aa89798abcce@kernel.org>
Date: Tue, 08 Sep 2026 09:58:47 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 50/74] drm/bridge: adv7511: Advertise HDMI 1.2
 capabilities
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-50-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-50-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:14 +0300, Cristian Ciocaltea wrote:
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
