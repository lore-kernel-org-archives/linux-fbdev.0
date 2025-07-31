Received: from c64.rulez.org (c64.rulez.org [79.139.58.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B5E1632DF
	for <linux-fbdev@vger.kernel.org>; Thu, 31 Jul 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.139.58.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753983068; cv=none; b=rdUdUl9P7WwR+ltwctxARKZS2FJQI4MMwTidbIqDcpI6X9z/BSjvGMflSmPAcYbbbUEtELHWr1kz+Y3RMBtc7JlXSPWZq6vDQr/+S078xlMUYJsEOZw5VIR+TkOWU0AuuLprtlys4jRC5fmdde7dYaKJ1sPzYAxhEbESiJlKJXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753983068; c=relaxed/simple;
	bh=dITYNCme5p+a6QkqNB9VXspm82nDvtdImgPVKx+xp1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uuNwhW1qAJhW2CAasHIla7y1d7wzuQ9FUQvUlge3Ltkka98tM+GxQwOaVVngX1OQ6bValEB9X3569LIrS4/IcFGsGKatnfmBjur+u7jYdl0ZDRZNuRK9AuTybNhwdG22SR0YhA3TchFLwaZNi+ktzB49IgAoTK0CKCYsEa1UG4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org; spf=pass smtp.mailfrom=c64.rulez.org; arc=none smtp.client-ip=79.139.58.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c64.rulez.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c64.rulez.org
Received: by c64.rulez.org (Postfix, from userid 1000)
	id 9BCE110136; Thu, 31 Jul 2025 19:21:08 +0200 (CEST)
From: Zsolt Kajtar <soci@c64.rulez.org>
To: linux-fbdev@vger.kernel.org
Cc: Zsolt Kajtar <soci@c64.rulez.org>
Subject: [PATCH] fbdev: core: Add checks for vc_resize failures
Date: Thu, 31 Jul 2025 19:15:52 +0200
Message-Id: <20250731171552.33585-1-soci@c64.rulez.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Whenever fbcon resizes the framebuffer the virtual console size is set
to match the new geometry. This ensures that the content won't end up
off-screen.

But in very rare cases vc_resize() can fail. If one follows the syzbot
monthly reports then this isn't all that rare because allocation
fault injection can do that reliably. Usually the one in
fbcon_set_disp.

Handling these failures gracefully and rolling back the resize isn't
trivial effort, at least for me. So the next best thing is to add
BUG_ON() checks.

In theory these checks shouldn't trigger normally. But when they do
memory corruption is prevented.

One check was left out in fbcon_startup.c, that's not a mistake. It
needs more investigation as it triggers on boot for me.

Signed-off-by: Zsolt Kajtar <soci@c64.rulez.org>
---
 drivers/video/fbdev/core/fbcon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 2df480376..b9b65ae32 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1144,7 +1144,7 @@ static void fbcon_init(struct vc_data *vc, bool init)
 		vc->vc_cols = new_cols;
 		vc->vc_rows = new_rows;
 	} else
-		vc_resize(vc, new_cols, new_rows);
+		BUG_ON(vc_resize(vc, new_cols, new_rows));
 
 	if (logo)
 		fbcon_prepare_logo(vc, info, cols, rows, new_cols, new_rows);
@@ -1412,7 +1412,7 @@ static void fbcon_set_disp(struct fb_info *info, struct fb_var_screeninfo *var,
 	rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 	cols /= vc->vc_font.width;
 	rows /= vc->vc_font.height;
-	vc_resize(vc, cols, rows);
+	BUG_ON(vc_resize(vc, cols, rows));
 
 	if (con_is_visible(vc)) {
 		update_screen(vc);
@@ -2682,7 +2682,7 @@ static void fbcon_modechanged(struct fb_info *info)
 		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 		cols /= vc->vc_font.width;
 		rows /= vc->vc_font.height;
-		vc_resize(vc, cols, rows);
+		BUG_ON(vc_resize(vc, cols, rows));
 		updatescrollmode(p, info, vc);
 		scrollback_max = 0;
 		scrollback_current = 0;
@@ -2725,7 +2725,7 @@ static void fbcon_set_all_vcs(struct fb_info *info)
 		rows = FBCON_SWAP(ops->rotate, info->var.yres, info->var.xres);
 		cols /= vc->vc_font.width;
 		rows /= vc->vc_font.height;
-		vc_resize(vc, cols, rows);
+		BUG_ON(vc_resize(vc, cols, rows));
 	}
 
 	if (fg != -1)
-- 
2.30.2

