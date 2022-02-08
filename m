Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CD3C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386403AbiBHWXt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386705AbiBHVIg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 16:08:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39890C061266
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 13:08:36 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q7so505667wrc.13
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 13:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4crFuo44YkHTtsyu93ovw2eXFVSYs3TA5dMCqcACcfE=;
        b=jQi7DARCTOMXz5tC+EIC8+SSebNsfkWcI1vfAOcJgnkqRbrl9Gbw9DcNTrzkF5/AM4
         UoT9eQCdb6EjYX8w+Ub2a2EKqQNnkAABbTe0Xq0077w3volpOypc1EzJp4JNSjN1cszY
         SUvcPj044oQe627lpXmNgf2p1UJPbTY4Y4FlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4crFuo44YkHTtsyu93ovw2eXFVSYs3TA5dMCqcACcfE=;
        b=g/Z2ckC9Bp41oxJ9kHpp5i6sNJsBp1Wsv9SvP/etrHZWPzV/f2903Hsm/R1EBE6KHK
         L0GM5Qie65lasyE/iUg7B8GdNLqXPJII0q9qmvfpGBTfHbFc3t625VfZ7jpT0deBH03f
         Ht2MdFhgZGFHbIW0TpORatXZXNIInrTADFJsnbY/7KPeehXZ5BNxKJTk8kRyhTHhu4fo
         ladYPpXyuFcrDSFLOtiuPuGZERx2C7/MeQtnl59cq09veKJjhewHWH7n1vS2Sk8llLWT
         sc6IJ40n33pHDMDp2M88S79+0a2HPBVIsv1uj+dkFbOWnVBs7n3IeESTTGt9CKXbUBCc
         TujA==
X-Gm-Message-State: AOAM533mDTznUanJXz6zc+x4olB1BQS1skddC5Bosgn4bANvmWcnybZ+
        1Yrrh1TgCNh53N7B9lemcP7Q5A==
X-Google-Smtp-Source: ABdhPJxyfY2skHNX0EzH+SvK1Ftr+4E95xGCkY+AUHxfLXuaNP8ZqaFebSt7JML9HJcvQyhPEOh1kA==
X-Received: by 2002:a5d:6da8:: with SMTP id u8mr5134612wrs.362.1644354514804;
        Tue, 08 Feb 2022 13:08:34 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o14sm3033561wmr.3.2022.02.08.13.08.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 13:08:34 -0800 (PST)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Helge Deller <deller@gmx.de>, Daniel Vetter <daniel@ffwll.ch>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Du Cheng <ducheng2@gmail.com>
Subject: [PATCH v2 04/19] fbcon: delete delayed loading code
Date:   Tue,  8 Feb 2022 22:08:09 +0100
Message-Id: <20220208210824.2238981-5-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
References: <20220208210824.2238981-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Before

commit 6104c37094e729f3d4ce65797002112735d49cd1
Author: Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue Aug 1 17:32:07 2017 +0200

    fbcon: Make fbcon a built-time depency for fbdev

it was possible to load fbcon and fbdev drivers in any order, which
means that fbcon init had to handle the case where fbdev drivers where
already registered.

This is no longer possible, hence delete that code.

Note that the exit case is a bit more complex and will be done in a
separate patch.

Since I had to audit the entire fbcon load code I also spotted a wrong
function name in a comment in fbcon_startup(), which this patch also
fixes.

v2: Explain why we also fix the comment (Sam)

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Claudio Suarez <cssk@net-c.es>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: Du Cheng <ducheng2@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index b75e638cb83d..83f0223f5333 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -944,7 +944,7 @@ static const char *fbcon_startup(void)
 		return display_desc;
 	/*
 	 * Instead of blindly using registered_fb[0], we use info_idx, set by
-	 * fb_console_init();
+	 * fbcon_fb_registered();
 	 */
 	info = registered_fb[info_idx];
 	if (!info)
@@ -3299,17 +3299,6 @@ static void fbcon_start(void)
 		return;
 	}
 #endif
-
-	if (num_registered_fb) {
-		int i;
-
-		for_each_registered_fb(i) {
-			info_idx = i;
-			break;
-		}
-
-		do_fbcon_takeover(0);
-	}
 }
 
 static void fbcon_exit(void)
-- 
2.34.1

