Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D4FBC64E8A
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33B0120771
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="myfU0/b/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbgK1Wmu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732694AbgK1Wmt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:49 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63464C061A49
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:39 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id j205so12743849lfj.6
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CkkKBlbXcP/dpbOfp8AnQrPHxu0MxowQOk9O/jfPEvM=;
        b=myfU0/b/5BFYwWjwwEIJ580+u3RvEPUA2rg/ubozChfVxxDlaoKNZhuFfnDH0A5lrG
         Tkjm6VvYHDbp+kfHTtLsrR5IB4+2ywduPgh/R6Lia2iz/HVW2S/38gl+oCUAbTF588SD
         pnYfdcRPs/vK8bODBe3Mi+MI9yGQSUya1bejxklUrGBtk1OmDAKhiYGGl3P+djpopBhr
         xGRQSWwMN4hU6eGB7OibLrx26ww6spt5XEdh/kEjzKPS4LzNmTmqv4Ud8s7leX6vmfsN
         BcwrEHhPrxkT7U6CrheID/979KvzyHVQUz9rayaWEtR4xuYTrMohfC9rgMyNx4iwnc1k
         0kIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CkkKBlbXcP/dpbOfp8AnQrPHxu0MxowQOk9O/jfPEvM=;
        b=sTPCVKsvIxbBiXFntKWHCKHiOHPTobeX65EfQwZ2pFUaNUv2I0gM4IBmMJv2fQTUyp
         gfpB4u67oS9OBelDA7XtVU0qUvypVSoh892Th2g9/TYzmvclt9u9aH9rIVJo5J69xgtp
         XYHa7ShUZR//A54ozc4T1aNlQJMOdU+QvpaYP3amcqGCMmlHnazDpMtpi4Y2hW0Se50c
         gg0TJ47pubXLh8p+V3erlncm4y9XPmrBo1yCQ8SZN//vC9bZkRjwf055DJgTF697f3d3
         CFuihJCA+gaVNVhzBiXDxeVKin7rdE41YYmJgdtUiWfKf71HD4JXlX5CchCWrZz7kpb5
         JaNw==
X-Gm-Message-State: AOAM533RYRBCaFWlPxEY1JlLX1VRi8OOHiiCIyQxyC6rGm2o0CIbLHmm
        9i+gsC3iuoeOR5ULX/cTv4nrmK5awwSqbA==
X-Google-Smtp-Source: ABdhPJw3xPU1N65OeV/W6wReXcoA9gIj8j2aMYlOo4jhEeadsqD44d7njz7QpKk4AOXAGGCfHn7uYg==
X-Received: by 2002:ac2:5486:: with SMTP id t6mr6432455lfk.138.1606603297672;
        Sat, 28 Nov 2020 14:41:37 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:37 -0800 (PST)
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
Subject: [PATCH v2 08/28] video: fbdev: sis: Fix defined but not used warning of SiS_TVDelay
Date:   Sat, 28 Nov 2020 23:40:54 +0100
Message-Id: <20201128224114.1033617-9-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warning by commenting unused SiS_TVDelay* variables.

The SiS_TVDelay* variables seem to contain some magic numbers
so looks like data worth keeping around but not as code we build.

v2:
  - Update subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/oem310.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/sis/oem310.h b/drivers/video/fbdev/sis/oem310.h
index 8fce56e4482c..ed28755715ce 100644
--- a/drivers/video/fbdev/sis/oem310.h
+++ b/drivers/video/fbdev/sis/oem310.h
@@ -200,6 +200,7 @@ static const unsigned char SiS310_TVDelayCompensation_651302LV[] =	/* M650, 651,
 	0x33,0x33
 };
 
+#if 0 /* Not used */
 static const unsigned char SiS_TVDelay661_301[] =			/* 661, 301 */
 {
 	0x44,0x44,
@@ -219,6 +220,7 @@ static const unsigned char SiS_TVDelay661_301B[] =			/* 661, 301B et al */
 	0x44,0x44,
 	0x44,0x44
 };
+#endif
 
 static const unsigned char SiS310_TVDelayCompensation_LVDS[] =		/* LVDS */
 {
-- 
2.27.0

