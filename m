Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC85FC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 23:33:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348078AbiBBXd5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 18:33:57 -0500
Received: from mx-lax3-2.ucr.edu ([169.235.156.37]:60219 "EHLO
        mx-lax3-2.ucr.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347732AbiBBXd4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Feb 2022 18:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1643844836; x=1675380836;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uavpFDxmGoKjrnyH0fVmnFMq2r7aGr052ubiJDv8DR8=;
  b=ZsxCq6VOaQejAGfXqnHIWmlwIuEB4pxItn+JB1W4ncCaPhZ2r2IBXdh4
   2kZteC8ShzrpOIU9vHkDHQ7n2Bdn2sldRgIKGJQmkfp7sV3d3Et63NvKO
   8pszNq3npGUncSCLRbHO63Rcedsyob3CCFOpEYOHZtp0wVFJtbvKZ3/mx
   INZ9pL0UhkI62EGNbEmqa77Gg2ZpX3mNDJGO5yAfsJWFHtPVuE6BgkbI5
   bZUj951b8czRPlvVmXulBRxA66yzhYIcPdpO/ZaT0ethyWvPV+mXAxqWi
   PeoS+8BnJ9menTwL4hSSOuKjjfgvUo6H9UMKIO+ioZCVdiEa17R8+a0/O
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="102067139"
Received: from mail-pj1-f69.google.com ([209.85.216.69])
  by smtp-lax3-2.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Feb 2022 15:33:55 -0800
Received: by mail-pj1-f69.google.com with SMTP id mg17-20020a17090b371100b001b816f127e0so4710927pjb.9
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 15:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=xDmZHe7b0lAJqRV03cgiwQiq8aVyFS9aT+B3OaOw+dR+d9mfsO5WhWIS1hey9PxQ/8
         pnHAutlDAUGni9R+QOz9ct54DuHYBVVF5lAGy+MaQvBMrHnR7tpJyTD+Ji0/d05HnW3U
         zPGVsGrgSzCJ8Zj7ELBZ7A+GpZsIoy7zxD5Ms=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LoPhiSf2j9AFlf81eKG6xH4TR1F1QmboBbxydv3xQ7Y=;
        b=4woc++xisrQTisd2SgLXSP7YKMn/we6G+cHmFgEFUg0wPS234rlyluy9VvCceZuGWz
         DuMJNBvf4Tfy2900Qg1a3cbgY6+L6k10DiigqrXms1JI8smJ2ymFn1NvIYhzRdIt99ul
         2j6wxIliFe+BwqNU5dbodliBk1D4Yx9NgRlit6st6UZzn1NAfC05Pn6ZLPKobK4KwUrV
         U9PZGD/9KypyM0tiP8W5FLPdBYgHV/XzMEZCApPvvTnVMgu0W6bM6x1G4z1xkGtuDw2X
         HmEomGrlb59b2oUL4Cg1UIK1I1ulUwLThlFcqbWYycXLn9Wl8oO7doz6HxiiGLypppA0
         lmjQ==
X-Gm-Message-State: AOAM530WgYDRKXMOTMuUqpXgXdjORqQriuBsxCkoNMy9cL+LMtaMkrM2
        5oKHWmfA/xlyeqTj+TJ0tAHMMKPcuMbTpeaKFe3uTlNUjhP+104CfxWYAypr3NIs90wskdDxRbT
        wFa5Fr2UOrVsmmQ8dkI2Q3gNY
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr10901906pjb.50.1643844835697;
        Wed, 02 Feb 2022 15:33:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwKw43I55RvXKUF5Oc0gQfOIu6GaU+jb9Uz6QfMkQXdHo2WKNl3sIP6kqSgU/6tvpMjh2bLug==
X-Received: by 2002:a17:90b:3841:: with SMTP id nl1mr10901883pjb.50.1643844835458;
        Wed, 02 Feb 2022 15:33:55 -0800 (PST)
Received: from kq.cs.ucr.edu (kq.cs.ucr.edu. [169.235.27.223])
        by smtp.googlemail.com with ESMTPSA id s2sm26380387pgq.38.2022.02.02.15.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 15:33:55 -0800 (PST)
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Cc:     Yizhuo Zhai <yzhai003@ucr.edu>, Helge Deller <deller@gmx.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Matthew Wilcox <willy@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5] fbdev: fbmem: Fix the implicit type casting
Date:   Wed,  2 Feb 2022 15:33:58 -0800
Message-Id: <20220202233402.1477864-1-yzhai003@ucr.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <83e46d8d-ec7a-6cbd-010e-7f50f88dcf96@I-love.SAKURA.ne.jp>
References: <83e46d8d-ec7a-6cbd-010e-7f50f88dcf96@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

In function do_fb_ioctl(), the "arg" is the type of unsigned long,
and in "case FBIOBLANK:" this argument is casted into an int before
passig to fb_blank(). In fb_blank(), the comparision
if (blank > FB_BLANK_POWERDOWN) would be bypass if the original
"arg" is a large number, which is possible because it comes from
the user input. Fix this by adding the check before the function
call.

Signed-off-by: Yizhuo Zhai <yzhai003@ucr.edu>
---
 drivers/video/fbdev/core/fbmem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0fa7ede94fa6..d5dec24c4d16 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1162,6 +1162,11 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 	case FBIOBLANK:
 		console_lock();
 		lock_fb_info(info);
+		if (arg > FB_BLANK_POWERDOWN) {
+			unlock_fb_info(info);
+			console_unlock();
+			return -EINVAL;
+		}
 		ret = fb_blank(info, arg);
 		/* might again call into fb_blank */
 		fbcon_fb_blanked(info, arg);
-- 
2.25.1

