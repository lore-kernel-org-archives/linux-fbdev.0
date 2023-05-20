Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A943C7EE23
	for <linux-fbdev@archiver.kernel.org>; Sat, 20 May 2023 18:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231877AbjETSYZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 20 May 2023 14:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232022AbjETSYF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 20 May 2023 14:24:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD41199F;
        Sat, 20 May 2023 11:23:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1378360F4D;
        Sat, 20 May 2023 18:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB18C433EF;
        Sat, 20 May 2023 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684606927;
        bh=+c/hg+pn6YqJJKirv+KPqU8DGCISXulUy2B44R/iVk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O2bJ2LscbtApx6ksXR0BdpW9CSzt2d//r6Qjwh4Bg0k7Z6OnAIiUb8C3g1ZgHVV/N
         vRuog6/JzDBXWI1+0T2bGvW6S6+T0S4QU72V1FuvzNcR+rcfkSA+MDdYEFkPIRWtnT
         PW3y7tl039bmls1WZZeYNT+fEgjGqElvtsc0m+FbMvv7eefE8xEyOE1TgqeiL3VsIK
         PyTX9267nIVpZbUxgO9GRdHJvLzaVxFkzT2tdHJYsOzdKApnbNFAZHEDgl+AsBGD+y
         MVKsUNj+hj1SxZ/laP5FRN/8tIp4l5RGxnqWvJAMWsOebM87sonXAyVsBgHhcE6wRr
         3rIAO2hnMy9kg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>,
        daniel@ffwll.ch, tzimmermann@suse.de, javierm@redhat.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 11/14] fbdev: modedb: Add 1920x1080 at 60 Hz video mode
Date:   Sat, 20 May 2023 14:20:39 -0400
Message-Id: <20230520182044.836702-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230520182044.836702-1-sashal@kernel.org>
References: <20230520182044.836702-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Helge Deller <deller@gmx.de>

[ Upstream commit c8902258b2b8ecaa1b8d88c312853c5b14c2553d ]

Add typical resolution for Full-HD monitors.

Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/modedb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/modedb.c b/drivers/video/fbdev/core/modedb.c
index 6473e0dfe1464..e78ec7f728463 100644
--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -257,6 +257,11 @@ static const struct fb_videomode modedb[] = {
 	{ NULL, 72, 480, 300, 33386, 40, 24, 11, 19, 80, 3, 0,
 		FB_VMODE_DOUBLE },
 
+	/* 1920x1080 @ 60 Hz, 67.3 kHz hsync */
+	{ NULL, 60, 1920, 1080, 6734, 148, 88, 36, 4, 44, 5, 0,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
+		FB_VMODE_NONINTERLACED },
+
 	/* 1920x1200 @ 60 Hz, 74.5 Khz hsync */
 	{ NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
-- 
2.39.2

