Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 672CEC3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 295E220809
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIf6uBH2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgK1C2K (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731072AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94601C061A52
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:04 -0800 (PST)
Received: by mail-lf1-x144.google.com with SMTP id q13so7865527lfr.10
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2z/dAT9naUmXE5qac+rK/70T5U7GBI/v+WhPmjvxr84=;
        b=nIf6uBH2ZKJjbyqV2d6fX1XuIPpHe14PCos51II/MmmX9UsTUjGWVLOj+XDbj6IH1j
         j8/sL1YQxZwFnx2Y3tpYvSe+iP7Q+1wGxsJ+yD4vkWHzQmSKxGjWR4+X0/5cnSJ9+E+U
         WU8L7VOqbnPDUiBgbuP1o8nKteYr8nUlMfIakz/XVdAJ6l6kAnJH338CdZnjgiCZ5DUD
         XOUI/EVS71x2AdQ/J+ls/NiRVVOmAiRLBTmVDFdOl0GQV6p5dRPdWOhIZ08Guhys9T6U
         JyMe7MXSkIUSlmCj3gncIzFiqAnQGd5mTmpCJ4wtyjkSqo3ODvAKCw2IRPkz4yJEK8PJ
         fFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=2z/dAT9naUmXE5qac+rK/70T5U7GBI/v+WhPmjvxr84=;
        b=tX81BXp/tsq6d2ZL5KE2hbUZFIet1nMBw2GZFhvcDEQpdo4YgkRPZhohOdYOH/idmA
         xNs3mOVxqai0YoIVuS6P5cXW47jtZTVPAE3rE+6Kr65MfCcGzm2fwLLeqlJrVBOxJWOi
         boQvaZ0VCVzdjMkBIWCphnmWG2xUKmRXF+Bb5BijOJM7KAHDOkyq5n9pc8W6F0zFPQ0s
         wvcPaGkbeKPjfmBbcvv87njNRsUmhqa2S4Rmqr2QYODwd/gzLv1LBkQcmq66Dd7sP4xb
         jfX0DZN32OUNS61yI8GNitIa3UaUMb1BqYQVwNEf+dc7sVs+weaKF6YgS37/bPsk6pHo
         elRg==
X-Gm-Message-State: AOAM530VWAjAE+9l9Tqed+YYCdgJp66jjA6HAvgFNqMPnc64uEP5HRYW
        sE1AYSE8cixHnyPxjZn57ZZetVn+P7BRpL1U
X-Google-Smtp-Source: ABdhPJxMUz94BHFF6rybfliMhdsF+17CnCkrgs8rTH0atREiGZy+JMiTw0e9sauLh8NOkSqqUM0QRg==
X-Received: by 2002:a05:6512:6c6:: with SMTP id u6mr4036455lff.174.1606507142897;
        Fri, 27 Nov 2020 11:59:02 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:59:02 -0800 (PST)
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
Subject: [PATCH v1 11/28] video: fbdev: via: Fix W=1 warnings
Date:   Fri, 27 Nov 2020 20:58:08 +0100
Message-Id: <20201127195825.858960-12-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 warnings about unused assignment.
Fixed by dropping the assignment and deleting the local variable.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/via/lcd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/via/lcd.c b/drivers/video/fbdev/via/lcd.c
index 4a869402d120..088b962076b5 100644
--- a/drivers/video/fbdev/via/lcd.c
+++ b/drivers/video/fbdev/via/lcd.c
@@ -537,11 +537,9 @@ void viafb_lcd_set_mode(const struct fb_var_screeninfo *var, u16 cxres,
 	u32 clock;
 	struct via_display_timing timing;
 	struct fb_var_screeninfo panel_var;
-	const struct fb_videomode *mode_crt_table, *panel_crt_table;
+	const struct fb_videomode *panel_crt_table;
 
 	DEBUG_MSG(KERN_INFO "viafb_lcd_set_mode!!\n");
-	/* Get mode table */
-	mode_crt_table = viafb_get_best_mode(set_hres, set_vres, 60);
 	/* Get panel table Pointer */
 	panel_crt_table = viafb_get_best_mode(panel_hres, panel_vres, 60);
 	viafb_fill_var_timing_info(&panel_var, panel_crt_table);
-- 
2.27.0

