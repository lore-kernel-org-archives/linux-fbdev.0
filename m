Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1E14A2A61;
	Tue,  1 Sep 2026 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288663; cv=none; b=Dif3rnLKZnw0wRY7caiMh+TU/U1IKbHvkeHEcysdNLp0W1Xru4EqAE6csj3X8xYcnbXEUUg++G/glMYYijiX/NEE61oRM3o45r5BlEvmO5Bap2UdH8L+5USHJo7Ht3+Ah9PTrhT857+mq2vTM9YWWB9qgU0xVo5d8aRjDsgpoEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288663; c=relaxed/simple;
	bh=llRoKpfXuQkYY+W0+/jwbxQOlm0Z0m47rfFzOtj1Nlw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pwvSB3O9AVx8So5mXe6sb1pBsyyk99ZthxZx0Ub1JPwD1OpbMvJuaGYedCZGfR6hREP2wr0RZeNAMmVXf1OyNO/xYFlfjqNkMtlW2eJucGK76jk0hsY7neO15D7RGPaD9Cjjw2MEHn7VP0Qm0hXoOl/C4rQr38RcWsexAPG0+Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=WkqOVOtU; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="WkqOVOtU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288659;
	bh=llRoKpfXuQkYY+W0+/jwbxQOlm0Z0m47rfFzOtj1Nlw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WkqOVOtUGI+dxR97lgGEVnMkIlpIq9j2acvd8iVZ9kqVtmIeu0bXneyWSBUt52yVA
	 szeP9EhMz62PcX8q1VXK8wcVjDgq9qoJAfdPoMqKUHqFHelUN1k6xBcfFS7azUUiDv
	 JTs0XyBfvU6eoLdyxDNbUIqibiB3GlqiNh2vqrF8RaAcBxjwYk0ahRXRS4HV7cIGcI
	 WfAMdN6skhKyLymkvub+vLTMaogL/1JPc9lhlMF7x2n1jNo/+hVFa8K7Z4ZBPXoq7O
	 2LVtJZCuShFVV2Bvh0fexr4Vjwr/KmmqhbaIivO7lCHDuingYR1LNdvRwqbIUH7BtR
	 jAsyWc9gI0XsA==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EDABA17E38F5;
	Tue, 01 Sep 2026 20:50:58 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:48 +0300
Subject: [PATCH v11 24/74] drm/display: hdmi-state-helper: Set HDMI
 scrambling requirement
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-24-bc12954a0688@collabora.com>
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

Set drm_connector_hdmi_state.scrambler_needed when the computed TMDS
character rate exceeds the HDMI 1.3 maximum TMDS character rate.

HDMI 2.0 requires scrambling above 340 MHz.  Centralize that clock-based
requirement in the HDMI state helper so drivers do not need to open-code
the threshold check.

Acked-by: Maxime Ripard <mripard@kernel.org>
Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 1e269b203b98..7cdb7ca3dc12 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -596,6 +596,9 @@ hdmi_compute_clock(const struct drm_connector *connector,
 
 	conn_state->hdmi.tmds_char_rate = clock;
 
+	/* TODO: also check drm_display_info.hdmi.scdc.scrambling.low_rates */
+	conn_state->hdmi.scrambler_needed = (clock > HDMI_1_3_TMDS_CHAR_RATE_MAX_HZ);
+
 	return 0;
 }
 

-- 
2.55.0

