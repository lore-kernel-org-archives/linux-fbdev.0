Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2DF199EB4
	for <linux-fbdev@vger.kernel.org>; Mon, 23 Sep 2024 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727107085; cv=none; b=pP9aeKjEG0t5ijIVJtrcQMfLVOLjJv1NZfdN9HZy39OkJY1U3KutflZrclQJLB88OWMSPHweQjggApe7jjgoxrPSvEs+6L/xOtcLXF8MJnHprER8d+KUQGLJCC6g3aYacnH8rDR+5YUXBaqxdzGDEwuffK8WSoYunWfoUWt24Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727107085; c=relaxed/simple;
	bh=W5gtcbCYp4vJg4Flsqj3JabmZDfdkYxI+vhYsmZg/pU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lvivjj00StvL38ROoJbllxBQkDLPr8sdOngLbYk5CZYAIflLiiRWJcJ5NUw2c+QPRLvWolec6gSevKxBEDtpIiVxy8wqvGNiuvLbuHlTD3hcN9xDH3qT9fY3b2HyoybgtuGRwM8DYalNN4k7/toE+SkC186VbJJlzSbt4Dk1QSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bTwIBCXQ; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bTwIBCXQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727107084; x=1758643084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=W5gtcbCYp4vJg4Flsqj3JabmZDfdkYxI+vhYsmZg/pU=;
  b=bTwIBCXQbo+JQhmI+q6vLAOvo+qh8Yd6840IhRk14dwJltn+gNvTEkBl
   01f6uJLM7jTA/XOn8ZWqF+ctGWdz83/rIjc/GrZCT3ztURbrScc/FhfEy
   kZexnyt9jwALLXc1kj2eUJkbJzVIrP1iW4DbB3EnXnsNBRs8zrwh4zxds
   3+UwL4/Bi/luEO+MnFPssZ8Vr2bXrSI06273uyrXHhHmHHBrYVdr48CK5
   E3paJMm3fFr6shXA9/rqImv20VymcrI/qw8exNgIdsS4dedpaGdb+8oui
   3hM9v0wmml3NByAizPtIv32mORmuFkpc03WhrRINCu/a0plXC1VN0TPoU
   A==;
X-CSE-ConnectionGUID: eJxHZbTtR3Ch7OONlcPJKQ==
X-CSE-MsgGUID: cqqW5A1TTNWwMyHmsBKEAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="28957233"
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="28957233"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 08:58:04 -0700
X-CSE-ConnectionGUID: +1YXDUogTT+AIac5L1RowA==
X-CSE-MsgGUID: e1tmV5n9QKGm46YWyYlpqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,251,1719903600"; 
   d="scan'208";a="71250782"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by fmviesa008.fm.intel.com with SMTP; 23 Sep 2024 08:58:01 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 23 Sep 2024 18:58:00 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-fbdev@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 3/6] fbcon: fbcon_cursor_noblink -> fbcon_cursor_blink
Date: Mon, 23 Sep 2024 18:57:46 +0300
Message-ID: <20240923155749.30846-4-ville.syrjala@linux.intel.com>
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

Invert fbcon_cursor_noblink into fbcon_cursor_blink so that:
- it matches the sysfs attribute exactly
- avoids having to do these NOT operations all over the place

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/video/fbdev/core/fbcon.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bbe332572ca7..eb30aa872371 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -166,7 +166,7 @@ static const struct consw fb_con;
 
 #define advance_row(p, delta) (unsigned short *)((unsigned long)(p) + (delta) * vc->vc_size_row)
 
-static int fbcon_cursor_noblink;
+static int fbcon_cursor_blink;
 
 #define divides(a, b)	((!(a) || (b)%(a)) ? 0 : 1)
 
@@ -399,7 +399,7 @@ static void fbcon_add_cursor_work(struct fb_info *info)
 {
 	struct fbcon_ops *ops = info->fbcon_par;
 
-	if (!fbcon_cursor_noblink)
+	if (fbcon_cursor_blink)
 		queue_delayed_work(system_power_efficient_wq, &ops->cursor_work,
 				   ops->cur_blink_jiffies);
 }
@@ -3214,7 +3214,7 @@ static ssize_t rotate_show(struct device *device,
 static ssize_t cursor_blink_show(struct device *device,
 				 struct device_attribute *attr, char *buf)
 {
-	return sysfs_emit(buf, "%d\n", !fbcon_cursor_noblink);
+	return sysfs_emit(buf, "%d\n", fbcon_cursor_blink);
 }
 
 static ssize_t cursor_blink_store(struct device *device,
@@ -3230,7 +3230,7 @@ static ssize_t cursor_blink_store(struct device *device,
 	console_lock();
 	idx = con2fb_map[fg_console];
 
-	fbcon_cursor_noblink = !blink;
+	fbcon_cursor_blink = blink;
 
 	if (idx == -1 || fbcon_registered_fb[idx] == NULL)
 		goto err;
-- 
2.44.2

