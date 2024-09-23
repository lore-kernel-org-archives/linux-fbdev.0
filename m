Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA37619E98D
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 15:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107092; cv=none; b=mVyEid4goVsawZdLjIa5MqnkH+2sjPHdVZGbCi2yVHZZLcKdaL5B/amDA6QE/TrVeycGL3eXSJoPqf3lYcrXqJFFZbctqyno9LC0hpj7E2khIUNH8PAr7BAEuhQw1zT6b/PfPtb1/wIO01xCJRlRGGv/LyVwLpXfZeDBft7lnSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107092; c=relaxed/simple;
	bh=ioMlxfqrEyEKt60+tus+rcbN4bz1k4k6ASpLmIUzo3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+u+S7V3kEf39SKYK+EH+3QvG30DV86iV2yRp3sAep5bjQB9+w+WJevb/mGfREOJr/Y7c8ObUAX3PxfprYeOq7lNhLI41/hA2rBzqJ+hFf84lTQQGNZm2oPZSFqVjQnkzVC5Z6m0gSB1YmoCGpxdE0qpHBwBiKCtAZ1Q6gGjZDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a8g+2S3M; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a8g+2S3M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107091; x=1758643091;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ioMlxfqrEyEKt60+tus+rcbN4bz1k4k6ASpLmIUzo3M=;
  b=a8g+2S3MWNpQmLPNfUaGrHzjugyWPuC+ty7wUltJHte8JqisbIBr+QDA
   H0UFROLwLlVhM0MOVLku2wtIJfJOhkpNyyEmHEx9uaAARPDykQ2WtQx7a
   JOVYw8XSdfLXxAcG+eW1kpZfB3Sw41pNgwlIxoLClEaKtjV+gK5/gks9g
   Vxpv5AEsLsbrC7x9Pub0Z3tWXtpF7ngQZECGyuNIS5Mxq3tGQa3vbbyB3
   fJmv7STs8+r+dhmzq3DccVy+tffalMEsGoag+PgjnNdOzi/8U0BL6sNkj
   dsrKCgCspE+mvAQcVHDQBexXFeZnDwX/wtJ73BQ7oVr2W1p22R9PstvJW
   g==;
X-CSE-ConnectionGUID: WpwOd2swTaiboyMvHQ9mdw==
X-CSE-MsgGUID: IjT7poGYSzmpXeR2vTffJw==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="28957248"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="28957248"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:58:10 -0700
X-CSE-ConnectionGUID: e2PE3l61Rm6FavEXs0dpCQ==
X-CSE-MsgGUID: 7Y3lK0UMSkiai1r3QFe/Dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71250798"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 08:58:08 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2024 18:58:07 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 5/6] fbcon: Introduce get_{fg,bg}_color()
Date: Mon, 23 Sep 2024 18:57:48 +0300
Message-ID: <20240923155749.30846-6-ville.syrjala@linux.intel.com>
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

Make the code more legible by adding get_{fg,bg}_color()
which hide the obscure 'is_fg' parameter of get_color()
from the caller.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/video/fbdev/core/fbcon.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 2a78cca3e9de..17540cdf1edf 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -356,6 +356,16 @@ static int get_color(struct vc_data *vc, struct fb_info *info,
 	return color;
 }
 
+static int get_fg_color(struct vc_data *vc, struct fb_info *info, u16 c)
+{
+	return get_color(vc, info, c, 1);
+}
+
+static int get_bg_color(struct vc_data *vc, struct fb_info *info, u16 c)
+{
+	return get_color(vc, info, c, 0);
+}
+
 static void fb_flashcursor(struct work_struct *work)
 {
 	struct fbcon_ops *ops = container_of(work, struct fbcon_ops, cursor_work.work);
@@ -387,8 +397,9 @@ static void fb_flashcursor(struct work_struct *work)
 
 	c = scr_readw((u16 *) vc->vc_pos);
 	enable = ops->cursor_flash && !ops->cursor_state.enable;
-	ops->cursor(vc, info, enable, get_color(vc, info, c, 1),
-		    get_color(vc, info, c, 0));
+	ops->cursor(vc, info, enable,
+		    get_fg_color(vc, info, c),
+		    get_bg_color(vc, info, c));
 	console_unlock();
 
 	queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
@@ -1297,8 +1308,8 @@ static void fbcon_putcs(struct vc_data *vc, const u16 *s, unsigned int count,
 
 	if (fbcon_is_active(vc, info))
 		ops->putcs(vc, info, s, count, real_y(p, ypos), xpos,
-			   get_color(vc, info, scr_readw(s), 1),
-			   get_color(vc, info, scr_readw(s), 0));
+			   get_fg_color(vc, info, scr_readw(s)),
+			   get_bg_color(vc, info, scr_readw(s)));
 }
 
 static void fbcon_clear_margins(struct vc_data *vc, int bottom_only)
@@ -1331,8 +1342,9 @@ static void fbcon_cursor(struct vc_data *vc, bool enable)
 	if (!ops->cursor)
 		return;
 
-	ops->cursor(vc, info, enable, get_color(vc, info, c, 1),
-		    get_color(vc, info, c, 0));
+	ops->cursor(vc, info, enable,
+		    get_fg_color(vc, info, c),
+		    get_bg_color(vc, info, c));
 }
 
 static int scrollback_phys_max = 0;
-- 
2.44.2

