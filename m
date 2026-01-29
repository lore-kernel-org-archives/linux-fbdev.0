Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871347478;
	Thu, 29 Jan 2026 04:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769660015; cv=none; b=OQvnBH1EU+ox+ls51bGKhCFoXBQiSY8L8f36MmvagUiy+dKoAj984mdXaYXYxiEYeKD5aWQDjaSE66mnvO0Aup1OamywceNpV+ezVXL9CqhnAXz96JR2aSh4aN8zRPiWYCkBZRFLvC2mD32H1XoOp2Rxg0Vl/MsgH+l4r6mTwKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769660015; c=relaxed/simple;
	bh=bjfbx/Yem/NlWAluEDqTGHZ87x6+gEnW52NtxHuWKqc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fJwrhakPI+uJLEwlIDU1E79O6KwEk40aBVU4N33NAibUx6BAVfYnSscrNjRgFxoguKNzw2dYKeYdT/BM/suhdXeyFzKTIJc5wDHF4+kRb6M7Tva6prUwwwWgpAWepWCo4mcOCJUz88vSAwhAon2vrT/BZO/W92emJi3rq1MzJzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowABXddxl3npp0LgrBw--.63613S2;
	Thu, 29 Jan 2026 12:13:25 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: u.kleine-koenig@baylibre.com
Cc: deller@gmx.de,
	dri-devel@lists.freedesktop.org,
	elfring@users.sourceforge.net,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH v2] fbdev: au1100fb: Check return value of clk_enable() in .resume()
Date: Thu, 29 Jan 2026 12:07:14 +0800
Message-Id: <20260129040714.2772522-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <zytpnyodschvn4mmpllxp62yg3o77hjl7l5nyckoxyuvucjyaj@xsxbybnyzd44>
References: <zytpnyodschvn4mmpllxp62yg3o77hjl7l5nyckoxyuvucjyaj@xsxbybnyzd44>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXddxl3npp0LgrBw--.63613S2
X-Coremail-Antispam: 1UD129KBjvdXoWrZFyDuw1UKFykCw47Xry7ZFb_yoWkCrX_ZF
	Z7urZ3Wry8Zr1kKF4xJF42yry3KFZFgrnIgrn2grZxtry7Zr18urWUZryI9a98XwnruFWD
	GF9FgrW7Ar1fCjkaLaAFLSUrUUUU1b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbaxFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6x
	CaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY
	1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gryl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYx
	BIdaVFxhVjvjDU0xZFpf9x0JUxOz3UUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

Check the return value of clk_enable() in au1100fb_drv_resume() and
return the error on failure.
This ensures the system is aware of the resume failure and can track
its state accurately.

Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changes in v2:
- Update commit message
- Clean up extraneous whitespace in the code
---
 drivers/video/fbdev/au1100fb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/au1100fb.c b/drivers/video/fbdev/au1100fb.c
index 6251a6b07b3a..feaa1061c436 100644
--- a/drivers/video/fbdev/au1100fb.c
+++ b/drivers/video/fbdev/au1100fb.c
@@ -567,13 +567,16 @@ int au1100fb_drv_suspend(struct platform_device *dev, pm_message_t state)
 int au1100fb_drv_resume(struct platform_device *dev)
 {
 	struct au1100fb_device *fbdev = platform_get_drvdata(dev);
+	int ret;
 
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

