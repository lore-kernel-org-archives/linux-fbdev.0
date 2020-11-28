Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8B4C64E7B
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC5820702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S0c68Zk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387716AbgK1WmN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbgK1WmM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:12 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C40C0617A7
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:32 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id f18so10578706ljg.9
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kZ9ZgHWmJyOywbHzVVtwWtTG6YhIEQd9QstxbodpcBQ=;
        b=S0c68Zk+pF34kAn1jifJ7j61hFiv24XXgHlCdXnCscJJaMe3DhkHymeJf31QSOWTZt
         w23t3x4hST+caW1FOsEXWM4cxQR9p3lqbEh01FmIhxTzm9IO0NoPvqNRsYy/7Qi9QRw/
         Kpwq1matftd2bCkk8fwc8H8+ZiQ5416y39eY8V1Pp9zZuxf2DW5K7r4Y3/6owZGkNFZf
         ZPUyUwqQZ+kAOZPuAahXFeTK8ifShm5ehxN++I6tZFO2+TUI1UXymRVycWkTtFsBL2B4
         MZEhjNIiM3C4MnnHsJjjIXUu4VAz3pKDuRWlgFvwMqdhkUC0UO7hdRVwB7sCK8YQzG/f
         bN1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=kZ9ZgHWmJyOywbHzVVtwWtTG6YhIEQd9QstxbodpcBQ=;
        b=DfbpuRAlW3OgNf0frfzoxsd/oKgY2IY0i3/DIK5/s+/6GPYrrn44Gsk0oQv0CzWplm
         CuEbSr1aujnqfWmMwQ5ms30avmGGakJUsLmj9BNYhb8QQnEuOtkMKML1J/C1I/vfCW8g
         HCb9peCWODVi3R71D+Im9kWWVm9Sobz1D8IzAsK6Q+XFcB9OCF9+xUlP/A/LQuGkPCvy
         aqvZzbBguIy8h3yRMMDO85wuuaT70wEnLjogipI25K45K43BpzoNxC1Uy/3cZ2IBtH1v
         RRdhzZZAvo85dbz1hEUbOS/p1/wB+lKjM0GNAYhEpLMy8EE2ZFveGfWM7gINbJclWSGt
         AFvg==
X-Gm-Message-State: AOAM532TukQRWI0Ut9xWf95B7uFoVtiKM75ut1u4Se7Qz4mJdIO9ABxp
        tRHAEYGIQmNriiRmeJD22X0JAh3p1R4gig==
X-Google-Smtp-Source: ABdhPJx4ymyjTnrmJSY6wFWclm51YzQlOTykubVxGPg/z9CJJLqHiLChQ9ZhrpimkKUPyuqHo1PtyQ==
X-Received: by 2002:a2e:161b:: with SMTP id w27mr6607806ljd.429.1606603290409;
        Sat, 28 Nov 2020 14:41:30 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:29 -0800 (PST)
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
Subject: [PATCH v2 04/28] video: fbdev: aty: Delete unused variable in radeon_monitor
Date:   Sat, 28 Nov 2020 23:40:50 +0100
Message-Id: <20201128224114.1033617-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix warning about variable that is asssigned a value but never used.
The variable was indeed never used so delete it.

Keep the call to radeon_probe_i2c_connector() as it may have
side-effects. It is unlikely but I could not verify that is was safe to
drop the call.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/aty/radeon_monitor.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_monitor.c b/drivers/video/fbdev/aty/radeon_monitor.c
index 9966c58aa26c..df55e23b7a5a 100644
--- a/drivers/video/fbdev/aty/radeon_monitor.c
+++ b/drivers/video/fbdev/aty/radeon_monitor.c
@@ -488,12 +488,10 @@ void radeon_probe_screens(struct radeonfb_info *rinfo,
 #if defined(DEBUG) && defined(CONFIG_FB_RADEON_I2C)
 		{
 			u8 *EDIDs[4] = { NULL, NULL, NULL, NULL };
-			int mon_types[4] = {MT_NONE, MT_NONE, MT_NONE, MT_NONE};
 			int i;
 
 			for (i = 0; i < 4; i++)
-				mon_types[i] = radeon_probe_i2c_connector(rinfo,
-									  i+1, &EDIDs[i]);
+				radeon_probe_i2c_connector(rinfo, i + 1, &EDIDs[i]);
 		}
 #endif /* DEBUG */
 		/*
-- 
2.27.0

