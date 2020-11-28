Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 446ACC63798
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C8ED20702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ceUf4brj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730785AbgK1Wnb (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:43:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729806AbgK1Wn3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:43:29 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F999C061A54
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:54 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id a9so12761086lfh.2
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4zXtp5JJ5kL9W0YA7a9u1oFQEkf6mUNDsE89w8XSjbA=;
        b=ceUf4brj/n0hkaGfOYFJBYiH9gMwfM6dVxGXtjLzBxWUBrKdOiBcNBiwjbk6I+CgJ3
         gI3ZS4XqlBZrmis/msFG4cYvku2FAl7iT+pZd7mTwUN+sAvY3OKBBRI8R9jT3nIJnz7G
         Y/FXeJA1VgtIpovJ8bC2XO8Vnlg0CPuD4ZM9l35PmOSYNB1bQXK9UEHN4L7N79HhrjOP
         rIKTYGJ55Bze+4fEzcwZgzXaNWenxz1Ag47/z9ITXQIM1e9Jzek+YaNUqrBh9XmKyPAV
         QgbY8AzXHQZKAokd0sXKMHIrdzNHIcCwnfAp7pKAiG0Qss+kun1A28cwelQfUQqbkl8O
         dwSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4zXtp5JJ5kL9W0YA7a9u1oFQEkf6mUNDsE89w8XSjbA=;
        b=hIhm5Oi1sqal/pvJutdLPIJx95PIL/H26Tx+mdJmZoXk+o9u9rJU9A9eI+bEns3sIG
         ieiECImAUAn/eBnXWrs49PD026J1jMZpRUOq6fyG9o1OzJy6HQ26QhCDATjsDsQuFK6r
         arxAjKKPVCpEM8FhJ6qEd7NRbOfbrU/hFyqdtsIstaNIdCZvzKXnofzksVapFycxdSb/
         6KMhQcw+ku4H1uLfXUW6z7ZJQt8A7mRimqBYFTcoaKpV97df+X1EmWs70vyIxr31BUqU
         0aUiNO4q9NcJcd4PJ8ThH6DjY5t3IBUXr7VKuuBTZ6bt68xgC5k5Zu5wztVm3qaVrAXe
         J3yA==
X-Gm-Message-State: AOAM531tt0oC8uL/S7sW2OVlJWlBG6T/kLn8EvaYOn7KHzS+cQCQ5CNM
        iucn4bQ/L2OeKSzmlbfEppa4/KQikeq0rtQu
X-Google-Smtp-Source: ABdhPJxss28jpDvSr/X/2726RDiBKWZyfMpYr3Grt4ZkKPwJPMW1Lii9D2KCP4lz4rLxgbgJM2IM8g==
X-Received: by 2002:a19:8001:: with SMTP id b1mr6321877lfd.353.1606603312476;
        Sat, 28 Nov 2020 14:41:52 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:52 -0800 (PST)
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
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        linux-nvidia@lists.surfsouth.com
Subject: [PATCH v2 16/28] video: fbdev: hgafb: Fix kernel-doc warnings
Date:   Sat, 28 Nov 2020 23:41:02 +0100
Message-Id: <20201128224114.1033617-17-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix kernel-doc comments.

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Ferenc Bakonyi <fero@drama.obuda.kando.hu>
Cc: linux-nvidia@lists.surfsouth.com
Cc: Lee Jones <lee.jones@linaro.org>
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

