Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A0C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E192722250
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 01:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5kbqnNA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgK1BcP (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 20:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731126AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12A0C08C5F2
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:17 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id y16so7155185ljk.1
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mRaQzSKHKEuFE/qSNI079F7TkEGyaY0pXgqjdW2jv1k=;
        b=F5kbqnNAjMLimvM6NUli0+DihWCFYsBD33fOr3p163gxIURDv8B6jteJoEoQ+geGjs
         MaShloEU1MtW6yhoNx/S2FtEUiP/7S0bg73YNb68VLyN+2NS/JHHXYq/MRDrl+j7d7Qs
         apXomIG4x8rmWcntA311Xv5TtIvKNpWMQ+cb2zkPlxhYuHglLRxZ+Xvh3yVfhmM9lD9W
         JllBNk9cOxuFLM2zmwQc8VfnmQYPwmQqBFcMfBMPTcNa7qxUor4JsVKfnWzCHQvP1QKT
         lb6tD8ZSHCEjGsUQXad9S939PolnZeDXHL8rxy8QaDpTsTyRy/dZxjqXXBF2+Bk4rC8g
         LuVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mRaQzSKHKEuFE/qSNI079F7TkEGyaY0pXgqjdW2jv1k=;
        b=BvICOvb7XVHPvM+KuXXl0AfpqtKfyqF3mZ/w2Ct8/K2E7NSYhSLp6Kal83JqHouQkt
         bAFR1PYgNIzUU5FlHMjgYbP7a9HwuxEZNCQ1dz5/zN1rwrE8Ce18Bov5E58P5vWuQzUg
         8jZrCM844v7/Vagx9qW9GbbvsJ27rzrAyyRZrqkRbT/FX0zMOarsuFNfJhLKKAqU7D0o
         PSSb0hY5uf4zl6aoslmhenYSQyim9g/+XrQ7ZHI+/tLc9NcPK8h2GRp9IwV1ramcdvfu
         5nO3RosT4d71b2TqPzW6LXHyxAwFdru187ricrGxkFLHITkv3mqT77ki42RrPefm8br7
         LauA==
X-Gm-Message-State: AOAM530cn+nRIyYhpjw3WbL0uOT1AQNRYOCtyV2u3wFhffE4pgl7gBfz
        xK7e5NZfnsqobegnV0dUSbB0/wdAerzOwQke
X-Google-Smtp-Source: ABdhPJxny0VqK6KTdW128+jhrnmUhcAiAPM8ah698YeRpDAV9+q/qAnWBVSKNtaRbwkos5sr5AZ61Q==
X-Received: by 2002:a2e:8796:: with SMTP id n22mr4325949lji.345.1606507156297;
        Fri, 27 Nov 2020 11:59:16 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:15 -0800 (PST)
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
Subject: [PATCH v1 16/28] video: fbdev: hgafb: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:13 +0100
Message-Id: <20201127195825.858960-17-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix kernel-doc comments.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
Cc: linux-nvidia@lists.surfsouth.com
---
 drivers/video/fbdev/hgafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hgafb.c b/drivers/video/fbdev/hgafb.c
index a45fcff1461f..69af72937844 100644
--- a/drivers/video/fbdev/hgafb.c
+++ b/drivers/video/fbdev/hgafb.c
@@ -358,7 +358,7 @@ static int hga_card_detect(void)
 /**
  *	hgafb_open - open the framebuffer device
  *	@info:pointer to fb_info object containing info for current hga board
- *	@int:open by console system or userland.
+ *	@init:open by console system or userland.
  */
 
 static int hgafb_open(struct fb_info *info, int init)
@@ -372,7 +372,7 @@ static int hgafb_open(struct fb_info *info, int init)
 /**
  *	hgafb_open - open the framebuffer device
  *	@info:pointer to fb_info object containing info for current hga board
- *	@int:open by console system or userland.
+ *	@init:open by console system or userland.
  */
 
 static int hgafb_release(struct fb_info *info, int init)
-- 
2.27.0

