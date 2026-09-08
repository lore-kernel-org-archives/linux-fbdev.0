Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B23ED374A1B;
	Tue,  8 Sep 2026 12:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788870438; cv=none; b=gHS7KIIArtamyj0KVrro2UVuQlZSeFNne/nSbCiJ8MxCz/ASStACfsRxOfV6hf4G32GjuC5bVEnn4VeLO9R6NXWAiaJH+bxBjQTlLqgFSzZnTxUt9EbL06J1wjfmUZZBtjntYErBqdal/y33Tm7tz+i04FEuzxsbvz79TfyexMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788870438; c=relaxed/simple;
	bh=9uvxCapjI4rnsF74LxQSOyWBvkiTodNoDkDsxskLB84=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=ZurUT1Wg3p/mJR2RFXiQ8lnVumIQmLh2dcPsUeJGk4YKUdxfoQHT8UYFIL5v7++n1zTWAg9L+yj+GYVwPtBAWnhe1vGdaoa5jSxVQokd/FOP6rA8IMu5Qr2i1NrA1a/4nYkLaR+8n4GZvkWedLvd9+HyqOcvKKjaAiBFfR9F9UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+OZxDzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+OZxDzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16D21F00A3A;
	Tue,  8 Sep 2026 12:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788870437;
	bh=fzGtfk86Cjb9SfEfKKT3CvCMk5MzBMJhuuAr5zCkHDo=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=T+OZxDzmFhtwfxQUDigQV8iYgcmk1nVuS1p5I+fsWVjs6z/Foia6U8gnM+85CdD1q
	 8e3kEiGLj5EIgbAajVqBFp3BmOAhliLVBkj0EbrxHbdhYj0OvlJS0h96Wd2S+Zj9Pw
	 7jOLuBaY9BnvA7BAYgHvOcpQ/qlhcash2+du7RPJj3Ph3VhFr8SidngLg0LGPcaCmi
	 AiUiql/fUlpQrSx5KSbjx7cz3fJozZD1rnmNxtYPXWQanoXM8F7rp7I5rKC3oSnfTg
	 bPCZucNWjKUAAFXBzd2Q2OYiVjpAQTRt9a1cBETRT1WfyVUGh1JI/NJQbQA2+FmK2j
	 Duxwa0xZf8Fsw==
Message-ID: <d251e4005c5bef3e1cf1cd49abe0e1bb@kernel.org>
Date: Tue, 08 Sep 2026 12:27:14 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 07/74] drm/connector: Add HDMI 2.0 scrambler
 infrastructure
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-7-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-7-bc12954a0688@collabora.com>
Cc: dri-devel@lists.freedesktop.org, kernel@collabora.com, linux-arm-kernel@lists.infradead.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev, "Algea
 Cao" <algea.cao@rock-chips.com>, "Andrzej Hajda" <andrzej.hajda@intel.com>, "Andy
 Yan" <andy.yan@rock-chips.com>, "Chen-Yu Tsai" <wens@kernel.org>, "Daniel
 Stone" <daniels@collabora.com>, "Dave Stevenson" <dave.stevenson@raspberrypi.com>, "David
 Airlie" <airlied@gmail.com>, "Diederik de Haas" <diederik@cknow-tech.com>, "Dmitry
 Baryshkov" <lumag@kernel.org>, =?utf-8?b?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, "Helge
 Deller" <deller@gmx.de>, "Jernej Skrabec" <jernej.skrabec@gmail.com>, "Jonas
 Karlman" <jonas@kwiboo.se>, "Laurent Pinchart" <Laurent.pinchart@ideasonboard.com>, "Liu
 Ying" <victor.liu@nxp.com>, "Luca Ceresoli" <luca.ceresoli@bootlin.com>, "Maarten
 Lankhorst" <maarten.lankhorst@linux.intel.com>, "Maud Spierings" <maud_spierings@hotmail.com>, "Maxime
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

On Tue, 1 Sep 2026 21:50:31 +0300, Cristian Ciocaltea wrote:
> Add the connector-level infrastructure to support HDMI 2.0 scrambling:
> 
> - A drm_connector_hdmi_scrambler_supported() helper to report whether
>   the source supports the scrambling capability
> - A .scrambler_{enable,disable}() pair of callbacks in
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
