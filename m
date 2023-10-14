Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B15CDB465
	for <linux-fbdev@archiver.kernel.org>; Sat, 14 Oct 2023 12:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233043AbjJNMWc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 14 Oct 2023 08:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjJNMWb (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 14 Oct 2023 08:22:31 -0400
X-Greylist: delayed 448 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Oct 2023 05:22:28 PDT
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CA0A9
        for <linux-fbdev@vger.kernel.org>; Sat, 14 Oct 2023 05:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1697286145;
        bh=YQheIxJjOau1s9uk+wO2dkdpHL1+wExdCD1+23pg5Oc=;
        h=From:To:Cc:Subject:Date;
        b=PUkeA7PlH/JWuKrBQiUXxDdhK7tYU5DJUHzhZ6WFGlgRqCMlgcThNSgE/INJHu7+Z
         f+6KTkFGR2brHCouXenzUm8Tg+LVqiPcV6estqxaBGGbcz21L19QavvX3Xkz+7GHGf
         Bva/JHWlonPaG/VOBowoNmTy2EpbWr+1ADYmtkqQ=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 3B6A8E9A; Sat, 14 Oct 2023 20:14:54 +0800
X-QQ-mid: xmsmtpt1697285694tghy4mbab
Message-ID: <tencent_C816151C508524D86E346A69B706C0D03C09@qq.com>
X-QQ-XMAILINFO: OGEC8BYa7lsBWWZ/vEd4TQyQV9TARh6WvGGkSsO7/3IuF9yTmPnEUCQIn8ey2z
         F64IQTFMZP37lymHUS6B2HZo4knNaarGV2AJKI0/yTUoLqfNF4afRuhhV4FTNaoSbeWeTktBa01p
         JD4VwXJudoABheJBhAln465jjNlbz+PN6oeSO6JNDmPskkFClQDABviiDTBWrUidCOn/iR6SKVep
         7P9tbTQhjAEBati0PEr7KJd0GzpWhIerLX/BtXOXLvC+fTwkCfM/Hj5SgJp9yum/bb1Qznc1tjE6
         3tMx7ExLXY1y821ipYkuuelfpdP31zq/zL3ipJuYIxBBHuGaWnnPq++I8dYdCV/Ture6ssLqk9qC
         qcCXEO9lC+0o5c68yDTu7NMukeKRl1O04UQQC2cA8N9Kr2qFbphyC1HIieIeJ6IfywqBlXKajofI
         O2x5CIeWnDQh+ONXQVm8VaB+Gt3U57AncYVPzbSHGuo/sRxPzwOyHT2IcqQmNtTv4iUqMme0TEl/
         CuZ63UASKrVN7Ylw6O/N2yqTpEdXvUyAk5RQRMBU1FdfIY3Wa6eHYSWxzgK3VMt9AVTkjt2FDT2w
         1encBQgxY5THYl1runLZR1+trSAJvHQiZ8gtGSJwmy5ole1jRD60lrSLrsoAzJcweW5jFIfEvVJ2
         quMcPFQzMVZiEOpGHUgrbsVbM2lpYXNPYT0TNGcZbowROSBnw/gEqK6XoY1SquAj0S2SGZrFnVEh
         rj+wdVDzIkbrNbojMWEv1G1JkWvt6gsdIWZZgCvkltWD8U/OdcOyRHnlgbJJncplq2uVO/sjNeul
         fw5AvqlFOJUW1rebBiLRw9F+xJy49ZA5xYdVZqEND1+p2VWkBEHCSzw9E8e8cr0ppCgKhdMAFmBm
         ymULOurlgBRfIeZKtH6SY/6KRUEsomydJTRfpNl5zmUjj40C0xNJ5k0SD1JQKkT6qgAH/po+Q1rP
         cfaacsbGI0CrhReW36tO2u3h4ZBtlznK+ZlUdGM6Ok9boHcJb3JuvvMCpr0qOVHOq3AyYnD1RGzF
         0YUZGzbA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     daniel@ffwll.ch
Cc:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] fbdev: fbmon: fix potential divide error in fb_validate_mode
Date:   Sat, 14 Oct 2023 20:14:53 +0800
X-OQ-MSGID: <20231014121453.3034941-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

We can easily use FBIOPUT_VSCREENINFO set fb_var_screeninfo, so
it's possible for a divide by zero error to occur.

Fix this by making sure the divisor is non-zero before the computation.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/video/fbdev/core/fbmon.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 79e5bfbdd34c..bdd15b8e3a71 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1470,6 +1470,9 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
 	if (var->vmode & FB_VMODE_DOUBLE)
 		vtotal *= 2;
 
+	if (!htotal || !vtotal)
+		return -EINVAL;
+
 	hfreq = pixclock/htotal;
 	hfreq = (hfreq + 500) / 1000 * 1000;
 
-- 
2.30.2

