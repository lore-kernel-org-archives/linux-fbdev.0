Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80F3C4338F
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 Aug 2021 02:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25116117A
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 Aug 2021 02:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhHUCTX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Aug 2021 22:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbhHUCTX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Aug 2021 22:19:23 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B01C061575;
        Fri, 20 Aug 2021 19:18:44 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id l3so9012988qtk.10;
        Fri, 20 Aug 2021 19:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICy06zsKPY88E4K8E9mtKZ1ECGVlz+4+NHijGy1OXms=;
        b=Wci5lZvCI8k9tQqolpEzHPQrd/i8CUfaaa3O6E6N1crRhv73wLCgONGBGbXOF4FS7i
         Eq/Wk4CoqONSBwwG1jYY9eP+gtGYwV3gJ4XpaCJwf76vaGuN/H70NjO/W5rk0GxlVr7s
         kCUMefgx1R/QKTBtDhMTPcrpALRhCPfpy4GXMQ+OkzyNbZuCBFKbpfcEnRQ03GfrQxfg
         n+qgsJAH59Qo+mDiBamrlWQTn3n3imTNO8G7c0FVesseGjHy0+SBhZSW940KwlBNrrA/
         +zi8/u4uuSIHqmkuJrEp0Ne6poamr6vgLFf7j1WiJ7RF2dMluCIv1JmmVOCVbg2a3E5C
         0Vxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ICy06zsKPY88E4K8E9mtKZ1ECGVlz+4+NHijGy1OXms=;
        b=Amlsw2+Lq2T7nuvFcdz4zvDxSkz/Y3jhT6HxHiyFsKG7nhGHEF8Cvhs9EVsFKZ2mxa
         puqPBTblOGE4tds0oCQgiCKYlVjzYdlc6UCg1/bZQrkcqGPHa6GvQOsboJM9pwGrLBWD
         2l8zvSCZEnqzn/9mJb2MSLeuyAEGsI57UNTBRTKOxWyuXQWks0CWZU8Yr+GDbPFGl2xI
         VPS13j6DT/LAfnNqA+1jwyHmeiRNzuLxn+Dt5uslaD4k/JXR/I45/evoRxayg01Xv5Z9
         U6Ht+MAV4ihRJx7q/sJI8EHwtskhSg4YmYeHPLus+szf7XX7h53CARMOF/og1bhxFcyb
         +/Kg==
X-Gm-Message-State: AOAM532c0tLBGAX0sFV9JmRLRtY/BuFv9w2CaeCHbodZEz74vMtXiAOH
        dQbawku9x3tOA7V6v3vbdxY=
X-Google-Smtp-Source: ABdhPJzzUXmVc10/csCH0VPL4FXF950um6EZtMywuLnbfpe9CVLhFsPMgUZxj5OaslRyJwsDcruOEw==
X-Received: by 2002:ac8:7c5:: with SMTP id m5mr14013073qth.180.1629512323881;
        Fri, 20 Aug 2021 19:18:43 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id c7sm3655813qtv.9.2021.08.20.19.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 19:18:43 -0700 (PDT)
From:   CGEL <cgel.zte@gmail.com>
X-Google-Original-From: CGEL <luo.penghao@zte.com.cn>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] video: fbdev: mb862xx: drop unneeded assignment in the mb86290fb_imageblit8()
Date:   Fri, 20 Aug 2021 19:18:33 -0700
Message-Id: <20210821021833.27238-1-luo.penghao@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Luo penghao <luo.penghao@zte.com.cn>

The first assignment is not used.In order to keep the
code style consistency of the whole file,the first
‘ptr’ assignment should be deleted.

The clang_analyzer complains as follows:

drivers/video/fbdev/mb862xx/mb862xxfb_accel.c:135:9: warning:
Although the value storedto 'ptr' is used in the enclosing expression,
the value is never actually read from 'ptr'.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Luo penghao <luo.penghao@zte.com.cn>
---
 drivers/video/fbdev/mb862xx/mb862xxfb_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
index d40b806..61aed7f 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
@@ -132,7 +132,7 @@ static void mb86290fb_imageblit8(u32 *cmd, u16 step, u16 dx, u16 dy,
 	cmd[2] = (height << 16) | width;
 
 	i = 0;
-	line = ptr = image->data;
+	line = image->data;
 	bytes = image->width;
 
 	while (i < height) {
-- 
2.15.2


