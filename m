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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7106C43460
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E1C613CD
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349163AbhDGGqZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349160AbhDGGqV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:46:21 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBA2C06174A;
        Tue,  6 Apr 2021 23:46:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so779374pjv.1;
        Tue, 06 Apr 2021 23:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=87FzL2bfn+zBBigzd2S34Gvtwu79/Sjcc2/CQOxweQU=;
        b=MubQ22CpAN1kkt6OD34w02Kt6gDd/Mo619issLItehETO7lPL1JJF/cs4ANeT1NBoU
         f1VNBSl8/PphpLTFZ17sDZz6U5SaCnO3p5ERo4r/NdxT73FI+G8SVh+1ZgqynUpvKMiM
         omnN9swULQHZ3Gxgvj4Hr0ti3PDqiGeRWtooNlVkVAgiZq5QxjWt2oRSQWGTngviELye
         lZrMNG0yhvO9oJlsxa5i9Lta35mTEgR8EY72CODyNfXnnw82wE3tQvdtwjEtRCKz0NRJ
         jAjT+H2Z0dDq/XbQH8EYEiG5MhO6qchB7G5aB0QD/aQ5t1FmAokqRVjPBYClqfgSETyQ
         HRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=87FzL2bfn+zBBigzd2S34Gvtwu79/Sjcc2/CQOxweQU=;
        b=fb/g2iI8Vs46PpIeaDBSqPVvmgyDtXjv7yCFUzc+ZidS5K0JgHxl1qj+TkEnOPpmFX
         P71korxiybzNSPD62zm+I6DjxWz40B/rF+D5RFVfa8z7OnsbpakJYwFF70rRLwVm3ujy
         NAn3uP7q7Eixx3EuWwUtHKJVLI+bQHnIvwGCW6nEdybdA8OBm74wSGbPc0hN5SDo19M9
         F6ioYLppyJ2Dx02w3Vppn7JR7mqSPywJQVfjDDSH8fBGM61fAJg+GAqloQlT12lizRmw
         IsnhHAmm0FHEEcwFIqnGk4w1rN+T46gQx0y62hekCE/bEXyQMFeWyH2DAPvovkP+RRLI
         OxHA==
X-Gm-Message-State: AOAM532SZssuKrxDa4DpW4xWfXaU2TnHxW3nOXC6t/jN7Nu2GS36SHiS
        dRM2J3Pgm4DVYxaBc0+O63s=
X-Google-Smtp-Source: ABdhPJxJMLnMvlrNyuI8azlZ4zPLdcHtePAjBxO51e+ihrQaykciRMTvUL0wA7/2BJib4J2hEv5gzg==
X-Received: by 2002:a17:90b:300a:: with SMTP id hg10mr1863313pjb.58.1617777970829;
        Tue, 06 Apr 2021 23:46:10 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id l1sm10927658pgt.29.2021.04.06.23.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:46:10 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:46:08 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 45/49] staging: sm750fb: Rename sii164_set_power function
 parameter
Message-ID: <e84fb623b9b89051758fda1a21877b008b5439ae.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for the function parameter
powerUp.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_sii164.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/ddk750_sii164.h b/drivers/staging/sm750fb/ddk750_sii164.h
index ac1431dcb419..a414afbb719a 100644
--- a/drivers/staging/sm750fb/ddk750_sii164.h
+++ b/drivers/staging/sm750fb/ddk750_sii164.h
@@ -33,7 +33,7 @@ unsigned short sii164_get_device_id(void);
 #ifdef SII164_FULL_FUNCTIONS
 void sii164_reset_chip(void);
 char *sii164_get_chip_string(void);
-void sii164_set_power(unsigned char powerUp);
+void sii164_set_power(unsigned char power_up);
 void sii164_enable_hot_plug_detection(unsigned char enable_hot_plug);
 unsigned char sii164_is_connected(void);
 unsigned char sii164_check_interrupt(void);
-- 
2.30.2

