Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568DB43C7DF;
	Tue,  8 Sep 2026 11:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868058; cv=none; b=pOBAi4AprglfyOG9gXMsoj8vT/kbyZ/3xwyplH2cRw2POGz1eMq52X0E5JWb8aOn8+xuhqfPZ3SEbV4/DI1ZUzgpFJJX9qlQgHf9KGK8JvCVXJ2QlALHmPrbTRDl+VmBS2yY7SXoF9K/Sh7UhHcTxjWquWMZ3PjD3zTws+zvKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868058; c=relaxed/simple;
	bh=jHjgRuvJii1Bau73xGMjyOwhz5kB9xMj+SOMIY58n7E=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=M9uuS6nRH23XFvyShYFwjgBRkk91fD3pru+V8EP0dc4B/Osurt82tWHyIP7iItq4R0hCDZonP0oPgrzr9u/y2vWr7+/D+uvNDsynDWNzSs3feJapTkrTvCHYz5De3Rx3JIg1Bp9l6dD3D5ovrMdno9NejU4aL9i7Xb+K68eG+dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQJYVkOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQJYVkOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4EF1F00A3A;
	Tue,  8 Sep 2026 11:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788868048;
	bh=Jhp7GY07oWtgx4+eRD3D6AU0jdo5ZC0oQmnbdRp7qjQ=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=dQJYVkOaLFUmuGJ3y9t87rV+WC6JytC0cDe6qJEfWf0rE6hPIAJzgfjjdn/mcBZpH
	 jxZFTfhyo71BxY+KjCcP/FtyitayNTieBC0r6K80L27le2OeLRPUT3sLGUngMp+WZL
	 sMrEaq+lcbduBKa3M/kv4gvFNeW892shI51zriF1MFx/QQKOIemR9KZ2HkZyLGfa2a
	 l6AIpLZtErjv03s8DD5Q97NxlRh7zboFqfdelA0SEmGZ49HA5/gn38o7zsMRDpb6Rl
	 nCCUre2QXd3B0SB5bJM1ch6Jct7iOC5ASKgITk3p4lJSw+Ve4a52o16DL5a7AbaQTI
	 Vo3NPWY8pUYFQ==
Message-ID: <26dc7e8210bbcc26f57f5b15dcab269e@kernel.org>
Date: Tue, 08 Sep 2026 11:47:24 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 60/74] drm/tests: edid: Fix conformity for 4K
 RGB/YUV 340MHz EDID
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-60-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-60-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:24 +0300, Cristian Ciocaltea wrote:
> The test EDID added by commit 54a5f1c4d5f8 ("drm/tests: hdmi: Provide
> EDID supporting 4K@30Hz with RGB/YUV") fails 'edid-decode --check'
> (v1.33.0) with the following issues:
> 
>   Warnings:
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
