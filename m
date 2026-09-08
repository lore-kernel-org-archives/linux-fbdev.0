Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A3C530E0D;
	Tue,  8 Sep 2026 11:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867996; cv=none; b=YTMAyweY8SSigyMREnxfUFP4Xs/HkWf6EtRVAR9t87kAj3Ahid6lKX31PWICQA2GA5knQlRP0MzkSzCe2WqPPUHRwubXtaKvNSeD99rNHUl3d/3CIyjdDz9oz5PibI18oetO9LEWIi2MNHiIcMcmot6KlMjWmHfdSL8NSQcgLuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867996; c=relaxed/simple;
	bh=672q7i7h8c1v2iRErqv/pL6qaNKFFLVjNF8SX8KgIys=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=oFEwxpajhe3D9tN0/urMbl34i8ZAD/DEUmNgH9Dvt6bf2otm4yAmCViM+JTSTg/IX4MpW7Iaaqy76vou+Lx94nuk/JMuKkeekXLhpewrO7BPqkhaxpPbKt15dGfd2dnJNB5tWpC9ragfRPf7jsXlBD/StcDCbzkX4TQTYTt9Qw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H/ekudPM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H/ekudPM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF17F1F00A3D;
	Tue,  8 Sep 2026 11:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867983;
	bh=Thmzt2bA5oDRdHIBsmWHHi7LxhCvKiJQFfK9uAWWp6I=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=H/ekudPMgJ3J+jTc+71sHPNQdwtVeyDUOof+Ch1isOl1fL3ScUIpdBNrFFqFvZU6I
	 6kZRGvza+AIlaSsGfs73K892T969F/JfZN8wJVkD3c2QIMdhiUKU0x3wAV84RnNvuw
	 kGAfT+S8Aq1qdy0I46HqN9BrFP+/78pv8K3lIWiQx3Bm0SFhcW2H+kNeGkdTJMQsxQ
	 s8yC9yidBrK7ZaKyU3nZmDUVRuXLFWXdyZgElpaBUDAB+lK/Wolr1Jh5cy/xBx3eLe
	 if6LnlxqxBuD/bx6L7aQjhh0pH4ESwSs2nUoFr6La5hceGZ4hhHNmfR7gUvg2zoCDT
	 nN4MvN0BYenmQ==
Message-ID: <a609592dd139aedc19fa400cfa55c048@kernel.org>
Date: Tue, 08 Sep 2026 11:46:20 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 55/74] drm/bridge: lontium-lt9611: Advertise HDMI
 1.4 capabilities
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-55-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-55-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:51:19 +0300, Cristian Ciocaltea wrote:
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
