Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170DF1B4135
	for <linux-fbdev@vger.kernel.org>; Sun, 12 Jan 2025 15:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736696549; cv=none; b=XHXYpUwXMvX2q71QFRtRXdnlFNK2qLOOaPhi+VhPqeBML7qZBx5e44fWEKKdbHV/gGudLjWYCEBNLip8GxtAvaOplRGf5GxkvHUbszoier/lHxReO6XW/3fRpbeLAPKfFNjdpEat0CJ8k0IYbQr9DyJDIkMlV2knrPPHag8Pn5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736696549; c=relaxed/simple;
	bh=8k8NXi3b5R7nM8ifoNF1d18IPT1RjXdEsXsAk0hP1kU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CS/Dqw7n4GtHXucAGBB3GqEX89L33TWbzQ8Z7tKyfUkOTC59A9qcEqAFvrDChmH0GB7dn2KOLztrdK9nlN27MmDGwAxwQfZJRhfCa1Dpledrvw8LIu511cmHYJuiJtTokiGw0BaDtmTf8pA7nKgRw9lH4M4+it3EzZDF9QnE2y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rY6/ptgk; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rY6/ptgk"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736696545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pLJBq80SdnMHTfQrSgK/oG85nH0qobc5d0GX5tMG/S8=;
	b=rY6/ptgkaF3YeEPADiOCLLrjl1tdTECV7k0aDUy27InFHYjCNZIMxPq6tJDXpr7GwtjpCm
	7+W0BMHfCDx/f2orakpm2KeBeby67ZgHudgzP1w0mq95TzWaCGljqRz0le80MMnsQqlZs4
	3MRi0jhqeH2gxnq9ocLZ3oRmfr8rrpY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: Use str_enabled_disabled() helper in sm501fb_init_fb()
Date: Sun, 12 Jan 2025 16:41:42 +0100
Message-ID: <20250112154145.126901-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove hard-coded strings by using the str_enabled_disabled() helper
function.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/video/fbdev/sm501fb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/sm501fb.c b/drivers/video/fbdev/sm501fb.c
index 86ecbb2d86db..7734377b2d87 100644
--- a/drivers/video/fbdev/sm501fb.c
+++ b/drivers/video/fbdev/sm501fb.c
@@ -27,6 +27,7 @@
 #include <linux/clk.h>
 #include <linux/console.h>
 #include <linux/io.h>
+#include <linux/string_choices.h>
 
 #include <linux/uaccess.h>
 #include <asm/div64.h>
@@ -1712,8 +1713,8 @@ static int sm501fb_init_fb(struct fb_info *fb, enum sm501_controller head,
 		BUG();
 	}
 
-	dev_info(info->dev, "fb %s %sabled at start\n",
-		 fbname, enable ? "en" : "dis");
+	dev_info(info->dev, "fb %s %s at start\n",
+		 fbname, str_enabled_disabled(enable));
 
 	/* check to see if our routing allows this */
 
-- 
2.47.1

