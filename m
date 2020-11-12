Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDB3C388F7
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F2F22227
	for <linux-fbdev@archiver.kernel.org>; Thu, 12 Nov 2020 12:11:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfGWH+sC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgKLMLw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 12 Nov 2020 07:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbgKLMLw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 12 Nov 2020 07:11:52 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEC8C0613D1;
        Thu, 12 Nov 2020 04:11:52 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c66so4364961pfa.4;
        Thu, 12 Nov 2020 04:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t1DdLgTC9wfaj9IQp94XVXE/ol9y5Kusx3kBt32JG7w=;
        b=nfGWH+sC/kJrBlznTemQAIuBYZQD2xNWxlJEtlggRHen6AMLz+O/MUAXtwEGzKvuZ/
         bsS3SrCgqY+YgV9+IQFoE66cWTsqf59EVv7MAXIMcyCZLQBi3ZYrdH0UBRMuLlUf2yj9
         b3zk/VlfZuKV5h+JRk2sbI5YCSK/eXZQe9SLBqml5q6VbrP+Hu37EXSklURgk0RJXkCL
         zaFuF/yPmrcY4R9Nl3tfQb6E0kpPJsUC1scb2nkDY4XAILjjEVTQ+IskKOpGAVM/tKzP
         a9OclLMKkoky6+eolkG9m1qHdhsY+dM5SBB4tu2ODyD6qKMArQFDJ5Rlnvj+QOkG6IN7
         pMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t1DdLgTC9wfaj9IQp94XVXE/ol9y5Kusx3kBt32JG7w=;
        b=OU69d8bAqyK+I/4tEJJRNMxpny5ha5Mp92v90p4TA1RjIjEfRUh2WUD2T/EEmKLxr+
         51qdN6OVJmdxvlvJvaz+CUCHeOgrPKsrYDqBSejaMfoTMfp3ZAwQZqL7DkJaECc5hI2R
         eDxhwwpva/noLLFIz7kM1y+2jYusdYyx/2w33qgi7fZJRnYqjd7W+eLNzYuYDsZivdDI
         t+EiQ8pyTj+OEpmnIAs4i+oQMNC7kvikDuKw5nyiXI9THQASysmq2laryLGQj58j2K98
         rsVgD60/dWFXuWZOXHnOenXIJSB/320N2tJTUJf3HulvcmHc+KoebLHf8V8/ayXIHlKc
         m7uA==
X-Gm-Message-State: AOAM533Hd0AzWh4oGcKayoPs7LEI1JvkkVpQHZ5gZsOE4Jdk4HM7jwBd
        4Q8gGOl8Hf3TxG348n6LxVmouXuF+u8Dteo=
X-Google-Smtp-Source: ABdhPJzoAKiGQyUiVJYAYxSHzoiJpwlzyy5z+eeSeCMFXBPBeQw15GAuIH4UK25wWxOwLWRnusSo1g==
X-Received: by 2002:a17:90a:4295:: with SMTP id p21mr9377058pjg.217.1605183112075;
        Thu, 12 Nov 2020 04:11:52 -0800 (PST)
Received: from localhost.localdomain ([221.124.243.27])
        by smtp.gmail.com with ESMTPSA id v23sm6150243pfn.141.2020.11.12.04.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 04:11:51 -0800 (PST)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH v3 2/5] console: Delete dummy con_font_set() and con_font_default() callback implementations
Date:   Thu, 12 Nov 2020 07:11:20 -0500
Message-Id: <9952c7538d2a32bb1a82af323be482e7afb3dedf.1605169912.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1605169912.git.yepeilin.cs@gmail.com>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

.con_font_set and .con_font_default callbacks should not pass `struct
console_font *` as a parameter, since `struct console_font` is a UAPI
structure.

We are trying to let them use our new kernel font descriptor, `struct
font_desc` instead. To make that work slightly easier, first delete all of
their no-op implementations used by dummy consoles.

This will make KD_FONT_OP_SET and KD_FONT_OP_SET_DEFAULT ioctl() requests
on dummy consoles start to fail and return `-ENOSYS`, which is intended,
since no user should ever expect such operations to succeed on dummy
consoles.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
v2: https://lore.kernel.org/lkml/c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com/

Strictly speaking this is different from v2 (see changelog), but it really
shouldn't matter, so I'm keeping Greg's "Reviewed-by:".

Changes in v3:
  - Improve commit message. (Jiri)
  - Do not delete con_font_copy() callbacks, since they have been deleted
    in patch "console: Delete unused con_font_copy() callback
    implementations".

Change in v2:
  - Do not Cc: stable.

 drivers/usb/misc/sisusbvga/sisusb_con.c | 15 ---------------
 drivers/video/console/dummycon.c        | 14 --------------
 2 files changed, 29 deletions(-)

diff --git a/drivers/usb/misc/sisusbvga/sisusb_con.c b/drivers/usb/misc/sisusbvga/sisusb_con.c
index fd9954381fbf..dfa0d5ce6012 100644
--- a/drivers/usb/misc/sisusbvga/sisusb_con.c
+++ b/drivers/usb/misc/sisusbvga/sisusb_con.c
@@ -1345,19 +1345,6 @@ static int sisusbdummycon_blank(struct vc_data *vc, int blank, int mode_switch)
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
 static const struct consw sisusb_dummy_con = {
 	.owner =		THIS_MODULE,
 	.con_startup =		sisusbdummycon_startup,
@@ -1370,8 +1357,6 @@ static const struct consw sisusb_dummy_con = {
 	.con_scroll =		sisusbdummycon_scroll,
 	.con_switch =		sisusbdummycon_switch,
 	.con_blank =		sisusbdummycon_blank,
-	.con_font_set =		sisusbdummycon_font_set,
-	.con_font_default =	sisusbdummycon_font_default,
 };
 
 int
diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index ab3df752fb57..f1711b2f9ff0 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -124,18 +124,6 @@ static int dummycon_switch(struct vc_data *vc)
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
 /*
  *  The console `switch' structure for the dummy console
  *
@@ -154,7 +142,5 @@ const struct consw dummy_con = {
 	.con_scroll =	dummycon_scroll,
 	.con_switch =	dummycon_switch,
 	.con_blank =	dummycon_blank,
-	.con_font_set =	dummycon_font_set,
-	.con_font_default =	dummycon_font_default,
 };
 EXPORT_SYMBOL_GPL(dummy_con);
-- 
2.25.1

