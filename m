Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62D5C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 00:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1AF22242
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 00:30:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ctjpvSvX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730858AbgK0UDF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 15:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbgK0UBR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 15:01:17 -0500
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614A8C08E861
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:36 -0800 (PST)
Received: by mail-lf1-x143.google.com with SMTP id l11so8590692lfg.0
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MQ7x12uggS1hOxK6f7aoLRuOChXNZlZXJg/tbIyd2NE=;
        b=ctjpvSvXytDB/DKOBAaGeJq6N+6ajZhDwwURDOm1a77ewn2epdHf91lKJmKsmV9Ntc
         Wk7XOINOThuZoiwWZIwCNjvbaF28djxwFm9wYet8glHpvm53BKYrCKMwJYauCUMjmOmq
         NxdjwfIK2Jnz4h/ah7pTKLyOLkSBMEdvoU3ifR3hRUcWGd/975WKCDBtdInczsSnIEg+
         JeWR62v/ubFBf3s/ap4vXK2Ta0ZR6TBHKp7ez3oY7QFQLKm5WH6wK479iEQq3KwVKZU2
         uw7IyT5qTtjFrWVxADiTkvkAYzbAuJ4tla5i6bd5kK5ffGxj2H1VYYZQbAFYeabjtXdB
         jSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MQ7x12uggS1hOxK6f7aoLRuOChXNZlZXJg/tbIyd2NE=;
        b=sgJprSN1OkR3HEgXfiwUK89KDGD8W4RDlT4BOqhQmcNWZ1a7FzeNaqt+x6JGDuBS8z
         dJph10djgC/LRQ8CBuR/w94ydd/5NyNaUJ9PhPZ82Qs0xd0dRCdWHKdaOiGyVq+YSm+y
         jW0I97ahDrtPlHdLjLmGW0kGHR/G/Iz+1YRaT/ILrlwe37wu+464H5S43coVnP0z6Z8I
         YYh4GqQp0Lc1lh9GvvmdB3IQP4bOv90fxpUyrGRcz/eesM3xNkcdq0pySgIrxYUmZvhr
         E3GZCOSw0rJCvAFXmKiPsH3RSM/FT60da4a4ysCnqhEuXZPhsd3kpRL92u3A3i7sIHov
         C3qQ==
X-Gm-Message-State: AOAM53116fL61Us4dZPutvdDJbd0ENUjFB/dSgWSnAYeaD1gdiZFp2p3
        hgpbpd0HaoleQuyAOf+V0UrI2hM/uZ3LtyGF
X-Google-Smtp-Source: ABdhPJwsswLBNRVwQvuTIB+FN9iriKOhhkmrAHLnDO+ZnWN0hmlyW5YbmkqfB7BJvDh/ZXx/oMQYeg==
X-Received: by 2002:a05:6512:481:: with SMTP id v1mr4168850lfq.132.1606507174690;
        Fri, 27 Nov 2020 11:59:34 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:34 -0800 (PST)
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
Subject: [PATCH v1 23/28] video: fbdev: omapfb: Fix W=1 warnings in hdmi*_core
Date:   Fri, 27 Nov 2020 20:58:20 +0100
Message-Id: <20201127195825.858960-24-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix a few W=1 warnings about unused assignments.
Drop the unused error code.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Qilong Zhang <zhangqilong3@huawei.com>
Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c | 4 ++--
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
index 726c190862d4..e6363a420933 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
@@ -679,7 +679,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	struct hdmi_audio_format audio_format;
 	struct hdmi_audio_dma audio_dma;
 	struct hdmi_core_audio_config acore;
-	int err, n, cts, channel_count;
+	int n, cts, channel_count;
 	unsigned int fs_nr;
 	bool word_length_16b = false;
 
@@ -741,7 +741,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		return -EINVAL;
 	}
 
-	err = hdmi_compute_acr(pclk, fs_nr, &n, &cts);
+	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
 
 	/* Audio clock regeneration settings */
 	acore.n = n;
diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
index eda29d3032e1..cb63bc0e92ca 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
@@ -790,7 +790,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 	struct hdmi_audio_format audio_format;
 	struct hdmi_audio_dma audio_dma;
 	struct hdmi_core_audio_config core_cfg;
-	int err, n, cts, channel_count;
+	int n, cts, channel_count;
 	unsigned int fs_nr;
 	bool word_length_16b = false;
 
@@ -833,7 +833,7 @@ int hdmi5_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
 		return -EINVAL;
 	}
 
-	err = hdmi_compute_acr(pclk, fs_nr, &n, &cts);
+	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
 	core_cfg.n = n;
 	core_cfg.cts = cts;
 
-- 
2.27.0

