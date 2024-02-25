Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9CA9443
	for <linux-fbdev@vger.kernel.org>; Sun, 25 Feb 2024 06:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708843676; cv=none; b=g5ZUQnLvHmZuswmfhmssWpvdrXfjwyNVFGmpdjUP4MPrOsIRnHzMAL7WEfxoo9HmGm9IgP/5SA7uR4lezrijKv6A1kjEqdftz/USs6iJXb/lMmOtO7+E3HVTUESbd8l6AWyhmv9Q+xSdTIhtUYRNLPjQiC3XCiabrj6zIzZALZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708843676; c=relaxed/simple;
	bh=M2859QzQ+R61FkyD744ASgs2qZVOK1XHHB7RztXuk7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwzH6rTz93PAweGS/uf+cS8FnynlFYtPUckk5FGzJrAKVt2W30VGqBHpB+Ie/Rry2oWWAMiJ8x09tctin1Weyr8Na+8MVlBkMEQ7RSRShkSdyKjStDerAboCYd/SX65AcB4gCymjN9iT7ghZOPLMFM0kfLw0KDG7cCtTmvgy7Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=pgFZjL8D; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="pgFZjL8D"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id D743E6049D;
	Sun, 25 Feb 2024 06:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1708843674;
	bh=M2859QzQ+R61FkyD744ASgs2qZVOK1XHHB7RztXuk7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgFZjL8D6IJlJQlpUKL6h/LDoWSKACslH/ZmxuCdhwEwzmGct/lHDPf+F5oU8d/DZ
	 qGpbQzJC5+QZZCENg3PEy3cwXJy1AkhcczUnYhjja8ht3eZLtBzTmnLjyZD1wqd/MI
	 q7v4HpzNZcFoHE/sUtwaa+SOvQUOqhY7ZsTgaC8celyOSFdsp3GWTTbTHRQfykKVkS
	 kwHDrue6RdHs9duCslYv9uFGpqfIL3ZwYyjvObUE7/gY7Q206qa7BsVS9Jw1ir6fll
	 Xb22EA1eH0jCyxixFD4GZBzlcRJuJ5XLLxiU2F19lnD/6qp92BrFkJRzD3/7nqdFeK
	 WtvhEd85w/1mA==
From: Tony Lindgren <tony@atomide.com>
To: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Subject: [PATCH v2 1/2] drm/omapdrm: Fix console by implementing fb_dirty
Date: Sun, 25 Feb 2024 08:46:54 +0200
Message-ID: <20240225064700.48035-2-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240225064700.48035-1-tony@atomide.com>
References: <20240225064700.48035-1-tony@atomide.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The framebuffer console stopped updating with commit f231af498c29
("drm/fb-helper: Disconnect damage worker from update logic").

Let's fix the issue by implementing fb_dirty similar to what was done
with commit 039a72ce7e57 ("drm/i915/fbdev: Implement fb_dirty for intel
custom fb helper").

Fixes: f231af498c29 ("drm/fb-helper: Disconnect damage worker from update logic")
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/omapdrm/omap_fbdev.c b/drivers/gpu/drm/omapdrm/omap_fbdev.c
--- a/drivers/gpu/drm/omapdrm/omap_fbdev.c
+++ b/drivers/gpu/drm/omapdrm/omap_fbdev.c
@@ -238,8 +238,20 @@ static int omap_fbdev_create(struct drm_fb_helper *helper,
 	return ret;
 }
 
+static int omap_fbdev_dirty(struct drm_fb_helper *helper, struct drm_clip_rect *clip)
+{
+	if (!(clip->x1 < clip->x2 && clip->y1 < clip->y2))
+		return 0;
+
+	if (helper->fb->funcs->dirty)
+		return helper->fb->funcs->dirty(helper->fb, NULL, 0, 0, clip, 1);
+
+	return 0;
+}
+
 static const struct drm_fb_helper_funcs omap_fb_helper_funcs = {
 	.fb_probe = omap_fbdev_create,
+	.fb_dirty = omap_fbdev_dirty,
 };
 
 static struct drm_fb_helper *get_fb(struct fb_info *fbi)
-- 
2.43.1
