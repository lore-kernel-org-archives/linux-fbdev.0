Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9BDC432BE
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 080D560F41
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Jul 2021 19:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhG0TUW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Jul 2021 15:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232013AbhG0TUT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Jul 2021 15:20:19 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20D3C061757;
        Tue, 27 Jul 2021 12:20:17 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id i1so17221377plr.9;
        Tue, 27 Jul 2021 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CrRX1VhMUAEaUUT8thGMO0K4ycJXwpkO93/cKNKr8tQ=;
        b=XhiInS6R9iLLmqs38cqgjFNnwDu7I/9x03NmxPL1dcWgNnAwCjn4l21KgMY3rKaUtN
         e7YvoQ21mlK3B/d9LwJnrD9f2YBZ1g0ac0U9zjTOyvQWBI0+2gi5xE01Jcd8IC0+G1Id
         hInFstS90GDkPNh7iCEv9PcYSyvGg0742ACbWAJecBPfBqd0iFlcPlZG2Xw3j99ZFWFR
         NVOfT0b8INoh8XvGINwBSFNLCFkePUYsK8jvdxsxDJzt4pUdHczUxnkgipRDvQChCGmM
         N1s/B6zEt3ku58gvsXl7c6QdJwYkNSvDly1Jj8qAut8fE7eO3NyuNtngityCFN6j/k0U
         CPMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CrRX1VhMUAEaUUT8thGMO0K4ycJXwpkO93/cKNKr8tQ=;
        b=ZuFBJ+wSpjy2LlVJMpgTgKe410V8Yd7qJJ6oluMuRbwqCSzzEvDJeHzMGhcDjNkEuu
         DfEH7o3AhUQitRvJpPpwiYH1gKiSoCJ9WKbuWy9wILCigwe5uz3oeRnlk6Wn/aR07csl
         ngdlgPQWYcz2eM69mO3ynzsfscUS5etnSum4DEBqzlGIaaOpVuPHuvu3Tde4/NxkzZ8c
         wZZ2wLJpWbE7vRCZUHIQdERot0r5oJeFqGjNDcu1QnfViUvtVUH9LM40Cg6ZlotcMEE8
         liLCXQTehT4Ei+jhixmTkRlQ563T6sxQWOauv8ex1qDN8/19i59VUwGLFrPpOxwmbVPn
         KrdQ==
X-Gm-Message-State: AOAM5317H9K0Pswl33ApjomSVCsE+S0kb+lb+BnfgEj3tIZI5BxiHOfD
        BZLg4/352WyTN9C2Wg+Vlg8=
X-Google-Smtp-Source: ABdhPJwx0POUhAiXJMoouWsuLANSyRpZmo+F49XSM6A0A4L/wo2B/f+8I2hkoNem1WUov1b/ihi1Sw==
X-Received: by 2002:aa7:9115:0:b029:359:69db:bc89 with SMTP id 21-20020aa791150000b029035969dbbc89mr24489253pfh.32.1627413617366;
        Tue, 27 Jul 2021 12:20:17 -0700 (PDT)
Received: from localhost.localdomain ([2402:e280:2130:198:9b25:1cfb:9ff3:2a8f])
        by smtp.gmail.com with ESMTPSA id f7sm4317096pfc.111.2021.07.27.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jul 2021 12:20:17 -0700 (PDT)
From:   Benjamin Philip <benjamin.philip495@gmail.com>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Benjamin Philip <benjamin.philip495@gmail.com>
Subject: [PATCH 3/4] staging: sm750fb: Rename vCursor to v_cursor in lynxfb_crtc
Date:   Wed, 28 Jul 2021 00:49:52 +0530
Message-Id: <58dfc3f12deabe3a786ff2b9c75ac24f51724974.1627413010.git.benjamin.philip495@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1627413010.git.benjamin.philip495@gmail.com>
References: <cover.1627413010.git.benjamin.philip495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The struct lynxfb_crtc has a member named vCursor. This name is
CamelCase and is frowned upon. This commit renames it to v_cursor
and makes the necessary changes for the module to build.

This change also fixes the following checkpatch CHECK:

CHECK: Avoid CamelCase: <vCursor>
135: FILE: sm750.h:135:
+	unsigned char __iomem *vCursor; /* virtual address of cursor */
Signed-off-by: Benjamin Philip <benjamin.philip495@gmail.com>
---
 drivers/staging/sm750fb/sm750.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 4093d5e898c6..8952154739ac 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -132,7 +132,7 @@ struct lynx_cursor {
 };
 
 struct lynxfb_crtc {
-	unsigned char __iomem *vCursor; /* virtual address of cursor */
+	unsigned char __iomem *v_cursor; /* virtual address of cursor */
 	unsigned char __iomem *vScreen; /* virtual address of on_screen */
 	int o_cursor; /* cursor address offset in vidmem */
 	int o_screen; /* onscreen address offset in vidmem */
-- 
2.31.1

