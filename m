Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818F4A5EBC;
	Tue,  1 Sep 2026 18:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288679; cv=none; b=bpTdVYwJq7R3tND2QdUiZhrOhZezSfoVQQGpBc988bp5h5Y3c7p+S7mAV9h0MvwdS59VuY063GD6e1nb1v8AqZ8viSWAn0y3QfjsRjQ2Gvym/uMP0WW39TRPQZAFLW43MuG+SpkOd5QB1SRLLqOHfTFDfwQDOcrSAat1oyHM6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288679; c=relaxed/simple;
	bh=W2m7Jca/rq/QUZdEC4unu3AGFLZj7t3LTmYrZHCk2pg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XJKYKC5unZT3BdTnSd0Ujmw02HFee20LqrG2/POd585qOL3w3ULL6BhV8oUqXUjI3GJ/OCJsq7GehJX4xVuap+KOuy0T0CItQGNV496ajHhQ/lHX6aIbdophForTKlIbnKadTctbLFZ15AG85vI9uDxKlFNJ+Ei5yIDec5xs7ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=afu5ZwY+; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="afu5ZwY+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288673;
	bh=W2m7Jca/rq/QUZdEC4unu3AGFLZj7t3LTmYrZHCk2pg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=afu5ZwY++6AHuXAeUdfaaE/k7fwjw8A8eIfYHhGq7PeQ+VHPmh4saZg+PA64M/JqD
	 2p2DwtaA0vTxkk9RDdWGRfXI98CLxoFeKLSm5EwthG03ieYp/hibN/eQnpkLJ8KF9h
	 KBELgAwrYEAM5lg5ECHCJeYZVA1+I1OOHh2QWxAjpQF2I50ujMSSwiV5kOgW0IaJKS
	 TlrWTSD5KN80eSnqezCcBa2hOC51EdIfTrytXVVt0UPppj/FeeJz++u8HR8J22ZL+w
	 k2Obj7ScS1Ald/9H2dhEN17rDV1iiV9/NSI2lIzLyqD8SVvyMxazzaMat+gqLCfuao
	 3TqTRfg7WBo0w==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 87A8517E3C64;
	Tue, 01 Sep 2026 20:51:13 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:08 +0300
Subject: [PATCH v11 44/74] drm/vc4: hdmi: Switch to .force_ctx() connector
 helper
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-44-bc12954a0688@collabora.com>
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

Use drm_atomic_helper_connector_hdmi_force_ctx() as the .force_ctx()
implementation, so that the acquire context created by the probe helper
reaches the HDMI connector framework.

This is a prerequisite for converting the driver to the common HDMI 2.0
scrambling infrastructure, which implicitly handles SCDC state recovery
through a CRTC reset when the sink reconnects while the display pipeline
is active.  Note that this does not interfere with the local SCDC
state-management implementation, since the driver's scrambler capability
has not yet been exposed through the common helpers.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 26c63ce2dc2f..7c921a444e98 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -505,7 +505,6 @@ static void vc4_hdmi_connector_reset(struct drm_connector *connector)
 
 static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 	.debugfs_init = drm_hdmi_connector_debugfs_init,
-	.force = drm_atomic_helper_connector_hdmi_force,
 	.fill_modes = drm_helper_probe_single_connector_modes,
 	.reset = vc4_hdmi_connector_reset,
 	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
@@ -514,6 +513,7 @@ static const struct drm_connector_funcs vc4_hdmi_connector_funcs = {
 
 static const struct drm_connector_helper_funcs vc4_hdmi_connector_helper_funcs = {
 	.detect_ctx = vc4_hdmi_connector_detect_ctx,
+	.force_ctx = drm_atomic_helper_connector_hdmi_force_ctx,
 	.get_modes = vc4_hdmi_connector_get_modes,
 	.atomic_check = vc4_hdmi_connector_atomic_check,
 	.mode_valid = drm_hdmi_connector_mode_valid,

-- 
2.55.0

