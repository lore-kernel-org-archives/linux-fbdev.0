Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05125C433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5C1123619
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 14:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbhAMOvC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 09:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbhAMOvB (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 09:51:01 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BADAC0617A3
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:18 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id t30so2433904wrb.0
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Jan 2021 06:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9f2BPaI0FPEfwHACkMCkRxYDyaBt02TKR4D8xELwApI=;
        b=zc9ZOpEUI+Nh6Qla1WDfrb2vnRL2q84hQM50XEQXQr0xU371apuDwreUQOZKKSgAr5
         g7a1pROIkw2JAlYrfbUiig2HWLqwWHy8HZ/XWWBHtiDNKwj55UxEgroLjJuCBw18hlHe
         92MAeh9s6TSYlS6N3UHBcggv18NhVPSGxCug7FAilAYfafpZsRbkQDlYTKiORivlccUP
         9LS1k+4OMMbCziBfn3XobchtVgfVFJZSPwFyAo4AnK1qxUYR+KRpOnUOlfLckY0T7SBh
         WIy1YBvftA/oJxDxlPln0TX3wEE3MMUxIU12tVxKSgY+5mviYsZit9GALu0OnFxLsu+0
         HhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9f2BPaI0FPEfwHACkMCkRxYDyaBt02TKR4D8xELwApI=;
        b=bGkb9cyLc+qT7CkQp2K1CbobeU7S0oYg2HZXTIDJLQwM54yv/WPF1i7PNmtVyIG6+g
         WupG9vUKoMVK9BeStwqIhiq1aZw7zpjkGA6F+ciCXQ/yXAseA6HJHjGwcqbLERCAEA/O
         GD+MiVg35fWv1gPswpQOqtQPO69J741KqbFVJlSq6O61i7uZRGQOChlnc9nuRyXgzL6l
         iBUDbpxHIqlmlYDobEdZv8fS/medmbHwsVIBrS0EZiocT6leQPWG17hTvXnNg4n4vH2p
         DK5OZjWFwh9G9SoKBNY08LCohigWjsCOURGd1CSsDXGG6G807VxDcjyNF4UMPIP+a07C
         Se0g==
X-Gm-Message-State: AOAM533zzNsUDkqQ6Jn2tqk9wNRUSnYhPl2BPCp/0w+nvhfSuv3FGg4j
        2PJhWrTQpHRKdtSO+6Nhzz3A3g==
X-Google-Smtp-Source: ABdhPJzvNk0my33Gw7zgd1XA3cpG4wONGFNN2ELceKXzyI59SQd9sR/5sbIBr/pV5XoFHhHHEN2b3g==
X-Received: by 2002:adf:f4d0:: with SMTP id h16mr3060914wrp.30.1610549416231;
        Wed, 13 Jan 2021 06:50:16 -0800 (PST)
Received: from dell.default ([91.110.221.229])
        by smtp.gmail.com with ESMTPSA id t188sm3273433wmf.9.2021.01.13.06.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 06:50:15 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH 02/31] video: of_display_timing: Provide missing description for 'dt'
Date:   Wed, 13 Jan 2021 14:49:40 +0000
Message-Id: <20210113145009.1272040-3-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/video/of_display_timing.c:58: warning: Function parameter or member 'dt' not described in 'of_parse_display_timing'

Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/video/of_display_timing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
index abc9ada798ee8..9f21f7dc85292 100644
--- a/drivers/video/of_display_timing.c
+++ b/drivers/video/of_display_timing.c
@@ -52,6 +52,7 @@ static int parse_timing_property(const struct device_node *np, const char *name,
 /**
  * of_parse_display_timing - parse display_timing entry from device_node
  * @np: device_node with the properties
+ * @dt: Display timing information
  **/
 static int of_parse_display_timing(const struct device_node *np,
 		struct display_timing *dt)
-- 
2.25.1

