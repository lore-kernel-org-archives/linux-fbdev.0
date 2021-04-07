Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E243EC433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40BE613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348897AbhDGGgf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348879AbhDGGg2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:28 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42CBC06174A;
        Tue,  6 Apr 2021 23:36:19 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id b17so8613099pgh.7;
        Tue, 06 Apr 2021 23:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JLhOPBDJGtizHkxpYodDCmquLiJc74NkWzdot10Uqo4=;
        b=E4gmRbZZB3nrPfH6rYurKTZ1NVPwu4BxR2b3mFcY7emW9XBR/0Vbkjv45xhT9mrl8T
         zYg4wPEw9rY2U1GXlL+4hgbLWG3p8o4XyvxD4IRyzljbRzvwWiRsD8w/HhjrFzcooPBO
         fWbbqnMdzR0r1trJROWweJ01y+8wsvtTnpIoqzFLoW6GJFL5GNtFdCvStx6/6kfN1Kzy
         7jg1EKGuX01KvY05QJw39yvzZqKU0uD3IpTRvbQJJWcPf81aSFPEMSjNj/SoP5ZtXatS
         nQFE3APRS7YENjU+7rrMObQ8I68YILgELibvRiW5iKo0l194K2EzEbyNqx5IsjJO+09g
         3WXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JLhOPBDJGtizHkxpYodDCmquLiJc74NkWzdot10Uqo4=;
        b=GOZG6ez9DEjeQ5kD/p+ZqCGTh3dkqMP+mEfEzpNSNaY3YteRAwb3W2OEDRNOI9QKM1
         ZYZNkWkxgkYUKY9AoA6dRoGUiBWU4BlZwe6KrWk9nG+WNrW73BjHqUbdCXpWwettAlPs
         HSu8XckLfOY3y5oJAy1Gl+RX+sUQiwGXeXnFkx4yYWpuHJUIXMDTzgLdil7GQLYUxg6m
         Al4BQGhBCaC4H3w77wLSU7Ay4vsGHhJeNeGoyfLUflN7W6MAEDmHyd3NvAqbJjIn/+Sa
         C8Xjs3N6CqrU3K0D3isg0lWxMWF+f/mVD1RQ8UUQVPKNw0AWHh3LK1B86oPZX4XOocEW
         th0w==
X-Gm-Message-State: AOAM531cE3+0lQbFtCoqe1HGltyQ9C37ZfRGqXQzJ11pkwHGez8yowV2
        Onkc/4D+FucuDuo1Gq1Y+s4wW6QstlwaAQ==
X-Google-Smtp-Source: ABdhPJxEYTKG+PCtN+CeP3xplySvBw9rwgnoRIal/cf2VznSrk1EHQGqNHaq0RI9n/aVrC5Yf78uig==
X-Received: by 2002:a63:4f59:: with SMTP id p25mr1868291pgl.21.1617777379324;
        Tue, 06 Apr 2021 23:36:19 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id p10sm20128790pfn.55.2021.04.06.23.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:36:18 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:36:16 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/49]  staging: sm750fb: Update enum values in dpms to
 snake case
Message-ID: <16693e7cc62f84ea1ec34b7d5cbd77c4cd1965e8.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for values in
enum dpms.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_power.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_power.h b/drivers/staging/sm750fb/ddk750_power.h
index 7002567a47d2..4756db1ccb9c 100644
--- a/drivers/staging/sm750fb/ddk750_power.h
+++ b/drivers/staging/sm750fb/ddk750_power.h
@@ -3,10 +3,10 @@
 #define DDK750_POWER_H__
 
 enum dpms {
-	crtDPMS_ON = 0x0,
-	crtDPMS_STANDBY = 0x1,
-	crtDPMS_SUSPEND = 0x2,
-	crtDPMS_OFF = 0x3,
+	CRT_DPMS_ON = 0x0,
+	CRT_DPMS_STANDBY = 0x1,
+	CRT_DPMS_SUSPEND = 0x2,
+	CRT_DPMS_OFF = 0x3,
 };
 
 #define set_DAC(off) {							\
-- 
2.30.2

