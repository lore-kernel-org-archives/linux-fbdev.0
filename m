Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A364A49B3;
	Tue,  1 Sep 2026 18:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288678; cv=none; b=I09VGAZjX/7v5qchj2wAbra4NpSr9mGXHe74R2Kya7UrCiLpoX/2J5thMc+a6A3HFclsBCHM2Tz+F10bB5V24XfgddTdR1a7x6H/yQEWxRetwuLmaoM+0Bj5uQssGoZblwzjelY1WfpqfG0sK3qfcz0f730WmxZl2sZfTf+R9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288678; c=relaxed/simple;
	bh=/m8gvp9haym0x96FTKhsWUEIJdRrppjWdXwILaWvM/I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p1woAExH3iB6W28JEzG/ApV1tGzBdAjEtdfAI3EqV9kmov7R8UbIYW0ROcmnv9sftQpA5Ji0ydewrZvXGygRL/yo32cdLl6H8L8vbEExEf+hYS8fRehO+0wbwpN118PNuCdcY1OKSP4jwA8AY5w1D0JqLO19DTtjYqK78HVSnRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=lKp0llvs; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="lKp0llvs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288670;
	bh=/m8gvp9haym0x96FTKhsWUEIJdRrppjWdXwILaWvM/I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lKp0llvsFBoqhydalqLylbjoO5bbx3ZCCVGREnrs2nGAA0kn4YnhE1xDWKNaW0DVl
	 25x/81+PPFwLbLUyMyLcISRBbJGwlgmGOgvxySTYsxRi+Fq9sxXprTFVEm9edgEwHB
	 QWskiazOz+w+TyAvMUrTlC6ws+AmZpP28g5Zoxu72YZQFKJ8CFboTsvHYs9tIfxrLL
	 LzUF4l9ZK9IyxPFM0wH2Oybv8x0mfd6sHdOu+fLRy8K9X8HFCuVVCiOOil9IUdUX8+
	 Pc3w9wabFqUBzoEpVnjOUV2Z81OjXzjbOg47txbwQJsKoc2iBudiyydtPs9lF4HuSC
	 kTvXN0dLOkPjQ==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D298117E3C58;
	Tue, 01 Sep 2026 20:51:09 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:03 +0300
Subject: [PATCH v11 39/74] drm/rockchip: dw_hdmi_qp: Control the HPD IRQ
 line via the bridge HPD ops
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-39-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, Diederik de Haas <diederik@cknow-tech.com>
X-Mailer: b4 0.15.2

The HPD interrupt must not be delivered before the DRM connector is fully
set up, and it should be quiesced while the display pipeline is suspended.
On top of that, the threaded handler re-arms HPD unconditionally after the
hotplug debounce, which must not override an explicit disable requested by
the DRM core.

Request the HPD IRQ in bind() with IRQF_NO_AUTOEN so it stays disabled
until the core arms it, and drive enable_irq()/disable_irq() from the
phy ops invoked by the bridge through its hpd_{enable,disable}()
callbacks.  This ensures the line is only armed after the connector is
ready.  disable_irq() additionally waits for the threaded handler to
finish, so its GRF re-arm can no longer race with and override a
core-requested disable.

Masking the line is not enough on its own, though: the threaded handler
merely queues hpd_work with a 150 ms debounce, so an event taken shortly
before the disable would still probe the connector and read the EDID
long after the core considers HPD quiesced.  Since disable_irq() has
drained the threaded handler, which is the only site arming the work, it
can no longer be requeued and dropping it is race-free.

Use the non-syncing cancel_delayed_work() for that: waiting on a running
callback would pull mode_config.mutex, taken by the work through
drm_connector_helper_hpd_irq_event(), under the hpd_state_mutex held by
drm_bridge_hpd_disable().  That inverts the order of the connector probe
path, which holds mode_config.mutex while reaching hpd_state_mutex via
drm_kms_helper_poll_enable().  A callback already in progress is drained
by the system-sleep and unbind paths instead.

