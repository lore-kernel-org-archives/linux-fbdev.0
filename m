Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547034CA798;
	Tue,  8 Sep 2026 09:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861543; cv=none; b=qwTiY1cntsYECbHcRMniv01Jfct+qndEmprl7jGy6pWz7kRg0zUg4cqhJDpLas+HYxZQTmkoLsdgfN2BrNLSz7Fzy97W0j+bVA3nKo4G1V0cfb8o06Bo1KP9QoEt+8sg/vcOcOu6oqE8XXVUuraBIgxdXh9oooNpSJzmJzSVUs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861543; c=relaxed/simple;
	bh=BF3RfRvcy38/pR2FwVmnhOtEyo2B0tTxkwbJhydVc5o=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=jV31PiEXUsyfFqmnh4XO6lbb+C04tkI+X1LFupoWAkiBiJpZb3cHJ8PF27caWNQimAxi0pLXO40jYFMYAJH9FMj8PYw29U22vl9Dn3yhMRWj3BexhRkO5v5WB2Ayl3J2IyHXUbX4h1SyQh0FOwaOHLxqxzpwtiLQ0YSvEllIQuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g0Dxy9so; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g0Dxy9so"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B05F1F00A3D;
	Tue,  8 Sep 2026 09:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788861541;
	bh=qJfUSJRCevtsAlee5fpqTfsNMuEH2eYAYjOny6uC7L0=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=g0Dxy9so8FfejqBtHuaG1lGFytbhTY/SYmnz7lxKGGPNFXJY6tksNCGAhMyyuz15c
	 A1HNknCOxFfkHm6oOjSbAspjVqXSKeptEF9ZCyFxezvuTAYWoKFqlUZ1Ic7jvWXwT5
	 7GZ/dYJqH8NTJlT6M3WcwIsCVLPKvLaPgU6wB3+eFiK5GMpwwkr651FofVo75WXkmL
	 tJEnmWfvy8w5HZ1GjjHqkEiL/+zDadoFTrSWGanx07uUhYjBr2I7rx8Wa+kWpePwYQ
	 O2qdzxGEg8NNjpa5m0fLxr6dMhZNw/OEgJuPqJxDqgSwis8L1EJF3ZExrowhezZVxL
	 QxBfCrjhil0eg==
Message-ID: <5053a2775eb9b2101ae7725b497912bc@kernel.org>
Date: Tue, 08 Sep 2026 09:58:58 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 51/74] drm/bridge: inno-hdmi: Advertise HDMI 1.2
 capabilities
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-51-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-51-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:15 +0300, Cristian Ciocaltea wrote:
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
