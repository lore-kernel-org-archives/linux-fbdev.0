Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84B34A8A1E;
	Tue,  1 Sep 2026 18:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288688; cv=none; b=XVBs2kqqD3F6DeC1zeQVga5K2XpHIE3Eftzc3fyefU2NmB4PZQw20R61U1j/4svS12tQbtjFFDJ6Gy0yQ6QQeCn/M9KahbCq16BzO8fTbf1a2Ak+fmbexoOABzZmWgbGJEzOOsSJMEmJAF5n2m2sptCMRI10v6CR3FSJo5CPU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288688; c=relaxed/simple;
	bh=lZUSDt3QSXeFHF6VV6Oc9j8qitYrzw5Nsf6oI2hLSn0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OSjRNfEb2kmUC7HPDxPL4FG+QpG1JV8S2gBiCIsqgaLbf+uac5i7Cf30ai1G9OluTx1qdmgxWP9H00lTsL7Li5tYgZRQ+FNfxHKJtteqXYm0/RAokl8DmHg7chH1GTzgHFJS3D3HhStz3iPXoQAVJOoRZqGyCYcMrxSCEx9pLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Ls9nlQpn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Ls9nlQpn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288682;
	bh=lZUSDt3QSXeFHF6VV6Oc9j8qitYrzw5Nsf6oI2hLSn0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Ls9nlQpnLqPTXQcg89AYQ6rxTbLiRLtJ1kMmTqWladWfS/RbOyvkx5a45wiBHVx5I
	 fBRmwnL802tyz1RaJMscAzZiax/5HvDoGiWQT4KCx+3aFpg4avHTyQjI2NlkWD0LKE
	 K2r+W3ltMnRJHVTJ+x4ZHX8WBwqYdPscWBS9VU6xrcIm4ooqWZApU/kHsTGxYiYUB0
	 seefaTRZA9lNnydjbM1jDOR5KyOG9hVNSFPUc14+HLWBvXlsqeWdRn1veFNZ3iFP0B
	 NN4KQZx1Whw78XCY4vOEBMtlXcbsh9LqNgrJCqimMhH9ZEvef6Sb2bYZGo0zORo3TP
	 wZTa0xJOj/DPw==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 4E34D17E3C85;
	Tue, 01 Sep 2026 20:51:22 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:20 +0300
Subject: [PATCH v11 56/74] drm/rockchip: rk3066_hdmi: Advertise HDMI 1.4
 capabilities
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-56-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org
X-Mailer: b4 0.15.2

Bridges using DRM_BRIDGE_OP_HDMI are now expected to also provide a
supported HDMI version.  This is not yet enforced, but will become
mandatory once the migration to the new caps-based HDMI connector
initialization API is completed.

The RK3066 HDMI TX supports HDMI 1.4a, as described in commit
f84d3d37b7fb ("drm: rockchip: introduce rk3066 hdmi").  However, the
driver does not currently enforce a maximum TMDS character rate, it only
filters non-CEA modes and excludes VIC 1 (640x480) via the .mode_valid
callback.

Advertise HDMI 1.4 support for now so that modes exceeding the 340 MHz
TMDS limit are rejected by the core.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index f28d6a883e09..f748700b0ba6 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -14,6 +14,7 @@
 #include <drm/drm_probe_helper.h>
 
 #include <linux/clk.h>
+#include <linux/hdmi.h>
 #include <linux/mfd/syscon.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
@@ -712,6 +713,7 @@ rk3066_hdmi_register(struct drm_device *drm, struct rk3066_hdmi *hdmi)
 	hdmi->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
 	hdmi->bridge.vendor = "Rockchip";
 	hdmi->bridge.product = "RK3066 HDMI";
+	hdmi->bridge.supported_hdmi_ver = HDMI_VERSION_1_4;
 
 	hdmi->bridge.ddc = rk3066_hdmi_i2c_adapter(hdmi);
 	if (IS_ERR(hdmi->bridge.ddc))

-- 
2.55.0

