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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B50C43462
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02EF9613C0
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348940AbhDGGhY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348935AbhDGGhU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:37:20 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA4CC06175F;
        Tue,  6 Apr 2021 23:37:11 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id p10so3695846pld.0;
        Tue, 06 Apr 2021 23:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BtyBOMvsqSJAayOGR2ps6Fm5o+TmuUaUOXkQzK0Am80=;
        b=FYxkr4zNiq+MJV0WrNM/yKUHigyUboVN9BVJ/JJ5qxDsVp7R+hZCNWzmv3aSNvZcvD
         2uIguRDT37Etg0K2v4exBizNKH2BtXOMR+bpoXs08TP7sZ4mJFZlAa4zDfYQhXujiuaU
         IUzokmik9TLiLYU8vVaKyySF3kAUQZhKE6FOUim5T8qas27ror5wckKPsJod7tThnTul
         XKkx8vQpAVWpwmPGqdvBOkEGjSUo0xIchc0wdYe6x3R58WuQFNXiAptRPCeLCl1Ymls9
         u1v0nUo3g0tNdqVReKWPhw8Tc3aNhzLHS7oZYIg92ZHE8509ju4NxoIlTJmC6eiqpnpr
         2slw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BtyBOMvsqSJAayOGR2ps6Fm5o+TmuUaUOXkQzK0Am80=;
        b=gd2khaQ3l5raVNlhWGLk24c6XO7j4DDbuyFtDCguznJL6ruIAdEVybLsek/F8frrb2
         6sEifWcITuGS1i98ASImnPBGQXL5ly6707UG6Tr0n4rh9iopu5Yj+56G3hM6u//6RJvT
         U/xgWMlzSWMyQEn9DnHorqxS5pJXso3z6VOQA9+fDuKx7okJ+C0ER7h8GlTvSEGOHT3X
         UeAGVmVPxB6BODydzH4fZum+C54mQNKQx2/7M9wVPpqy4TXhdb5/uXKfCpK5w0s3YkZ4
         d7Yp5htq/iI9q+hZeI8ZtY4USKX12Tsyr06tOYbD+USeLbXbNkp2+QUhoe/9PIgq7gM+
         KrqA==
X-Gm-Message-State: AOAM5337vw5QkfPsaOniq0xllnUDmLH15gO3zNfjItmkrVYrUhTd+sde
        WIMjYROrRoQXz32wJ+82UFg=
X-Google-Smtp-Source: ABdhPJx62uNLl6w6YDWL21XyY3o6O682yByIaQI1OCkg2oivnbKc6M+sEPhfMEzwkSr20Tun3HEiDQ==
X-Received: by 2002:a17:902:f686:b029:e5:de44:af60 with SMTP id l6-20020a170902f686b02900e5de44af60mr1772297plg.64.1617777430958;
        Tue, 06 Apr 2021 23:37:10 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id w203sm19836430pfc.188.2021.04.06.23.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:37:10 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:37:08 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 14/49] staging: sm750fb: Rename
 sii164SelectHotPlugDetectionMode to snake case
Message-ID: <39d33b45117c205208b6fa9c21ac9d32eaa9c5b1.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for the function
sii164SelectHotPlugDetectionMode in ddk750_sii164.c.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.c b/drivers/staging/sm750fb/ddk750_sii164.c
index ceeb914f8441..7e0a481970f5 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.c
+++ b/drivers/staging/sm750fb/ddk750_sii164.c
@@ -298,11 +298,11 @@ void sii164_set_power(unsigned char powerUp)
 }
 
 /*
- *  sii164SelectHotPlugDetectionMode
+ *  sii164_select_hot_plug_detection_mode
  *      This function selects the mode of the hot plug detection.
  */
 static
-void sii164SelectHotPlugDetectionMode(enum sii164_hot_plug_mode hotPlugMode)
+void sii164_select_hot_plug_detection_mode(enum sii164_hot_plug_mode hotPlugMode)
 {
 	unsigned char detectReg;
 
@@ -344,9 +344,9 @@ void sii164_enable_hot_plug_detection(unsigned char enableHotPlug)
 	 * on each individual chip design.
 	 */
 	if (enableHotPlug != 0)
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_USE_MDI);
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_USE_MDI);
 	else
-		sii164SelectHotPlugDetectionMode(SII164_HOTPLUG_DISABLE);
+		sii164_select_hot_plug_detection_mode(SII164_HOTPLUG_DISABLE);
 }
 
 /*
-- 
2.30.2

