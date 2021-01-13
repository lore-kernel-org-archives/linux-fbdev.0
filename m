Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23A03C433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4A123602
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbhAMOwC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727624AbhAMOwB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:01 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A0D0C061381
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id a6so1851094wmc.2
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UBertLrO50IMon3TZ4gj0CSxI3Yqy8ksl/8MP2cv2iw=;
        b=akpdEhMJh2ARCHyoNNx9VPJuhAoo9/Y4QVqEYnbUJ0Hy/4xwAFnitREVMt08+c+3Qu
         Kc2u8TwF4caPKUyn75DQBoHuu3wGDMO0r2V3p0Yo+d9smk9uBH9HBLge1hMCGnifQUR9
         JjsszdKmG43arb7E46nkyyLFqd/tXDE7Y7P9jv3oeKYHpCIPG8OOt+aQ4sR1/nWloE2f
         51Wwa7J/1t45aqUrswNJxn0kk2k4+oGZ23ac7biP9+idnJfOmRnbqPHH2PwdliX+83OH
         bnrAP/8D7ucxpARodtDBgI/9O7O5s2Vfm3AXS7vGGur65NmXvY4JTtIa3YxDSPJQGQVk
         BZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UBertLrO50IMon3TZ4gj0CSxI3Yqy8ksl/8MP2cv2iw=;
        b=U2YELZaJkH3/z72fKfAZtNLWmjMrmLNPDbGd6JAV0LTBzZzV+CODag4DKgph6/i3Zr
         I5grU5V6fBq6dqtkXfh9NWkMprIbK7FvcHnvT+q7R2zrGGEdkXpxcnVRjwuGPgAghqYp
         duNEV+8oPDScM2oUAWbQwW2BctQ5vEPmT59VTkLtTsi9ASBPFY80z54k6pgRJ6q+K05V
         MHlsFbb9F4mkInGRq0cltdoNODzBtKfHO3EyExhyoLDYJZsDybp3g9vQC/gRuiWGrakN
         fJQ2WY2XSpPZfH/8j3S2kwsgCbgoXeAI9nBvCPwyr16Pc+gu7dmhvbHewsdcwQjRSnTr
         E7og==
X-Gm-Message-State: AOAM533x4G/vguhyzc8HZ6OlEH3opQX7DrBhgRXDcyTSIhxZVG933dTn
        lO4bIm6DtlXVNOziP3SI9QfUqw==
X-Google-Smtp-Source: ABdhPJw509pJdXHv0jOqPq8GOcIPKK4q+ka5nv3ec9nw6ylQAnAdVKzrPJgraDgus3zDqa2Oa+9RdA==
X-Received: by 2002:a7b:c10e:: with SMTP id w14mr2520321wmi.161.1610549431282;
        Wed, 13 Jan 2021 06:50:31 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:30 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Winischhofer <thomas@winischhofer.net>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 11/31] video: fbdev: sis: init: Remove four unused variables
Date:   Wed, 13 Jan 2021 14:49:49 +0000
Message-Id: <20210113145009.1272040-12-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/sis/init.c: In function ‘SiS_SetCRT1ModeRegs’:
 drivers/video/fbdev/sis/init.c:2651:49: warning: variable ‘resindex’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sis/init.c: In function ‘SiS_Generic_ConvertCRData’:
 drivers/video/fbdev/sis/init.c:3544:19: warning: variable ‘A’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sis/init.c:3542:34: warning: variable ‘VBS’ set but not used [-Wunused-but-set-variable]
 drivers/video/fbdev/sis/init.c:3541:34: warning: variable ‘HBS’ set but not used [-Wunused-but-set-variable]

Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/sis/init.c | 21 +++++----------------
 1 file changed, 5 insertions(+), 16 deletions(-)

diff --git a/drivers/video/fbdev/sis/init.c b/drivers/video/fbdev/sis/init.c
index fde27feae5d0c..4510272ad297a 100644
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
@@ -3538,16 +3538,15 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 			struct fb_var_screeninfo *var, bool writeres
 )
 {
-   unsigned short HRE, HBE, HRS, HBS, HDE, HT;
-   unsigned short VRE, VBE, VRS, VBS, VDE, VT;
+   unsigned short HRE, HBE, HRS, HDE, HT;
+   unsigned short VRE, VBE, VRS, VDE, VT;
    unsigned char  sr_data, cr_data, cr_data2;
-   int            A, B, C, D, E, F, temp;
+   int            B, C, D, E, F, temp;
 
    sr_data = crdata[14];
 
    /* Horizontal total */
    HT =  crdata[0] | ((unsigned short)(sr_data & 0x03) << 8);
-   A = HT + 5;
 
    /* Horizontal display enable end */
    HDE = crdata[1] | ((unsigned short)(sr_data & 0x0C) << 6);
@@ -3557,9 +3556,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
    HRS = crdata[4] | ((unsigned short)(sr_data & 0xC0) << 2);
    F = HRS - E - 3;
 
-   /* Horizontal blank start */
-   HBS = crdata[2] | ((unsigned short)(sr_data & 0x30) << 4);
-
    sr_data = crdata[15];
    cr_data = crdata[5];
 
@@ -3593,7 +3589,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 	 ((unsigned short)(cr_data & 0x01) << 8) |
 	 ((unsigned short)(cr_data & 0x20) << 4) |
 	 ((unsigned short)(sr_data & 0x01) << 10);
-   A = VT + 2;
 
    /* Vertical display enable end */
    VDE = crdata[10] |
@@ -3611,12 +3606,6 @@ SiS_Generic_ConvertCRData(struct SiS_Private *SiS_Pr, unsigned char *crdata,
 
    cr_data2 = (crdata[16] & 0x01) << 5;
 
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
2.25.1

