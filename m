Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99554C433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 03:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 413B064F20
	for <linux-fbdev@archiver.kernel.org>; Thu, 18 Mar 2021 03:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhCRDRj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 17 Mar 2021 23:17:39 -0400
Received: from m12-17.163.com ([220.181.12.17]:52652 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229766AbhCRDRI (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 17 Mar 2021 23:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=W12mF
        x5zwkYJm0lwqakEsOPM1rg3JP/KCo5hL6AZCko=; b=RDolLNaif5hswbP3WO+Tw
        bKbWuMeUwBBJr2h10bnsTMbGLQF90xJPH2iTzhSxeSoPrgov9f6UVvP5oYGpzqHz
        0hSBwfaqgi2N5Mv6s6KqlMAex/zll4lHFlsd54QjBoQf4WElVyyYjP3wRDdnHDqQ
        SSTM0z+vSYDHWXz/bYFZ+I=
Received: from COOL-20200911ZP.ccdomain.com (unknown [218.94.48.178])
        by smtp13 (Coremail) with SMTP id EcCowADX3JQXxlJg+FZgqg--.26427S2;
        Thu, 18 Mar 2021 11:16:49 +0800 (CST)
From:   ChunyouTang <tangchunyou@163.com>
To:     gustavoars@kernel.org, sam@ravnborg.org
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangchunyou@yulong.com
Subject: [PATCH v2] drivers/video/fbdev:modify 'if (addrp == NULL)' to 'if (!addr)
Date:   Thu, 18 Mar 2021 11:16:36 +0800
Message-Id: <20210318031636.552-1-tangchunyou@163.com>
X-Mailer: git-send-email 2.30.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADX3JQXxlJg+FZgqg--.26427S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1xZFyrWFy5ZryUZw4xJFb_yoW8tw1UpF
        W5KFyFyF18Gws3WayxAFWvya42grn3tFW2yryxuw1a9a15Zr15X343G342gF9rArWrA343
        A3WDK3W8Gw4UJFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jxPEfUUUUU=
X-Originating-IP: [218.94.48.178]
X-CM-SenderInfo: 5wdqwu5kxq50rx6rljoofrz/xtbBRQFZUVPAKkRtgwAAsf
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: tangchunyou <tangchunyou@yulong.com>

modify 'if (addrp == NULL)' to 'if (!addr)

Signed-off-by: tangchunyou <tangchunyou@yulong.com>
---
 drivers/video/fbdev/offb.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index cd1042f..52d86e3 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -305,9 +305,9 @@ static void __iomem *offb_map_reg(struct device_node *np, int index,
 	unsigned int flags;
 
 	addrp = of_get_pci_address(np, index, &asize, &flags);
-	if (addrp == NULL)
+	if (!addrp)
 		addrp = of_get_address(np, index, &asize, &flags);
-	if (addrp == NULL)
+	if (!addrp)
 		return NULL;
 	if ((flags & (IORESOURCE_IO | IORESOURCE_MEM)) == 0)
 		return NULL;
@@ -412,7 +412,7 @@ static void __init offb_init_fb(const char *name,
 
 	info = framebuffer_alloc(sizeof(u32) * 16, NULL);
 
-	if (info == NULL) {
+	if (!info) {
 		release_mem_region(res_start, res_size);
 		return;
 	}
@@ -555,25 +555,25 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 #endif
 
 	pp = of_get_property(dp, "linux,bootx-depth", &len);
-	if (pp == NULL)
+	if (!pp)
 		pp = of_get_property(dp, "depth", &len);
 	if (pp && len == sizeof(u32))
 		depth = be32_to_cpup(pp);
 
 	pp = of_get_property(dp, "linux,bootx-width", &len);
-	if (pp == NULL)
+	if (!pp)
 		pp = of_get_property(dp, "width", &len);
 	if (pp && len == sizeof(u32))
 		width = be32_to_cpup(pp);
 
 	pp = of_get_property(dp, "linux,bootx-height", &len);
-	if (pp == NULL)
+	if (!pp)
 		pp = of_get_property(dp, "height", &len);
 	if (pp && len == sizeof(u32))
 		height = be32_to_cpup(pp);
 
 	pp = of_get_property(dp, "linux,bootx-linebytes", &len);
-	if (pp == NULL)
+	if (!pp)
 		pp = of_get_property(dp, "linebytes", &len);
 	if (pp && len == sizeof(u32) && (*pp != 0xffffffffu))
 		pitch = be32_to_cpup(pp);
@@ -593,7 +593,7 @@ static void __init offb_init_nodriver(struct device_node *dp, int no_real_node)
 	 * the "address" property. If none match, we pick the biggest
 	 */
 	up = of_get_property(dp, "linux,bootx-addr", &len);
-	if (up == NULL)
+	if (!up)
 		up = of_get_property(dp, "address", &len);
 	if (up && len == sizeof(u32))
 		addr_prop = *up;
-- 
1.9.1


