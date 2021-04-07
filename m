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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3577AC43460
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 098F86139C
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349057AbhDGGot (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349162AbhDGGoR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:44:17 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD83C06174A;
        Tue,  6 Apr 2021 23:44:07 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i190so3923767pfc.12;
        Tue, 06 Apr 2021 23:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JESl8F7HZRw0LoSc8TBdM56g5Q/RrwjjChVRu++BC7M=;
        b=pIeW7733ZNniiFIlG+mz0goVz0YILC2Er9C5Kut4+DkulhA/X+gIrSoG3evHTxVokF
         pcUIKMTiw0pXAkteWkRJ7yeZ0Nwsb4ZNCGUVj94/+ohk6f2TP35et6CAw6vp4Z9UfCCE
         97nGNlFpim7JyIHyz3r2ERQVLFLLvudS/AGNEe9YY3mVHRSQ6y28z+9v1Jz+bM6LNRgU
         nHd36/plfVjrJHzzeYHerr2UrNmq8/cO22oSJOkxy7rvHvRX7x/89skw+L7hDvkFctxq
         MYYfL2dLtEAjcNijKHLxcLBraaTyiVhCTladZ2CfxDO8cso7Q4/c3xXBX7f+GyZm2U1a
         vWKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JESl8F7HZRw0LoSc8TBdM56g5Q/RrwjjChVRu++BC7M=;
        b=XImO3A9DzPiys0oUeFkkTEWTNL4D/bqVew+vjms3C48bH3rwcYahIsvkkq3Hcw6nwQ
         appGGwDqxiRVfEigsIpJ3wq9MZX2NEL3FBiAzGgvhc8OHOBBs5L8+n4+bZ3nlATgAGAE
         eomcYNWOE3IBMJjy+OGBJ8qR/jCFeqmYeCzjKV6Pmz64cjJi2TaYTkQPlaYFEtwNZWYi
         RyL3EAa7T83HMjAPfbL5/Az10fPIvuxLT9JlaRqE7NC3wa1aN5hEugTCvS/LtvZ2c0B2
         CcVAq3S2vRTbrbbJoKOS815jlcVbFDpIYix2EgJy9wKAQ0MU8IChJIDC7Gm+hUG4m7UY
         BMVg==
X-Gm-Message-State: AOAM531LEU5C+xSrxEvgQ+B8x4gICol45L+9imjUOLgQaaxwhpFYOXbr
        HsMTFhCBjUaSiT3OoRr7kY27wvmn1qaQzg==
X-Google-Smtp-Source: ABdhPJyOtpgRhE/HbBiaHc+S7qKnzFbedlYfn3+0kIirv2faj+coYPXBXXmjEEtZxcdNqmo5b2P4PA==
X-Received: by 2002:a63:5466:: with SMTP id e38mr1939318pgm.172.1617777846646;
        Tue, 06 Apr 2021 23:44:06 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id y2sm20296657pgp.2.2021.04.06.23.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:44:06 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:44:04 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 30/49] staging: sm750fb: Rename function
 sm750_hw_cursor_setPos to snake case
Message-ID: <64e2d34d1aada4b5ea77afa11019422f3fcb7229.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function
sm750_hw_cursor_set_pos.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750.c        | 2 +-
 drivers/staging/sm750fb/sm750_cursor.c | 2 +-
 drivers/staging/sm750fb/sm750_cursor.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index eeba12f4b267..b76d3d40969a 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -125,7 +125,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 					fbcursor->image.height);
 
 	if (fbcursor->set & FB_CUR_SETPOS)
-		sm750_hw_cursor_setPos(cursor,
+		sm750_hw_cursor_set_pos(cursor,
 				       fbcursor->image.dx - info->var.xoffset,
 				       fbcursor->image.dy - info->var.yoffset);
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index d5ef40b8bc8e..0ba80e086415 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -64,7 +64,7 @@ void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h)
 	cursor->h = h;
 }
 
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y)
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y)
 {
 	u32 reg;
 
diff --git a/drivers/staging/sm750fb/sm750_cursor.h b/drivers/staging/sm750fb/sm750_cursor.h
index edeed2ea4b04..d0ade8e366f4 100644
--- a/drivers/staging/sm750fb/sm750_cursor.h
+++ b/drivers/staging/sm750fb/sm750_cursor.h
@@ -6,7 +6,7 @@
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_disable(struct lynx_cursor *cursor);
 void sm750_hw_cursor_set_size(struct lynx_cursor *cursor, int w, int h);
-void sm750_hw_cursor_setPos(struct lynx_cursor *cursor, int x, int y);
+void sm750_hw_cursor_set_pos(struct lynx_cursor *cursor, int x, int y);
 void sm750_hw_cursor_setColor(struct lynx_cursor *cursor, u32 fg, u32 bg);
 void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 			     const u8 *data, const u8 *mask);
-- 
2.30.2

