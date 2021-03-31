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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61181C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 31 Mar 2021 16:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 345876102A
	for <linux-fbdev@archiver.kernel.org>; Wed, 31 Mar 2021 16:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233757AbhCaQnh (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 31 Mar 2021 12:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbhCaQnR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 31 Mar 2021 12:43:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98304C061574;
        Wed, 31 Mar 2021 09:43:16 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id b14so30052472lfv.8;
        Wed, 31 Mar 2021 09:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69RsZQP8V4UnpYZy11fJRF0FoC9i++XGLM1UOmQqQnI=;
        b=W+uXbX6Ts6KkMF2YvgXpeKrn+NQqRdR/Qqw0iTCmDUacJN5uw9QId9sK/1BCSrcVji
         qelyj3Ca/VK/LrSTCFxp87yrfducIHJaP1YKI47su8de3N5othmYnmcl9+e4/1U36KpL
         NIv8uYGy0ejNhW6MwNEl+GNSGRHE706RtvukzNBne9zgYurq9b2/gNOKtNQTTV8N6kAG
         lErbXIZLbjyw2S9YKWbXhYqrEGggH1hxvjy0UUwGbnijIWK2znnwe30xROOIoHYos2Od
         XjOfrd7XT8+LnVRNNzbSCez7hr6q9D8NkXoQvyRMDt9NaRzcIHkofMIlVrtNwJsXxTS9
         DRWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=69RsZQP8V4UnpYZy11fJRF0FoC9i++XGLM1UOmQqQnI=;
        b=KV7xZJBNP4zFQX+ZwFR9LqXHHYi+XEnpQzFWqL/QRaI6azVWdlwcMYMbJanxWqvyHL
         dN+AEGusyGGGLZAzbJN6/7dr0SKX0Cz52Xe/7p1muk6NDtcgdqEP/KPu3tiTbcEXdCkN
         xIUFy6Utk+4Xtu610P3BbWDJdzZ6VuAD7qEoTNkdaN4qjw6Pe2czkfo7qIeN/BdxAvOq
         DrDU4qaTVDXhrkNzVXUfr85l5z8DElHifdrdl6Vb233cbhdcIxt0Q1XhJQ6nJqMJ7+tP
         B7YWlUEzfaOzzXTnaaHBVe7MSiRCJuhSXVBIbpS3l7tAXLBO0A64TfxNf6qZkpkL1Bqj
         H8jg==
X-Gm-Message-State: AOAM531Rhu6vHpiz5QGrfOPjQ98V5tRACSc3Vecsi957Har6IxGWLt2E
        OWKOh7udTXV5E9x7j4w1/Tkt3NMVRAC/qQ==
X-Google-Smtp-Source: ABdhPJxxYaJdGpCQu9/PXOwwFdn2/rCA6ETsp9cNioEKjPNiv81oe1C3luZPdEINCLjDzVD6tLLIPg==
X-Received: by 2002:a19:c18f:: with SMTP id r137mr2559820lff.519.1617208995107;
        Wed, 31 Mar 2021 09:43:15 -0700 (PDT)
Received: from localhost.localdomain (cable-hki-50dc2f-26.dhcp.inet.fi. [80.220.47.26])
        by smtp.gmail.com with ESMTPSA id b25sm277693lff.268.2021.03.31.09.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 09:43:14 -0700 (PDT)
From:   Hassan Shahbazi <h.shahbazi.git@gmail.com>
To:     gregkh@linuxfoundation.org, daniel.vetter@ffwll.ch,
        jirislaby@kernel.org, yepeilin.cs@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Hassan Shahbazi <h.shahbazi.git@gmail.com>
Subject: [PATCH] fix NULL pointer deference crash
Date:   Wed, 31 Mar 2021 19:34:29 +0300
Message-Id: <20210331163425.8092-1-h.shahbazi.git@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The patch has fixed a NULL pointer deference crash in hiding the cursor. It 
is verified by syzbot patch tester.

Reported by: syzbot
https://syzkaller.appspot.com/bug?id=defb47bf56e1c14d5687280c7bb91ce7b608b94b

Signed-off-by: Hassan Shahbazi <h.shahbazi.git@gmail.com>
---
 drivers/video/fbdev/core/fbcon.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 44a5cd2f54cc..ee252d1c43c6 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1333,8 +1333,9 @@ static void fbcon_cursor(struct vc_data *vc, int mode)
 
 	ops->cursor_flash = (mode == CM_ERASE) ? 0 : 1;
 
-	ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
-		    get_color(vc, info, c, 0));
+	if (ops && ops->cursor)
+		ops->cursor(vc, info, mode, get_color(vc, info, c, 1),
+				get_color(vc, info, c, 0));
 }
 
 static int scrollback_phys_max = 0;
-- 
2.26.3

