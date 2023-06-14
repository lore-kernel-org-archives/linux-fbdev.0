Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61DE5EB64D8
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Jun 2023 13:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbjFNNNv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Jun 2023 09:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244911AbjFNNNt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Jun 2023 09:13:49 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138541FF7
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Jun 2023 06:13:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 0A1A72253C;
        Wed, 14 Jun 2023 13:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1686748378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NowBNHYm1j2pm0/04DLXGS/RJgQBaug3LwNNgtMoY80=;
        b=glTK7zrMsJmcWs0ZjCgJiDxyaUC+EE1DvQVdNqldwLb2FC1v/gCcRylZuGCKF1bjGi/YsU
        w0GWbXihHeQNXJyLmtxW9re1KO6+e3e8YRV5KzZx00/N9aH+Aw/GYLBtgWrfLilDdVaPfI
        iw1cUJXx7t9+i5oYw4L7/II5dWSw+cs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1686748378;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=NowBNHYm1j2pm0/04DLXGS/RJgQBaug3LwNNgtMoY80=;
        b=y+ch78RgGWXplwWjv3k6PnrNIeBC7aGodjEjYGXOYrCgUv3Ni5gya6YG1hBqnnXqr5J92R
        ObJrE1+IPZy95EAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CDF261357F;
        Wed, 14 Jun 2023 13:12:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Ev44Mdm8iWR9VAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 14 Jun 2023 13:12:57 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     sam@ravnborg.org, deller@gmx.de, ckoenig.leichtzumerken@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] fbdev: Use /* */ comment in initializer macro
Date:   Wed, 14 Jun 2023 15:12:12 +0200
Message-ID: <20230614131253.10208-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Use /* */ in initializer macro to avoid out-commenting the comma
at the end of the line.

Reported-by: Christian König <ckoenig.leichtzumerken@gmail.com>
Closes: https://lore.kernel.org/dri-devel/20230530150253.22758-1-tzimmermann@suse.de/T/#m356cda2679c17d7a01f30ce2b5282cd9046ea6d4
Fixes: f1061fa641b8 ("fbdev: Add initializer macros for struct fb_ops")
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 include/linux/fb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fb.h b/include/linux/fb.h
index ce6823e157e6b..ce7d588edc3e6 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -552,7 +552,7 @@ extern ssize_t fb_io_write(struct fb_info *info, const char __user *buf,
 	.fb_imageblit	= cfb_imageblit
 
 #define __FB_DEFAULT_IO_OPS_MMAP \
-	.fb_mmap	= NULL // default implementation
+	.fb_mmap	= NULL /* default implementation */
 
 #define FB_DEFAULT_IO_OPS \
 	__FB_DEFAULT_IO_OPS_RDWR, \
@@ -585,7 +585,7 @@ extern ssize_t fb_sys_write(struct fb_info *info, const char __user *buf,
 	.fb_imageblit	= sys_imageblit
 
 #define __FB_DEFAULT_SYS_OPS_MMAP \
-	.fb_mmap	= NULL // default implementation
+	.fb_mmap	= NULL /* default implementation */
 
 #define FB_DEFAULT_SYS_OPS \
 	__FB_DEFAULT_SYS_OPS_RDWR, \
-- 
2.41.0

