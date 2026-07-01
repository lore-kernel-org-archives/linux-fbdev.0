Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC943FA5CB
	for <linux-fbdev@vger.kernel.org>; Wed,  1 Jul 2026 23:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782947840; cv=none; b=DH2f+HbAiaIAlKBsR0CWVqSZyNUHIVMneIkX5t25UHtTmAXSnNurNJrJSk0E07VpNLWvG3KV1HBt9xL6K+7nOCMSmVWUQ0JxmPauPL1Dbfu9AszLFeTlXkM3/VS7xfDtIOtJRE90QJsaYVKFDcemIB1BQCtZ1XQy3NRLLROcLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782947840; c=relaxed/simple;
	bh=NwvngB55nrQuY2zsw+u/UlQ+ziOq9i4AgvNGIC5B8qg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=SdAKy8NZgIG3h/t0VHxlb4VjmB6jpWde7AxFYM1mDbM7MDBEDEizg4SD830c+xyRBOMqp+tZxTfrmxvqdmV/LEtSfXWs5AdpU027G9t37zlMLxOP+Yf24UvJdS7RRC8jafwcomO95oJSijPDZr6IatH3ZHCGxxUsM3auzXOKq/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSIpZY85; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSIpZY85"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb5829fd5so899766e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 01 Jul 2026 16:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782947832; x=1783552632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
        b=CSIpZY85TZwwhMrmUWTKmXQvvXKXXOigC5Y+Y1i+1fTGxltzauMeK4jdgB6AK7ULox
         bB2EnJSIU0+H88MQ2m3GgqimnNrTBiQUolZKiYTuQUJLUvhsGEG4WMWVKFanimUfpDC1
         X1wuGCSE4N/ffZJhWwn0roSjXEJ+Yb8GMlsmZMKCvjUolGEY3/UzFa9WetnEdt47Bt08
         ZeJietjzyb/MH9auiw5RHlZ/7hV1vd/4Q8AqevCiJpmGjf71JccOpivyhu6cq0xDpcc1
         qjV5D/lyvVQ232y+qXcVRatyslA1FXz/UDTHUJ5fR5IUNeDdA+3FPxaHqAw97oHKM9ez
         XJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782947832; x=1783552632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HjOEsE0qEDjFyTwl3K+CtParcmWNsl4rWJyxgaM5lGk=;
        b=Hl3EvsVQPIB6plUXKwoydE0KaHJg+tGTPkTEQvbdkbzTFF9zdtwVyCiRg6ds4kulRW
         LtNmsKjnnxv8/VS2i4XX8dcmgj2xJXRWBN3bodkK4xm1C4f03WpRdorn43NL1SJGAxyC
         qSI+4ZfG9naSzavYAoxhKjr4rSd9N29LnRfQxudDCOm9uuF/1jvVeDgBJlAsN5bnQ/U8
         7BD4qx1lw6mIYmNvHnBYPMgE1SyCBpqX9IZJiUksAiUamVsOOJD9IvQgy+5XBCcaY2uA
         +EdXWmEW4Ax5uZsDMyNPhtcbOxlnz6jbGV43XGs8Wgteh+pOSzzW7XndQeVnxJhyXKs1
         oYiA==
X-Gm-Message-State: AOJu0Yz2miYHGhUK0nCtJ0kwC+PsLY4g6Amv6Bvyy43GFfxwY2FuaVnd
	R7OZ8AKvt1SH1URYjzSRRcTMv4dcpdKSYAJwgz2GvTvexClmiIc1dF1B
