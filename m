Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6C844C6C
	for <linux-fbdev@vger.kernel.org>; Wed, 17 Jul 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721206923; cv=none; b=kBFbz5AKbjCfq2dHvLKhWn43wlIGaC3vQBIygj/DGZWbyNnE03j7vVGAFyphCgYlIExI8HQJguR4lNvb2RJ6zAlXWZ6V8Vi2h34QS9MFMOW2rwq+ZZiwZ0bV/sBryX63U6yvD9+iWmGA5VypQt4gqlyd7AnG+5FrGo5TwxvgmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721206923; c=relaxed/simple;
	bh=2SY4kino7DfBR2QzmbrqcxQZV1XTYHYltN/SsBfDPpc=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P7roSpWmUKIb+RfnVnIi9nfgL26uhT+paXGB5FOcGav/Qc8LaSfcbbXq3MheMh/GDwM7qQRgIRCSEGpuE3WVyxkGWneHYIlezVenNVht5HXfBgpsp+yAPYogFkRyq6CMWVEJ7OoUZDybV4MxwRKKkD7Bp9uKoO144sfMMmWTd18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jQLopddQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jQLopddQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721206920;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRuBANNGOfAVhYgcUec7uelK4S9x1EhlXp94QYTaMXE=;
	b=jQLopddQHj2e/zCC01rItZsoTuUwQzgazYZs9wsyik4I1IKVU/5aCC/CdnKZIu4Ci5fu/L
	VTcsY6SJ5L7J7D6hLTdbJSP0CfdxURhLn++ygAKtECrYCMQfKOiob/FaCs7F3jOV8vqSAA
	GFg/94tRINpPGW+i8IlUwPb8DVWt+dY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-ghtTmlCHNCu3XQ6cPlgK4A-1; Wed,
 17 Jul 2024 05:01:55 -0400
X-MC-Unique: ghtTmlCHNCu3XQ6cPlgK4A-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3357A1955BFC;
	Wed, 17 Jul 2024 09:01:53 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.18])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E44E81955F40;
	Wed, 17 Jul 2024 09:01:48 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Jocelyn Falempe <jfalempe@redhat.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH 2/3] fbcon: Add an option to disable fbcon in panic.
Date: Wed, 17 Jul 2024 10:48:40 +0200
Message-ID: <20240717090102.968152-3-jfalempe@redhat.com>
In-Reply-To: <20240717090102.968152-1-jfalempe@redhat.com>
References: <20240717090102.968152-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

This is required to avoid conflict between DRM_PANIC, and fbcon. If
a drm device already handle panic with drm_panic, it should set
the skip_panic field in fb_info, so that fbcon will stay quiet, and
not overwrite the panic_screen.

Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
---
 drivers/gpu/drm/drm_fb_helper.c  | 2 ++
 drivers/video/fbdev/core/fbcon.c | 7 ++++++-
 include/linux/fb.h               | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
index e2e19f49342e..3662d664d8f9 100644
--- a/drivers/gpu/drm/drm_fb_helper.c
+++ b/drivers/gpu/drm/drm_fb_helper.c
@@ -40,6 +40,7 @@
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_panic.h>
 #include <drm/drm_print.h>
 #include <drm/drm_vblank.h>
 
@@ -524,6 +525,7 @@ struct fb_info *drm_fb_helper_alloc_info(struct drm_fb_helper *fb_helper)
 	fb_helper->info = info;
 	info->skip_vt_switch = true;
 
+	info->skip_panic = drm_panic_is_enabled(fb_helper->dev);
 	return info;
 
 err_release:
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 3f7333dca508..498d9c07df80 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -270,12 +270,17 @@ static int fbcon_get_rotate(struct fb_info *info)
 	return (ops) ? ops->rotate : 0;
 }
 
+static bool fbcon_skip_panic(struct fb_info *info)
+{
+	return (info->skip_panic && unlikely(atomic_read(&panic_cpu) != PANIC_CPU_INVALID));
+}
+
 static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	return (info->state != FBINFO_STATE_RUNNING ||
-		vc->vc_mode != KD_TEXT || ops->graphics);
+		vc->vc_mode != KD_TEXT || ops->graphics || fbcon_skip_panic(info));
 }
 
 static int get_color(struct vc_data *vc, struct fb_info *info,
diff --git a/include/linux/fb.h b/include/linux/fb.h
index db7d97b10964..865dad03e73e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -510,6 +510,7 @@ struct fb_info {
 	void *par;
 
 	bool skip_vt_switch; /* no VT switch on suspend/resume required */
+	bool skip_panic; /* Do not write to the fb after a panic */
 };
 
 /* This will go away
-- 
2.45.2

