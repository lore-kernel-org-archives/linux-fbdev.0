Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3787C4708E
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Oct 2023 22:59:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbjJ2W7Y (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Oct 2023 18:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231522AbjJ2W7L (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Oct 2023 18:59:11 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226B444B6;
        Sun, 29 Oct 2023 15:58:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C336FC116B2;
        Sun, 29 Oct 2023 22:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698620297;
        bh=rJf6G8M72yMlaVU2jO9MlObEVaV5lSGiC2CYomegD+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UwjHgbDstKmq+RvFdff/H64ORAZwJKd2Yg/bDjNpo/GtA30ygRD3yF0vIeHuL+4Kz
         Lpn2OCOkWuARQBdOxUfRWTDrKIU5QXE11x9aOz3EtGQ+o4qaOqqXMK4VipoVnKrPYz
         yZyL012hb2IK3L7ZQl3VB9x97LVCHcZzSrc372hI9jGO+yZ3gOsNgFASoRGKBFLz/6
         oiahoXnsnc7iQAFWtSYeY3TidGUCgL8GCH4Ya+UML01OdTS3GhZmjPIh4Uyoqgzass
         8Lp1ffNncEr2EY+73FuV+HGXo1jWT3FgAXRBbzUauPAB0OsWnbSn7zmHAVLhhjMKkl
         2QwF2Cpj96IvA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jorge Maidana <jorgem.linux@gmail.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        spock@gentoo.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 24/39] fbdev: uvesafb: Call cn_del_callback() at the end of uvesafb_exit()
Date:   Sun, 29 Oct 2023 18:56:56 -0400
Message-ID: <20231029225740.790936-24-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225740.790936-1-sashal@kernel.org>
References: <20231029225740.790936-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.60
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
index 0e3cabbec4b40..a85463db9f986 100644
--- a/drivers/video/fbdev/uvesafb.c
+++ b/drivers/video/fbdev/uvesafb.c
@@ -1935,10 +1935,10 @@ static void uvesafb_exit(void)
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

