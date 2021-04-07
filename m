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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E529C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62EC061222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349015AbhDGGnn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhDGGnn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:43 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FDEC06174A;
        Tue,  6 Apr 2021 23:43:34 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso728939pji.3;
        Tue, 06 Apr 2021 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bvyOIchcblyTZxnk7QAJ5m+10+TOrC3FpEbk+84z4mA=;
        b=L2LHFPXPOiW6v3ukim6PWI9ekG/YDRwkjW5YT01lM9eZ9nS/i+qJnVnT8ZVAyRalD5
         dKnt45ZAZR5MioQkIpRouxs1KonXRR1Z+hfsguv3UJONa5oBBBqL+gVj0jZw4w/8DyNJ
         25IBbZqpKGYMHJc4OZTv8QwTsli8d1gFdQ9oItH5/ejvzsH8B1kWbzecw/VCVD15flQS
         0ltX1D46/DWkQFSv9HiC2ZU0gTss1F/Sik51jCaN4gwoqAC01DYFwSLCbLewi12/gQU5
         8T7dSIFDckdzWIshwiNcZrQ6gPymfFiEHfnI7k2PeQuvNGF2trbL0tfKnE4Pb9e1atoV
         oWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bvyOIchcblyTZxnk7QAJ5m+10+TOrC3FpEbk+84z4mA=;
        b=FW/oOBYAwLpVr1oOHEC03DlGjIVuaryhXcs1frOaGU6ETMPlIglH5K4RLjJhSx1rat
         tRgnQEbUrlCUaiz03poBK7bxnp3CBPRiKTM4sGDJCihQpiBF6SIhLECYc7BGUYAigufS
         KIalVOD9FNSSVWjDpLslKGFICRLdP7pN4u7/KIzZHZDyIbtB6QGRwp4fld+N2CsCOaW2
         i9aiIcjCx8wRN1ukbHWsMx5vxRshscFZyzBokyYmLmBnyEedSmlnub/ptvNECPYlsgxY
         oMGtuN3ghiJ0SgZ2lvevDEaLeUkntlQljTRO/IfweHR6cWPVom98A/aSY4bTNMGF+7uz
         jQtg==
X-Gm-Message-State: AOAM533OKGelxqjPqKBS6PHo4X5Asv9SLM1Sg30X4eNngEfplkgSzFXS
        NGajPiGkDUwTH8jeJATDaaw=
X-Google-Smtp-Source: ABdhPJy4Ln4m3cV2fjHszjqG0UJvfKjad9FvZloqq8wON2TZdz9ZWHsKfeBcQ/qPq0j5Rz86wUFH1w==
X-Received: by 2002:a17:902:ee93:b029:e9:6b29:3219 with SMTP id a19-20020a170902ee93b02900e96b293219mr695699pld.16.1617777813875;
        Tue, 06 Apr 2021 23:43:33 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id e190sm20147991pfe.3.2021.04.06.23.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:33 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:31 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/49] staging: sm750fb: Rename function parameter of
 sii164_enable_hot_plug_detection
Message-ID: <d2feddde2b2d8658ea990eabf16747561c15c395.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the function parameter
enable_hot_plug in the prototype of the function
sii164_enable_hot_plug_detection.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ceafac60340f..ac1431dcb419 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -34,7 +34,7 @@ unsigned short sii164_get_device_id(void);
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
 void sii164_set_power(unsigned char powerUp);
-void sii164_enable_hot_plug_detection(unsigned char enableHotPlug);
+void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
 unsigned char sii164_check_interrupt(void);
 void sii164_clear_interrupt(void);
-- 
2.30.2

