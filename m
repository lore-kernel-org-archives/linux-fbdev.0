Return-Path: <SRS0=P75A=EG=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EE95C388F7
	for <linux-fbdev@archiver.kernel.org>; Sat, 31 Oct 2020 07:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65247206B5
	for <linux-fbdev@archiver.kernel.org>; Sat, 31 Oct 2020 07:27:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SrX3hCDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgJaH1D (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 31 Oct 2020 03:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgJaH1D (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 31 Oct 2020 03:27:03 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85141C0613D5;
        Sat, 31 Oct 2020 00:27:03 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id gi3so519060pjb.3;
        Sat, 31 Oct 2020 00:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuNBtGDh3GuSA2eKznKy/F5TkdS26fRroHOEG3pO17c=;
        b=SrX3hCDZ7xS4x9fg991BD6OjiIncp3p82vByYKuRBgT7s5flaA6HxV+Yco2lJP7h0x
         6fFtzs4G22KyoEnjI37FAZP8KzfLPKJiMTbCDnfCmk17M9TWjbRJ6h3wBedLqhB8pjb4
         /uJXGDW4Uxae41ztHOcM4h1YY8tefGlGItVDnfABg/QgjYUd9FUva8kGwRbhgyrxYo6H
         CImYd62zdikkr8M8FttgEvV6L3ohv6rMjNfvZfu3hX3Tj6DCXcntC/tVMJ66PiCx/97W
         iDrNWt9RmjG+ePFSJsjvrOhfD3jDIsZO5co59yypK9r+2FoMsvfs+uH3NpCDg5IQwatE
         RUDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iuNBtGDh3GuSA2eKznKy/F5TkdS26fRroHOEG3pO17c=;
        b=HBDBznv+pZFDPiKBuN6U4vYqTxaVrzEkI6kQdx7vZsL52OlB5P2KRTaPF+gC0Z8N6G
         PKoVseskA1OSb/Sc6fOeE34BW0jRxBYAdMhuntN0JUwz+j9VvrayLrLJhvBAT+rvuP8H
         +Dv8bV55XOC4nyrgbgI1c5xuwEnzgQI8MfDfQNlUWpP3j1faHCIrmew9Fao3KUbbRlbR
         rjt7ku0zyOttaI2/UTXyLc/9qxqRBySB9S47i3CmU8udl03kJZnrxuM8fO7q5e0H3czR
         0Kk4jhxPWknr0ms3wxKPhjsUAbntSIgK3uo/7A4NTatgwMCP3RJx/qQNufFMFydIDZgi
         Si/g==
X-Gm-Message-State: AOAM532u4BtGmjRe7tEPvk2kzBPPqozfrZdNb3EHHgAMVRN+VXow0GgY
        ZKwLFkyb236HjhVM0MBBnw==
X-Google-Smtp-Source: ABdhPJyqBDEZ+Cnvw1QGEXJk9kInS+eaEDpbOK8w0OyGN/ZJAG4L+UEsgPxEBNlZPDkCjgsrVkcsVQ==
X-Received: by 2002:a17:902:b7c4:b029:d6:855a:df2c with SMTP id v4-20020a170902b7c4b02900d6855adf2cmr12579781plz.26.1604129222649;
        Sat, 31 Oct 2020 00:27:02 -0700 (PDT)
Received: from localhost.localdomain (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id x10sm7460005pfc.88.2020.10.31.00.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2020 00:27:01 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>
Cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 1/2] console: Remove dummy con_font_op() callback implementations
Date:   Sat, 31 Oct 2020 03:24:41 -0400
Message-Id: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

`struct console_font` is a UAPI structure, thus ideally should not be
used for kernel internal abstraction. Remove some dummy .con_font_set,
.con_font_default and .con_font_copy `struct consw` callback
implementations, to make it cleaner.

Patch "fbcon: Prevent global-out-of-bounds read in fbcon_copy_font()"
depends on this patch, so Cc: stable.

Cc: stable@vger.kernel.org
Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Context: https://lore.kernel.org/lkml/CAKMK7uFY2zv0adjKJ_ORVFT7Zzwn075MaU0rEU7_FuqENLR=UA@mail.gmail.com/

 drivers/usb/misc/sisusbvga/sisusb_con.c | 21 ---------------------
 drivers/video/console/dummycon.c        | 20 --------------------
 2 files changed, 41 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index c63e545fb105..dfa0d5ce6012 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1345,24 +1345,6 @@ static int sisusbdummycon_blank(struct vc_data *vc, int blank, int mode_switch)
 	return 0;
 }
 
-static int sisusbdummycon_font_set(struct vc_data *vc,
-				   struct console_font *font,
-				   unsigned int flags)
-{
-	return 0;
-}
-
-static int sisusbdummycon_font_default(struct vc_data *vc,
-				       struct console_font *font, char *name)
-{
-	return 0;
-}
-
-static int sisusbdummycon_font_copy(struct vc_data *vc, int con)
-{
-	return 0;
-}
-
 static const struct consw sisusb_dummy_con = {
 	.owner =		THIS_MODULE,
 	.con_startup =		sisusbdummycon_startup,
@@ -1375,9 +1357,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_scroll =		sisusbdummycon_scroll,
 	.con_switch =		sisusbdummycon_switch,
 	.con_blank =		sisusbdummycon_blank,
-	.con_font_set =		sisusbdummycon_font_set,
-	.con_font_default =	sisusbdummycon_font_default,
-	.con_font_copy =	sisusbdummycon_font_copy,
 };
 
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index 2a0d0bda7faa..f1711b2f9ff0 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -124,23 +124,6 @@ static int dummycon_switch(struct vc_data *vc)
 	return 0;
 }
 
-static int dummycon_font_set(struct vc_data *vc, struct console_font *font,
-			     unsigned int flags)
-{
-	return 0;
-}
-
-static int dummycon_font_default(struct vc_data *vc,
-				 struct console_font *font, char *name)
-{
-	return 0;
-}
-
-static int dummycon_font_copy(struct vc_data *vc, int con)
-{
-	return 0;
-}
-
 /*
  *  The console `switch' structure for the dummy console
  *
@@ -159,8 +142,5 @@ const struct consw dummy_con = {
 	.con_scroll =	dummycon_scroll,
 	.con_switch =	dummycon_switch,
 	.con_blank =	dummycon_blank,
-	.con_font_set =	dummycon_font_set,
-	.con_font_default =	dummycon_font_default,
-	.con_font_copy =	dummycon_font_copy,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
-- 
2.25.1

