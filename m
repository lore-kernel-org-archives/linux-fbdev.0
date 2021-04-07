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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F7DC43460
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAA39613B3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbhDGGhX (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348922AbhDGGhR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:37:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E698AC061756;
        Tue,  6 Apr 2021 23:37:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id c17so12170442pfn.6;
        Tue, 06 Apr 2021 23:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZGMaTnhAGkt8KYVxrVKbfZTGzttqgPwSz58aY8xeIts=;
        b=DPhGn5VNya3y33vxf5Ki/zWMTNOzOY4P+JPBBl00ReAABTtKxV40hi/pVgmAetvOTt
         hkMy4xCmn89/m2by9NNV7BDHFZJGsoHsc47SLRkxyfDZQyUxoxhUeS45T6LgezSQIOCB
         0uhJKnbfwioBIBj7eJoROWEMljCJkj7xuiZ20Ve154ll4LTOe8m0TfPGm14GUti21cLu
         tQpgu0o7x9q28SB7JSGiRZpJbfyq4T6ox6GS7ivjcHipOhJzXubTqcttnD7fcLpsAC55
         P0JUPSzVlPnLmKgJUfixs/FL4PxNyASxhamX2KZfMCPOr1HBy5ZM8NEb4evCkaV68rfO
         gNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZGMaTnhAGkt8KYVxrVKbfZTGzttqgPwSz58aY8xeIts=;
        b=UIwYfJ8docdQ/OROW5blDBx6dUQxgckV3NgI1DlHcP6j2DYOb/i6oBI7dDnAvY+Mkd
         3iVVPrNdVozXkieOr0j5f9JtCFRskZAueiRH4r/YIsgyGp7e7mLrab1KmNPHdYs0hwW7
         Rebzj6ParlzOTGk/f+7VC93G7mk79f6fSXuH/eYWfiK6miWmUJuRPQCw2e3XTibo4UZe
         69RTWVX7iwPkXXXgLj91MQfAebVWh3D6dyETLr6KK8hViUbeH4WlRbsMGyH5Q3FWiNUc
         T3RFNmZwblcNEWENMdYSc3u7IPUAMPcfM93eyb4eNYb7eTRybOzLilHndXConp4isuF3
         EqAA==
X-Gm-Message-State: AOAM5317GJ6hJsXAEvyjf6aVqI9Mit2oNUemoHAVKN1/rpCZcyWrRAWD
        D+OvE38k27R3jp99AWEmqaw=
X-Google-Smtp-Source: ABdhPJyT0UMLGJ9rpAI763JX6R6qPy2596YeMN0kG9OZZlfz5zu/2aTtVSennR8N+N796+LoKrcVwg==
X-Received: by 2002:a62:8485:0:b029:1fc:823d:2a70 with SMTP id k127-20020a6284850000b02901fc823d2a70mr1606951pfd.18.1617777428422;
        Tue, 06 Apr 2021 23:37:08 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id s76sm20722388pfc.110.2021.04.06.23.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:37:08 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:37:06 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/49] staging: sm750fb: Rename deviceID local variable to
 snake case
Message-ID: <d377e081c0a67c3ee838e1821aa6b35a46fcc92e.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the local
variable deviceID in the function sii164_get_device_id.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index 14d7083775b4..ceeb914f8441 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -56,14 +56,14 @@ unsigned short sii164_get_vendor_id(void)
  */
 unsigned short sii164_get_device_id(void)
 {
-	unsigned short deviceID;
+	unsigned short device_id;
 
-	deviceID = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
+	device_id = ((unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					       SII164_DEVICE_ID_HIGH) << 8) |
 		   (unsigned short)i2c_read_reg(SII164_I2C_ADDRESS,
 					      SII164_DEVICE_ID_LOW);
 
-	return deviceID;
+	return device_id;
 }
 
 /*
-- 
2.30.2

