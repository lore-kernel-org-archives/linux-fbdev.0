Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92E8B1925BF;
	Tue, 21 Jan 2025 06:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737441826; cv=none; b=g1/Y+eR9al5yKhoDqnHjwzqKyEzw66rcRTSEi6t9ylseSbLoXMlW9M09z3QYs55H3pmXe07F5NaMBOzJajcGdT6JHRInhYbYYog4VbmEIDR2m4uqniOyGrm5GmkHZ91s9ZmC/IdkX0zx4jyd13wYBFBj0K1IEmaOZ/KHaBJxBuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737441826; c=relaxed/simple;
	bh=DKS/m4Na0zHLseK34vH8cD36MaZ/lUfnzTirzW6FZNs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B38SBBxJug1wEfDKSO5Q6oS8LBd+qGIsIYeT3lfZwSVnG6obP6dSAf1m9G5JxaqRpMt4NcbvW6At35K095TLdp6JULU+J0yYBijp/u7SSt7/ULktTV1p0I2fCGtFrWyX/OlVb7mKrrfkFQnEjCALYou3ScWpieHo73iUaXXIz1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aNjOSedS; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aNjOSedS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/Z/LB
	Ny6fGJ1luOMGyIGCsvIGKVal3b+N+TSWS3wLIk=; b=aNjOSedSzj+IiV/vDT/r5
	O0up6lmEqhKl2awSxNzRuxq0ZzDVBU0YIJIWxYnTlciv1PHFNXQdagdVJVmN28MA
	VTiRiZwDlemOC/YmNuarD4xBsfGdleGnnXTsWIPRjux89Ctr+TdYNsMNWyitKLJQ
	iKb3tZ1BEs9K0K7UGK3yy0=
Received: from localhost.localdomain (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgD32Hr1QY9nee4gFg--.59693S2;
	Tue, 21 Jan 2025 14:43:03 +0800 (CST)
From: oushixiong1025@163.com
To: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Arnd Bergmann <arnd@arndb.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Lee Jones <lee@kernel.org>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Shixiong Ou <oushixiong@kylinos.cn>
Subject: [PATCH] fbdev/sh_mobile_lcdcfb: Use backlight helper
Date: Tue, 21 Jan 2025 14:42:36 +0800
Message-Id: <20250121064236.168236-1-oushixiong1025@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgD32Hr1QY9nee4gFg--.59693S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFW3uw4UJr1kWw1xAryrWFg_yoWDCFX_CF
	s0va4vgrsrt395KwnruFn5CFySgr4DuF1aqr4qqrZ3W347J3y3XryYgw4UKF98u3y0yF97
	XFnFqryrAr1fCjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbqg4PUUUUU==
X-CM-SenderInfo: xrxvxxx0lr0wirqskqqrwthudrp/xtbBYwjbD2ePPsE4EAAAsA

From: Shixiong Ou <oushixiong@kylinos.cn>

Signed-off-by: Shixiong Ou <oushixiong@kylinos.cn>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 6b37b188af31..69c9067eff88 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -2123,11 +2123,7 @@ sh_mobile_lcdc_channel_fb_init(struct sh_mobile_lcdc_chan *ch,
 static int sh_mobile_lcdc_update_bl(struct backlight_device *bdev)
 {
 	struct sh_mobile_lcdc_chan *ch = bl_get_data(bdev);
-	int brightness = bdev->props.brightness;
-
-	if (bdev->props.power != FB_BLANK_UNBLANK ||
-	    bdev->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
+	int brightness = backlight_get_brightness(bdev);
 
 	ch->bl_brightness = brightness;
 	return ch->cfg->bl_info.set_brightness(brightness);
-- 
2.25.1

