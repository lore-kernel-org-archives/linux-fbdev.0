Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCACC433B4
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Apr 2021 18:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6455B611F0
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Apr 2021 18:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351976AbhDNSM1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Apr 2021 14:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352292AbhDNSMZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:25 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B09C061342
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Apr 2021 11:12:02 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h10so24795681edt.13
        for <linux-fbdev@vger.kernel.org>; Wed, 14 Apr 2021 11:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a5roCrWCSkmt1RP3Taphq9R1YmlOTY/ma9pHzyYzjyA=;
        b=MoUMuWuFAAarvGL1AUHSNosCqD4tw/Pqic0xuy7Q+2iF23t1JCt3Vyp2LV2En4tT/s
         ZLhySDKnh00w5s9Hofv8uGG4YSUrCQJfEIY/6JjRJWi5uxTcBPKcn/1qzGOnWYUy5aBD
         GYcuxIxHDSxh6L7X2IHS2s6uvfHGZaYW5JvB1+16BkP0unMj8rJONU+mj8T5OXWirqzb
         p+JZLMSSa4tBhjuFmYOKCk4KpPrUdtBH+0R/nzJPvk1SWqGko6Q+DkYB75Hu4Yu9dADU
         oRR/zmrG+1FNpReIHC/lVLPLUn5pq6eyaK8EXs2V4WhulXfnwyHkMojT1oBmIr/xW/yD
         EIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a5roCrWCSkmt1RP3Taphq9R1YmlOTY/ma9pHzyYzjyA=;
        b=W+4qaGWf58DnSF0HpNDLWQFME6tcEd/w6geK2dbKbyCsR/50jLen8hnFjRVJHYC/2a
         24phOmHR51/KJYcooMKLzxboL6Zi+zmKA+jn5LPJhJW310Jk/J0MbpUBUJ47ON618GDp
         3bBvWLabmo0ftOwgzIpYPRBGql9u+IxJkSvSgQVjwrfxHqNtdShiHaAdTXugCAuJEFGL
         71Qn59fmnhzY/DZNlXeW5awB+Jr8hr1qjhOd6CQff5fThxp3PSjw5G+J9jPWOqTAhS97
         ntPk7VaeQefnBlmV+E1/4UDpzP2Un4PLquWfSS/Pe1ZiZAyHrEtwGnJhA+9pFAsBovt1
         4MXQ==
X-Gm-Message-State: AOAM532zBaNW8HX9kljThxIJKXgl0iF2RCaS9j/DXBRVu5eTErNnom7g
        5YnEsbQRuRTn7YnKEnYjcDFC9A==
X-Google-Smtp-Source: ABdhPJyR0mBukYZlK9GIkfQp2+J2Vxx6FhpKATTYgN0Ed8PS2LyMu0qvOBL7RPLb8lf9BQSs5wEseg==
X-Received: by 2002:aa7:ccd0:: with SMTP id y16mr171436edt.101.1618423920890;
        Wed, 14 Apr 2021 11:12:00 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:00 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 25/57] staging: sm750fb: sm750_accel: Provide description for 'accel' and fix function naming
Date:   Wed, 14 Apr 2021 19:10:57 +0100
Message-Id: <20210414181129.1628598-26-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/sm750fb/sm750_accel.c:155: warning: Function parameter or member 'accel' not described in 'sm750_hw_copyarea'
 drivers/staging/sm750fb/sm750_accel.c:155: warning: expecting prototype for sm750_hm_copyarea(). Prototype was for sm750_hw_copyarea() instead
 drivers/staging/sm750fb/sm750_accel.c:321: warning: Function parameter or member 'accel' not described in 'sm750_hw_imageblit'

Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/sm750fb/sm750_accel.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 8faa601c700b2..24b9077a634a6 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -131,7 +131,8 @@ int sm750_hw_fillrect(struct lynx_accel *accel,
 }
 
 /**
- * sm750_hm_copyarea
+ * sm750_hw_copyarea
+ * @accel: Acceleration device data
  * @sBase: Address of source: offset in frame buffer
  * @sPitch: Pitch value of source surface in BYTE
  * @sx: Starting x coordinate of source surface
@@ -298,6 +299,7 @@ static unsigned int deGetTransparency(struct lynx_accel *accel)
 
 /**
  * sm750_hw_imageblit
+ * @accel: Acceleration device data
  * @pSrcbuf: pointer to start of source buffer in system memory
  * @srcDelta: Pitch value (in bytes) of the source buffer, +ive means top down
  *	      and -ive mean button up
-- 
2.27.0

