Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF845C77B61
	for <linux-fbdev@archiver.kernel.org>; Tue, 25 Apr 2023 14:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233893AbjDYO2z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 25 Apr 2023 10:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbjDYO2w (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 25 Apr 2023 10:28:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4852D54
        for <linux-fbdev@vger.kernel.org>; Tue, 25 Apr 2023 07:28:51 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2EAE4219C1;
        Tue, 25 Apr 2023 14:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1682432930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQABSfQRyIdDzQ/2aBb6RQQndmg/tEmC+h0//N9kxaE=;
        b=1nvApDr0Vf6xjcXPKlh5HXFwc5SVHGSYsalRjKRY+oRCbGEqPxOWuyra5HwezGpGKL1gDl
        hV8LmyFe+2OLxphBPaunug6NPNInBfFiP+/12c8gzpAJ0N6XIrXAjvgra79cEsSjhnzl7z
        DUlg/WRfkcXo/WKK5eI1h7s0XfTuEPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1682432930;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MQABSfQRyIdDzQ/2aBb6RQQndmg/tEmC+h0//N9kxaE=;
        b=DHDfYIN0L01WOEnz6oeP0z74SvDE0DXAofMCC/7ExHP/VTJSd25bXh5aVoAV9Cmm34PgMo
        hPGLJ3X+FRL31tDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6CD2138E3;
        Tue, 25 Apr 2023 14:28:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MKF5N6HjR2ReOgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 25 Apr 2023 14:28:49 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@gmail.com, daniel@ffwll.ch, javierm@redhat.com,
        deller@gmx.de, geert@linux-m68k.org, sudipm.mukherjee@gmail.com,
        teddy.wang@siliconmotion.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/6] fbdev: Validate info->screen_{base,buffer} in fb_ops implementations
Date:   Tue, 25 Apr 2023 16:28:44 +0200
Message-Id: <20230425142846.730-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230425142846.730-1-tzimmermann@suse.de>
References: <20230425142846.730-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Push the test for info->screen_base from fb_read() and fb_write() into
the implementations of struct fb_ops.{fb_read,fb_write}. In cases where
the driver operates on info->screen_buffer, test this field instead.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/cobalt_lcdfb.c     |  6 ++++++
 drivers/video/fbdev/core/fb_sys_fops.c |  6 ++++++
 drivers/video/fbdev/core/fbmem.c       | 10 ++++++++--
 drivers/video/fbdev/sm712fb.c          |  4 ++--
 4 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/cobalt_lcdfb.c b/drivers/video/fbdev/cobalt_lcdfb.c
index 5f8b6324d2e8..26dbd1c78195 100644
--- a/drivers/video/fbdev/cobalt_lcdfb.c
+++ b/drivers/video/fbdev/cobalt_lcdfb.c
@@ -129,6 +129,9 @@ static ssize_t cobalt_lcdfb_read(struct fb_info *info, char __user *buf,
 	unsigned long pos;
 	int len, retval = 0;
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	pos = *ppos;
 	if (pos >= LCD_CHARS_MAX || count == 0)
 		return 0;
@@ -175,6 +178,9 @@ static ssize_t cobalt_lcdfb_write(struct fb_info *info, const char __user *buf,
 	unsigned long pos;
 	int len, retval = 0;
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	pos = *ppos;
 	if (pos >= LCD_CHARS_MAX || count == 0)
 		return 0;
diff --git a/drivers/video/fbdev/core/fb_sys_fops.c b/drivers/video/fbdev/core/fb_sys_fops.c
index 7dee5d3c7fb1..0cb0989abda6 100644
--- a/drivers/video/fbdev/core/fb_sys_fops.c
+++ b/drivers/video/fbdev/core/fb_sys_fops.c
@@ -22,6 +22,9 @@ ssize_t fb_sys_read(struct fb_info *info, char __user *buf, size_t count,
 	unsigned long total_size, c;
 	ssize_t ret;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -61,6 +64,9 @@ ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 	unsigned long total_size, c;
 	size_t ret;
 
+	if (!info->screen_buffer)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index abc92d79a295..b993bb97058f 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -768,7 +768,7 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	int c, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || ! info->screen_base)
+	if (!info)
 		return -ENODEV;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -777,6 +777,9 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 	if (info->fbops->fb_read)
 		return info->fbops->fb_read(info, buf, count, ppos);
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
@@ -833,7 +836,7 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	int c, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info)
 		return -ENODEV;
 
 	if (info->state != FBINFO_STATE_RUNNING)
@@ -842,6 +845,9 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (info->fbops->fb_write)
 		return info->fbops->fb_write(info, buf, count, ppos);
 
+	if (!info->screen_base)
+		return -ENODEV;
+
 	total_size = info->screen_size;
 
 	if (total_size == 0)
diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 6f852cd756c5..b7ad3c644e13 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -1028,7 +1028,7 @@ static ssize_t smtcfb_read(struct fb_info *info, char __user *buf,
 	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info->screen_base)
 		return -ENODEV;
 
 	total_size = info->screen_size;
@@ -1091,7 +1091,7 @@ static ssize_t smtcfb_write(struct fb_info *info, const char __user *buf,
 	int c, i, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || !info->screen_base)
+	if (!info->screen_base)
 		return -ENODEV;
 
 	total_size = info->screen_size;
-- 
2.40.0

