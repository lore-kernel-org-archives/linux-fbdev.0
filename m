Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C960053A8A4;
	Tue,  8 Sep 2026 12:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871729; cv=none; b=Xav4aRjWSf+OL742V/ii15cuWWm1loNOKG2qZxbsgAdcs0c/oqzTgk3elF7vvxRIXmIkJHfSH3lZizV4EWBJnze80DyvByC619zzx2ZJraWkPjb4o9jzubgzILjRIgHUbVLBxj472LwA/B/r2WBCJK43IDPzH5YCXhGw/QQ2oRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871729; c=relaxed/simple;
	bh=F9sQc8zuXkg2ojqpknNg8kftWecSZ0yQrTcHHIV3+jk=;
	h=Message-ID:Date:From:To:Subject:In-Reply-To:References:Cc; b=Qz6pVGypbglkc4ZWUva3NnZfB6zaAH75FRRX83ZtNsBKDznb5NmDpIQ4Ko8etLmJP7Fd1LsYLzZZI48KDfhC52cDhPu1KumwM/CNNg17aNEh2WykgmnVvui4weG4jejM/4NXMnYyuLpI/lsRNGlO7Bv8CkcOv7z8UZZvw/OH6D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGVT7l2S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGVT7l2S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33421F00A3A;
	Tue,  8 Sep 2026 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871728;
	bh=IWzC+cpScHArEofhHNJdNazquTsIhUyNEhIyJg+5Scg=;
	h=Date:From:To:Subject:In-Reply-To:References:Cc;
	b=GGVT7l2S4dESIgGS20pfkuiT/kBX5QGIuTktZdB39zP73d8Yu9LrsKJWJam7JYlk/
	 wqE7xxZs8nprYX0lgaWzT5BiQz0xSZONqZms45Pl8vfxUOALaer+pOXuPnO/FolRGK
	 wYHlDGo3ER9gSlUomxfRNcRhT98rS7Yf1ZKhaGAfMxi5JPTUMjj0OkDIcS21/t0YYS
	 dTkBVl5wr2BkzbLaSAvbES7tpVbATHIciB/NGmbG/6pE7YJj+sLNCY3frTCNbdim89
	 aKaWPeUg7YyGcxX7EktwlvKhfj+M/l9ZBO9L0yUE1cKiT1l4FIOawGB0t1Mle0kI3z
	 4Xd38HFf0Fvsw==
Message-ID: <35fa469d86b8dfba50d755c525dac0e9@kernel.org>
Date: Tue, 08 Sep 2026 12:48:45 +0000
From: "Maxime Ripard" <mripard@kernel.org>
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Subject: Re: [PATCH v11 23/74] drm/display: hdmi-state-helper: Sync SCDC
 state on hotplug
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-23-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-23-bc12954a0688@collabora.com>
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

On Tue, 1 Sep 2026 21:50:47 +0300, Cristian Ciocaltea wrote:
> drm_atomic_helper_connector_hdmi_hotplug() does not currently
> synchronize SCDC status on hotplug events, leaving the scrambler state
> potentially inconsistent after (re)connect.
> 
> Hook drm_connector_hdmi_sync_scdc() into both the connect and disconnect
> 
> [ ... ]

Reviewed-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
