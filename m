Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA1F530E0B;
	Tue,  8 Sep 2026 11:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867967; cv=none; b=lZ/Fwws0QWhnjBRVFY11jndSPTai8MOIOGEblK1amjf9evKwsqTUHoLj00YptHRg2Ujgc40esbeOco6i8dpb+6kKzTTdfYjibdkOCsJqFG/K4QPGFM8y+s32SsJUfeUd2LJ3ZIC3l+A/A6zN48FJgHBee6aTfz4qf+JGplaVKC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867967; c=relaxed/simple;
	bh=5KS2yUbUBZqpf+abxjeqJMpMQckfzOO25qaAP9stJDA=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ov/qQDP9etKvWRcY59ptz9SF6MMgzriQq+hWUHplc7S5tIpgMato+Dt9HYKEPRz2CW3QuBL3TSPx4zs/jrYap8dwaNR5nDwDXNdn1MjCvhiSv8bBMKOZGP0eIprxenApbetw9wSv+O9xuSiMujd9AbOAUs06LEvFi7a7rBtL6fA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LscrDB6y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LscrDB6y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE581F00A3A;
	Tue,  8 Sep 2026 11:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867959;
	bh=TvBcVAP7Xte4hXp7tFPxbcEIaY+sVDfeQbUwhJkefGo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=LscrDB6yAvYsoaiCWf8QXN0O6I7bifJcbOF7U4O8uKtXUCUcqEtwJTEpYGh8z096y
	 UZap/ZBSgwgccuCNPAANeC5d5s7JtHhfc2ufRCxyKjmdZ25ZHeSn4AN6NjSYCcGkch
	 OPNtcHJ2IjF7ecPLyuFZDFY65+GkhGFdDt3GpnIljs+Nus3ae5bPNNSLLydzDu2ReF
	 K+k36WA6LSvxxJ+bn91YMxCbC59qfoSIpIPaDOZ5bq04glFVLdduxU8rFvtMFjO2EC
	 8Fa/o3Gklu+85jRk5b1r64W+WeIxXolQIxLM5SWifV4HlacWHVYeuStJlRFrCInl52
	 daZWO5GF5faew==
Message-ID: <d24d2bd88c66ed1b110b1035f7d09e6e@kernel.org>
Date: Tue, 08 Sep 2026 11:45:55 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 53/74] drm/bridge: ite-it6263: Advertise HDMI 1.3
 capabilities
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-53-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-53-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:17 +0300, Cristian Ciocaltea wrote:
> Bridges using DRM_BRIDGE_OP_HDMI are expected to provide the supported
> HDMI version.  This is not enforced yet, but will become mandatory once
> the migration to the caps-based HDMI connector initialization API is
> complete.
> 
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
