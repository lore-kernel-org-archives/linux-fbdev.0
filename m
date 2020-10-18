Return-Path: <SRS0=OfnY=DZ=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D938BC433DF
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C46E22277
	for <linux-fbdev@archiver.kernel.org>; Sun, 18 Oct 2020 20:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qBvzINNo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727439AbgJRUzB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 18 Oct 2020 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgJRUzB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 18 Oct 2020 16:55:01 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED92C061755;
        Sun, 18 Oct 2020 13:55:00 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l18so4803354pgg.0;
        Sun, 18 Oct 2020 13:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=40tXI37pHlk3TtzN2k44HneDIZz4amkAP9vv7Yjmryo=;
        b=qBvzINNoyd0ePJlIBr9XRAf5uj3vpv4Qr+DUgP5kyRA85wMxV7ztzWw/LBsHwefrly
         sC8tCYADiC/eld+Xed1K6diTdNz9H7dLztWAN9bo+udAPBB/icdea1Cxf4FSwz+xsn/v
         Mad2slFqH8totbokNDgWI4nPLDjNj9bII5uqpwwafuxag1BtPvGimntlBJFHCfS4YN3p
         /R5+kcJtS1Ul+ukoozoudfqCgW+k+CuBasqd1yW1FYTM+fj6dRhhPEEkawWv/4lvQCfB
         a4czKI1Yo20AMM87Wtis1+Y4oC+bW/vtvrrZAKeAkWzmCBwXWrAxFAjuJj3+AflXP14p
         E9kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=40tXI37pHlk3TtzN2k44HneDIZz4amkAP9vv7Yjmryo=;
        b=lI92qHkr13mJQitjahPE7S+5/2Qg2oePOUtn1hgF5kunQjdDdZoQOJWDEjFs4Gc4jU
         S5AB9PyAdouK3d37j3lF2lvogJJ/3gsi1J20cFZt1uziizm5QZceUZnLxY2qFVfBVc2I
         x3aTw48UfiIUUTpA4WHqWRronwlWXT9pe6vgYRWoCwegjT624TUaottXhRxlds2b6PN3
         H2v0g9NNMYjL44aYObcC6fknYl5Xsuy63mu4aFmB/OM8yHIZHCsd/YQ6s4ZrZn8qdKId
         lVfgQpOiKdtXJ7HER/V0j1ESqZxreoIt9cbPft+gZm2D9pJ+jv/4iOxfEq6qknRJjWgo
         fDDw==
X-Gm-Message-State: AOAM532j9dRE1sxug+//1T6qwgUPJLexws9rRGgdG85dO7QjGOLVT67K
        b4dztqidCI03Zi2wXKOc5w==
X-Google-Smtp-Source: ABdhPJwJrUu0DW+lj02llJjiJVooeTj2lO5SI0doIdiPIzmOVKhr10VEfVZiynEkgJxjWHlTLcM1ig==
X-Received: by 2002:a63:3115:: with SMTP id x21mr12018067pgx.416.1603054499615;
        Sun, 18 Oct 2020 13:54:59 -0700 (PDT)
Received: from localhost.localdomain ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id ck21sm9517430pjb.56.2020.10.18.13.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2020 13:54:58 -0700 (PDT)
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Jonathan Corbet <corbet@lwn.net>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peilin Ye <yepeilin.cs@gmail.com>
Subject: [PATCH 2/2 RESEND] docs: fb: Add font_6x8 to available built-in fonts
Date:   Sun, 18 Oct 2020 16:54:01 -0400
Message-ID: <20201018205401.698242-1-yepeilin.cs@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com>
References: <717bb41dda8e2ed615f3faadfbc3e215de726d38.1603037079.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201018205401.ZEHPd6okWdDVz4hQAKplxw54y_JoMQ9TsnGCbrh2AVo@z>

Recently we added a new 6x8 font in commit e2028c8e6bf9 ("lib/fonts: add
font 6x8 for OLED display"). Add its name to the "compiled-in fonts"
list.

Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
---
Resending +Cc: dri-devel, sorry if I spammed.

 Documentation/fb/fbcon.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/fb/fbcon.rst b/Documentation/fb/fbcon.rst
index 9aad964b767c..57f66de2f7e1 100644
--- a/Documentation/fb/fbcon.rst
+++ b/Documentation/fb/fbcon.rst
@@ -81,7 +81,7 @@ C. Boot options
 1. fbcon=font:<name>
 
 	Select the initial font to use. The value 'name' can be any of the
-	compiled-in fonts: 10x18, 6x10, 7x14, Acorn8x8, MINI4x6,
+	compiled-in fonts: 10x18, 6x10, 6x8, 7x14, Acorn8x8, MINI4x6,
 	PEARL8x8, ProFont6x11, SUN12x22, SUN8x16, TER16x32, VGA8x16, VGA8x8.
 
 	Note, not all drivers can handle font with widths not divisible by 8,
-- 
2.25.1

