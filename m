Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C68AC3E8C5
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F3F21534
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 20:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwYLqsrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731143AbgK0T73 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 14:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730903AbgK0T6o (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:58:44 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5AAC061A04
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:40 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id s27so8558693lfp.5
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=da1A3vPp/gSfs8uQBFTqVywhFC5di/xPXEUcczCTk0g=;
        b=OwYLqsrQMpPVt+ChWeSPEvd1NbyN39kT9QgmMexvDbvKZzxVnAwlLyDVRQXb+G1rnL
         /ucb0C5ndckRbVUSYtwh/nUcnPVHej9oHsdAPqX7HZBrS2o4yFZuL8gqW0iO7Rnw+RGp
         BOdTXa9LoGy6KWFz+70GzDU88IzQGWHSzET0qaVaW8FqEE2uSANZi68YS6jMU77KEcEZ
         /dbrJTXqWAlYs8e0rRuNKw3lPCje5DbyzN/R0S/3n9oBVPW9QjmM4QGmCPp6c94I3ocJ
         nYbkmEAT7umptMLc2DtxqEh5D6JYGKqa3zu+D2BqmuhD7qMvaUefYUU4ZZQq58ZmRfKi
         MSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=da1A3vPp/gSfs8uQBFTqVywhFC5di/xPXEUcczCTk0g=;
        b=QUbN2Xh2ZD6uQhLmigg6zRDV5zi3yC9MBMFLqAOoNWvGkw+jd1q7kjmpTB9E9uHgFl
         8SgAIW/jhxjGFRBkdAtIrrhEcwwiolNtev4/s3beFg6XvisKesIjbmuw75fzZUbaMxJM
         tGiHa3zCDvoYL6utFjQRQgjlGm7TXboF55Gzs44ZN2umNoUvI10HNiY0AJmK+ATd0AW4
         6fH8yKxqUqkpsM5CR8ENDMfv67OG9krDUdASFju/RkPHZSFQc7f2qXXj0U2+BAeYrBSG
         YdP7iD6ByyIXak0v6HB5WhFy5wUnUegVPqrgnILaPj1TzXopW4MaLn1aQPxYW17ky4gG
         nOvg==
X-Gm-Message-State: AOAM533DFWIpCAz9u3qNCbunJ/MCYbthGeYLqXwEDBmfpdbVNMarL2Ni
        wwX/Cw0s/pb56o4zdj8SetuM8YInWd+Zv99u
X-Google-Smtp-Source: ABdhPJxeusx1caPeHdHB09plu8ypFBaVCpeZX2OYdt+vTNBu3WWgW/FB/EuDCLXCO8WH0av2bFYc7A==
X-Received: by 2002:a05:6512:15e:: with SMTP id m30mr3937440lfo.213.1606507119250;
        Fri, 27 Nov 2020 11:58:39 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:38 -0800 (PST)
Sender: Sam Ravnborg <sam.ravnborg@gmail.com>
From:   Sam Ravnborg <sam@ravnborg.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>
Cc:     Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: [PATCH v1 02/28] video: fbcon: Use pr_debug() in fbcon
Date:   Fri, 27 Nov 2020 20:57:59 +0100
Message-Id: <20201127195825.858960-3-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Replacing DPRINTK() statements with pr_debug fixes
W=1 warnings.
And moves to a more standard logging setup at the same time.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Peilin Ye <yepeilin.cs@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: George Kennedy <george.kennedy@oracle.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Peter Rosin <peda@axentia.se>
---
 drivers/video/fbdev/core/fbcon.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index bf61598bf1c3..2edf90f638f3 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -56,8 +56,6 @@
  *  more details.
  */
 
-#undef FBCONDEBUG
-
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/fs.h>
@@ -82,12 +80,6 @@
 
 #include "fbcon.h"
 
-#ifdef FBCONDEBUG
-#  define DPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __func__ , ## args)
-#else
-#  define DPRINTK(fmt, args...)
-#endif
-
 /*
  * FIXME: Locking
  *
@@ -1015,9 +1007,9 @@ static const char *fbcon_startup(void)
 	rows /= vc->vc_font.height;
 	vc_resize(vc, cols, rows);
 
-	DPRINTK("mode:   %s\n", info->fix.id);
-	DPRINTK("visual: %d\n", info->fix.visual);
-	DPRINTK("res:    %dx%d-%d\n", info->var.xres,
+	pr_debug("mode:   %s\n", info->fix.id);
+	pr_debug("visual: %d\n", info->fix.visual);
+	pr_debug("res:    %dx%d-%d\n", info->var.xres,
 		info->var.yres,
 		info->var.bits_per_pixel);
 
@@ -2013,7 +2005,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 	    y_diff < 0 || y_diff > virt_fh) {
 		const struct fb_videomode *mode;
 
-		DPRINTK("attempting resize %ix%i\n", var.xres, var.yres);
+		pr_debug("attempting resize %ix%i\n", var.xres, var.yres);
 		mode = fb_find_best_mode(&var, &info->modelist);
 		if (mode == NULL)
 			return -EINVAL;
@@ -2023,7 +2015,7 @@ static int fbcon_resize(struct vc_data *vc, unsigned int width,
 		if (virt_w > var.xres/virt_fw || virt_h > var.yres/virt_fh)
 			return -EINVAL;
 
-		DPRINTK("resize now %ix%i\n", var.xres, var.yres);
+		pr_debug("resize now %ix%i\n", var.xres, var.yres);
 		if (con_is_visible(vc)) {
 			var.activate = FB_ACTIVATE_NOW |
 				FB_ACTIVATE_FORCE;
@@ -3299,7 +3291,7 @@ static void fbcon_exit(void)
 
 		if (info->queue.func)
 			pending = cancel_work_sync(&info->queue);
-		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
+		pr_debug("fbcon: %s pending work\n", (pending ? "canceled" :
 			"no"));
 
 		for (j = first_fb_vc; j <= last_fb_vc; j++) {
-- 
2.27.0

