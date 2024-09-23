Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F5C19CC0D
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107089; cv=none; b=JKvqMQrzwpTQlvS+QPMuoNgKiIDpn7UJj98r9s/MUj5Ob+HJMKnQQ1E27ZSPDN40RLpfq/yzBjfM0F91uDzfFnmBsZQ1+COqOog1LQ4/Azi+VwDKGUPK74EY+eOQDqhZsP2ABLtl8kE6FCfnbnDb0Xc7wC75QVKTkCfol0tbS74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107089; c=relaxed/simple;
	bh=Dhz4yoGnGvFhypQ5PyRJUXFCPK7llw2F8XmGuSmqvkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=svjVP/p89V25hY9qu4/9ASJ2MSC6sA3qnrjNUdjUUIBQUGFskXvz/gO62NsU/KoKjIrGg272YzqN4C0OiwESnC63BOPhTIjX6dxG40PgN75C3FeDD28eaQvsAZlPr6w8d6ALCjiNfL+TFJ04tXiu5iWDmza/24d7RAmMEFTtIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnJUx3Cc; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnJUx3Cc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107087; x=1758643087;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Dhz4yoGnGvFhypQ5PyRJUXFCPK7llw2F8XmGuSmqvkw=;
  b=GnJUx3CcodTJTPNZW39kxJ1c2mCLstH08NXYnwvttOj3U3q/j/7wC/a2
   pM2czrF1YTVYgFdFayNzRHeLgfoDpXPteNr2eUXrzK3dnpWFieSlnb1ux
   QNWRRTIo/8WFPeQ0+OQ9haysFOHyci79BVYddr7Jajwb1SbP6UEW76Oq8
   y4WP3zSJFCK7lRDPMNi1KPeN5d4yOlvhtC2bxEdVV+JzuESA58cmR5ALW
   muGnNUR0R4rWE5Z/Yf7eiAuGwmbFB/vxVBKNJrkfFpGT0cy/nNYy5NIdL
   3aZA7GD0BMBdPJyqKAj2EU7wMeJYrEbhVQUaGmyKVuSwaylLTtRTU+tPV
   g==;
X-CSE-ConnectionGUID: 3+xADbghSpyKPPwN311IIQ==
X-CSE-MsgGUID: 17U91C0OTqi2AxcPad65WQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="28957241"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="28957241"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:58:07 -0700
X-CSE-ConnectionGUID: 2sUuxskQQwuC1pJck0EGog==
X-CSE-MsgGUID: bnMx7RZVTzOzWa+hp55oXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71250790"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 08:58:04 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2024 18:58:03 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/6] fbcon: fbcon_is_inactive() -> fbcon_is_active()
Date: Mon, 23 Sep 2024 18:57:47 +0300
Message-ID: <20240923155749.30846-5-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.44.2
In-Reply-To: <20240923155749.30846-1-ville.syrjala@linux.intel.com>
References: <20240923155749.30846-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Invert fbcon_is_inactive() into fbcon_is_active(). Much easier
on the poor brain when you don't have to do dobule negations
all over the place.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/video/fbdev/core/fbcon.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index eb30aa872371..2a78cca3e9de 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -281,12 +281,12 @@ static bool fbcon_skip_panic(struct fb_info *info)
 #endif
 }
 
-static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
+static inline int fbcon_is_active(struct vc_data *vc, struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	return (info->state != FBINFO_STATE_RUNNING ||
-		vc->vc_mode != KD_TEXT || ops->graphics || fbcon_skip_panic(info));
+	return info->state == FBINFO_STATE_RUNNING &&
+		vc->vc_mode == KD_TEXT && !ops->graphics && !fbcon_skip_panic(info);
 }
 
 static int get_color(struct vc_data *vc, struct fb_info *info,
@@ -1253,7 +1253,7 @@ static void __fbcon_clear(struct vc_data *vc, unsigned int sy, unsigned int sx,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	u_int y_break;
 
-	if (fbcon_is_inactive(vc, info))
+	if (!fbcon_is_active(vc, info))
 		return;
 
 	if (!height || !width)
@@ -1295,7 +1295,7 @@ static void fbcon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_is_inactive(vc, info))
+	if (fbcon_is_active(vc, info))
 		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
 			   get_color(vc, info, scr_readw(s), 1),
 			   get_color(vc, info, scr_readw(s), 0));
