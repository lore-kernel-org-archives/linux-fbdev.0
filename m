Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE3AC04A6A
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jul 2023 17:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGXREC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jul 2023 13:04:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjGXREB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jul 2023 13:04:01 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6D05E54
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jul 2023 10:03:58 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2d50:2ea4:d4e1:2af3])
        by xavier.telenet-ops.be with bizsmtp
        id R53t2A00F2TBYXr0153tLe; Mon, 24 Jul 2023 19:03:56 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qNyyD-002PJX-Ku;
        Mon, 24 Jul 2023 19:03:53 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qNyyP-007DmR-NR;
        Mon, 24 Jul 2023 19:03:53 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] Revert "fbcon: Use kzalloc() in fbcon_prepare_logo()"
Date:   Mon, 24 Jul 2023 19:03:48 +0200
Message-Id: <98b79fbdde69a4a203096eb9c8801045c5a055fb.1690218016.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

This reverts commit a6a00d7e8ffd78d1cdb7a43f1278f081038c638f.

The syzbot report turned out to be a false possitive, caused by a KMSAN
problem.  Indeed, after allocating the buffer, it is fully initialized
using scr_memsetw().  Hence there is no point in allocating zeroed
memory, while this does incur some overhead.

Closes: https://lore.kernel.org/r/CAMuHMdUH4CU9EfoirSxjivg08FDimtstn7hizemzyQzYeq6b6g@mail.gmail.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 8e76bc246b3871b0..0246948f3c81a7a6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -577,7 +577,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 		if (scr_readw(r) != vc->vc_video_erase_char)
 			break;
 	if (r != q && new_rows >= rows + logo_lines) {
-		save = kzalloc(array3_size(logo_lines, new_cols, 2),
+		save = kmalloc(array3_size(logo_lines, new_cols, 2),
 			       GFP_KERNEL);
 		if (save) {
 			int i = min(cols, new_cols);
-- 
2.34.1