X-Gm-Gg: AfdE7cnGdyXCfSbQtBnYzuRLhp/Ia3K3BtVsA4iRPal+Q2+q22uTiKfRAulZ4c5VxUA
	F7IJEMyOVsvsyEmfKMzg9dsav4zUsSKUBw26jHxNhfdBS+Pfwkx9NDY4RVirfL9aST0wcAOjx16
	CmYpgXR3AZy99XXWsYICDurxyV4yndB+PSb97eFLcovpFU8rGkAhwm5PjRugNFyeucPfggttXwb
	vdkMohAcb0eJdV6xixedAQw1h/KSmPCYhz+PyjQ/0lfb2X7+oWQJOLDiaNPVnM3Pkj6abbBXbnk
	njZOQ/M+ilZhdcx0VQnC9dSR5gkn72ZpJTixUM/FuM44CleQwlouCDrmtzoFkgBtDASd0wVdWBy
	I6y3WpJYhKfFDSNCbDLCjbdEjYMOfrM1iJ+jMD7MiFCGCL2evZDcTmrDH6/p0rANHHO1Faw39yj
	2qY5+DbpyhXgD9ICwEbK9bZsl8a0dbEVj36CqJQ0v+ow==
X-Received: by 2002:a05:6512:8387:b0:5ae:9c19:165c with SMTP id 2adb3069b0e04-5aec7fe9d35mr502903e87.7.1782947832122;
        Wed, 01 Jul 2026 16:17:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:4f9:2a:1c13::2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec8991974sm308950e87.4.2026.07.01.16.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 16:17:10 -0700 (PDT)
From: Melbin K Mathew <mlbnkm1@gmail.com>
To: deller@gmx.de
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Melbin K Mathew <mlbnkm1@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/2] fbdev: bound mode sysfs output to the sysfs buffer
Date: Thu,  2 Jul 2026 01:17:05 +0200
Message-Id: <20260701231706.234715-2-mlbnkm1@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260701221757.231490-1-mlbnkm1@gmail.com>
References: <20260701221757.231490-1-mlbnkm1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mode_string() uses snprintf() which can return a value larger than the
remaining buffer space. show_modes() accumulates the return value into i
without checking whether i has reached PAGE_SIZE, causing the offset to
advance past the sysfs buffer if the modelist is long enough.

Add a size parameter to mode_string() and use scnprintf() to return
only the bytes actually written. Add an early return when offset
already exceeds the buffer. In show_modes(), stop accumulating once
the buffer is full.

Cc: stable@vger.kernel.org
Signed-off-by: Melbin K Mathew <mlbnkm1@gmail.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index ea196603c7..af21dc5052 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -27,12 +27,15 @@ static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 	return 0;
 }
 
-static int mode_string(char *buf, unsigned int offset,
+static int mode_string(char *buf, size_t size, unsigned int offset,
 		       const struct fb_videomode *mode)
 {
 	char m = 'U';
 	char v = 'p';
 
+	if (offset >= size)
+		return 0;
+
 	if (mode->flag & FB_MODE_IS_DETAILED)
 		m = 'D';
 	if (mode->flag & FB_MODE_IS_VESA)
@@ -45,7 +48,7 @@ static int mode_string(char *buf, unsigned int offset,
 	if (mode->vmode & FB_VMODE_DOUBLE)
 		v = 'd';
 
-	return snprintf(&buf[offset], PAGE_SIZE - offset, "%c:%dx%d%c-%d\n",
+	return scnprintf(&buf[offset], size - offset, "%c:%dx%d%c-%d\n",
 	                m, mode->xres, mode->yres, v, mode->refresh);
 }
 
@@ -64,7 +67,7 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i = mode_string(mstr, 0, mode);
+		i = mode_string(mstr, sizeof(mstr), 0, mode);
 		if (strncmp(mstr, buf, max(count, i)) == 0) {
 
 			var = fb_info->var;
@@ -86,7 +89,7 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 	if (!fb_info->mode)
 		return 0;
 
-	return mode_string(buf, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -136,7 +139,9 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	i = 0;
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
-		i += mode_string(buf, i, mode);
+		i += mode_string(buf, PAGE_SIZE, i, mode);
+		if (i >= PAGE_SIZE - 1)
+			break;
 	}
 	return i;
 }
-- 
2.39.5

