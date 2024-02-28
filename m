Received: from mail5.25mail.st (mail5.25mail.st [74.50.62.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4B82231A
	for <linux-fbdev@vger.kernel.org>; Wed, 28 Feb 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.50.62.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709102205; cv=none; b=mZo8arejDD2oRwtKK+DCDl8A394kJFjO3F6q7VMOfStyGdGbUkNb4eel82Y3B6zMLd8vLlZEw335X4sGNZHpK4BQRsnNvkLXagDmP/36ZeWRJYrwDWiPxGKeUX7Iw0jB7cAeSEZDVJvjK13U91SwkHitcvfbArNd2gpeau7kVtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709102205; c=relaxed/simple;
	bh=TvTu9swDGR5SvHLBlOYu7buPsT5R8bc5TqNCjCJsSbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NbLvVuSr8XM0giQwYAhEs/XaUT75luC7CQl4Mzm4zgZA+9+zHuEnBWJwCcN5m3uSqLkVAu6tlacDY7pkQ5XFkqVYscmunzE9lNHdsdxZ54KGH6+7p+lvGtuH09QH+uq1xWYvQPK2vHKHoBpxoKKvhoWKqmESZWV1G3ds8F9fD5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com; spf=fail smtp.mailfrom=atomide.com; dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b=Y2Gr/SB1; arc=none smtp.client-ip=74.50.62.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=atomide.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atomide.com header.i=@atomide.com header.b="Y2Gr/SB1"
Received: from localhost (91-158-86-216.elisa-laajakaista.fi [91.158.86.216])
	by mail5.25mail.st (Postfix) with ESMTPSA id CE44C603C6;
	Wed, 28 Feb 2024 06:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=atomide.com;
	s=25mailst; t=1709102196;
	bh=TvTu9swDGR5SvHLBlOYu7buPsT5R8bc5TqNCjCJsSbM=;
	h=From:To:Cc:Subject:Date:From;
	b=Y2Gr/SB1PUa/DjxFssS8AgREcs9iHYLHpEXttrjyyvxWTTFvlaxVc2mz0IwjHj/ga
	 Lh9bispRdd2XNYF8lo0lZevIuUqi4x7LkeciX3WXBDWrKyLazs0TskwJawtwHzIfaB
	 v5UsSaI9B2BOFS8UjI/MtH13LKTd6fFchpLhZ97DpSFV0Zny2+sAf4tJcI3kNzy1eA
	 HKcAafAfTtKkrQwyzmca9e2tDDE+tpzzikBxSp42YBAAmD1R62p6jSnaJRTkhTT2oy
	 5i6U4FWgwvNHN5ggcERnnQ0FTJa4dBhSOK2jhC1mKzHzMOag285MuWU/x1yMa4M06H
	 FJKNqxB8tGjWg==
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
Subject: [PATCH v3 0/2] Fixes for omapdrm console
Date: Wed, 28 Feb 2024 08:35:30 +0200
Message-ID: <20240228063540.4444-1-tony@atomide.com>
X-Mailer: git-send-email 2.43.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Here are two fixes for omapdrm for missing drm_framebuffer_funcs.dirty
that needs to be paired with omap_framebuffer_dirty(), and to add
FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS so things behave as earlier with
drm_fb_helper_sys_write(). Without these fixes, the console won't update
for the command mode displays. And likely mmap() using writes can miss
updates as noted by Thomas.

Regards,

Tony

Changes since v2:
- Fix cache issue noted by Tomi using custom omap_fbdev_fb_mmap() as
  suggested by Thomas

- Add FB_DMAMEM_HELPERS_DEFERRED Kconfig option and use it for omapdrm
  as noted by Thomas

Changes since v1:

- Add FB_GEN_DEFAULT_DEFERRED_DMAMEM_OPS to use with
  FB_DEFAULT_DEFERRED_OPS as suggested by Thomas

Tony Lindgren (2):
  drm/omapdrm: Fix console by implementing fb_dirty
  drm/omapdrm: Fix console with deferred ops

 drivers/gpu/drm/omapdrm/Kconfig      |  2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c | 40 +++++++++++++++++++++++-----
 drivers/video/fbdev/core/Kconfig     |  6 +++++
 include/linux/fb.h                   |  4 +++
 4 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.43.1
