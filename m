Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E9A4C43460
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 09:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B4461370
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 May 2021 09:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232802AbhEMJxG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 13 May 2021 05:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbhEMJw7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 13 May 2021 05:52:59 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A654AC06174A
        for <linux-fbdev@vger.kernel.org>; Thu, 13 May 2021 02:51:49 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id D505292009E; Thu, 13 May 2021 11:51:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id CCDBF92009B;
        Thu, 13 May 2021 11:51:45 +0200 (CEST)
Date:   Thu, 13 May 2021 11:51:45 +0200 (CEST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel@ffwll.ch>,
        Martin Hostettler <textshell@uchuujin.de>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] vt_ioctl: Revert VT_RESIZEX parameter handling
 removal
In-Reply-To: <alpine.DEB.2.21.2105131132100.3032@angie.orcam.me.uk>
Message-ID: <alpine.DEB.2.21.2105131137130.3032@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2105131132100.3032@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Revert the removal of code handling extra VT_RESIZEX ioctl's parameters 
beyond those that VT_RESIZE supports, fixing a functional regression 
causing `svgatextmode' not to resize the VT anymore.  As a consequence 
of the reverted change when the video adapter is reprogrammed from the 
original say 80x25 text mode using a 9x16 character cell (720x400 pixel 
resolution) to say 80x37 text mode and the same character cell (720x592 
pixel resolution), the VT geometry does not get updated and only upper 
two thirds of the screen are used for the VT, and the lower part remains 
blank.  The proportions change according to text mode geometries chosen.

Revert the change verbatim then, bringing back previous VT resizing.

Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Fixes: 988d0763361b ("vt_ioctl: make VT_RESIZEX behave like VT_RESIZE")
Cc: stable@vger.kernel.org # v5.10+
---
No changes from v1.
---
 drivers/tty/vt/vt_ioctl.c |   57 +++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 10 deletions(-)

Index: linux-macro-ide/drivers/tty/vt/vt_ioctl.c
===================================================================
--- linux-macro-ide.orig/drivers/tty/vt/vt_ioctl.c
+++ linux-macro-ide/drivers/tty/vt/vt_ioctl.c
@@ -671,21 +671,58 @@ static int vt_resizex(struct vc_data *vc
 	if (copy_from_user(&v, cs, sizeof(struct vt_consize)))
 		return -EFAULT;
 
-	if (v.v_vlin)
-		pr_info_once("\"struct vt_consize\"->v_vlin is ignored. Please report if you need this.\n");
-	if (v.v_clin)
-		pr_info_once("\"struct vt_consize\"->v_clin is ignored. Please report if you need this.\n");
+	/* FIXME: Should check the copies properly */
+	if (!v.v_vlin)
+		v.v_vlin = vc->vc_scan_lines;
+
+	if (v.v_clin) {
+		int rows = v.v_vlin / v.v_clin;
+		if (v.v_rows != rows) {
+			if (v.v_rows) /* Parameters don't add up */
+				return -EINVAL;
+			v.v_rows = rows;
+		}
+	}
+
+	if (v.v_vcol && v.v_ccol) {
+		int cols = v.v_vcol / v.v_ccol;
+		if (v.v_cols != cols) {
+			if (v.v_cols)
+				return -EINVAL;
+			v.v_cols = cols;
+		}
+	}
+
+	if (v.v_clin > 32)
+		return -EINVAL;
 
-	console_lock();
 	for (i = 0; i < MAX_NR_CONSOLES; i++) {
-		vc = vc_cons[i].d;
+		struct vc_data *vcp;
 
-		if (vc) {
-			vc->vc_resize_user = 1;
-			vc_resize(vc, v.v_cols, v.v_rows);
+		if (!vc_cons[i].d)
+			continue;
+		console_lock();
+		vcp = vc_cons[i].d;
+		if (vcp) {
+			int ret;
+			int save_scan_lines = vcp->vc_scan_lines;
+			int save_font_height = vcp->vc_font.height;
+
+			if (v.v_vlin)
+				vcp->vc_scan_lines = v.v_vlin;
+			if (v.v_clin)
+				vcp->vc_font.height = v.v_clin;
+			vcp->vc_resize_user = 1;
+			ret = vc_resize(vcp, v.v_cols, v.v_rows);
+			if (ret) {
+				vcp->vc_scan_lines = save_scan_lines;
+				vcp->vc_font.height = save_font_height;
+				console_unlock();
+				return ret;
+			}
 		}
+		console_unlock();
 	}
-	console_unlock();
 
 	return 0;
 }
