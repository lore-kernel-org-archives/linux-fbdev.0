Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8344DEC1B;
	Mon, 21 Sep 2026 15:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006081; cv=pass; b=KOu++6mCgTyzIIwKM94W4qvf4i9tJsc/9smGRAaaupP53bf55XZTiM9b7V6irtxZlsqNHNqCmDy+j/3uIWx+yeD02+GCqQ88dF7BPoBxTYuMcTkMv28SW0xhRHE6AbLaz/KJnKttr1bv8eXml7hxUVGhQUrTcXO7VH6f72D6HaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006081; c=relaxed/simple;
	bh=hgdrJmUY5WC2xIIO5U4MQbG/gE0OtfbomoZyNIZP+TI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8+ZxLfUUB+0H+SnIW+B9EjxOyvOp1I7zHpC1OkV7pWbOATOwjGGCOjS2Neydl0BrSFRtMZp0TZnZV+Vb9ipyiRkxk/wzz55PS0rcnb/Gs0rLwKTeHp18IKKcbZCKzRa8Qccx/5HpQjLcWrcLqOOrA9HK6tlwkJEIt+YI3872Ys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=U/5psYyp; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="U/5psYyp"
ARC-Seal: i=1; a=rsa-sha256; t=1790006039; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gLqMhLxXpe6hx53mTo4znLvDBS2WttlbDjGxey7roZkgGUGP2hM4BbFXAliT+dWI7ucpuALigVRVWMWjcr8GLkWf6sitqZ6Kwa2DN/YW4Jm5+VdA0tP5OFM2PbUZfgMqXxDJftNkeA5MES9KEmsy4nf8xLR8WGniJbJYOXcXXFY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790006039; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=UZryrWM94xhdFNiIc91FHkuUZmbywMObyi/aWoB7MIo=; 
	b=OT7gtSIKbWAIbk2sTJgFIMnBtLncQnXWOZvwsWmdo44J6rgtY2W/6UQvgUjcZ/nrLePrMRc3sEJtG4Q1J6QKsM3dH8kUv80NFLO9tcRBpwBGPNHh3IBOF7psiJGrKjGd4qIJx46+LV2GiAyr12dbEReXC13h3sOmjtrfbmsl5Qc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790006039;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=UZryrWM94xhdFNiIc91FHkuUZmbywMObyi/aWoB7MIo=;
	b=U/5psYypXBarRk0a70YMj3Tq6qmKHVnIGnHTv7n4Olwg7Xxgath/pbq9On6AKQG+
	kBBUc00bJd91NYSk8sJ6XuKMDJuJujQ6ggtLz09cTaAEIao2bt9pdB8XDWyPjin81RY
	6NCzwzxtudxmtAmpfDiAsdlV3B2DX7LTyQ9GhFr8=
Received: by smtp.zohomail.com with SMTPS id 179000603922831.181435721949583;
	Mon, 21 Sep 2026 08:53:59 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:47 +0200
Subject: [PATCH RFC 21/25] drm/rockchip: dw_hdmi_qp: Add QMS support
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-21-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2

Register the "qms_enabled" property on RK3588. This property can then be
used by userspace to request that a given VRR target frame rate on a
CRTC should be achieved through QMS. The common HDMI state helpers
implement the actual functionality for this.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index 2b9432aa8c54..01ed7c18a7e0 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -521,6 +521,7 @@ struct rockchip_hdmi_qp_cfg {
 	const struct rockchip_hdmi_qp_ctrl_ops *ctrl_ops;
 	const struct dw_hdmi_qp_phy_ops *phy_ops;
 	bool supports_vrr;
+	bool supports_qms;
 };
 
 static const struct rockchip_hdmi_qp_cfg rk3576_hdmi_cfg = {
@@ -541,6 +542,7 @@ static const struct rockchip_hdmi_qp_cfg rk3588_hdmi_cfg = {
 	.ctrl_ops = &rk3588_hdmi_ctrl_ops,
 	.phy_ops = &rk3588_hdmi_phy_ops,
 	.supports_vrr = true,
+	.supports_qms = true,
 };
 
 static const struct of_device_id dw_hdmi_qp_rockchip_dt_ids[] = {
@@ -709,6 +711,13 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 					     "Failed to attach 'vrr_capable' property\n");
 	}
 
+	if (cfg->supports_qms) {
+		ret = drm_connector_attach_qms_enabled_property(connector);
+		if (ret)
+			return dev_err_probe(hdmi->dev, ret,
+					     "Failed to attach 'qms_enabled' property\n");
+	}
+
 	return 0;
 }
 

-- 
2.55.0

