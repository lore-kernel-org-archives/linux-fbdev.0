Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874621C93AB;
	Tue, 27 Aug 2024 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772364; cv=none; b=iaVJ4h7CVftexQRYAH3ayDk0xbLiFaHRVnTU8l62VgX6ceVNX8F9nFzNgvyrk7E+iV1BR9uIA9PIa+lbzcUOf6nwv8xp/h0nr2/lBK1d6469MKxfZrAEObpq3vHFivYD4yLPQX5kpTWKODDIJKGvfs0AOE5nrFds34BLVJ5u0ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772364; c=relaxed/simple;
	bh=2fuwEC3Yp225FwaS701NUfjP1g4xTmgB08/zOpmpsAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FpVvR/F8NS9BvgxhFcETKNItzHcesYIYGSglG3pJQ/bOzzGutsRN+XXIGmFIcElVKZ6l1XlS/M/rAEiWU16KsJz9OVPqYQoGD/xFtBCHY/TPUUOyINwMatbinXMiSO8P1GVuSdxrg4Rc5KItJdTJzHXkasBbAri5RNnluD5Qf/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=DCqt5RYP; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="DCqt5RYP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724772359;
	bh=2fuwEC3Yp225FwaS701NUfjP1g4xTmgB08/zOpmpsAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DCqt5RYPBHq4y1tFuB7C/JYlnHW4jqqVrEEB1R/smTUMuyK20U4nSdr/FlzcZzJ8W
	 LwMRCSA5L2wN0ozoBsQGBx7s/HbX0HnQXv3kOU2+TJwq2Zd09JVyIP2jycTHMSXOnL
	 kwDWf9a5ogwdQi1LGAsMK7jQ3ZgqyDJzn6CJQYGo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 27 Aug 2024 17:25:12 +0200
Subject: [PATCH 1/5] fbdev/efifb: Use stack memory for screeninfo structs
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-efifb-sysfs-v1-1-c9cc3e052180@weissschuh.net>
References: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
In-Reply-To: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
To: Peter Jones <pjones@redhat.com>, Helge Deller <deller@gmx.de>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724772358; l=1859;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2fuwEC3Yp225FwaS701NUfjP1g4xTmgB08/zOpmpsAA=;
 b=rOkv5WWJdsYyy7gSwo6ETnm+0fpNWf1gQQInzjmRji2pSdC5vaSVpncDd9Wvim18h/qjuGEaS
 6mXd0NYbotdCVXwSvlogkuLn3iuwWJeBwPQzO8P3C6CInqlgPfHpFPJ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

These variables are only used inside efifb_probe().
Afterwards they are using memory unnecessarily.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/video/fbdev/efifb.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 8dd82afb3452..8bfe0ccbc67a 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -52,24 +52,6 @@ struct efifb_par {
 	resource_size_t size;
 };
 
-static struct fb_var_screeninfo efifb_defined = {
-	.activate		= FB_ACTIVATE_NOW,
-	.height			= -1,
-	.width			= -1,
-	.right_margin		= 32,
-	.upper_margin		= 16,
-	.lower_margin		= 4,
-	.vsync_len		= 4,
-	.vmode			= FB_VMODE_NONINTERLACED,
-};
-
-static struct fb_fix_screeninfo efifb_fix = {
-	.id			= "EFI VGA",
-	.type			= FB_TYPE_PACKED_PIXELS,
-	.accel			= FB_ACCEL_NONE,
-	.visual			= FB_VISUAL_TRUECOLOR,
-};
-
 static int efifb_setcolreg(unsigned regno, unsigned red, unsigned green,
 			   unsigned blue, unsigned transp,
 			   struct fb_info *info)
@@ -357,6 +339,24 @@ static int efifb_probe(struct platform_device *dev)
 	char *option = NULL;
 	efi_memory_desc_t md;
 
+	struct fb_var_screeninfo efifb_defined = {
+		.activate		= FB_ACTIVATE_NOW,
+		.height			= -1,
+		.width			= -1,
+		.right_margin		= 32,
+		.upper_margin		= 16,
+		.lower_margin		= 4,
+		.vsync_len		= 4,
+		.vmode			= FB_VMODE_NONINTERLACED,
+	};
+
+	struct fb_fix_screeninfo efifb_fix = {
+		.id			= "EFI VGA",
+		.type			= FB_TYPE_PACKED_PIXELS,
+		.accel			= FB_ACCEL_NONE,
+		.visual			= FB_VISUAL_TRUECOLOR,
+	};
+
 	/*
 	 * If we fail probing the device, the kernel might try a different
 	 * driver. We get a copy of the attached screen_info, so that we can

-- 
2.46.0