Note that IRQF_NO_AUTOEN is incompatible with IRQF_SHARED; the latter is
dropped as this IRQ has no other users.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c | 33 +++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
index ecf12403101d..1c547016ee00 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c
@@ -99,6 +99,7 @@ struct rockchip_hdmi_qp {
 	struct phy *phy;
 	struct gpio_desc *frl_enable_gpio;
 	struct delayed_work hpd_work;
+	int hpd_irq;
 	int port_id;
 	const struct rockchip_hdmi_qp_ctrl_ops *ctrl_ops;
 	unsigned long long tmds_char_rate;
@@ -308,13 +309,23 @@ static void dw_hdmi_qp_rk3588_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
 	dw_hdmi_qp_rk3588_unmask_hpd(hdmi);
+	enable_irq(hdmi->hpd_irq);
 }
 
 static void dw_hdmi_qp_rk3588_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
+	disable_irq(hdmi->hpd_irq);
 	dw_hdmi_qp_rk3588_mask_hpd(hdmi);
+
+	/*
+	 * Cannot use the _sync() variant: the work takes mode_config.mutex,
+	 * which the connector probe path already holds when acquiring the
+	 * hpd_state_mutex this caller runs under. Requeuing is already ruled
+	 * out by disable_irq().
+	 */
+	cancel_delayed_work(&hdmi->hpd_work);
 }
 
 static const struct dw_hdmi_qp_phy_ops rk3588_hdmi_phy_ops = {
@@ -355,13 +366,23 @@ static void dw_hdmi_qp_rk3576_enable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
 	dw_hdmi_qp_rk3576_unmask_hpd(hdmi);
+	enable_irq(hdmi->hpd_irq);
 }
 
 static void dw_hdmi_qp_rk3576_disable_hpd(struct dw_hdmi_qp *dw_hdmi, void *data)
 {
 	struct rockchip_hdmi_qp *hdmi = (struct rockchip_hdmi_qp *)data;
 
+	disable_irq(hdmi->hpd_irq);
 	dw_hdmi_qp_rk3576_mask_hpd(hdmi);
+
+	/*
+	 * Cannot use the _sync() variant: the work takes mode_config.mutex,
+	 * which the connector probe path already holds when acquiring the
+	 * hpd_state_mutex this caller runs under. Requeuing is already ruled
+	 * out by disable_irq().
+	 */
+	cancel_delayed_work(&hdmi->hpd_work);
 }
 
 static const struct dw_hdmi_qp_phy_ops rk3576_hdmi_phy_ops = {
@@ -584,7 +605,7 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	struct resource *res;
 	struct clk_bulk_data *clks;
 	struct clk *ref_clk;
-	int ret, irq, i;
+	int ret, i;
 
 	if (!dev->of_node)
 		return -ENODEV;
@@ -688,14 +709,14 @@ static int dw_hdmi_qp_rockchip_bind(struct device *dev, struct device *master,
 	if (plat_data.cec_irq < 0)
 		return plat_data.cec_irq;
 
-	irq = platform_get_irq_byname(pdev, "hpd");
-	if (irq < 0)
-		return irq;
+	hdmi->hpd_irq = platform_get_irq_byname(pdev, "hpd");
+	if (hdmi->hpd_irq < 0)
+		return hdmi->hpd_irq;
 
-	ret = devm_request_threaded_irq(dev, irq,
+	ret = devm_request_threaded_irq(dev, hdmi->hpd_irq,
 					cfg->ctrl_ops->hardirq_callback,
 					cfg->ctrl_ops->irq_callback,
-					IRQF_SHARED, "dw-hdmi-qp-hpd",
+					IRQF_NO_AUTOEN, "dw-hdmi-qp-hpd",
 					hdmi);
 	if (ret)
 		return ret;

-- 
2.55.0

