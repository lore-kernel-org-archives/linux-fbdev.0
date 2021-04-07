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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506C0C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 214346052B
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348854AbhDGGgY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348883AbhDGGgX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:23 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B88F7C06174A;
        Tue,  6 Apr 2021 23:36:13 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id f29so9803075pgm.8;
        Tue, 06 Apr 2021 23:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DybsWO6cYupTAYK5TY3h7KJtjw7Gu9U9lSriFDUMaw8=;
        b=FdKvOV3IL4dnT5Qd/skievzAJiYmP8mOYgeLLnlq8L9EL4D4WJkv9ydKhfJHdfDcpD
         3mmH7Ir/l5o9MTRgL7OacSM9crrSypLeLHN1TyKvyqucvvP9juoFuXW9fep1pOgnBlj8
         6HM+IH4/WtAUjyAhoJWv1TpXk3OTWDuvCWnBQ77qnw/IIoOOLMx/RoR5k3cOtQVAzs0N
         hgOecVo+7k1TP9tlKQ5sQDHt4BhkQG6cGZIYyB11VhyqLiaQEc9QEXWuocbp2k2gHkkJ
         NUW1A0bUUkKs/ivXH8cT1c13KiHIQZRHTPjvV1wcJ1cYnPNyfF3AT+R4XUZCLsy7lwVY
         jLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DybsWO6cYupTAYK5TY3h7KJtjw7Gu9U9lSriFDUMaw8=;
        b=C8eVMB8bZv+0Kir2bwEscE2oPROmiu3dTFO0Sx/hA3GlXKwpEfacsXaPTn/af+Lcvg
         VkQ93uxNlYGNeRZDP2ceu8E+P3SdNmwF1kSLtyY6vIpEVT0fgxNGxSWg/4p2w2qbzBni
         Udqmd0/kMSa2aGEHuRW7x3Ir/jmljJx+08uQYhqNtKxEpOIPuaYBpkTzJM81J9Am/J8S
         y2vFh1WWlhbOxfH5erpQiE/xOWLTZLnhs/Wrg8TWLWw3XgIbkzZiy+MpMgmUmrSOkrM/
         CTy6bvAvrozLq1+WnZkYry1ISNpyBZ/nkMzla2rok/46QdQ00ENZLre1gUllM+SSqyUz
         YYBg==
X-Gm-Message-State: AOAM533907fSYjVzwftroxJSZJVDbzGLuIhZsKFb3UQm6BDxt0tSP0HC
        V0LcZ3WRwT9L1W/Be0MKMWM=
X-Google-Smtp-Source: ABdhPJwuyTAC8jxTxOk3Mmj1dDuxKrU16iQQtdWCrgRfJU7JlDZ3fSgVkVL7AJIYC/S1Qw5EZuHKEQ==
X-Received: by 2002:a05:6a00:158b:b029:241:a969:4da6 with SMTP id u11-20020a056a00158bb0290241a9694da6mr1584990pfk.27.1617777373300;
        Tue, 06 Apr 2021 23:36:13 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id mu6sm4115326pjb.35.2021.04.06.23.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:36:12 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:36:10 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/49] staging: sm750fb: Remove remaining camel case names
 in ddk750_dvi.h
Message-ID: <2ee5dbf98547860d93d5c72b73ea61991dac0b1c.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl check for type definitions
DVICTRL_SETPOWER and DVICTRL_HOTPLUGDETECTION in ddk750_dvi.h.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index 8aee0cdf63a4..d953fb5ab9f2 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -19,8 +19,8 @@ typedef void (*DVICTRL_RESETCHIP)(void);
 typedef char* (*DVICTRL_GETCHIPSTRING)(void);
 typedef unsigned short (*DVICTRL_GETVENDORID)(void);
 typedef unsigned short (*DVICTRL_GETDEVICEID)(void);
-typedef void (*DVICTRL_SETPOWER)(unsigned char powerUp);
-typedef void (*DVICTRL_HOTPLUGDETECTION)(unsigned char enableHotPlug);
+typedef void (*DVICTRL_SETPOWER)(unsigned char power_up);
+typedef void (*DVICTRL_HOTPLUGDETECTION)(unsigned char enable_hot_plug);
 typedef unsigned char (*DVICTRL_ISCONNECTED)(void);
 typedef unsigned char (*DVICTRL_CHECKINTERRUPT)(void);
 typedef void (*DVICTRL_CLEARINTERRUPT)(void);
-- 
2.30.2

