Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380DA513568;
	Tue,  8 Sep 2026 13:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872688; cv=none; b=PGALPIuf78YiQZsx/0zFxjc1je/uToleaZbRUnRDFsBMaj+xrpySUNKcfjWohkQH5tw4xIU9v46++GCwfRI5w4NnTAVMg2Mng9Qc6CwgYWwaIxc7KOaCTR7Sl5Lf7+0+IlcRsoCDoMO6CJ2qzEUVJlhpfEGwS9HghUSTbLBQ1+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872688; c=relaxed/simple;
	bh=TWsqc2hmMoTS+LukWCXIXcfxrsBcDp2qVzqzJMX72FQ=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=nQR3fs+OylKJ44NvICTrCX4d9Pofsj5g1lu6kVWcPUgNmmBTvZTvmRsNFP5cO55siF8J6UVfIcGHC6sCLO4xg8aafQOTG1UEQNNr1sBfrvhWEIk/suqrmRNSjuPII+zr468obIXj7SFKgh+qJEUh0sc2IxNV3xq43IyRT6kVZ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GME5OEfm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GME5OEfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4F21F00A3A;
	Tue,  8 Sep 2026 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788872686;
	bh=0c6VVgpgr8QRvVK0L3AA+Ya2VGnRG3C/SeaIoCEOEIw=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=GME5OEfmBM3W0vV/lVcz+5iVnZEC5ckUSFlvI8uKcFRfnIi/d7yvCw33IdTcWPrOG
	 +ODsMzky9dGz8w1QvGQ90Rjxbc6478UAnrg7p0yiOWzjOSF7WU7wxuE4NUxRanh3EY
	 J5K091ChOVt841MVIvPiboxtyhgRplOqOOGj15aUxNb1vbrf5IZl/UbnwkrW5qD87Q
	 Ov23nnRh40+Y3J/7ubOvVyg/lyu1P7SFBrsi4Q6EDRPLYoKu2jm4Xv30Yk+DFrdsJn
	 XkOmt3S3WSQ7t2wPuUTZli7yc041+BiDeff9S74+zS6fP2gdhUrypH5nX4llhwjzd3
	 3Dk7FHiMKatdw==
Message-ID: <0ec40db90bd0d2ece46b185deb3c8eca@kernel.org>
Date: Tue, 08 Sep 2026 13:04:43 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 45/74] drm/vc4: hdmi: Propagate -EDEADLK to the top
 level
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-45-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-45-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:09 +0300, Cristian Ciocaltea wrote:
> drm_connector_helper_funcs.detect_ctx() is expected to propagate
> -EDEADLK so that context owners, e.g. drm_helper_probe_detect_ctx(), can
> perform the required backoff and retry.
> 
> vc4_hdmi_handle_hotplug() instead runs its own retry loop and calls
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
