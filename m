Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E54A33EA;
	Mon, 21 Sep 2026 15:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006014; cv=pass; b=BN2Ks1EFFzQAkSixe9b4uRLQDmVa3FeduZUtxpmxacMeqQ5P5HkQZB0zbhfph2jXv+Q7rod/WfTpvZVwmWbHPgfUDLB4uoZ7FUBDQy2JaGVhEKsHxh7TZm17JHDHmN/0866h9/FOCpfqrdsBgksUlsjFxVdjL3+YAjtLyT0F31k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006014; c=relaxed/simple;
	bh=i7369EXNVUL9nfixSD/eS3x3wYjFoM3yDmScV08zkLw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JBiMLsXoI+b2g6WO1TT+7g77EvmlWFah1T9jpExSrSP7NJYlA5j81E7g986ewfjBpbg1RJCSobfik9FooCM+3OdB2Qc9BoCSsGuR2VBT+BJDSre8/e0M0+xeEP7BBVHihMnc3SLyxTVerHbulRy25FeB7v+zR+aB/CtrQa2Hwqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=XWOkjhXG; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="XWOkjhXG"
ARC-Seal: i=1; a=rsa-sha256; t=1790005961; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ekDDWz6SKI6q6ld6C77KoGkwZ5pQEiQ2wumL+GCaea5SlhTExiwzvhnMqdMj6NNzbNmocdnyuw4Hx+bXnuubZ+Zoe8+T9Pu37KrWlO9mZa9uJECkZLdw51WHZxP7UZYU6y0ILrqV9R7d3qlYqHVT/qaFz2DuSXoBDwEO3ZJWN60=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790005961; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=fVK7xdLrIgmNCx71jw7NwMha6WBnYRw57W6b6ElMFQw=; 
	b=NU7kt8+teL4wsnrpXy5NYLNKO8qPyM/gShZqQhLcLg9fbS6H0xA2XwbnWXAB5sHmQ8B6kTg2vGGd0256mQS5EdGRL+z/lPh5NKhIpdcdCpYqUdSA+zonY3aQjjg3WJQ2NER4tUYD3gwKjECig1dwvlpCvuqOGt/+ashGZkdgIkE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005961;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
	bh=fVK7xdLrIgmNCx71jw7NwMha6WBnYRw57W6b6ElMFQw=;
	b=XWOkjhXGE+0Ttweod/Ofn4ftYbzzg/lblKp6FpAWxnMUd91E55EZpgcPCbkgP3fB
	h6h710VlM+Hg/y5T25Ga7MJxL42rVOQSeoh8jKL42RNrFf5q4C/BSguRCdTbaP7RSLg
	OHYpGkM2erk6Ch076Q07G4YVxL1vSZbSXiWiFD4o=
Received: by smtp.zohomail.com with SMTPS id 1790005960600608.9880494214716;
	Mon, 21 Sep 2026 08:52:40 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:33 +0200
Subject: [PATCH RFC 07/25] drm/crtc-helper: Add VRR helper functions
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-7-2fcd7d011646@collabora.com>
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

VRR needs to change the vertical front porch timing to change the duration
of a frame. Add two helpers to aid in this.

drm_crtc_helper_vrr_flush should be called when the source has a new
frame ready to present. It adjusts the internal VRR state, and returns
whether the current vtotal has been changed. Callers can then adjust
their hardware state as is necessary.

drm_crtc_helper_vrr_vsync should be called in the vblank interrupt
handler. It adjusts the internal VRR state, and returns whether the
current vtotal has been changed. Callers can then adjust their hardware
state as is necessary.

Co-developed-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/drm_crtc_helper.c | 63 +++++++++++++++++++++++++++++++++++++++
 include/drm/drm_crtc_helper.h     |  4 +++
 2 files changed, 67 insertions(+)

