Return-Path: <SRS0=OfnY=DZ=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EF89C43457
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 19:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F22320708
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1603050161;
	bh=MoBhK/7Ht9x5KVldjiEmNJ4N0GxtlmSpLJsWAMgpVXE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s3O4TZinIWMSGJWBoDAAV2FntJNmFdqgdEy94MMqmn2VGT6Sc2JYV9PB7amIsMHCZ
	 KKx36tvDppd58tZOZSLBWd8nPa1xZXuQN582mw3I1GtS9kyjLbVGZzGISdvcjsQc3M
	 NdH61yOyn0q2j8w3HUotMAYwQP1k//ZAq7wC39sY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgJRTm3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Oct 2020 15:42:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:37510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730511AbgJRTXy (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Oct 2020 15:23:54 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BDE44222E9;
        Sun, 18 Oct 2020 19:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603049033;
        bh=MoBhK/7Ht9x5KVldjiEmNJ4N0GxtlmSpLJsWAMgpVXE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IXwxhRpkE8P8OnnZ1q3yvfnD4C2O8bIuvrpdkJdN2g2TkSwTW+MBy2nZv9pH/KBXq
         IvaJR6LrX7VZiM14A9hqclsU1kRlkEIj41wAhJFq1nyjDJdmRNFeY+rk4GA4/GJJI/
         +i1dYZltAnaLSMp70CH+VE8f2327RZG7t+k90egg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     George Kennedy <george.kennedy@oracle.com>,
        syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <sashal@kernel.org>, linux-fbdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 65/80] fbmem: add margin check to fb_check_caps()
Date:   Sun, 18 Oct 2020 15:22:16 -0400
Message-ID: <20201018192231.4054535-65-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201018192231.4054535-1-sashal@kernel.org>
References: <20201018192231.4054535-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201018192216.EgsrDfY6czuKQkbfF8RwGd_otNJpO9XTKfLDRD_14Wk@z>

From: George Kennedy <george.kennedy@oracle.com>

[ Upstream commit a49145acfb975d921464b84fe00279f99827d816 ]

A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
or yres setting in struct fb_var_screeninfo will result in a
KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
the margins are being cleared. The margins are cleared in
chunks and if the xres setting or yres setting is a value of
zero upto the chunk size, the failure will occur.

Add a margin check to validate xres and yres settings.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Reported-by: syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Dhaval Giani <dhaval.giani@oracle.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1594149963-13801-1-git-send-email-george.kennedy@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 97abcd497c7e0..bf76dadbed87f 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1001,6 +1001,10 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 		return 0;
 	}
 
+	/* bitfill_aligned() assumes that it's at least 8x8 */
+	if (var->xres < 8 || var->yres < 8)
+		return -EINVAL;
+
 	ret = info->fbops->fb_check_var(var, info);
 
 	if (ret)
-- 
2.25.1