@@ -1306,7 +1306,7 @@ static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_is_inactive(vc, info))
+	if (fbcon_is_active(vc, info))
 		ops->clear_margins(vc, info, margin_color, bottom_only);
 }
 
@@ -1318,7 +1318,7 @@ static void fbcon_cursor(struct vc_data *vc, bool enable)
 
 	ops->cur_blink_jiffies = msecs_to_jiffies(vc->vc_cur_blink_ms);
 
-	if (fbcon_is_inactive(vc, info) || vc->vc_deccm != 1)
+	if (!fbcon_is_active(vc, info) || vc->vc_deccm != 1)
 		return;
 
 	if (vc->vc_cursor_type & CUR_SW)
@@ -1724,7 +1724,7 @@ static void fbcon_bmove(struct vc_data *vc, int sy, int sx, int dy, int dx,
 	struct fb_info *info = fbcon_info_from_console(vc->vc_num);
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 
-	if (fbcon_is_inactive(vc, info))
+	if (!fbcon_is_active(vc, info))
 		return;
 
 	if (!width || !height)
@@ -1748,7 +1748,7 @@ static bool fbcon_scroll(struct vc_data *vc, unsigned int t, unsigned int b,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int scroll_partial = info->flags & FBINFO_PARTIAL_PAN_OK;
 
-	if (fbcon_is_inactive(vc, info))
+	if (!fbcon_is_active(vc, info))
 		return true;
 
 	fbcon_cursor(vc, false);
@@ -2132,7 +2132,7 @@ static bool fbcon_switch(struct vc_data *vc)
 			fbcon_del_cursor_work(old_info);
 	}
 
-	if (fbcon_is_inactive(vc, info) ||
+	if (!fbcon_is_active(vc, info) ||
 	    ops->blank_state != FB_BLANK_UNBLANK)
 		fbcon_del_cursor_work(info);
 	else
@@ -2172,7 +2172,7 @@ static bool fbcon_switch(struct vc_data *vc)
 	scrollback_max = 0;
 	scrollback_current = 0;
 
-	if (!fbcon_is_inactive(vc, info)) {
+	if (fbcon_is_active(vc, info)) {
 	    ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
 	    ops->update_start(info);
 	}
@@ -2228,7 +2228,7 @@ static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 		}
 	}
 
- 	if (!fbcon_is_inactive(vc, info)) {
+	if (fbcon_is_active(vc, info)) {
 		if (ops->blank_state != blank) {
 			ops->blank_state = blank;
 			fbcon_cursor(vc, !blank);
@@ -2242,7 +2242,7 @@ static bool fbcon_blank(struct vc_data *vc, enum vesa_blank_mode blank,
 			update_screen(vc);
 	}
 
-	if (mode_switch || fbcon_is_inactive(vc, info) ||
+	if (mode_switch || !fbcon_is_active(vc, info) ||
 	    ops->blank_state != FB_BLANK_UNBLANK)
 		fbcon_del_cursor_work(info);
 	else
@@ -2572,7 +2572,7 @@ static void fbcon_set_palette(struct vc_data *vc, const unsigned char *table)
 	int i, j, k, depth;
 	u8 val;
 
-	if (fbcon_is_inactive(vc, info))
+	if (!fbcon_is_active(vc, info))
 		return;
 
 	if (!con_is_visible(vc))
@@ -2672,7 +2672,7 @@ static void fbcon_modechanged(struct fb_info *info)
 		scrollback_max = 0;
 		scrollback_current = 0;
 
-		if (!fbcon_is_inactive(vc, info)) {
+		if (fbcon_is_active(vc, info)) {
 		    ops->var.xoffset = ops->var.yoffset = p->yscroll = 0;
 		    ops->update_start(info);
 		}
-- 
2.44.2