diff --git a/drivers/gpu/drm/drm_crtc_helper.c b/drivers/gpu/drm/drm_crtc_helper.c
index 4a8cfe046e4a..4ffb3b0b7878 100644
--- a/drivers/gpu/drm/drm_crtc_helper.c
+++ b/drivers/gpu/drm/drm_crtc_helper.c
@@ -838,6 +838,69 @@ int drm_crtc_helper_set_config(struct drm_mode_set *set,
 }
 EXPORT_SYMBOL(drm_crtc_helper_set_config);
 
+/**
+ * drm_crtc_helper_vrr_flush - Update VRR state on frame ready
+ * @crtc_state: pointer to &struct drm_crtc_state of CRTC that has a new frame ready
+ *
+ * Update the VRR state by communicating that a frame is ready on
+ * @crtc_state.crtc.
+ *
+ * Should be called from the @crtc_state.crtc &drm_crtc_helper_funcs.atomic_flush
+ * hook.
+ *
+ * Returns:
+ * - %true if @crtc_state.vrr_state.cur_vtotal changed
+ * - %false otherwise
+ */
+bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state)
+{
+	struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
+
+	if (!crtc_state->vrr_enabled) {
+		if (vrr->cur_vtotal) {
+			vrr->cur_vtotal = 0;
+			return true;
+		}
+		return false;
+	}
+
+	if (vrr->cur_vtotal == vrr->base_vtotal)
+		return false;
+
+	vrr->cur_vtotal = vrr->base_vtotal;
+
+	return true;
+}
+EXPORT_SYMBOL(drm_crtc_helper_vrr_flush);
+
+/**
+ * drm_crtc_helper_vrr_vsync - Update VRR state on vblank end
+ * @crtc_state: pointer to &struct drm_crtc_state of CRTC the vblank occurred on
+ *
+ * Update the VRR state by communicating that a vertical blank has ended and a
+ * new frame is about to start.
+ *
+ * Returns:
+ *  - %true if @crtc_state.vrr_state.cur_vtotal changed
+ *  - %false otherwise
+ */
+bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state)
+{
+	struct drm_crtc_vrr_state *vrr = &crtc_state->vrr_state;
+	u16 old_vtotal = vrr->cur_vtotal;
+
+	if (!crtc_state->vrr_enabled)
+		vrr->cur_vtotal = 0;
+	else
+		vrr->cur_vtotal = vrr->max_vtotal;
+
+	if (abs_diff(vrr->cur_vtotal, old_vtotal) > 1)
+		vrr->dynamic = true;
+
+	return old_vtotal != vrr->cur_vtotal;
+}
+EXPORT_SYMBOL(drm_crtc_helper_vrr_vsync);
+
 static int drm_helper_choose_encoder_dpms(struct drm_encoder *encoder)
 {
 	int dpms = DRM_MODE_DPMS_OFF;
diff --git a/include/drm/drm_crtc_helper.h b/include/drm/drm_crtc_helper.h
index 855da5733c47..0c8c11ea36dd 100644
--- a/include/drm/drm_crtc_helper.h
+++ b/include/drm/drm_crtc_helper.h
@@ -44,6 +44,7 @@ struct drm_encoder;
 struct drm_framebuffer;
 struct drm_mode_set;
 struct drm_modeset_acquire_ctx;
+struct drm_crtc_state;
 
 void drm_helper_disable_unused_functions(struct drm_device *dev);
 int drm_crtc_helper_set_config(struct drm_mode_set *set,
@@ -62,4 +63,7 @@ int drm_helper_connector_dpms(struct drm_connector *connector, int mode);
 void drm_helper_resume_force_mode(struct drm_device *dev);
 int drm_helper_force_disable_all(struct drm_device *dev);
 
+bool drm_crtc_helper_vrr_flush(struct drm_crtc_state *crtc_state);
+bool drm_crtc_helper_vrr_vsync(struct drm_crtc_state *crtc_state);
+
 #endif

-- 
2.55.0

