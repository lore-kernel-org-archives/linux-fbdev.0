Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09F294A13AB;
	Tue,  1 Sep 2026 18:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788288655; cv=none; b=MeYGOpqPyAnPaaFXP1ndH86I2feipZhEutNIyi3iU54kkpWfqQiep70mQC4G39IAlXJfeE0+qtA3WAOB5NBiGhgfg0ZDE8PlO1il35xet2qzWl4V3ZIlLb3mkbFfFjASU7giDXJiEB/QVn6/Sm/NVPFAILoMWPn/HjHQk51Pk/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788288655; c=relaxed/simple;
	bh=FYdmAkPWFKCF8O++onHpEmGeuQyVm5oG12OGbdUPBSU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h80fh7IHeAi8sWkrJGIPv7sW6fEwNUKkoH++Qwt/gFyBpQT763aaPr1r4JqaTMNu228lIeDrswQK2xrU2uxjZbzIq0I0EF/6Xi4OMyQMw/1LB85AZYYL41vGv3XkvIbRrfAUZ9XpEfmHZqrUO5d0C63sN4bPW33AVy024FhyLK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=I9EWgqCE; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="I9EWgqCE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1788288650;
	bh=FYdmAkPWFKCF8O++onHpEmGeuQyVm5oG12OGbdUPBSU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=I9EWgqCEXTO1HQHg65SdoSbw5hytYZgMJMA6p8u+jfLmpEjrhQGG4EJiMqZnRCDsB
	 Dc0di44ZLXRA8tRKhF1P6oTNQt94LGIvGkt2iERzqSi6/USBZn9VGT/olY9/vut1Lu
	 X1gy2To1yHvCtyQAhZnSjelA83+9OSrXVBAfu7CCuV++LfRlBJWCyGb+WbMUjll8yp
	 VCat2m9yWQRBtBO/IebG2njy7jfYa8B30zxBTw3khcaCe/ZQqV8Y2aoiQKZLkso+6B
	 fjQ7gGCnavuBP+4XqExdhIai0DqfCQGnyHih70BTHcLhD4h2cGrTodPmgOHp5Ql/H/
	 hOUH8pBl3Vdow==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id ADF5117E361B;
	Tue, 01 Sep 2026 20:50:50 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:37 +0300
Subject: [PATCH v11 13/74] drm/bridge: Fix NULL deref in drm_bridge_add()
 for legacy bridges
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-13-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Legacy bridge drivers that embed struct drm_bridge in a zero-initialized
allocation, rather than obtaining it from devm_drm_bridge_alloc(), never
run INIT_LIST_HEAD() on bridge->list, leaving next and prev NULL.
list_empty() compares next against &bridge->list, so it reports such a
list head as non-empty.  list_del_init() therefore runs and dereferences
the NULL pointers, panicking the kernel during probe.  Only builds with
CONFIG_DEBUG_LIST survive, with a list corruption report.

This affects rk3066_hdmi and the i.MX8 LDB bridges, which still embed a
bridge in a devm_kzalloc()'d struct.

Initialize the list head when it is found to be NULL, so that the bridge
ends up with a valid empty list head and list_del_init() is only reached
for bridges that can actually be linked.

Fixes: 17805a15d175 ("drm/bridge: add list of removed refcounted bridges")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260731175016.C5D591F00AC4@smtp.kernel.org/
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_bridge.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_bridge.c b/drivers/gpu/drm/drm_bridge.c
index 2c457ad74f3b..a8b6df5c13ea 100644
--- a/drivers/gpu/drm/drm_bridge.c
+++ b/drivers/gpu/drm/drm_bridge.c
@@ -453,9 +453,16 @@ void drm_bridge_add(struct drm_bridge *bridge)
 	 * If the bridge was previously added and then removed, it is now
 	 * in bridge_lingering_list. Remove it or bridge_lingering_list will be
 	 * corrupted when adding this bridge to bridge_list below.
+	 *
+	 * Legacy drivers that allocate the bridge with kzalloc() rather than
+	 * devm_drm_bridge_alloc() leave list.next NULL. Such a bridge cannot
+	 * be on any list, and list_del_init() would dereference NULL, so
+	 * initialize the list head first.
 	 */
 	mutex_lock(&bridge_lock);
-	if (!list_empty(&bridge->list))
+	if (!bridge->list.next)
+		INIT_LIST_HEAD(&bridge->list);
+	else if (!list_empty(&bridge->list))
 		list_del_init(&bridge->list);
 	mutex_unlock(&bridge_lock);
 

-- 
2.55.0

