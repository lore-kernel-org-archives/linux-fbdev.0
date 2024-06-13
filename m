Received: from riemann.telenet-ops.be (riemann.telenet-ops.be [195.130.137.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C55A14C59A
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 19:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.130.137.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718306304; cv=none; b=PayFaTQHc9eH1OKcQPZYdoNawmQ2kI8/4ca97jpmFdD+R1YT7YEHOBxxzysWSlTZVphtzVMRzRMPTbTugl29c5IhaVXiV9tY2jsDANcTQOQGQPqy4vwY8T1bXkaT6US45+yhF8hPKJ8jbGyT/i2eWL+pIBWTbw0tIRPFhBPOeaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718306304; c=relaxed/simple;
	bh=FnN05GM8vDYZMAvxvHkfN+j13yu2M7/BW/pNimOsW8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BbebGDHkeaDHXjKIGgslcrERjKuzWW2xO9UM+4fDc/N0P83DRLocnqN7JsxxwRLhsPJRlSDO7KGV8FAeJtMeXUcX6yFEurPC6QlhEdEL6LViYgau5yBhr+Y11Olo09C67NEkbqHIXeHrLE7npgpA8Y/gGyF+7XF1O40Pku5INFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be; spf=none smtp.mailfrom=linux-m68k.org; arc=none smtp.client-ip=195.130.137.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux-m68k.org
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
	by riemann.telenet-ops.be (Postfix) with ESMTPS id 4W0XHq5qNCz4x2LQ
	for <linux-fbdev@vger.kernel.org>; Thu, 13 Jun 2024 21:18:15 +0200 (CEST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed80:be2a:f066:50f0:dff7])
	by michel.telenet-ops.be with bizsmtp
	id b7J62C00A3w30qz067J6ad; Thu, 13 Jun 2024 21:18:08 +0200
Received: from rox.of.borg ([192.168.97.57])
	by ramsan.of.borg with esmtp (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpwS-00Ax6x-Fm;
	Thu, 13 Jun 2024 21:18:06 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
	(envelope-from <geert@linux-m68k.org>)
	id 1sHpxW-00FL8f-GF;
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
Subject: [PATCH v2 4/7] drm/panic: Spelling s/formater/formatter/
Date: Thu, 13 Jun 2024 21:18:02 +0200
Message-Id: <5a11f8caf8759aaa22d421034d3047368e9d5f33.1718305355.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718305355.git.geert+renesas@glider.be>
References: <cover.1718305355.git.geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a misspelling of "formatter".

Fixes: 54034bebb22fd4be ("drm/panic: Add a kmsg panic screen")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - New.
---
 drivers/gpu/drm/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
index a9972ce05d7e6fe4..e3c51009d9b476b3 100644
--- a/drivers/gpu/drm/Kconfig
+++ b/drivers/gpu/drm/Kconfig
@@ -138,7 +138,7 @@ config DRM_PANIC_DEBUG
 	  If in doubt, say "N".
 
 config DRM_PANIC_SCREEN
-	string "Panic screen formater"
+	string "Panic screen formatter"
 	default "user"
 	depends on DRM_PANIC
 	help
-- 
2.34.1

