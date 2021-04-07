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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41052C43460
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FEBF61222
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349035AbhDGGnt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349029AbhDGGns (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:43:48 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EC3C06174A;
        Tue,  6 Apr 2021 23:43:39 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id ay2so8840603plb.3;
        Tue, 06 Apr 2021 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=juPdFsys4r3Aaic/tVEakxA+SlqXVvRJQMcNPtT88ko=;
        b=V3Jd8on2MAtBF/RvEHZ1tA0fxsIBKGL9HyHv8m7MS02I+BhhMaFAxvfwKrxBtdmgIa
         ZsvnIg9VaPf5aQw5/FhyhPtpNNezI9I3/ThfdWf1zEZR9/dAyrl9yIgtsRPYFey6OqMi
         qNdSDWkx/74o0qT5iirVrEh4HwyXNShC+jPlWitcli4StnQCtIHI2ysMQCAQs7K6k1er
         D6dccbtfNj0/+sPSFech95aVrHX7qDadNgR8dQiQo2vYZ7woqy6ZIt+nPa1TyfbMYxv7
         WEMxEyhCUQAo5KbGGsbd7pMB4OC5ZNijgLZQz1Jz1eEupTBufLJkXPS9BjKuav0Vxt03
         ts+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=juPdFsys4r3Aaic/tVEakxA+SlqXVvRJQMcNPtT88ko=;
        b=cotmmx2ZlRPvo9QIlDxFiDrWdvB3UTyPrm5bhp9Z/qda6Hj4lhs8v9IoGed/Bwv6OJ
         WeHKMjNr1LCao/gtH92XbZjSfuCxK2Halwb6jKDPlH5K4hMVNM6Punn1qk+5yaQ9gJX/
         T0u8X++emVHvig8AX0utE3O/a4KsoSVeQIxVH+wVem7VQt8PfaUurkUB1IV26eDk1w+Z
         T5yNvczGFnN5SClRM6o4F09MV1TAXTWnJXw5z7O2ooiM+6oXpZvKbDLCbgd66OoyJG8l
         w2wwuP+t35kzlPg+vV6ZhlTLootAughYex2ZXGDn2JNo554YmC1XnnlKiMIvFvSaf3Ed
         WsdQ==
X-Gm-Message-State: AOAM533dPiKprT46VOnJHLWNbIoIeSQ32WE+RppXwd8SahPJr/l6SKXd
        mEbxf7jgC1/qX7kn2YuXOhQ=
X-Google-Smtp-Source: ABdhPJzooZZLcFRKF8gWsCfqXUMmjqpDRxFfh8K5S0UQaX5Xv3UXDYqGmunEpRFbquOtNCtZ80nsCA==
X-Received: by 2002:a17:902:122:b029:e8:bde2:7f6c with SMTP id 31-20020a1709020122b02900e8bde27f6cmr1686322plb.29.1617777818946;
        Tue, 06 Apr 2021 23:43:38 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id 14sm19981411pfl.1.2021.04.06.23.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:43:38 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:43:36 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 22/49] staging: sm750fb: Update local variable in
 sm750_hw_copyarea to snake case
Message-ID: <e112c237568818ab77e11d5785c89e7932a62678.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpoint.pl checks for the local variable
nDirection in the function sm750_hw_copyarea.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/sm750_accel.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 4ad2814b5b54..760dd036d71a 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -153,9 +153,9 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		      unsigned int width, unsigned int height,
 		      unsigned int rop2)
 {
-	unsigned int nDirection, de_ctrl;
+	unsigned int n_direction, de_ctrl;
 
-	nDirection = LEFT_TO_RIGHT;
+	n_direction = LEFT_TO_RIGHT;
 	/* Direction of ROP2 operation: 1 = Left to Right, (-1) = Right to Left */
 	de_ctrl = 0;
 
@@ -173,7 +173,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = BOTTOM_TO_TOP;
+			n_direction = BOTTOM_TO_TOP;
 		} else if (sy > dy) {
 			/*  +----------+
 			 *  |D         |
@@ -185,7 +185,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 			 *	+----------+
 			 */
 
-			nDirection = TOP_TO_BOTTOM;
+			n_direction = TOP_TO_BOTTOM;
 		} else {
 			/* sy == dy */
 
@@ -198,7 +198,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = RIGHT_TO_LEFT;
+				n_direction = RIGHT_TO_LEFT;
 			} else {
 			/* sx > dx */
 
@@ -210,12 +210,12 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 				 * +------+---+------+
 				 */
 
-				nDirection = LEFT_TO_RIGHT;
+				n_direction = LEFT_TO_RIGHT;
 			}
 		}
 	}
 
-	if ((nDirection == BOTTOM_TO_TOP) || (nDirection == RIGHT_TO_LEFT)) {
+	if ((n_direction == BOTTOM_TO_TOP) || (n_direction == RIGHT_TO_LEFT)) {
 		sx += width - 1;
 		sy += height - 1;
 		dx += width - 1;
@@ -277,7 +277,7 @@ int sm750_hw_copyarea(struct lynx_accel *accel,
 		  (height & DE_DIMENSION_Y_ET_MASK)); /* dpr08 */
 
 	de_ctrl = (rop2 & DE_CONTROL_ROP_MASK) | DE_CONTROL_ROP_SELECT |
-		((nDirection == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
+		((n_direction == RIGHT_TO_LEFT) ? DE_CONTROL_DIRECTION : 0) |
 		DE_CONTROL_COMMAND_BITBLT | DE_CONTROL_STATUS;
 	write_dpr(accel, DE_CONTROL, de_ctrl); /* dpr0c */
 
-- 
2.30.2

