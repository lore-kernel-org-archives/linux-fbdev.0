Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4784BC64E7B
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FDC20702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGdAgss+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388283AbgK1WnF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387814AbgK1WnE (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:04 -0500
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 672C8C061A53
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:52 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id r18so10599478ljc.2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RGE3ZlcEoP1SxPsiy77Qp2XR/URo401XNflyUfm64IE=;
        b=NGdAgss+FahUORm2x4DH9YzsRqcLgj0lXXnanlCNTpQqTfgaHVlZbqLKRsMQzZYxr9
         zoNveiLLa1iWP5JzNJVbw2lOPyrYB0Sr9ombxq1voQHGB0Oo0GL1KsoUzlrx5S5Zj56f
         vBruRLtiEHiE1X6vaJoYrf7Du6qhuS43Nd6BzkBFhTZF4pLxxowsP4uUsT58x6nym+Ky
         AznbSHvNNjj+pDf4WbGInBM6Ze0G+zZbUtGflnyzFIGPHXIiuUqYL8MYj+aFqwOMzb0e
         HT14qrtojp/d8CjY0HP3bmUNZP/E3NNfrZqdf5SXo4FDLbagOAzajk3oioHmWKIFT+FU
         UTXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RGE3ZlcEoP1SxPsiy77Qp2XR/URo401XNflyUfm64IE=;
        b=jC/hoatx0m3F5WLTokq3cE7r8NlxTpCfGj50A6pWnP1ekb8NwvuFpkFb+57DLWRzFB
         KnpledrXCumFNgvAb3g+MXNBKSTUxd/tlUbXZUs/u+Iy/k5xIetB6ohz6EQEjqNCvz2y
         EaBsrPRHmx0Oj5Qt6PYT6zcPqLyPVs/7LMmn/vrC7ic5upzcd+ZhwLv36ARwc8QdUTBx
         OF+k45Aw/vvzH8F6Qfy7ANzj3KLWo44lBw4UkDhB1OcsOhzKbYJFRlsZS84Ylm0M9o3F
         LbbLe8dk2gfP7M4AjoI/9IScKAQkZyozqcjoE0SZZXH71vivWa7mMMg3marqsQbehg9/
         A8hA==
X-Gm-Message-State: AOAM532UGKl3KYLL9K46ch7Y00rl2c+jub6GWQ3yl5IBoH8CuNCVEN2e
        0EXAv8EifhDyBjQIIkb3LJZJJdQ6Wj20RA==
X-Google-Smtp-Source: ABdhPJxpScsB3nbNJ7Ym+OnGnfIL7YQp8eOIXX03B8zty9uORsv85KSdCb7dN3BdLWsJa159Bj2Bxg==
X-Received: by 2002:a2e:99c8:: with SMTP id l8mr6101773ljj.469.1606603310634;
        Sat, 28 Nov 2020 14:41:50 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:50 -0800 (PST)
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
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 15/28] video: fbdev: neofb: Fix set but not used warning for CursorMem
Date:   Sat, 28 Nov 2020 23:41:01 +0100
Message-Id: <20201128224114.1033617-16-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings by removing unused code

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Evgeny Novikov <novikov@ispras.ru>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/neofb.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/video/fbdev/neofb.c b/drivers/video/fbdev/neofb.c
index 09a20d4ab35f..c0f4f402da3f 100644
--- a/drivers/video/fbdev/neofb.c
+++ b/drivers/video/fbdev/neofb.c
@@ -1843,7 +1843,6 @@ static int neo_init_hw(struct fb_info *info)
 	struct neofb_par *par = info->par;
 	int videoRam = 896;
 	int maxClock = 65000;
-	int CursorMem = 1024;
 	int CursorOff = 0x100;
 
 	DBG("neo_init_hw");
@@ -1895,19 +1894,16 @@ static int neo_init_hw(struct fb_info *info)
 	case FB_ACCEL_NEOMAGIC_NM2070:
 	case FB_ACCEL_NEOMAGIC_NM2090:
 	case FB_ACCEL_NEOMAGIC_NM2093:
-		CursorMem = 2048;
 		CursorOff = 0x100;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2097:
 	case FB_ACCEL_NEOMAGIC_NM2160:
-		CursorMem = 1024;
 		CursorOff = 0x100;
 		break;
 	case FB_ACCEL_NEOMAGIC_NM2200:
 	case FB_ACCEL_NEOMAGIC_NM2230:
 	case FB_ACCEL_NEOMAGIC_NM2360:
 	case FB_ACCEL_NEOMAGIC_NM2380:
-		CursorMem = 1024;
 		CursorOff = 0x1000;
 
 		par->neo2200 = (Neo2200 __iomem *) par->mmio_vbase;
-- 
2.27.0

