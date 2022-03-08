Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3071C433F5
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Mar 2022 20:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344808AbiCHUYc (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Mar 2022 15:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242196AbiCHUY3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Mar 2022 15:24:29 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D253586E;
        Tue,  8 Mar 2022 12:23:31 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id k24so20871927wrd.7;
        Tue, 08 Mar 2022 12:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXyC5AW49mHHOyaspB0AVoqut4G8nZTKpgTNMZNuGkQ=;
        b=YE3ikwTb5vEazQMOdf5t2mhQdCFCrUylGfLVztMn0JsQ5sHGAF003QZjiCwd5Di4OE
         ch8vMt9MsFW2Uk4VIQ0TXXbw0JxzgbW6LZkixNNDSVQGi0TE+KS0ydhL7mNvod+OvHQ+
         FTzeHMDjFzCvg3qGbG+2QyoEC1zEuTfiT6Uuh7N3D/5TnvuSJlvu/aPZLRDyucuTuiVn
         qVd8sJ3aY3fmIgZNdsgn2Wm+iBHg7PXyaVCjKJ4QXbuV6deIUHgv0KZ4B5bfU4c3WINr
         HCCaZ9GDLpKKudwakKi7v8WMMQ7tLi2gyhEs8hzI/H9VNykYVZXvbOV81YcT57B8iJtx
         cgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mXyC5AW49mHHOyaspB0AVoqut4G8nZTKpgTNMZNuGkQ=;
        b=C/esyRYqsJ/6uW0n6MZDSLgyd60WVFPvYB1s3tkgkmz/CxcSL+9Qi9dRZ055DTRUYl
         /kdr5vTV9KsMiQfVPPRerPGD4QZ7Uc/6T6o9oYFfMCsHZA3j3LAOqxQyONqnQ51iUCpS
         SHxF600W6qwjHwVmZsx/bRZIS5VLSXM4KMIxQPwHZsXvd027yAcE1kq3PIs5b4XcNquS
         7YNocexs3oQTcI2CIutH5ZesXj2JSJSHtCgqF1PC6UOy1DPX0W4U1O4o5saZdO5aK9ht
         AL20RDvuyzHivnAJusK7gAI2dK8Y24z12DJI6E80k/Vr0C6mGqPd12Ra6qFfXO53kth4
         Q9Nw==
X-Gm-Message-State: AOAM531HMdHaD0QQiagLFs5OlLK/gtHG45bTmeD2CheuUyskU5QQS0Rp
        UzCzdY5tP2byY8pDaQD5XkI=
X-Google-Smtp-Source: ABdhPJwGZBW6UGqgP6AXu3Bnw4JCg8loJncWlCnrpwjKMWSgonD6uc188068eNC50h8fIMk7j7fT4A==
X-Received: by 2002:a05:6000:508:b0:1e4:a027:d147 with SMTP id a8-20020a056000050800b001e4a027d147mr13610952wrf.315.1646771009903;
        Tue, 08 Mar 2022 12:23:29 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id z6-20020adfd0c6000000b001f1ffd04672sm4832933wrh.12.2022.03.08.12.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:23:29 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: kyro: make read-only array ODValues static const
Date:   Tue,  8 Mar 2022 20:23:28 +0000
Message-Id: <20220308202328.104043-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Don't populate the read-only array ODValues on the stack but
instead make it static const. Also makes the object code a little
smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/kyro/STG4000InitDevice.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
index 21875d3c2dc2..ffeb355c8b50 100644
--- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
@@ -124,7 +124,7 @@ u32 ProgramClock(u32 refClock,
 	u32 ulScore, ulPhaseScore, ulVcoScore;
 	u32 ulTmp = 0, ulVCO;
 	u32 ulScaleClockReq, ulMinClock, ulMaxClock;
-	u32 ODValues[] = { 1, 2, 0 };
+	static const u32 ODValues[] = { 1, 2, 0 };
 
 	/* Translate clock in Hz */
 	coreClock *= 100;	/* in Hz */
-- 
2.35.1

