Return-Path: <SRS0=zOMX=EF=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4197DC4742C
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Oct 2020 00:30:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB66D20756
	for <linux-fbdev@archiver.kernel.org>; Fri, 30 Oct 2020 00:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="leJqdVBa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgJ3Aaz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 29 Oct 2020 20:30:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgJ3Aay (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 29 Oct 2020 20:30:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF11C0613CF
        for <linux-fbdev@vger.kernel.org>; Thu, 29 Oct 2020 17:30:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id c21so5125020ljj.0
        for <linux-fbdev@vger.kernel.org>; Thu, 29 Oct 2020 17:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcU6T4hccd5cIgxH69lq3LU3dv7XKAqa7a9Wy3kb2Dc=;
        b=leJqdVBahsfYuyVGnp9yBWGadv/E8WB9Ig4JGQiNyu3DnPfed0IwIVmf2uEAdtpuMB
         ICLXiiowdZVfibEEsDMCqRbfIl91S6AvQAV/+A5ydpcsVu+2/dl4vtIzGJRXDePNuGHU
         JPR7fquhT3lhSKFh61nxSr9dt9pBUBgf8JFbGPQkM4bGwd7ibRTpTjm9lhZvGS0HglWz
         qF8HP0VrVTBR8H0UY4K23h2f9qLhZe2BArWsOgoXQviCEeNcpqnmracXw+EZnSOGbP8t
         sa+c265v/OqRU1CmqKElqEBP86I09lB4vcMkMTblkYkyRH9ZwJkQPaJWCrbniyFLXYIz
         Uz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WcU6T4hccd5cIgxH69lq3LU3dv7XKAqa7a9Wy3kb2Dc=;
        b=Qb3g43g40UD22o4fncj6Q9KsXBdoIrRV5To0n76oZ2CxemSR99FI4Lkpaq98qITHUm
         NmTC4rHuXP2Vjoc5B72C1arY7vto3She6O0lNr5UF5TJMANc0l29sHgFx2IZ+Y0NkNT8
         ehiIiqMYbaFbzyLdIGwwbSDxjU6FkSreEvELdQduqGy3gbmpZ6yR0I4NZKxpAg/21UMD
         Qdyhe79k/Q127uuntKTsuQuS0Ef27P5wSarRyWOahKoYlZvD1vacUFIiOhWdG9iRbb3Q
         kJw1Kcqjd3KY3YrfA1Lna1fMYavKr4LdkUceetIkjQQ88qv6e/Vmu2MSgR43Tw4Xl+sH
         y/xA==
X-Gm-Message-State: AOAM533d4Bz8FMm7gwoKA+0HURfiFr+7N+TSS1COkBnjiFEXlpZeYC0y
        DOU1BF7j2yBT+ywQ3DW2DXbqKh9ugUKMLhIA
X-Google-Smtp-Source: ABdhPJysATEz/+0sEJLgj3DA4+hz7bygNlLwNnEkTdEngOO0I/TIZuUL4RDZe3S4Qiv5MhxkgBI03A==
X-Received: by 2002:a2e:8049:: with SMTP id p9mr3121422ljg.9.1604017852754;
        Thu, 29 Oct 2020 17:30:52 -0700 (PDT)
Received: from localhost.localdomain (c-92d7225c.014-348-6c756e10.bbcust.telenor.se. [92.34.215.146])
        by smtp.gmail.com with ESMTPSA id j10sm497336ljb.93.2020.10.29.17.30.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 17:30:52 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH] fbdev/sh_mobile: Drop unused include
Date:   Fri, 30 Oct 2020 01:28:50 +0100
Message-Id: <20201030002850.6495-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The driver includes <linux/gpio.h> but doesn't use any symbols
from this file.

Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index c1043420dbd3..027c74d7c010 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -16,7 +16,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
 #include <linux/fbcon.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
-- 
2.26.2

