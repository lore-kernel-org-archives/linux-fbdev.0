Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90C0D4A3874;
	Tue,  1 Sep 2026 18:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288666; cv=none; b=iC2f/ACrIg0kGCINOyX2er2rZtKJ0MKmAXGjxIwEVX1z/G2ztqmR7RfL3lffoaoB/h10toRVkKJqHklY2asxNdxOovwVSp2qLJQzCGBzEE/dmqtU+5U0uo2hRyDffCgS3u7U7ctQQlRZBNHdLpha/++dmHbRxzq0nxN63aXYMYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288666; c=relaxed/simple;
	bh=Np7wpAYZLHRt1c9crOqakHGhI+KoSOWphtz4jQaYs5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUjwX5BycirukC5zgfmqNNaUEHjCk8G4Eu1GSy/Xl15GQZU+p99BKldaRP3yJP3JBsljzgUX4bH41ULMOWw16WXLI2C8dy6kQMi05Qx+oPJAmSVy7tjAiiKLpNz68h20CoIKa1km8ZFXxFoBf+qGjhVrJWS+Dk7+WwO4tKsTsIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JR+grpfv; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JR+grpfv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288660;
	bh=Np7wpAYZLHRt1c9crOqakHGhI+KoSOWphtz4jQaYs5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JR+grpfvhJdyZRSqjI1L5Q/515KONS70bTEa1h5vxrNspDVf0zlUyN1Zlsc3RQfmT
	 x5CGZiH5ZQfOuAUqLXPaimcWxT7+VXaRCzE1PWdvi/PsrwXFK8zubDyTrpInyAkgzp
	 YLO57D1oCv5ZLmdfNKDzSKtXraBIqSCAdZjZR4Ny9mB1bhiCtP/oHihaPimXriuFWa
	 2KiZnLBL+PC40wHA51pzsNgGFZ5XQWwwyJDABzGuJXcJJXzUeYNF4wrK4s7pK7lt7o
	 OgW9oZptMGxmSoN4pQvYuavaKqc6Z2BL0XZ0ZpSyYALECgrEPLkZhv9/y76bJJo1my
	 XaZOjm8rg+FWw==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5D5DC17E3976;
	Tue, 01 Sep 2026 20:51:00 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:50 +0300
Subject: [PATCH v11 26/74] drm/bridge: dw-hdmi-qp: Rate limit i2c read
 error messages
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-26-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>, 
 Diederik de Haas <diederik@cknow-tech.com>
X-Mailer: b4 0.15.2

During EDID reads, repeated i2c errors can flood the kernel log:

[   25.361716] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[   25.363376] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
...
[   25.368671] dwhdmiqp-rockchip fde80000.hdmi: i2c read error
[   25.369440] dwhdmiqp-rockchip fde80000.hdmi: failed to get edid

Switch to dev_err_ratelimited() in dw_hdmi_qp_i2c_read() to reduce log
spam while still reporting the condition.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
index cfd1b18c06e6..7475b6b71836 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
@@ -561,7 +561,7 @@ static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
 				dev_dbg_ratelimited(hdmi->dev,
 						    "i2c read timed out\n");
 			else
-				dev_err(hdmi->dev, "i2c read timed out\n");
+				dev_err_ratelimited(hdmi->dev, "i2c read timed out\n");
 			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
 			return -EAGAIN;
 		}
@@ -572,7 +572,7 @@ static int dw_hdmi_qp_i2c_read(struct dw_hdmi_qp *hdmi,
 				dev_dbg_ratelimited(hdmi->dev,
 						    "i2c read error\n");
 			else
-				dev_err(hdmi->dev, "i2c read error\n");
+				dev_err_ratelimited(hdmi->dev, "i2c read error\n");
 			dw_hdmi_qp_write(hdmi, 0x01, I2CM_CONTROL0);
 			return -EIO;
 		}

-- 
2.55.0

