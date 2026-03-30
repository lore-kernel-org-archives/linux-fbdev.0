Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5DC39E19F;
	Mon, 30 Mar 2026 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774863903; cv=none; b=iWjWQ1Fcnaw/O/IwTThq5MDF/enm0UrUFvY/zqWNCeHN1e0t5I6UGB07ZE068HJQP1uxb8R109FXOaNIB7ADscn5HLjcn4uC0saEjMvdHkZDJNVYG99xuqFOJl4HDl+XQwX+LuqgZFkTkhh91EPbIaC/jHY5WYzPJ6sG9GnCczE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774863903; c=relaxed/simple;
	bh=Sz0/hhHIxqEOXmnZQSPgUvXkYl6pYEZctCaAA/LA6A4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pdf+0v56fqnwgCwdpo1hl+uSlkbFX8+W3uK+HB1pqPXAIAx6ebm4G24YpACkXN+506iKtUYjsHAj/51Rr/UzVddQuueesE0j75IVkimayLL9Eqt6ZdY8AWuvTBGAfxfvneOCJbSxR+COOJrVjOaY4tHfAqO8vGed/4od83v7S2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F86FC4CEF7;
	Mon, 30 Mar 2026 09:45:02 +0000 (UTC)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] fbdev: atyfb: Remove unused fb_list
Date: Mon, 30 Mar 2026 11:44:59 +0200
Message-ID: <571a3e072a2eef5a587d768d74559fc549b03ab6.1774863796.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With clang and W=1:

    drivers/video/fbdev/aty/atyfb_base.c:2327:24: warning: variable 'fb_list' set but not used [-Wunused-but-set-global]
	2327 | static struct fb_info *fb_list = NULL;

Indeed, the last user of fb_list was removed in 2004, while the actual
linked list was removed in 2002.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202603300931.osMYxYZ7-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index d5e107730a4d75dd..9fc5af09f86c4df2 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -2324,8 +2324,6 @@ static void aty_calc_mem_refresh(struct atyfb_par *par, int xclk)
  * Initialisation
  */
 
-static struct fb_info *fb_list = NULL;
-
 #if defined(__i386__) && defined(CONFIG_FB_ATY_GENERIC_LCD)
 static int atyfb_get_timings_from_lcd(struct atyfb_par *par,
 				      struct fb_var_screeninfo *var)
@@ -2758,8 +2756,6 @@ static int aty_init(struct fb_info *info)
 #endif
 	}
 
-	fb_list = info;
-
 	PRINTKI("fb%d: %s frame buffer device on %s\n",
 		info->node, info->fix.id, par->bus_type == ISA ? "ISA" : "PCI");
 	return 0;
-- 
2.43.0

