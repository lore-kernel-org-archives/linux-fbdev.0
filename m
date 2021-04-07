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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED477C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA353613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345797AbhDGGgO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345860AbhDGGgN (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:13 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 199CAC061756;
        Tue,  6 Apr 2021 23:36:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id a6so5495143pls.1;
        Tue, 06 Apr 2021 23:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PxKQLgSh2nb/XH5YpVxCcvU5M202Y3gpnJJ5xTXypQU=;
        b=Pk9+F3zXJx2odkFEnk3qTPJQJawwOiW7zo1VDocATkl0Xo1xLZK1O9MDIwZOax71Sp
         Eo4zma5NCIzHy/LFdHZnkAA/FvAUNUCymAD1GaeIGvrfFHtn9CXxklMr/0i5BU96QDR1
         DzxeUsW3eJIG8OVIocHhKN550jENBzZ9F+ad5bAvKGzcx/SvSVQO7vY/Onr74Nwdz5BK
         H7jiHTq6xkr6a0st1fZE17sGNH8UF0X4nepevpeXwZxts+h7fiLD5ubymz3L5+MvM+hp
         vDGPGHaNDm11XCGe5Gin1/aRGoCPt+9PnDSZ+4IE8FJrA+JhIB8h1rO0hCyr6eWiAZeW
         H9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PxKQLgSh2nb/XH5YpVxCcvU5M202Y3gpnJJ5xTXypQU=;
        b=UEg7QVXI6TgYMIhnlHqMjL9fjBNwE9Syv2yV3NVrfguAHs7fLPVIGLFM/PiAjsonDU
         b8ZiYg8PAP61sopn8wPgvaSc75N3Wh80E11/mjIAPOFtdaI/0e32hKCG4vnHXtkJ3fkM
         skFFUGYPEtWhn/PzNqCE5B73ZdvxNo3v+fuKUJcq7DJwTM4XEEo0Hq4fFwjnoJasLJOS
         SgkvTUo35gJyN5Wz9hleLZrf64r/+wLSG1pae0Qwl+uOR4lHVOwxw3hFWKsAPmAAbhZI
         wala3im+5aSZBrnxo3zRute4fEZ7uzeMTLPzIJUTmTlv5aJ1fGMKLvpF3rYclH4hYCO1
         ZmkA==
X-Gm-Message-State: AOAM532iQuK7Vg+GxivdkVYT5n1ap+BjLKpaDlQ1JuvYDDkQH4WXTexi
        fs7BsGju3GdQxmbVQl9ZT3s=
X-Google-Smtp-Source: ABdhPJz5BHdME/ZkEDDAA94wWwwQO3IeFNw2DCQZ0XToLxKfItLff/Yx2kMf8yf03KEQnHPpjLtUBw==
X-Received: by 2002:a17:902:a513:b029:e5:d91c:2ede with SMTP id s19-20020a170902a513b02900e5d91c2edemr1773981plq.65.1617777363671;
        Tue, 06 Apr 2021 23:36:03 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id z23sm20476921pgn.88.2021.04.06.23.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:36:03 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:36:01 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/49] staging: sm750fb: Rename dviInit to dvi_init and
 update param names
Message-ID: <6c6ecf7eee7d41492dbbcc4410db7eefd1fbb13d.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function dviInit and
its parameter names in ddk750_dvi.h.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.c |  2 +-
 drivers/staging/sm750fb/ddk750_dvi.h | 20 ++++++++++----------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
index db19bf732482..943cbcafcffa 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.c
+++ b/drivers/staging/sm750fb/ddk750_dvi.c
@@ -30,7 +30,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
 #endif
 };
 
-int dviInit(unsigned char edge_select,
+int dvi_init(unsigned char edge_select,
 	    unsigned char bus_select,
 	    unsigned char dual_edge_clk_select,
 	    unsigned char hsync_enable,
diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 4ca2591ea94b..fbc897c7efb8 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -42,16 +42,16 @@ struct dvi_ctrl_device {
 #define DVI_CTRL_SII164
 
 /* dvi functions prototype */
-int dviInit(unsigned char edgeSelect,
-	    unsigned char busSelect,
-	    unsigned char dualEdgeClkSelect,
-	    unsigned char hsyncEnable,
-	    unsigned char vsyncEnable,
-	    unsigned char deskewEnable,
-	    unsigned char deskewSetting,
-	    unsigned char continuousSyncEnable,
-	    unsigned char pllFilterEnable,
-	    unsigned char pllFilterValue);
+int dvi_init(unsigned char edge_select,
+	    unsigned char bus_select,
+	    unsigned char dual_edge_clk_select,
+	    unsigned char hsync_enable,
+	    unsigned char vsync_enable,
+	    unsigned char deskew_enable,
+	    unsigned char deskew_setting,
+	    unsigned char continuous_sync_enable,
+	    unsigned char pll_filter_enable,
+	    unsigned char pll_filter_value);
 
 #endif
 
-- 
2.30.2

