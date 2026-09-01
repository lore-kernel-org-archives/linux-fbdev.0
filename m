Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEEA4A262B;
	Tue,  1 Sep 2026 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288661; cv=none; b=TaP2VwwBv4GsuMbGZe1Q+cQaiA0ARUKU9Yt6MGbVTWONyyr7wNBfw3YyJ3u7SnKWKV4v6LGY0WOektng2X21WIv21JwhZIvu2tS9+f7HBfROP/K4HABN7n9LMN3QAG8Y0guYvuleKaZ1C1+x/5l9TuMuWapfz40HQgDyv6SDLM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288661; c=relaxed/simple;
	bh=vC1ePJhBclg4QnFEqL+ZBqQ2Dmw2tOM/83/2vVp78Ek=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rCeujUP+U/uxFb3ChsI9+JVS57cDfl7xYvGROWz+PC6kl7fxLvJyi+CVEebv+VRzSdyJ3l2IpcRWJWHOXCFVAsQPe6Wmi6KEL7/n2pWPziBQ3cQyuqyrJKqHUMieemQGI+22pZCb+0lBj1RP2MZ7bhBhGmooFap6MBcSmtKT2Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bk9a5vj5; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bk9a5vj5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288656;
	bh=vC1ePJhBclg4QnFEqL+ZBqQ2Dmw2tOM/83/2vVp78Ek=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bk9a5vj5KKQVpC88RRIhX6/+gQ8prDtm29SgwjSvO03T1k+MLbnPRHN1ZXz6gEy0e
	 IHBj4ClJaFr9GX+ox7Fj3AjWuwxj9K2jqRamOO4VE01LcfddZ7ilLykVutLeNEy8uC
	 D2EZkjFkXy+pKk6GN/70Qs2uyAh8PIhoaab7ZImSSZFnTpKueG/gAlLXL29HWgJzP9
	 EUJoinXmOfccQ9Gg+Gjn4SdXlym3G+iWwJT2aZazC1SKScsgggnHfm+iiqWg2U5X5K
	 fGHPjg32uxZ8KxENaK2BV2b1RIigNOveso2kmDaYgutHKn46beNBvj9tMDi+C8RzAQ
	 ntb3w77mVMwOA==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E7D8F17E37E2;
	Tue, 01 Sep 2026 20:50:55 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:44 +0300
Subject: [PATCH v11 20/74] drm/display: hdmi-state-helper: Add source TMDS
 rate validation
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-20-bc12954a0688@collabora.com>
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

Validate the computed TMDS character rate against
connector->hdmi.max_tmds_char_rate, when provided by the driver/source.

This gives HDMI connectors common support for rejecting modes whose TMDS
character rate exceeds the source supported limit, while still allowing
drivers with custom validation requirements to implement their own
tmds_char_rate_valid() callback.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index bccc5d7c8eed..3ef6de31dc02 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -562,6 +562,10 @@ hdmi_clock_valid(const struct drm_connector *connector,
 	if (info->max_tmds_clock && clock > info->max_tmds_clock * 1000)
 		return MODE_CLOCK_HIGH;
 
+	if (connector->hdmi.max_tmds_char_rate &&
+	    clock > connector->hdmi.max_tmds_char_rate)
+		return MODE_CLOCK_HIGH;
+
 	if (funcs && funcs->tmds_char_rate_valid) {
 		enum drm_mode_status status;
 

-- 
2.55.0

