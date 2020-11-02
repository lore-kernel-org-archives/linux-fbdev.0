Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D664C388F2
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D20FF206F8
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 09:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ouivo3Wk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728322AbgKBJhQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 04:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgKBJhP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 04:37:15 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 225F7C0617A6;
        Mon,  2 Nov 2020 01:37:15 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 133so10597890pfx.11;
        Mon, 02 Nov 2020 01:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q4LWjOQb48RbMvuqunvROMBYqbWJviRmRbs1farYf+o=;
        b=Ouivo3WkaZWDdXarHlxfc76m/TrdvxXtNjxs/qxYSq5z1VkleGC5Biq3uMuBsyswOw
         sewYi9DabhWO7RN0Qvtwl9XEYrmkScHJrmHPoSUlYwXuGUrsfb7uYXvkM4O+iHn6kqh+
         MYJIDi6A4Ufxb+P5QQUIB2ztW1TBwwoaxRAWXfj904qfJAiNKy6X2oafViYxJR1oq5qT
         fgm9qCtv3huwI6tLzKwUE8+0Xu9caqDo2RTNhA7Fx8KTtWLom/JvHNfI2YHgAwodKNxn
         sGmDA0j9bSydLptOUNPWxXJzv5RZcEvHgWExANOO60Sn8cR6+dxA/yNo3PdA8jR5DQcU
         +1Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q4LWjOQb48RbMvuqunvROMBYqbWJviRmRbs1farYf+o=;
        b=QyfpC29DOUVWVoWvY2CdRES45GBRReIj5H+sQgOgsfbt/HzkzcgpRb1/KJQVm0+gSV
         uuMhw2F8sWX++HU8tDtbc9QZaInYLc9zVa9qTJ3hm4npc8tRiMr5U51KgIrOhHp/tQcv
         WlLbzjx5V/mytex8vuoAhydGwmEsXUXJVU9EG0eTK9FqZulU4BpMLZBTfS4zf0CQFxBx
         bZtX2eNcibMuDLi3RbzqvHZqm+CnPjfMJR1eZcSA8Fc5MkciIZPKNHyTCPZqMX2Kx7wp
         CzZ9lV+54HtFxa+N0/1Oezw21Cn28gzhDno3cytJDnG54bg32DdFk7RzrJ+6HOJQiBAh
         /btA==
X-Gm-Message-State: AOAM533OJYM9UITSQgjQHFV8Xo6PvujohnWziplsnjS1Oqs1iHXcwyap
        AODMg9NPsU3HWUIhFCX5ag==
X-Google-Smtp-Source: ABdhPJzsH5NB3PxiruEjGrp4JTwVXQZfViSpD41UawE+gLt4Mib6M7rMtc3KzqmkqFgSe0xUpuE/iA==
X-Received: by 2002:a62:1991:0:b029:155:f476:2462 with SMTP id 139-20020a6219910000b0290155f4762462mr21521857pfz.43.1604309834682;
        Mon, 02 Nov 2020 01:37:14 -0800 (PST)
Received: from localhost.localdomain (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id 199sm5566013pgg.18.2020.11.02.01.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 01:37:13 -0800 (PST)
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
Subject: [PATCH v2 1/2] console: Remove dummy con_font_op() callback implementations
Date:   Mon,  2 Nov 2020 04:36:05 -0500
Message-Id: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604128639.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

`struct console_font` is a UAPI structure, thus ideally should not be
used for kernel internal abstraction. Remove some dummy .con_font_set,
.con_font_default and .con_font_copy `struct consw` callback
implementations, to make it cleaner.

Suggested-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Change in v2:
  - [v2 2/2] no longer Cc: stable, so do not Cc: stable

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

