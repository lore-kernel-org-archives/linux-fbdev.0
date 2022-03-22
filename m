Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC09C433EF
	for <linux-fbdev@archiver.kernel.org>; Tue, 22 Mar 2022 20:33:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbiCVUfL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233871AbiCVUfL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 22 Mar 2022 16:35:11 -0400
Received: from smtp.smtpout.orange.fr (smtp06.smtpout.orange.fr [80.12.242.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9A962458B
        for <linux-fbdev@vger.kernel.org>; Tue, 22 Mar 2022 13:33:42 -0700 (PDT)
Received: from pop-os.home ([90.126.236.122])
        by smtp.orange.fr with ESMTPA
        id WlCGnBrc3IQAdWlCGn8qgV; Tue, 22 Mar 2022 21:33:41 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 22 Mar 2022 21:33:41 +0100
X-ME-IP: 90.126.236.122
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] video: of: display_timing: Remove a redundant zeroing of memory
Date:   Tue, 22 Mar 2022 21:33:38 +0100
Message-Id: <99f22ad1068fbbbc95acea59871cd408cde2623d.1647981212.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

of_parse_display_timing() already call memset(0) on its 2nd argument, so
there is no need to clear it explicitly before calling this function.

Use kmalloc() instead of kzalloc() to save a few cycles.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/video/of_display_timing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index f93b6abbe258..bebd371c6b93 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -199,7 +199,7 @@ struct display_timings *of_get_display_timings(const struct device_node *np)
 		struct display_timing *dt;
 		int r;
 
-		dt = kzalloc(sizeof(*dt), GFP_KERNEL);
+		dt = kmalloc(sizeof(*dt), GFP_KERNEL);
 		if (!dt) {
 			pr_err("%pOF: could not allocate display_timing struct\n",
 				np);
-- 
2.32.0

