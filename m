Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161E33E368;
	Wed, 28 Jan 2026 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769591448; cv=none; b=uY8UHMs6Y8HI2Uc3rNexKSRKHllVzLkEv4VzcYxa3hKCu6DPg0raceIJHdjCrpv7DhlOf/CUeRZlUviHsxd1uFIQhWH6rXqytmM1QPVoRWPej/4dpRv6bO86PhY59oQfGKnyuOCMRWmVD4Dk7zN7R1Tm+h7Qwjz6FYblEzBUhvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769591448; c=relaxed/simple;
	bh=8MKhY8HR/ZM2KQUtkTtjTy4OLP39sF+Kad87Ki86s24=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZqLlZoxeo/cEJutTUNA5lgxU2x0iq/GGzECRVlGshlixdDLEUjpau9vwdA73Yub49erBCNZVyHwhjWaWysCAXFltSVINuN6XaxEFw3v2BMsgbV7gAmeSgLHqpqXfRQ7/bqoKZB1t45Y6gWWWSVoGHXfCSn6QrR4jsNEk6UPbRBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowAAnSeCK0nlp7T4TBw--.58122S2;
	Wed, 28 Jan 2026 17:10:34 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: deller@gmx.de,
	u.kleine-koenig@baylibre.com,
	elfring@users.sourceforge.net
Cc: linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH] fbdev: au1100fb: Add missing check for clk_enable
Date: Wed, 28 Jan 2026 17:10:04 +0800
Message-Id: <20260128091004.2747011-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAAnSeCK0nlp7T4TBw--.58122S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtr48CF47CF13Jw4kWryDJrb_yoWDGrc_ZF
	WIvrZ3WrW8Zr18KF48Jryjyry5KFsFvrnFgr1vgr93try7Cr1rurWUZr1xua98XwnruFWD
	JF9F9rW5Cr1fCjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbs8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1lc2xSY4AK67AK6r4fMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI
	8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AK
	xVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI
	8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280
	aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
	ZEXa7VUjD5r3UUUUU==
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Add check for the return value of clk_enable() andreturn the error
if it fails in order to catch the error.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
 drivers/video/fbdev/au1100fb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 6251a6b07b3a..5e7a8f018b7b 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -567,13 +567,16 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 int au1100fb_drv_resume(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
+	int  ret;
 
 	if (!fbdev)
 		return 0;
 
 	memcpy(fbdev->regs, &fbregs, sizeof(struct au1100fb_regs));
 
-	clk_enable(fbdev->lcdclk);
+	ret = clk_enable(fbdev->lcdclk);
+	if (ret)
+		return ret;
 
 	/* Unblank the LCD */
 	au1100fb_fb_blank(VESA_NO_BLANKING, &fbdev->info);
-- 
2.25.1

