Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84D21C9ECD;
	Tue, 27 Aug 2024 15:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724772367; cv=none; b=nQJSCENKtPWEL+hNWk56N+FLYhRyqFNOxhee2zhV1R+vHEPFOs9FvUksYOBhxh9NqwPrjK6180t/MZ3NoXy4dqqEBXKhYsGbrviKB5Yhr9XkfKlVscgxE5J/b32hyEY09obxwMCmpI2a1sxvnc3/6vl1p5lxsmDOoCY6IlFBhYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724772367; c=relaxed/simple;
	bh=z4+MXZQwSzyk1DP5JRe+oUonhr5WcjwKYTX3+no3UJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G/h8IR/DzLA/J0TZ5ITF8SJLlbdRKPCRZtM432GD7C5DOSZcR4ErUjUajkMspN3U5H03nm8M/xKoaX3kqB78vY7o6HuJ1wTJqECSgoW8xD4roEYTXGwCma90aG9JPP7L6GDJRdY5mhLSj6+7kOTyadG0FmWq5OvShZ8BFoSKR0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=i8EjG6U6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="i8EjG6U6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1724772359;
	bh=z4+MXZQwSzyk1DP5JRe+oUonhr5WcjwKYTX3+no3UJk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i8EjG6U6G1PkfcqAsUdXQFhmPUG3mk30QmSV7iu3wr2oUNGMRPqCdynu45Ib3l8HG
	 SvaKdjX23oRT7GBBUUtbIhRBltGzxt3NrZ0R4+RPbDpT0UrylB4sbIRcSmPw7cu+IT
	 5tBe1aSXkWhiRVPM6hAgG3tJQpcnDwYi3QQhAYxI=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 27 Aug 2024 17:25:13 +0200
Subject: [PATCH 2/5] fbdev/efifb: Register sysfs groups through driver core
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240827-efifb-sysfs-v1-2-c9cc3e052180@weissschuh.net>
References: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
In-Reply-To: <20240827-efifb-sysfs-v1-0-c9cc3e052180@weissschuh.net>
To: Peter Jones <pjones@redhat.com>, Helge Deller <deller@gmx.de>, 
 Daniel Vetter <daniel@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724772358; l=1814;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=z4+MXZQwSzyk1DP5JRe+oUonhr5WcjwKYTX3+no3UJk=;
 b=dFQ22KZQtiJhBVo/hCnGO4UOTOmeEvkQZjkIRcgRS5YGTZFjIL+ghunSlzA2DUjztOeDJq+G3
 Vf69rcJVMwdCvEjMXIqXtmhG+AgZbyjeP6gBQo8cNof0NulgiAvPWk0
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The driver core can register and cleanup sysfs groups already.
Make use of that functionality to simplify the error handling and
cleanup.

Also avoid a UAF race during unregistering where the sysctl attributes
were usable after the info struct was freed.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 drivers/video/fbdev/efifb.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
index 8bfe0ccbc67a..d36b95856dd0 100644
--- a/drivers/video/fbdev/efifb.c
+++ b/drivers/video/fbdev/efifb.c
@@ -561,15 +561,10 @@ static int efifb_probe(struct platform_device *dev)
 		break;
 	}
 
-	err = sysfs_create_groups(&dev->dev.kobj, efifb_groups);
-	if (err) {
-		pr_err("efifb: cannot add sysfs attrs\n");
-		goto err_unmap;
-	}
 	err = fb_alloc_cmap(&info->cmap, 256, 0);
 	if (err < 0) {
 		pr_err("efifb: cannot allocate colormap\n");
-		goto err_groups;
+		goto err_unmap;
 	}
 
 	err = devm_aperture_acquire_for_platform_device(dev, par->base, par->size);
@@ -587,8 +582,6 @@ static int efifb_probe(struct platform_device *dev)
 
 err_fb_dealloc_cmap:
 	fb_dealloc_cmap(&info->cmap);
-err_groups:
-	sysfs_remove_groups(&dev->dev.kobj, efifb_groups);
 err_unmap:
 	if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
 		iounmap(info->screen_base);
@@ -608,12 +601,12 @@ static void efifb_remove(struct platform_device *pdev)
 
 	/* efifb_destroy takes care of info cleanup */
 	unregister_framebuffer(info);
-	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
 }
 
 static struct platform_driver efifb_driver = {
 	.driver = {
 		.name = "efi-framebuffer",
+		.dev_groups = efifb_groups,
 	},
 	.probe = efifb_probe,
 	.remove_new = efifb_remove,

-- 
2.46.0

