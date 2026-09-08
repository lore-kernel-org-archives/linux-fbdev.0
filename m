Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135C73E6DE8;
	Tue,  8 Sep 2026 09:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861554; cv=none; b=fB3FxDaTNupUDSsWo5N03lyFdhpf4An+LHOQt9eRwCiP6PNLPlkvBogpea/EMli3F8c2/Z7hzFZAmpKblmbvHI54F3LSA6+Z7ErpryQFNCydJbfZdlbdeKe1sfAsvioxm9MGhsWgN7846wYlThdDDQ4tAvBvCl9d+cTIwZVLSgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861554; c=relaxed/simple;
	bh=WGt7z35ScZzwVnw7Km4hbFIpBLwdZOD14qMKx1Rrprk=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=fNZUJuILcSIk+56WItS/57/wTtardqfJapmm+60JEDbo+zdv3MCZ+MO4XMSoffldfmnxsZPir1g+yxebTagnQ0F8VKCXwGbYddA+u4xxyxJ4SApOrnWQKyJpNNBxqCAW3NgBckuasT8ZDAsy+uMS69FmB9T4vk3Kja3DVQHQ6IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B621F00A3A;
	Tue,  8 Sep 2026 09:59:12 +0000 (UTC)
Message-ID: <e2276f3d021d374a4638dd6dc899e24b@kernel.org>
Date: Tue, 08 Sep 2026 09:59:08 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 52/74] drm/bridge: ite-it6263: Drop redundant
 .mode_valid hook
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-52-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-52-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:16 +0300, Cristian Ciocaltea wrote:
> Bridges using DRM_BRIDGE_OP_HDMI expect connectors to be created through
> drm_bridge_connector_init(), thereby relying on the bridge connector's
> .mode_valid hook to invoke drm_hdmi_connector_mode_valid().
> 
> The generic helper computes the mode's TMDS character rate and forwards
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
