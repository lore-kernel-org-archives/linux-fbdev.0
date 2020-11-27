Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31880C3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE82221D46
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:30:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jQJJ5C2S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgK1C3i (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731052AbgK0T66 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:58:58 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A05CC0617A7
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:46 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id j205so8556555lfj.6
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=elXwDkZqCWbwars/a4PGxe80QnxYqSvOiXbjb845R9M=;
        b=jQJJ5C2S7D8szVUR25mbQT5RmCZpktF7FWL3p0OS57iRBuna6+UiSzqrn5Pv3gOO5A
         2oILbhokAeBdbYfI3Zw+b1ya+RZ8KfyrTKG2dlmHl14lPej6x8/ZHQAEmXnhZDd9XI2b
         mjTFmyM/x5arLTXOpOJPImA/G99hdnc3fEderAiqRBNil5gdBOfzZ1UFUglTGLe8pBKV
         E7IUwNmbMUh0hVJWdqbomvCxozev0ljukOfKl2EdMhenNN7hnv83Pj/c3/qHSE2cATIu
         UuJbfK+LNozQUhL3a7jVRGNqgDpXbw8QBT6qEagMw51lQHDQMkERakZHJNbCWEO8moOi
         /Eng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=elXwDkZqCWbwars/a4PGxe80QnxYqSvOiXbjb845R9M=;
        b=QCI5hL6kzuMfCut25O3edDEQRjAnDg9No+dQVSVm1NqXv3a25GrKGE9PchqhDzXy0H
         17IGe3409DZkOmP9S85D1U2x7+Bdm2Et+0h+c7FO0K9Z/hWcF9SB2JErQKQUeQ92htYb
         sWx/3l1CzFq3wOkUwVuCIhaojvjv2SgfmpC/1M6OvDRGTW2F+wg/A/DsJ1c5P9b4SMhf
         CAsBNCz6WfHof4XkOIFsArRZswpJlvCQKWQ+428ytqLODuMRfm528lJokOpye9BJ1fz1
         xybSQjQ7H4LpZEZ+2rHo/dW0AhrTeHv+5kv/GLpxCoDcVAeij73sItiQ8FDDTLmvHv55
         b/SQ==
X-Gm-Message-State: AOAM533dtq1GXKkqp0abOS7neih+IXBk0cHsCtv2926zLEui5CKgS2Y1
        QP98ZQnng+eck6UUbFpfRDkm4zZ8TztOq7sE
X-Google-Smtp-Source: ABdhPJyEvODl2X9feO2V1e8aOwadRfjN8fIygmoqxMNyeCNcXtYuBfiDpc2mv8qb3JKasYlmoB391A==
X-Received: by 2002:ac2:4559:: with SMTP id j25mr2183950lfm.511.1606507124592;
        Fri, 27 Nov 2020 11:58:44 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:44 -0800 (PST)
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
Subject: [PATCH v1 04/28] video: fbdev: aty: Delete unused variable in radeon_monitor
Date:   Fri, 27 Nov 2020 20:58:01 +0100
Message-Id: <20201127195825.858960-5-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix W=1 about variable that is asssigned a value but never used.
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

