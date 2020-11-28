Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95121C64E7B
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60E8620702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NZOYx0PX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732712AbgK1Wnf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732750AbgK1Wne (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:34 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7DCC0617A7
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:16 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id d20so12700355lfe.11
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:42:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/wOYQm62UhJJiBuQwa5K2rYcXYPHs0L5tvvEbAmKSNM=;
        b=NZOYx0PXz29EI6oUGn7poLQOl3WKi1JE7XojDK9qkRt1BU3tYpqof835ajOsE3bAQz
         +N1wIFEeoMctj3+aSVd02EbL/iO5MbQVuFj2whjZCstGYrBcODFncMIVBgimHZ+3a5PL
         gVh6gU41uaM1BwqVOtKHmHqGlPGOQ4X7P1PPOgKr9hpd18xx2UTiyqDaCWiKF7JkhI60
         ce3lz2iYacfvWKV7RE3bylfc1eqtTkqO4UaaaJ0zedIeRGJxwA/8gGcBcCGT4qnx8cMp
         +qPPnntEcXBIsCrEs9J+ef8eLoYGcx9H2iK6p130Rw4ddHLBj1kB0XC70pVLiYc1F2sp
         hqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/wOYQm62UhJJiBuQwa5K2rYcXYPHs0L5tvvEbAmKSNM=;
        b=Nd2dZCpAsMVICYjg3MjTTEbLf0eGGWr3dRBzqXkAWnT9niEt+s3MK8GwOYZBB9W5TC
         Xxzj7cHnKis8YZl0o2p+zU4UgsMshlv3eMSgG/NdQ76JkZt/118kFlheChyjq0w8TnNG
         XGzy2zajJ66+SgnrdaR43SUt6yiJMO3YhY+Fb1jl++eDEMUR60f5boWTBSbC7Z5BjU1Y
         PxaN8i2XP6gptDXW/rhNOpdjCJf1y4iKnAFx57S1IvBsbTPKJ1lxDuwtTFRJIiLV20Dk
         UV1/jRkqR3tXjqRSsXoan1WK2vZr/7P+U6mVI0KAThfk9OrWRGuoMpWposbQCLXaCf5Z
         Hu3w==
X-Gm-Message-State: AOAM530yEJi7kL6DFHpsXK3CxnKxwFG47hD4b4EwzzqlidwBcyLHxjqx
        cGeA/5nh1H4FIQL2ggS62QQ2s4s8W8SM+A==
X-Google-Smtp-Source: ABdhPJwgu41H0h4BWPxtxzUlLXhRkkdQIo57ciP/l1l7Li+YJUMCKjT0gBiawsB+TaPikmiXCZpNPg==
X-Received: by 2002:a19:4915:: with SMTP id w21mr6485130lfa.57.1606603335224;
        Sat, 28 Nov 2020 14:42:15 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:42:14 -0800 (PST)
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
Subject: [PATCH v2 28/28] video: fbdev: s1d13xxxfb: Fix kernel-doc and set but not used warnings
Date:   Sat, 28 Nov 2020 23:41:14 +0100
Message-Id: <20201128224114.1033617-29-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix following W=1 warnings:
- Fix set but not nused variables which was used only for logging.
  Fixed by introducing no_printk() to trick compiler to think variables
  are used
- Fix kernel-doc warning by deleting an empty comment line

v2:
  - Subject updated (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Kristoffer Ericson <kristoffer.ericson@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/s1d13xxxfb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/s1d13xxxfb.c b/drivers/video/fbdev/s1d13xxxfb.c
index 4541afcf9386..d1b5f965bc96 100644
--- a/drivers/video/fbdev/s1d13xxxfb.c
+++ b/drivers/video/fbdev/s1d13xxxfb.c
@@ -45,7 +45,7 @@
 #if 0
 #define dbg(fmt, args...) do { printk(KERN_INFO fmt, ## args); } while(0)
 #else
-#define dbg(fmt, args...) do { } while (0)
+#define dbg(fmt, args...) do { no_printk(KERN_INFO fmt, ## args); } while (0)
 #endif
 
 /*
@@ -512,7 +512,6 @@ s1d13xxxfb_bitblt_copyarea(struct fb_info *info, const struct fb_copyarea *area)
 }
 
 /**
- *
  *	s1d13xxxfb_bitblt_solidfill - accelerated solidfill function
  *	@info : framebuffer structure
  *	@rect : fb_fillrect structure
-- 
2.27.0

