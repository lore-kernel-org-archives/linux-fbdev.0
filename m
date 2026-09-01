Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951CA4A5C3D;
	Tue,  1 Sep 2026 18:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288692; cv=none; b=GB3dQwoeD53DDw4QMNqKy+V+fw9uiEb8+sEJhW/ocLyFCqExAWFZjTdxtdr6r3F9ZSyR1ZkbYESQpaPmuyoFFTuRXO4XojtE29RFbJBpXCviS9BRU7/xsJVlmuhK64G6/oP/hgaiqX1S8TE6zlwHMNhlnlcc87KkUiQL4yQq0lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288692; c=relaxed/simple;
	bh=9+B0lSYbOtT/mNa8n8pzlwF+N7/unRvesgf3I/R8mRg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gjvuH+OMTGOhdmTeqj904onnwyksD2jQbpbOR6tQoK0NVlDtnAiwYbX2o4bUkbq1gb+ZrXPdgrlqzyg6mNxH1iFo6gCW9ZZjzPQ3y1cB9c9S5ohoQmwndM0Pn4vFc2NSmNarkBV4avbiMMG/hobp/EbzhEvCvf6M7O4IjIzcVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mOE/zo47; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mOE/zo47"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288686;
	bh=9+B0lSYbOtT/mNa8n8pzlwF+N7/unRvesgf3I/R8mRg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mOE/zo47NqcktPeFz6KITCmmEVvDv/qiq04xSJ1SJVWtzw7hAOUd6GhIJEOXOPaPN
	 lQ1/6SZsU127+3kZQIZYYW6tpGsm5pJYRywXFHWl+heVB+OwAra/QRGc7zkBIj1NCI
	 fjxamXAaXgxZ/AgM/NBpYF0x8NFHba13o9q0aMHM8cULUfa9UcRDhxrPPrP/ws6TfQ
	 uatxnHtbLsO48lY3FopDf5cd8R3o7+cQFis0OYzEEucpaC68eXrfZTqUsFY9nbJ7G4
	 SAAcHiEobWwb22CeTi9i7+qnb0SJNf54Mmocjte5VwyGSfqgc2fNkpowdWU+6uCHlU
	 mjYLy8m7wGEGg==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E4A6D17E3C8F;
	Tue, 01 Sep 2026 20:51:25 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:51:25 +0300
Subject: [PATCH v11 61/74] drm/tests: bridge: Set supported HDMI version
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-61-bc12954a0688@collabora.com>
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
mandatory once the migration to the new HDMI connector initialization API
is completed.

Advertise HDMI 1.4 as the default for the test bridges, since that is
the highest version that does not require additional initialization
data.  This also avoids implying support for HDMI capabilities they do
not currently model.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/tests/drm_bridge_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/tests/drm_bridge_test.c b/drivers/gpu/drm/tests/drm_bridge_test.c
index 15583ade8494..a445f71c31b8 100644
--- a/drivers/gpu/drm/tests/drm_bridge_test.c
+++ b/drivers/gpu/drm/tests/drm_bridge_test.c
@@ -497,6 +497,7 @@ drm_test_bridge_chain_init(struct kunit *test, unsigned int num_bridges,
 			bridge->type = DRM_MODE_CONNECTOR_HDMIA;
 			bridge->vendor = "LNX";
 			bridge->product = "KUnit";
+			bridge->supported_hdmi_ver = HDMI_VERSION_1_4;
 			bridge->supported_formats = (BIT(DRM_OUTPUT_COLOR_FORMAT_RGB444) |
 						     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR444) |
 						     BIT(DRM_OUTPUT_COLOR_FORMAT_YCBCR422) |
@@ -597,6 +598,7 @@ drm_test_bridge_hdmi_init(struct kunit *test, const struct drm_bridge_funcs *fun
 	bridge->ops |= DRM_BRIDGE_OP_HDMI;
 	bridge->vendor = "LNX";
 	bridge->product = "KUnit";
+	bridge->supported_hdmi_ver = HDMI_VERSION_1_4;
 
 	ret = drm_kunit_bridge_add(test, bridge);
 	if (ret)

-- 
2.55.0

