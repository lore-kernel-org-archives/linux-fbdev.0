Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C87C63798
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Nov 2020 08:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46E8722252
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Nov 2020 08:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgKTI33 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Nov 2020 03:29:29 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25]:35898 "EHLO cstnet.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725801AbgKTI33 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Nov 2020 03:29:29 -0500
X-Greylist: delayed 328 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Nov 2020 03:29:28 EST
Received: from localhost.localdomain (unknown [124.16.141.242])
        by APP-05 (Coremail) with SMTP id zQCowABnepwTfbdfzxRbAQ--.19873S2;
        Fri, 20 Nov 2020 16:23:48 +0800 (CST)
From:   Xu Wang <vulab@iscas.ac.cn>
To:     b.zolnierkie@samsung.com, daniel.vetter@ffwll.ch,
        jani.nikula@intel.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] video: goldfishfb: remove casting dma_alloc_coherent
Date:   Fri, 20 Nov 2020 08:23:44 +0000
Message-Id: <20201120082344.8623-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowABnepwTfbdfzxRbAQ--.19873S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xw15CFW5tw43Kw1DWw1UGFg_yoWfWrbEkF
        WkuF97W348Jrs5Wrn7t3y5Cryqkr95Z3Z7uFnrKrWaq347ur15Way7Zrn5G3yUWw4jgFZ8
        Kr90krW7Aw1fujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUb28YjsxI4VW3JwAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I
        6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM2
        8CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0
        cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I
        8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
        64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVW8JVWxJw
        Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r43MxAIw28I
        cxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2
        IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI
        42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42
        IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E
        87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j4yxiUUUUU=
X-Originating-IP: [124.16.141.242]
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCQYGA102ZuqQ7AAAsR
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Remove casting the values returned by dma_alloc_coherent.

Signed-off-by: Xu Wang <vulab@iscas.ac.cn>
---
 drivers/video/fbdev/goldfishfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 9c83ec3f8e1f..c2f386b35617 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -238,8 +238,7 @@ static int goldfish_fb_probe(struct platform_device *pdev)
 	fb->fb.var.blue.length = 5;
 
 	framesize = width * height * 2 * 2;
-	fb->fb.screen_base = (char __force __iomem *)dma_alloc_coherent(
-						&pdev->dev, framesize,
+	fb->fb.screen_base = dma_alloc_coherent(&pdev->dev, framesize,
 						&fbpaddr, GFP_KERNEL);
 	pr_debug("allocating frame buffer %d * %d, got %p\n",
 					width, height, fb->fb.screen_base);
-- 
2.17.1

