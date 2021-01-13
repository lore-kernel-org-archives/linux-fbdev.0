Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AFFEC432C3
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68F5523600
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbhAMOwT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727716AbhAMOwS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:52:18 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9283AC06135C
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:54 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id r4so1844020wmh.5
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9xOmpZJSJcGjkWdwzXh/1wdxHxk1qdbTp529iSzZw+A=;
        b=MymSG+nXTdHHBzQGPOze7DAAa+ej555u1BcqPgKwDdULmCR+9lifj/RBMgwbwLjlyt
         elvEBNHzvmvW/yms4fg79Qi5WzxgrFr7YClQKZgIpcNwnQ6ljdR5HdRdcTX3fA10rdIO
         aO30H/7nbBKrI5hxOWH6sSs6sEMtOANO1pinWzByh2d2GV3m/EpoTjowTDqX+0kZ8xaX
         liF75WImH8LTXSQqNUBp9HlqfewIAHFYh7spBcCRwDuq6cWAwda7+vnAqeuvQNX58v7P
         03COI9tjDj1PG/ZMJxlUk7Sxq24UPa6mvTMs6nk8c9qwdcBQeIG7i50znWEf+3nSQ5RB
         JzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9xOmpZJSJcGjkWdwzXh/1wdxHxk1qdbTp529iSzZw+A=;
        b=py3cwGUscMDEUgsPjNBkkxujCwnCxjZd3sn8M9hwgpHfbn3ie+fyZWFvWLdvgCFS4M
         a4gZS9UQsPoWA9XrwgCkgsHlIj/PpOfAXey24jWGyB5+kCjzqsRwfCCiCA4z4n8nmm+I
         HQhN/x+nNL5I/P6XD8w1BGZ0eIgPlxvJIPSyhORQhBO7kd4Pk2O89ePIdsy7DphZbZMD
         p10hlcahaQOM/2NsnBMY/bDPqMMcgO82D1YWkN98rKBx7L4JP52XHOKZ/sxXGpJ2USoO
         fcB4IkMyHI2vLAX1jJQUI2vca1KuFlsJ+ei1CdwBFk4Gpbhbwr/am9YSJQ8761EfzaZw
         Wy6A==
X-Gm-Message-State: AOAM531a9uLKr1ITZaQY33V/CVZ/3jEiGczA/AA4NuQ4yiblK9pE+Hfw
        Kx2mIwqQt+nfTvfxjSnbnxutWA==
X-Google-Smtp-Source: ABdhPJy1eR+KY9VjvEkheIzVcqWp7XoiAxVirwoH+ntCmyxPC42Czfx3zHGSaOqSDxojIeI3efM6eQ==
X-Received: by 2002:a05:600c:29cc:: with SMTP id s12mr1724821wmd.180.1610549453390;
        Wed, 13 Jan 2021 06:50:53 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:52 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 28/31] video: fbdev: cirrusfb: Add description for 'info' and correct spelling of 'regbase'
Date:   Wed, 13 Jan 2021 14:50:06 +0000
Message-Id: <20210113145009.1272040-29-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/fbdev/cirrusfb.c:2815: warning: Function parameter or member 'info' not described in 'cirrusfb_dbg_print_regs'
 drivers/video/fbdev/cirrusfb.c:2815: warning: Function parameter or member 'regbase' not described in 'cirrusfb_dbg_print_regs'
 drivers/video/fbdev/cirrusfb.c:2815: warning: Excess function parameter 'base' description in 'cirrusfb_dbg_print_regs'
 drivers/video/fbdev/cirrusfb.c:2859: warning: Function parameter or member 'info' not described in 'cirrusfb_dbg_reg_dump'
 drivers/video/fbdev/cirrusfb.c:2859: warning: Function parameter or member 'regbase' not described in 'cirrusfb_dbg_reg_dump'
 drivers/video/fbdev/cirrusfb.c:2859: warning: Excess function parameter 'base' description in 'cirrusfb_dbg_reg_dump'

Cc: Jeff Garzik <jgarzik@pobox.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/fbdev/cirrusfb.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
index f05160fa34da9..bb2cc753c1cf5 100644
--- a/drivers/video/fbdev/cirrusfb.c
+++ b/drivers/video/fbdev/cirrusfb.c
@@ -2800,7 +2800,8 @@ static void bestclock(long freq, int *nom, int *den, int *div)
 
 /**
  * cirrusfb_dbg_print_regs
- * @base: If using newmmio, the newmmio base address, otherwise %NULL
+ * @info: frame buffer info structure
+ * @regbase: If using newmmio, the newmmio base address, otherwise %NULL
  * @reg_class: type of registers to read: %CRT, or %SEQ
  *
  * DESCRIPTION:
@@ -2847,7 +2848,8 @@ static void cirrusfb_dbg_print_regs(struct fb_info *info,
 
 /**
  * cirrusfb_dbg_reg_dump
- * @base: If using newmmio, the newmmio base address, otherwise %NULL
+ * @info: frame buffer info structure
+ * @regbase: If using newmmio, the newmmio base address, otherwise %NULL
  *
  * DESCRIPTION:
  * Dumps a list of interesting VGA and CIRRUSFB registers.  If @base is %NULL,
-- 
2.25.1

