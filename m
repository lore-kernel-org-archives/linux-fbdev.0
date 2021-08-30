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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3963CC4320E
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 03:31:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 055F360234
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 03:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhH3Dbu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Aug 2021 23:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhH3Dbt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Aug 2021 23:31:49 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D576CC061575;
        Sun, 29 Aug 2021 20:30:56 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id k24so12100372pgh.8;
        Sun, 29 Aug 2021 20:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=LVrIEBdknSQXfx0VWfJkptFor1oJQkXATIr1CLgYdbo=;
        b=Rx5ngJvkMPbn+t9gQ+9VQUcXzvxVRWcJ2tjxNgrBTxmU8Xt1uvHrSbgQE+UcCB7YHV
         rFPp2YHE4RBUQSKnYVU5J9VAdcySGI+iGbZeiFqgpuOztwBsAEWUeR2BYLDdtZgA2LgD
         YCya/h6gd/JnKYwrlGFqBi5SrZskqdrwVkpkQ/UkOEnv5t/CrSnLcwqZu2yjeSyC+PA8
         ky7W5gjOJbxG+26zITFMTB0JtssZKkznOXUJh1H1DIZaqXiZuDqqXvnPgWWStL5gJxN3
         5DMygP+sp5m/+Y9DznBKubMtCs5vd1a/snq8wF7hXV5sGJxQFy0/qxnPCSKR9htneYKt
         PZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=LVrIEBdknSQXfx0VWfJkptFor1oJQkXATIr1CLgYdbo=;
        b=mEbr0yhFXypSyaNmQkzUtl9LkO+deN0Lhan1C6SJxRsyfipxOfhNSfCZsLDXB7Kvqx
         U5BSml6sPM2lKw5j8KYu88lK31SYFlbfOW+V6QyAlvy4SXcuTKfHQvk5QVp923dbF3Q/
         7PNd5MfpKA3Mth8NYJas+lEEL+z6XFwmoFe/L2yg1/rHlP2cDNLCzK+9JMWXjWHYfYDX
         MObNyGqrCvZSzOFXhJz1W1v71EFlavdjVKI1vsT2ZleqhwbfrT16bXwNAPcOvbbtjvAf
         /1Qa3sbOqRAvVwofEjl4JM+mLfwiY14v5/PZsNNB5qQyD4ZukriRPtrP1WWbkBBHyvKh
         rFdg==
X-Gm-Message-State: AOAM530W0eIHt6GJF7aNKv0Gatrdde7bIF0mVmOvc2WHZSqNB8ZHXXQd
        aABMwhShl456vNGFmItHL64=
X-Google-Smtp-Source: ABdhPJyDJ8StFoH8uIEVwWqjuwhqKzajigoszqpezpWUt4cO4yn0Yb7skWuCO5WlHbQOrgEdS9kyqQ==
X-Received: by 2002:a05:6a00:84d:b0:3ff:24a6:1d9b with SMTP id q13-20020a056a00084d00b003ff24a61d9bmr3938605pfk.14.1630294256191;
        Sun, 29 Aug 2021 20:30:56 -0700 (PDT)
Received: from localhost.localdomain ([162.14.21.36])
        by smtp.gmail.com with ESMTPSA id 20sm13139989pfi.170.2021.08.29.20.30.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 29 Aug 2021 20:30:55 -0700 (PDT)
From:   tcs.kernel@gmail.com
X-Google-Original-From: tcs_kernel@tencent.com
To:     daniel.vetter@ffwll.ch, willy@infradead.org,
        george.kennedy@oracle.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        penguin-kernel@I-love.SAKURA.ne.jp
Cc:     Haimin Zhang <tcs_kernel@tencent.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: [PATCH V4] fbcon: fix fbcon out-of-bounds write in sys_imageblit
Date:   Mon, 30 Aug 2021 11:30:23 +0800
Message-Id: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Haimin Zhang <tcs_kernel@tencent.com>

yres and vyres can be controlled by user mode parameters, and cause
p->vrows to become a negative value. While this value be passed to real_y
function, the ypos will be out of screen range.This is an out-of-bounds
write bug.
some driver will check xres and yres in fb_check_var callback,but some not
so we add a common check after that callback.

Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
---
 drivers/video/fbdev/core/fbmem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 1c85514..5599372 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1013,6 +1013,10 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
 	if (ret)
 		return ret;
 
+	/* virtual resolution cannot be smaller than visible resolution. */
+	if (var->yres_virtual < var->yres || var->xres_virtual < var->xres)
+		return -EINVAL;
+
 	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
 		return 0;
 
-- 
1.8.3.1

