Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125B5C4167B
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Oct 2023 23:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbjJ2Xdk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Oct 2023 19:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjJ2XdU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Oct 2023 19:33:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6100D7B;
        Sun, 29 Oct 2023 15:56:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DD7C4339A;
        Sun, 29 Oct 2023 22:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620155;
        bh=l0EgOhbI6Doopd7yiIRwP+W/QP9yQiBqW81TeYmPLuM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dz2DKRqD+R27psT5TkKIetimnyfHPf11mUuOAMUbS7ootLHsIw+uoakKR+hVHDEqh
         NE+HMVjOeeSWBuPSPAYNwjorONwSHtvUHqX4yF8shfLSvj1CFx665bzV4tiiKFeslc
         WUJsSmbqy8trpgYQsVehmAS1LwYDklPwoWcAa2jiJge/dF9U3nYjdP7jEpIpJFVa2l
         t5XywtsGyLceY29jh5Gq0rNSlQNyoTLpdNhvmXaiwGpPBFjeIQGghtHd9gwtx2UYOa
         zK8XUee1dPWPyD/4Liy7cG7iLmMn+QOwyxAAuTHihvue8GAeaV5O9hRq5fT9Cf5XP4
         recBRKSXjOlWA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jorge Maidana <jorgem.linux@gmail.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        spock@gentoo.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.5 33/52] fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()
Date:   Sun, 29 Oct 2023 18:53:20 -0400
Message-ID: <20231029225441.789781-33-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Jorge Maidana <jorgem.linux@gmail.com>

[ Upstream commit 1022e7e2f40574c74ed32c3811b03d26b0b81daf ]

Delete the v86d netlink only after all the VBE tasks have been
completed.

Fixes initial state restore on module unload:
uvesafb: VBE state restore call failed (eax=0x4f04, err=-19)

Signed-off-by: Jorge Maidana <jorgem.linux@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/uvesafb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/uvesafb.c b/drivers/video/fbdev/uvesafb.c
index 78d85dae8ec80..c4559768f00f6 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1931,10 +1931,10 @@ static void uvesafb_exit(void)
 		}
 	}
 
-	cn_del_callback(&uvesafb_cn_id);
 	driver_remove_file(&uvesafb_driver.driver, &driver_attr_v86d);
 	platform_device_unregister(uvesafb_device);
 	platform_driver_unregister(&uvesafb_driver);
+	cn_del_callback(&uvesafb_cn_id);
 }
 
 module_exit(uvesafb_exit);
-- 
2.42.0

