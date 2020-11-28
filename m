Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD032C64E7D
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B07F20702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cFk6UHh1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387754AbgK1WmR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387681AbgK1WmQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:16 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62095C0613D4
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:30 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id f18so10578627ljg.9
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LdDgNuGgErPdHu+TCAPas4kKOuFU9UdpBETdmvhEYm8=;
        b=cFk6UHh1GPx3ccPWrUSUTZuavAngx+GlFcO+u6qQ9SB9tnO1bmHZ7C3rX0xsm3mdPN
         CkYFdR4SCPcCFdQTFTqiuu7IHelMz//Ys4aoH5Jl08cTsrz24RaA+k/KIZOqq/Ve8L4L
         CX0VXRluAh22kjNDNjEEgukilQsoHa0wsmVMjPxFFdeMIJujLzBi/2AueavSTFZHf1qZ
         ezK2jT8IGOfaJ4ldPKBFxkV8scEqNN1jKwGoYvgpgMRAfcMsi1Tj2M7JVuIpxfPwKA/e
         /TwTI5P61P47P9uTBWyL3VVBm13QK/sfQePvUUE0z1v49r4H6WXdPCzHMWn5o8mJPgdK
         cdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=LdDgNuGgErPdHu+TCAPas4kKOuFU9UdpBETdmvhEYm8=;
        b=emYh9edmafOFDV3Uo78HcJ4BS6CPY8NPbfbftRjib+bZlk4Mp5S5Ix1MJt+qQrP7cQ
         Gnmiu2w7cqm9hGLRRiXJIiWT6cigl9hn1hE3ucVB6qle6E6Gq4KULmWmAQMaYHgipzAo
         eKXyqs6tILqhaiWRsTVIzOr0Q2dBQFd5zX7yAvLAsUYITgIcONt/0reGGL/bRGSF1hK/
         o/D3JPWO8UjjxYsmkMayJYsV3zdDlNaBGaL4Wp6MK8+Z5kIT+dEDgYeGUEgvRtqfk8vv
         qzHz1OeI3VPFzjB1RGvDlzSrrMmbc9EYpBDyoWMuJlTNdceaiUyFum8CLA3T7qk0FYC6
         QiVQ==
X-Gm-Message-State: AOAM5328ob0Qz8QXNynVv9CMSu9WaT5qHNeFtKdGyMIcXru/u0oI7Cta
        8b2UEyCKElLK/9Bj4vVNCUMm3h05t1fuDg==
X-Google-Smtp-Source: ABdhPJwKqTgycGtvqKEd9497HZCekzPHQbsM9lUTpAxPO6FfM5xjyn3DOkE8grANkPTZdwdkHUHNIQ==
X-Received: by 2002:a2e:b4af:: with SMTP id q15mr3800772ljm.273.1606603288637;
        Sat, 28 Nov 2020 14:41:28 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:28 -0800 (PST)
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
Subject: [PATCH v2 03/28] video: fbdev: core: Fix kernel-doc warnings in fbmon + fb_notify
Date:   Sat, 28 Nov 2020 23:40:49 +0100
Message-Id: <20201128224114.1033617-4-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix kernel-doc warnings reported when using W=1

v2:
  - Improve subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
---
 drivers/video/fbdev/core/fb_notify.c | 3 ++-
 drivers/video/fbdev/core/fbmon.c     | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_notify.c b/drivers/video/fbdev/core/fb_notify.c
index 74c2da528884..d85717b6e14a 100644
--- a/drivers/video/fbdev/core/fb_notify.c
+++ b/drivers/video/fbdev/core/fb_notify.c
@@ -38,7 +38,8 @@ EXPORT_SYMBOL(fb_unregister_client);
 
 /**
  * fb_notifier_call_chain - notify clients of fb_events
- *
+ * @val: value passed to callback
+ * @v: pointer passed to callback
  */
 int fb_notifier_call_chain(unsigned long val, void *v)
 {
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 1bf82dbc9e3c..b0e690f41025 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -605,6 +605,7 @@ static void get_detailed_timing(unsigned char *block,
  * fb_create_modedb - create video mode database
  * @edid: EDID data
  * @dbsize: database size
+ * @specs: monitor specifications, may be NULL
  *
  * RETURNS: struct fb_videomode, @dbsize contains length of database
  *
@@ -1100,7 +1101,6 @@ static u32 fb_get_hblank_by_hfreq(u32 hfreq, u32 xres)
  *                                    2 * M
  *        M = 300;
  *        C = 30;
-
  */
 static u32 fb_get_hblank_by_dclk(u32 dclk, u32 xres)
 {
-- 
2.27.0

