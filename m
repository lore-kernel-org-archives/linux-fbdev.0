Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F73354B1D4;
	Tue,  8 Sep 2026 13:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788872719; cv=none; b=JfKoOknA1T2O+mkbBiY5JKrLnAzlGUaIlW43czuDEJvfSrrcR7hICK8QtMKXNGvKghzK6xFjA78mm2/a06MkpuKu1DiRa+807lfVleanjXXx6aIl9oO+73faD4GgUZPFqFHa96tbz+pUGvFFsRioMrJuT3C9T6q+V5AeFxeYojU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788872719; c=relaxed/simple;
	bh=nlNEuebvIqPCaa1OEU50cG1bVgfde7HNYoe1wZRn7SQ=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Gyuz5MtfqnqdG0EbWCmvEEz7i6Gie2SQ1tlL5IaW7OfOvfhMLvghI3K+dd2t2MG3ztZzW8xXDgP96IB01hNKZYY09pJ99YGn3KPNbUbJXxjwhC/yI1iSKztqOBppSJ9IG9+9b2UfvdQ3eQflJDrCMfyDA5xhp5kuUFcfwa33Pns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BaRrzSMA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaRrzSMA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 038CC1F00A3A;
	Tue,  8 Sep 2026 13:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788872717;
	bh=aGTtaq+6H/MylUW1RWg3sjvRgbOJMdbhBr1FvgmlBNM=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=BaRrzSMAn8EfjT4wRWhWrmfDz3x8XeYQnqZBLLwgqh1oJ1Oc4pdvbE5XJoSjByxhY
	 2wvb+OFrl2a3PjTSpfVjroAfOBcmdBcjr2C/uLiDV6NXhYvHfwc3Ogfeu6T8HxwhVE
	 bgQkr067DWEIH4gYyjiZT6x5mozingz+yPwOfUlDIdVfasy+7VJBL9+qedyEzH2x2N
	 yhABRXMH7nDhhHoGKyOKtybXt6WT1qOJjcX95PUXYlIPpQ8ueJo3Brozfj2WA3T6E0
	 DylCu8/1RdTxJE85P/L4lVXfXnEJixtF20gT6+i25aXRiULJt0200kBuvjyVG0F3lK
	 TSpNFZUQvLO6w==
Message-ID: <0d05dad937047c8c8e18df7d5a92f89f@kernel.org>
Date: Tue, 08 Sep 2026 13:05:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 47/74] drm/vc4: hdmi: Convert to common HDMI 2.0
 scrambling infrastructure
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-47-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-47-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:11 +0300, Cristian Ciocaltea wrote:
> Replace driver local scrambling logic with the newly introduced common
> HDMI 2.0 scrambling support:
> 
> - Advertise source-side scrambling capability by setting supported HDMI
>   version based on the variant's max_pixel_clock.
> 
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
