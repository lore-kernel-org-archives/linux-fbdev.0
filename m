Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1C19E965
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107095; cv=none; b=UBBnVa231W+wXsPNIomDAUkR92CNISLG1wn969UKzPY8BQsFF69R8zgHfVJFgBWZtk1Yxi2M07Q/2MXb7fToHbn8ly9QlvevLFtiZiUPp7lZAFU00nDkilySoJNpE8pBViKJBBbBbmDuZYONNwV/7UXU1JzmDKtC2/ANvewIVcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107095; c=relaxed/simple;
	bh=jQhqhShi45bE3F1tqDpD2eTLJXTwjUT+li1G1Ev3zCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5Ol6KwrJ2dPAJsExe+pMzA2yIhqg6oSM5orp8HIMDJeTGCFXGnQ9R6kD9DTlfMAquEuaX1wTWjrotpYTIsMAokxgit1/qY5YOB/2cID3f9v8QLrJwUl5u0qmtfQi016TrN8ChqHbEiu/vI9Z/A/NdwxPG6cjfWiisw939kMdSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Nj9kgCV1; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Nj9kgCV1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107094; x=1758643094;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jQhqhShi45bE3F1tqDpD2eTLJXTwjUT+li1G1Ev3zCQ=;
  b=Nj9kgCV10esHZFUEBTcYk6N6mE/TGmClNceGkB7FFEayFB8YJ246zxKd
   BvjjZVIfB/iFfuLcK7/Yhb704CplbWLvzJK9CmKnNG6yJIqs3FZdG0K7S
   N8ZaoR9UJVd5oeNlTSr/+omu+RkoIDWGlP8mxrgHqMEWzN49tFjEBjgV0
   0ZyYtKQB8Dkes74hZRewUqdPHophsFUddOxxUyyMScDTU13j215sufGc2
   sRId4JHzn/iI9Ew2LrfPhkzJ92u3Tt7wW6l8mGLNwVEcHexSTJawE2kft
   3s4kOeAsvPLIhyq/P9+g0EWmDZcO7liSMLuMsA1FIGFMNCATuuiQsOq2W
   Q==;
X-CSE-ConnectionGUID: gyp10/z8SUycEaqeZx0k5g==
X-CSE-MsgGUID: XjTPlsy3R6CUIAeeOMb6IQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="28957253"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="28957253"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:58:14 -0700
X-CSE-ConnectionGUID: Xp0mMn6aTJmrS1RKIK2Sfw==
X-CSE-MsgGUID: iLkUdrEDSV6NVfy+IynrUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71250804"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 08:58:11 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2024 18:58:10 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 6/6] fbcon: Use 'bool' where appopriate
Date: Mon, 23 Sep 2024 18:57:49 +0300
Message-ID: <20240923155749.30846-7-ville.syrjala@linux.intel.com>
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

Use 'bool' type where it makes more sense than 'int'.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/video/fbdev/core/fbcon.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 17540cdf1edf..03d48e665bba 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -129,9 +129,9 @@ static int logo_shown = FBCON_LOGO_CANSHOW;
 /* console mappings */
 static unsigned int first_fb_vc;
 static unsigned int last_fb_vc = MAX_NR_CONSOLES - 1;
-static int fbcon_is_default = 1;
+static bool fbcon_is_default = true;
 static int primary_device = -1;
-static int fbcon_has_console_bind;
+static bool fbcon_has_console_bind;
 
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY
 static int map_override;
@@ -166,7 +166,7 @@ static const struct consw fb_con;
 
 #define advance_row(p, delta) (unsigned short *)((unsigned long)(p) + (delta) * vc->vc_size_row)
 
-static int fbcon_cursor_blink;
+static bool fbcon_cursor_blink;
 
 #define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
 
@@ -281,7 +281,7 @@ static bool fbcon_skip_panic(struct fb_info *info)
 #endif
 }
 
-static inline int fbcon_is_active(struct vc_data *vc, struct fb_info *info)
+static inline bool fbcon_is_active(struct vc_data *vc, struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
@@ -290,7 +290,7 @@ static inline int fbcon_is_active(struct vc_data *vc, struct fb_info *info)
 }
 
 static int get_color(struct vc_data *vc, struct fb_info *info,
-	      u16 c, int is_fg)
+		     u16 c, bool is_fg)
 {
 	int depth = fb_get_color_depth(&info->var, &info->fix);
 	int color = 0;
@@ -358,12 +358,12 @@ static int get_color(struct vc_data *vc, struct fb_info *info,
 
 static int get_fg_color(struct vc_data *vc, struct fb_info *info, u16 c)
 {
-	return get_color(vc, info, c, 1);
+	return get_color(vc, info, c, true);
 }
 
 static int get_bg_color(struct vc_data *vc, struct fb_info *info, u16 c)
 {
-	return get_color(vc, info, c, 0);
+	return get_color(vc, info, c, false);
 }
 
 static void fb_flashcursor(struct work_struct *work)
@@ -467,7 +467,7 @@ static int __init fb_console_setup(char *this_opt)
 				last_fb_vc = simple_strtoul(options, &options, 10) - 1;
 			if (last_fb_vc < first_fb_vc || last_fb_vc >= MAX_NR_CONSOLES)
 				last_fb_vc = MAX_NR_CONSOLES - 1;
-			fbcon_is_default = 0;
+			fbcon_is_default = false;
 			continue;
 		}
 
@@ -558,7 +558,7 @@ static int do_fbcon_takeover(int show_logo)
 			con2fb_map[i] = -1;
 		info_idx = -1;
 	} else {
-		fbcon_has_console_bind = 1;
+		fbcon_has_console_bind = true;
 	}
 
 	return err;
@@ -2802,7 +2802,7 @@ static void fbcon_unbind(void)
 				fbcon_is_default);
 
 	if (!ret)
-		fbcon_has_console_bind = 0;
+		fbcon_has_console_bind = false;
 }
 #else
 static inline void fbcon_unbind(void) {}
@@ -3234,8 +3234,9 @@ static ssize_t cursor_blink_store(struct device *device,
 				  const char *buf, size_t count)
 {
 	struct fb_info *info;
-	int blink, idx;
 	char **last = NULL;
+	bool blink;
+	int idx;
 
 	blink = simple_strtoul(buf, last, 0);
 
-- 
2.44.2

