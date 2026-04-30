Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630F16FC5;
	Thu, 30 Apr 2026 06:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777528907; cv=none; b=FWUIjR8oowP6Oeii6fdy964B6eIZaalhhPxyK21dSWpiRqQXUMRe2OVu2i9d391DJzcVxsRotdu6BIIlr0bQHjV8A2NrEvziTSzCRPVGIFlEMoZJ+VgNf4fEI4rNw54nH6FDp5RmupIHlc+z1Bb7YL7eY1yCHYwDCKwjjtm2Ly0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777528907; c=relaxed/simple;
	bh=Os2X++cj3HNUfvqVn7n7PcsOOi64ihdj36ERIxNfuvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TdtQGzA5es+ELkXktI7Eh7hM7TJxQwp3n49XK19pW3vkilKnMMs3XF3bv985SjxVOh591m/RaY3jMG4bTLCsrgsGqVJL6LGabIGpm54vgGJgj+UlE9iQMAfGeq1D7hQW99+6U8qWD/S4lPQuI9Yhiw6phTYfOYb/WdJHDDnN0f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 0eb9ac86445a11f1aa26b74ffac11d73-20260430
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:7b426810-9e7d-407f-951f-abdfb5810312,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:c130f4c0ec06df3c7f4d462a8b4d6f0c,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 0eb9ac86445a11f1aa26b74ffac11d73-20260430
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yaolu@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 20162764; Thu, 30 Apr 2026 14:01:40 +0800
From: yaolu@kylinos.cn
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] fbcon: don't suspend/resume when vc is graphics mode
Date: Thu, 30 Apr 2026 14:01:37 +0800
Message-Id: <20260430060137.131107-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lu Yao <yaolu@kylinos.cn>

Don't need to do suspend/resume for fbcon in graphic mode.

Doing this may cause error, eg:
  At the beginning, starting the Xorg with single screen and then an
  external screen was plugged in. After logging out in Xorg, fbdev
  info may using screen which is connected later on for info always
  using first connected connector in list in func 'drm_setup_crtcs_fb'.
  Then, S3 executed, fbcon found that the information did not match
  and do atomic to switch fb. However, Xorg will not re-bind the crtc
  fb but continues doing ioctl. At this time, the fb is incorrect.

Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/video/fbdev/core/fbcon.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b0e3e765360d..450e690d0bd2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2602,8 +2602,9 @@ void fbcon_suspended(struct fb_info *info)
 		return;
 	vc = vc_cons[par->currcon].d;
 
-	/* Clear cursor, restore saved data */
-	fbcon_cursor(vc, false);
+	/* Don't need to clear cursor and restore saved data in graphic mode */
+	if (vc->vc_mode != KD_GRAPHICS)
+		fbcon_cursor(vc, false);
 }
 
 void fbcon_resumed(struct fb_info *info)
@@ -2615,7 +2616,9 @@ void fbcon_resumed(struct fb_info *info)
 		return;
 	vc = vc_cons[par->currcon].d;
 
-	update_screen(vc);
+	/* Graphics mode is managed by userspace */
+	if (vc->vc_mode != KD_GRAPHICS)
+		update_screen(vc);
 }
 
 static void fbcon_modechanged(struct fb_info *info)
-- 
2.25.1

