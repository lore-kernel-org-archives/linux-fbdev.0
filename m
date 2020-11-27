Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A52FC3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2A8220809
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 02:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuI8PFRu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgK1C2T (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 21:28:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731037AbgK0T71 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 14:59:27 -0500
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE16C061A04
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:59 -0800 (PST)
Received: by mail-lf1-x141.google.com with SMTP id s27so8559701lfp.5
        for <linux-fbdev@vger.kernel.org>; Fri, 27 Nov 2020 11:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UH09h1yaTBjOi1rndtqeEtocB9Ydxx+E8RryiPhl80I=;
        b=DuI8PFRuFcBEsab+erd77IHuvnY8X2uavYqsppgZq2LhEVglNoLcdL2BBbegGr/ffA
         jqV6CGbool+G7prxO3WrStTbRpUgua91b8UoI3yTSErWryrT1eoP5cy9djZbHSmMpwA3
         Il1crCMOXNVjF0avCjJ0dY0mqZGOR2XnLRuNLKlAiuknGJuSScTo4aEW/I6coBAiPsk9
         032Rl39gk2bLbb1zLfjE1hPfun2hzuUFZj7ko8/KuZ7DF1TYVxCJXBM31PkFilNyTWH1
         ICqt/hxIKKB2Hvf2rcb63Y8scqnddxVFCSoFlfPV9hkU1vmGRXYzb6GXvtmvqaFjyH8w
         jMEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UH09h1yaTBjOi1rndtqeEtocB9Ydxx+E8RryiPhl80I=;
        b=mshMvtAaB568sszdIQgAmECY1qj1JxJTNWruVDf0tgG+rCStioE9Xg+cOELLVn8uq/
         m9+U3AUre2blH9QFLNcB3hmR5zyNxDje8o0pNNJhXYpZuIYMw+EepHK5zaTvdeadS9nk
         706K5DV2Z/nLfweFAwCV9odgBvUYrpSh5pao+gX38T0ci+nU+QMW7rDkBQdDHooQ2fRM
         P/CQANdrFXkUGAbF2abtkrfQ0T2d2q8QvZBd+UZ/p4vGIwZAa3zTjI31r7IRhKf5WLZk
         rxJaU3IIi+YVS8M/MBe0aZlX54eTkLMzvQX8e1ix1VGWzjfUvsN0ETYwg5v5qrtaDYqZ
         ZpIQ==
X-Gm-Message-State: AOAM532/nFLaMJdn0NCq1PJHlmv4jMg1uDAiyso00nvB/vA6EHa3l1DD
        uFIfjkcFnBp7HCeAn6jMK+jTpto/ZAYJ59sh
X-Google-Smtp-Source: ABdhPJxv8ewp8sQd6Y48H9pROFlcKOQZd2NriGhQnvxkdr/vjO74fh63W/MTIpiiLYtQco3gQo3/7A==
X-Received: by 2002:a19:c1c4:: with SMTP id r187mr4910882lff.518.1606507137770;
        Fri, 27 Nov 2020 11:58:57 -0800 (PST)
Received: from saturn.localdomain ([2a00:fd00:8060:1c00:9d62:990:4557:451])
        by smtp.gmail.com with ESMTPSA id c6sm1070415ljj.140.2020.11.27.11.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 11:58:57 -0800 (PST)
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
Subject: [PATCH v1 09/28] video: fbdev: sis: Fix W=1 warnings in init.c
Date:   Fri, 27 Nov 2020 20:58:06 +0100
Message-Id: <20201127195825.858960-10-sam@ravnborg.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201127195825.858960-1-sam@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix several W=1 warnings.
This removes a lot of unused code - which is always a good thing to do.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Thomas Winischhofer <thomas@winischhofer.net>
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

