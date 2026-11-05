Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793894100;
	b=ZvYi+NL2PQ8esrweiMH6JMH/7w0PQ6EIPNDA1kSRkCRAJX+Bqd8ANrd55NFm8F+LKrJH
	 859KCx2Zs/RRZxC1Yp9dkyARiDhQ/sHMMk3FvTL6Kys4CwbpS010PnoGne7fWAgHunGpM
	 3na928wg90pZLnT1+pJRIjhpeuISpKZLDi4QCoPP3hZAsX1SlDnaWMHy5hr8HsN9aJZVb
	 1WOJHp9iMp00S4ZYBl8B32N2A/BOoav4NT0WmdGI0cgE6YxOLyCDgG8gml/EbT8wOCWCC
	 fkfNtDu8cBjlKVbmj7NtBo6PAjo65CiXPqAdqt8VEoJPQbmJf6soemvgHelN8kRzgTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793894100;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=X5Z7qcMwD7blBfeK0v/J475OEl1PgkfNhhezrgvSE88=;
	b=lPgZX9v6KWPEUdSrxSf0Eq2VjhYse7h3a8t/qFgsN28eQvFStYarg6yQXRwE+ftuPWNv
	 RxIM5IcNgHhfNxMTRskF9fpue5UjmKkx8lZZkQOjUnd1+9FKQzojpnYLhHxov+eHAW0Py
	 kBmgZrDt0Es1IN4C1Hi+Jd0MD6+/3VLP+pWxnKR2VqaVmtzijyBQSiE29Q5rtEIzSHd9v
	 1Gv7aRsFFkMGLrtgZCRiOT6PEaxLHlmHAN476Ov8/WERjfiBYHsQylJUmZDqpilgneoN4
	 jHquoyol2R5akFbSf0tSML6Ih7vWjY6FgprvlgxTiyMdrTi9lMgM+v1hZg8TS5G9roQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WXbRKlsK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=136.143.188.112
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EBF56075F6A;
	Thu,  5 Nov 2026 15:55:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBF56075F6A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=zohomail header.b=WXbRKlsK
ARC-Seal: i=1; a=rsa-sha256; t=1793894035; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=f1GG34Z5y1R9kEj027n5ViHkhVVjQQ3h2qJNnolFhPnbBzPUViU2JpfT1NfkLBoYSyd2N8S3z2s+iNgVyZjmvsGyHDeNKZ8jvx4z2gYknOtiEt64I3+kg5HBO5+SWrJSAix0GDVw2oHNuoo6w21/bOtVF0moTTMJkw5t5LZz3Co=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1793894035; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X5Z7qcMwD7blBfeK0v/J475OEl1PgkfNhhezrgvSE88=; 
	b=fsW7zFL9EPhwqK+6Y7wip34C1En/t6OzF2RV42BpImgvjZilQQnJQ46rGDAkwUaZVTzg+XvAzW/J9JCI5zIHGb3+rAznOhSXoXTMuYM/goJieh6UULIb1NoRr/WLlpCbJToOGzMsLzv39DaIUX8HtAN1MRtTjwTww7uGWt6G8vA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: a=rsa-sha256; b=WXbRKlsKHBc1R30c81R8lCa4x2UNdAyyXxMagZUxw1pDNA1KQco1vmR5ksXMs5XZ2dmzyd0iqGeD+pWlVz1rwBHvki7TtM35FQIQDQSlOuhlBWBZmLlZoKJKumtF3iIFmc7T1IVYeFcI3WGOmOxiCBw9PmDAvyyQ15zHqH9InXQ=; c=relaxed/relaxed; s=zohomail; d=collabora.com; v=1; bh=X5Z7qcMwD7blBfeK0v/J475OEl1PgkfNhhezrgvSE88=; h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1793894034502964.1810565741954;
	Thu, 5 Nov 2026 07:53:54 -0800 (PST)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Thu, 05 Nov 2026 16:52:04 +0100
Subject: [PATCH v2 13/27] drm/rockchip: Set mode_changed on vrr_enabled
 change
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
Message-Id: <20261105-vrr-limiter-uapi-v2-13-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
In-Reply-To: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
To: Xaver Hugl <xaver.hugl@gmail.com>, Vidith Madhu <vmadhu@nvidia.com>, 
 "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Harry Wentland <harry.wentland@amd.com>, 
 Fangzhi Zuo <Jerry.Zuo@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 =?utf-8?q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
X-Mailer: b4 0.15.2

RK3588 (and likely other Rockchip hardware) requires a full modeset when
VRR is enabled in order for it to function properly.

Set mode_changed during the atomic check phase to do this.

Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
---
 drivers/gpu/drm/rockchip/rockchip_drm_fb.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
index 45588b79b3d4..e3aad75b88b4 100644
--- a/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_drm_fb.c
@@ -13,6 +13,7 @@
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_print.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_drm_fb.h"
@@ -59,9 +60,26 @@ rockchip_fb_create(struct drm_device *dev, struct drm_file *file,
 	return &afbc_fb->base;
 }
 
+static int rockchip_drm_atomic_check(struct drm_device *dev, struct drm_atomic_commit *state)
+{
+	struct drm_crtc_state *old_crtc_state, *new_crtc_state;
+	struct drm_crtc *crtc;
+	int i;
+
+	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
+		if (old_crtc_state->vrr_enabled != new_crtc_state->vrr_enabled) {
+			new_crtc_state->mode_changed = true;
+			drm_dbg_driver(dev, "[CRTC:%d:%s] VRR changed\n",
+				       crtc->base.id, crtc->name);
+		}
+	}
+
+	return drm_atomic_helper_check(dev, state);
+}
+
 static const struct drm_mode_config_funcs rockchip_drm_mode_config_funcs = {
 	.fb_create = rockchip_fb_create,
-	.atomic_check = drm_atomic_helper_check,
+	.atomic_check = rockchip_drm_atomic_check,
 	.atomic_commit = drm_atomic_helper_commit,
 };
 

-- 
2.56.0

