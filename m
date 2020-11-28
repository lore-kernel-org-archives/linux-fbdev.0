Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5A2C64E7D
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A3DB20702
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:43:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ofNdOjN3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387994AbgK1Wmy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 17:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387760AbgK1Wmx (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 17:42:53 -0500
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7E5C061A4A
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:41 -0800 (PST)
Received: by mail-lj1-x243.google.com with SMTP id s9so10557046ljo.11
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 14:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+z/W9959CxKgG4WcN4Iy85oHK/P3LJfjbdab6tB79s=;
        b=ofNdOjN3WlUdlrHX/axL+yDyfNp545lGepiNBKQTQhrGcpIvCOWIuIjmylzgvkYZo3
         zZ/ft8dSvifUehjxethC+jjHyVhbJbbjzOyZv7I45z0hMnk7U/WcWz59qqdRlHjau7Y8
         N/Jpsm0jU14ltV83pn3FBcOgxnP5ZObDgmQ6RYyZTh0MxWUufx5lZXZFbnPzAblh+b7X
         2aVq6lJPoySRtc8kJrl/DwvplCIv5AzOmCPoU306KRinlxOrwDWgnPpmXiseo/BiaShA
         zovEbZQ6radlpeQZs5vPGCcwjpAYs9QIKn569HPMbFl38taCFfnbhp/Lzbx7qFDcJnbG
         Z5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=X+z/W9959CxKgG4WcN4Iy85oHK/P3LJfjbdab6tB79s=;
        b=idjQvITCAnVyFLHsWKU5itVW9uQmYVeQRPVEwbeJNSE1FTKbZCWPDPMqgQKIWIk18j
         xBybEN4ns4Zh77LpyNIdR7oVqRRPZO+jCMKqWvf9fVPyM/6NLX3fAbvb4/POJHZ9Q6EY
         UXHoRmkWUTf2UxodKpiBdNJnv8He53T1510nt+vxKQFnqfuUt7f9HIRuwvi7NnK3zQs/
         kCM/cLW0cp3yWHv4bWFuZ3yGs+lT7c4rLYvcUPCUT0gom3Y/UKRTNT4yn+JtbaiuWorM
         k2I3SfhzS9cCftWIfxN+mxTRyFK7IvdGEhO7GZvMW492ybtTFuD1c53+pYZ55fNZd+g/
         Lubw==
X-Gm-Message-State: AOAM530Ob2eM4hcZ+hGYKlvheAd5gpZd6jHm2AP2Ut6USb6yhufktKSS
        S95wZ01Ye2zb+MQDCZAa0kL5/Za7w+K3wg==
X-Google-Smtp-Source: ABdhPJwNCw1BRqGWU4zvMymxV8jqichRChera60GIW5wRzO4XHUQq1DJ6DguS8QDaDBs7tzG3iq0Xg==
X-Received: by 2002:a2e:a376:: with SMTP id i22mr6714027ljn.217.1606603299518;
        Sat, 28 Nov 2020 14:41:39 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:a4c7:9ff9:a160:aad0])
        by smtp.gmail.com with ESMTPSA id w21sm1236857lff.280.2020.11.28.14.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 14:41:39 -0800 (PST)
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
Subject: [PATCH v2 09/28] video: fbdev: sis: Fix set but not used warnings in init.c
Date:   Sat, 28 Nov 2020 23:40:55 +0100
Message-Id: <20201128224114.1033617-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201128224114.1033617-1-sam@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix set bit not used warnings by removing the code the assign the
variables and the definition of the variables.
A register read is kept as it may have unknown side-effects.

This removes a lot of unused code - which is always a good thing to do.

v2:
  - Updated subject (Lee)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/init.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index fde27feae5d0..b77ea1a8825a 100644
--- a/drivers/video/fbdev/sis/init.c
+++ b/drivers/video/fbdev/sis/init.c
@@ -2648,7 +2648,7 @@ static void
 SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
 		unsigned short ModeIdIndex, unsigned short RRTI)
 {
-   unsigned short data, infoflag = 0, modeflag, resindex;
+   unsigned short data, infoflag = 0, modeflag;
 #ifdef CONFIG_FB_SIS_315
    unsigned char  *ROMAddr  = SiS_Pr->VirtualRomBase;
    unsigned short data2, data3;
@@ -2659,7 +2659,7 @@ SiS_SetCRT1ModeRegs(struct SiS_Private *SiS_Pr, unsigned short ModeNo,
    if(SiS_Pr->UseCustomMode) {
       infoflag = SiS_Pr->CInfoFlag;
    } else {
-      resindex = SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
+      SiS_GetResInfo(SiS_Pr, ModeNo, ModeIdIndex);
       if(ModeNo > 0x13) {
 	 infoflag = SiS_Pr->SiS_RefIndex[RRTI].Ext_InfoFlag;
       }
@@ -3538,17 +3538,13 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 			struct fb_var_screeninfo *var, bool writeres
 )
 {
-   unsigned short HRE, HBE, HRS, HBS, HDE, HT;
-   unsigned short VRE, VBE, VRS, VBS, VDE, VT;
-   unsigned char  sr_data, cr_data, cr_data2;
-   int            A, B, C, D, E, F, temp;
+   unsigned short HRE, HBE, HRS, HDE;
+   unsigned short VRE, VBE, VRS, VDE;
+   unsigned char  sr_data, cr_data;
+   int            B, C, D, E, F, temp;
 
    sr_data = crdata[14];
 
-   /* Horizontal total */
-   HT =  crdata[0] | ((unsigned short)(sr_data & 0x03) << 8);
-   A = HT + 5;
-
    /* Horizontal display enable end */
    HDE = crdata[1] | ((unsigned short)(sr_data & 0x0C) << 6);
    E = HDE + 1;
@@ -3557,9 +3553,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
    HRS = crdata[4] | ((unsigned short)(sr_data & 0xC0) << 2);
    F = HRS - E - 3;
 
-   /* Horizontal blank start */
-   HBS = crdata[2] | ((unsigned short)(sr_data & 0x30) << 4);
-
    sr_data = crdata[15];
    cr_data = crdata[5];
 
@@ -3588,13 +3581,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
    sr_data = crdata[13];
    cr_data = crdata[7];
 
-   /* Vertical total */
-   VT  = crdata[6] |
-	 ((unsigned short)(cr_data & 0x01) << 8) |
-	 ((unsigned short)(cr_data & 0x20) << 4) |
-	 ((unsigned short)(sr_data & 0x01) << 10);
-   A = VT + 2;
-
    /* Vertical display enable end */
    VDE = crdata[10] |
 	 ((unsigned short)(cr_data & 0x02) << 7) |
@@ -3609,14 +3595,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 	 ((unsigned short)(sr_data & 0x08) << 7);
    F = VRS + 1 - E;
 
-   cr_data2 = (crdata[16] & 0x01) << 5;
-
-   /* Vertical blank start */
-   VBS = crdata[11] |
-	 ((unsigned short)(cr_data  & 0x08) << 5) |
-	 ((unsigned short)(cr_data2 & 0x20) << 4) |
-	 ((unsigned short)(sr_data  & 0x04) << 8);
-
    /* Vertical blank end */
    VBE = crdata[12] | ((unsigned short)(sr_data & 0x10) << 4);
    temp = VBE - ((E - 1) & 511);
-- 
2.27.0

