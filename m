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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F00C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE5A6052B
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 06:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345860AbhDGGgR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 02:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348815AbhDGGgP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 02:36:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886EEC06174A;
        Tue,  6 Apr 2021 23:36:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id k23-20020a17090a5917b02901043e35ad4aso719570pji.3;
        Tue, 06 Apr 2021 23:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OH0zYh2ZFmb689ReWGztZUI2CNWri3Mtoqhtg+OoAIA=;
        b=q/PqrlHVdCpvFjAw95bHjGsgaRHjqqCSP3+wsmNOWSPAFCBky2VtW8Y+LC+NdU2gNq
         LfyL/RLPB5ly2rl9c4PBIWGvdC44KvWWsWf+3GDVSGzNY7Fun3Awd/99A68XSxrSZs3n
         3cBfuVymGxQ6WMfH8+TuZSohcFrZbBB2jvj1c8vLihkHL4chhss0Ovrspycv0XVP2BI3
         yYMiV6Awwaz1F2qxvHajDd2B5V8g9xvwZXWpvff9/wZhhDDRONIc7A1+YNTwTDCK67jb
         sIHCzb4sILGrx8JxZE/tKGFtcwfBdyInUvEI4JzBQinOxPfL8oeXAM9Ze/Y0OacqtmCK
         Dmeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OH0zYh2ZFmb689ReWGztZUI2CNWri3Mtoqhtg+OoAIA=;
        b=AQDjRU8Z+NL0YsCpTDjExhFOxnIFNXqjjUY9LYlZnYVWMPKwhQrkAz0A8ijGLYlfoM
         n6o+lobSI9HpBhryivamA/58nUA9O5H8jy22u4EHS5jvwfIKs5tNi5amcdPG10zqExNo
         +XRoj6+csFhSJv/8Cnxes3u+XDNS/5TXqQ333sichLrFOG3WLggVssF0gvCG5okZU/qM
         GL7psaIJeGk0xAIpKnL9h6DjF891fAxA1+UzJpLdMqiO2JOACwFc2N50bVrFrq14r140
         Mzt98Zid8fXF7MZDtfVm9qQE+VZpZoCrEAFNUGzmIxsyMja6PDNMP6hv1gaJCi6UlgiS
         c3GQ==
X-Gm-Message-State: AOAM533vkNxhYLwjmpbRQok5xXWKdH68WMUoJp3QWTC17Hzzid7koc3K
        D7YA4oDdAe+d0l0MQVKew3MhFxI98aj4vQ==
X-Google-Smtp-Source: ABdhPJyQUOXMZVoOmoZsPyEGgo8FcUEFzPIawSF1BczppHICzW6bmSbZIAGb4ojPKN2ea+3zkDEi3A==
X-Received: by 2002:a17:90a:c004:: with SMTP id p4mr1824906pjt.202.1617777366153;
        Tue, 06 Apr 2021 23:36:06 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id j20sm4187921pjn.27.2021.04.06.23.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 23:36:05 -0700 (PDT)
Date:   Tue, 6 Apr 2021 23:36:03 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/49] staging: sm750fb: Update param names of
 PFN_DVICTRL_INIT function pointer
Message-ID: <fbf0bb3ddb5cfc9a80fe7342b828d3ab5740314e.1617776878.git.pavle.rohalj@gmail.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix "Avoid CamelCase" checkpatch.pl checks for parameter names in the
type definition of PFN_DVICTRL_INIT function pointer.

Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
---
 drivers/staging/sm750fb/ddk750_dvi.h | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_dvi.h b/drivers/staging/sm750fb/ddk750_dvi.h
index fbc897c7efb8..b2fd56ef51fc 100644
--- a/drivers/staging/sm750fb/ddk750_dvi.h
+++ b/drivers/staging/sm750fb/ddk750_dvi.h
@@ -4,16 +4,16 @@
 
 /* dvi chip stuffs structros */
 
-typedef long (*PFN_DVICTRL_INIT)(unsigned char edgeSelect,
-				 unsigned char busSelect,
-				 unsigned char dualEdgeClkSelect,
-				 unsigned char hsyncEnable,
-				 unsigned char vsyncEnable,
-				 unsigned char deskewEnable,
-				 unsigned char deskewSetting,
-				 unsigned char continuousSyncEnable,
-				 unsigned char pllFilterEnable,
-				 unsigned char pllFilterValue);
+typedef long (*PFN_DVICTRL_INIT)(unsigned char edge_select,
+				 unsigned char bus_select,
+				 unsigned char dual_edge_clk_select,
+				 unsigned char hsync_enable,
+				 unsigned char vsync_enable,
+				 unsigned char deskew_enable,
+				 unsigned char deskew_setting,
+				 unsigned char continuous_sync_enable,
+				 unsigned char pll_filter_enable,
+				 unsigned char pll_filter_value);
 
 typedef void (*PFN_DVICTRL_RESETCHIP)(void);
 typedef char* (*PFN_DVICTRL_GETCHIPSTRING)(void);
-- 
2.30.2

