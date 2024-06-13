Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3D6314C5BA
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 19:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306297; cv=none; b=X2WkXEz0rEF7Q5tIe7mxOjvVqGD+zvfvNQg9VuK+IYQgtv3PAL9Ju3E9j/EwBh/v2YeeK1ysoWbqkhPthZgDgW/Szm19VFWHnmSXQN75eIo9T2Ge81rnTlLSBcYv3O68ozYnP4997MHJ09Z1bq9kvUZJW0sif4dQwj/bWkr2jxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306297; c=relaxed/simple;
	bh=SteWlDtqVG4RLnqZvL1arCk2m03QFmc7dLGN3aHEwK0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SHqQa/XbSe+jR6tKUN4DtOEvvumSUH2O6mEra+kBHA8m4Beu1E8+ga3kYbXvpaAvatNoSpWiQ/L3tR+VjeiaqgSib3tY9N9huEj/a1KzX2NeU5Pf4h0ObRbAwBBEaPtOHaKK09uCrYW+9UoOT7amIi8eMgwwsUIqGrXjTHpWFiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:be2a:f066:50f0:dff7])
	by laurent.telenet-ops.be with bizsmtp
	id b7J62C0083w30qz017J6YX; Thu, 13 Jun 2024 21:18:08 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpwS-00Ax6i-C0;
	Thu, 13 Jun 2024 21:18:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpxW-00FL8Q-AI;
	Thu, 13 Jun 2024 21:18:06 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jocelyn Falempe <jfalempe@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2 0/7] drm/panic: Fixes and graphical logo
Date: Thu, 13 Jun 2024 21:17:58 +0200
Message-Id: <cover.1718305355.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

	Hi all,

If drm/panic is enabled, a user-friendly message is shown on screen when
a kernel panic occurs, together with an ASCII art penguin logo.
Of course we can do better ;-)
Hence this patch series extends drm/panic to draw the monochrome
graphical boot logo, when available, preceded by the customary fixes.

Changes compared to v1:
  - Rebase against today's drm-misc-next, where drm_panic is broken on
    all current drivers due to an uninitialized pointer dereference.
    Presumably this was only tested with an out-of-tree driver change?
  - New fixes [1/7], [3/7], and [4/7],
  - New cleanup [5/7],
  - Inline trivial draw_logo_mono().

This has been tested with rcar-du.

Thanks for your comments!

Geert Uytterhoeven (7):
  drm/panic: Fix uninitialized drm_scanout_buffer.set_pixel() crash
  drm/panic: Fix off-by-one logo size checks
  lib/fonts: Fix visiblity of SUN12x22 and TER16x32 if DRM_PANIC
  drm/panic: Spelling s/formater/formatter/
  drm/panic: Convert to drm_fb_clip_offset()
  drm/panic: Rename logo to logo_ascii
  drm/panic: Add support for drawing a monochrome graphical logo

 drivers/gpu/drm/Kconfig     |  2 +-
 drivers/gpu/drm/drm_panic.c | 74 +++++++++++++++++++++++++++++++------
 drivers/video/logo/Kconfig  |  2 +
 lib/fonts/Kconfig           |  6 ++-
 4 files changed, 70 insertions(+), 14 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
