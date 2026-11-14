Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679466;
	b=wyLicj+XU/jDMLOAQ2b8Hq5je7XVO2U58aoqp3Nle2W0H03x34R0Xp8Ry7GAT0uxvvb0
	 Kn6rygyM/5aYJ2sFftVvi8/BlzYdP+cd+Hy8uY/qE3+R/oSJhe5DeawfIIZvkQroVOUPV
	 qN8wZGryQDB2IZ9MDr1QfaUlwP5WOy369Ny4elEO3L1GsYr5HYyTNcLAq1lXWI0CFuUBc
	 N+LD78383KxKUU4IczQEOeZKfHO+Cas8z+HOHR4mVxw94HCJkYgicXQ5XkWXfMOY3jR6U
	 vI4bXsoVyVcJAq5TPXGGleFZuI3g0NVllT/VEG3L1tOcCjUfBwAtBogn+5SeruNXvow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679466;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=jw+MrZsI04UhCut1Lcy9TfgOtgk6vMk75DWUITxs4CM=;
	b=dP0pK0zh5SOKV1TYPr1ptcHhELlaaKIy1JczcRZD7RfpFDDnkQcTqu92ZIL8SHwNE7UD
	 Um3tAsVWitSHsLDcMDUfmK2RgzseU9nW8cMwgHW6T028YsRNEZxoeHsbDiUyK+Ghzvefa
	 PUWktyKxN4PgUVu5QTteoYqB5pkwyBWER63E1iJjFo+0foJTJ9YEjpRIdN8qFTq8dBJcp
	 yDDf6tT8LPohKjRYWqMRMppd5vciYo5fmh83AbcEevKxSluR8En5kXrvRuf6kVrarFzkn
	 kAdIHBz5XyZKrKnLzpJrChb9xLNpp62drZ2BMBnbXiynRK/KH8eaBEb1dYfqkD+YJhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AuAdV4hK;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49764606A883;
	Sat, 14 Nov 2026 18:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49764606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=AuAdV4hK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794679459;
	bh=VA0rwkfjSh33P+agF41CZoRoNRegKroGX+B+IDlTDzs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AuAdV4hK6N8r3Qcr9K6kq7g2E4LPupergUw2gcirBQiganMOJegrSohQwdyi3G9pg
	 cPnngILkVuJtELdWIPCN4t7kjnJSWNpzGuZvEFufwjF61LN2VP810AegVFkXrNopHn
	 JqLvCfXb8tEcds8WDMnodqcpawVVWHzQnsEsShvx6HsOzuRVdqRWU9JANENRaU7LXl
	 RhAJyNQyzNK0Lrju7R4BkRgVX0z7RepdRJ30m8MEHv7TJKXtTPDI0umGnND0hH+0iI
	 kE9eO3bii8xuHmxu4qF9c33X4VHGaEUstoG2vW6tvtt7bEHhJbvQXrkhgVF+Cub4pG
	 Z/+HpwIh5eu6A==
Received: from localhost (unknown [100.64.0.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: cristicc)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 67EAA17E0F3F;
	Sat, 14 Nov 2026 19:04:19 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Sat, 14 Nov 2026 20:03:27 +0200
Subject: [PATCH 03/25] drm/display: hdmi-state-helper: Drop
 drm_atomic_helper_connector_hdmi_force()
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
List-Help: <mailto:linux-fbdev+help@vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-fbdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261114-drm-conn-hdmi-cleanup-v1-3-20e8a33a2286@collabora.com>
References: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
In-Reply-To: <20261114-drm-conn-hdmi-cleanup-v1-0-20e8a33a2286@collabora.com>
To: Helge Deller <deller@gmx.de>, Martin Bugge <marbugge@cisco.com>, 
 Thierry Reding <treding@nvidia.com>, Hans Verkuil <hverkuil@kernel.org>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: kernel@collabora.com, linux-fbdev@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

With all callers converted to the .force_ctx() connector helper, this
function has no users left.  Remove it.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 15 ---------------
 include/drm/display/drm_hdmi_state_helper.h     |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 66ae678fc078..c50cedc7fa65 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1440,21 +1440,6 @@ int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_hotplug);
 
-/**
- * drm_atomic_helper_connector_hdmi_force - HDMI Connector implementation of the force callback
- * @connector: A pointer to the HDMI connector
- *
- * This function implements the .force() callback for the HDMI connectors. It
- * can either be used directly as the callback or should be called from within
- * the .force() callback implementation to maintain the HDMI-specific
- * connector's data.
- */
-void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
-{
-	drm_atomic_helper_connector_hdmi_update(connector, NULL, connector->status);
-}
-EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
-
 /**
  * drm_atomic_helper_connector_hdmi_force_ctx - HDMI Connector implementation
  * of the force_ctx callback
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 21e5a9215319..ddbfb5b80fa8 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -27,7 +27,6 @@ int drm_atomic_helper_connector_hdmi_update_infoframes(struct drm_connector *con
 int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					     struct drm_modeset_acquire_ctx *ctx,
 					     enum drm_connector_status status);
-void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
 int drm_atomic_helper_connector_hdmi_force_ctx(struct drm_connector *connector,
 					       struct drm_modeset_acquire_ctx *ctx);
 

-- 
2.56.0

