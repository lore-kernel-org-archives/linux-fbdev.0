Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC32C07E95
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Jul 2021 12:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B8346128D
	for <linux-fbdev@archiver.kernel.org>; Tue, 13 Jul 2021 12:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhGMMyR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 13 Jul 2021 08:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236283AbhGMMyP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 13 Jul 2021 08:54:15 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC98C0613DD;
        Tue, 13 Jul 2021 05:51:25 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id k20so14549192pgg.7;
        Tue, 13 Jul 2021 05:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=L6Z19cM06hJr3254lNoc8rFS2DcnQVnOHZzVU5oJkdY=;
        b=RycI6eIu6txifUyYNMh21Z91nG+cHEG9+nXcu0OFLcnfvuHYaTD4zWzprYyZhxfLIR
         +pPn37tSl1Wh1qxt0RlAIJW8O3XbkUw6PvWe6s8yaClJ3wj3Ru+5cPiW/pB7oXDLkVe1
         JKg+YvTq9xkOjA3p+6zeapn+LsiAvX3AvKrlTNUWE+xlKntq44HkLyoDkj8+o3RtIAzK
         t0SKHaWLfohe1KlHJYlnVfolun8NDY2Ww5vLZdQHaesIiUUHRm0/6JWeklCnSoqXHyls
         Y0DO52xuEFBmYZ8y7etd3TPL+yf/IcJN8YG690uzO7hO6clDVcNk1zROkgIuQ3/OR1VH
         6lgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=L6Z19cM06hJr3254lNoc8rFS2DcnQVnOHZzVU5oJkdY=;
        b=bSS4ew5Myx6R2Oh/oNxowMXxbtKclnMb1oIf4rSy8j78RNC9S2BFBKOl9CAEVFr1jK
         kvD4IgL1pDyOKo7gbTEEoY+K3t0uZ8MZTKQZFIsNf37rLovk+vV9+4/aTuDS3Zamg/0v
         KNwr5Xuisi1KBsLBQtINY/T3Vm3J+HVuF28FsvQieiLOpkoUJoajRUz90NVru7ztNuE7
         OL2wZjciGanJ96rocxp+Whs5OivPlCB5eUnoC4pczZ/rmz//cdBsufWfMAcn4gU6pNMS
         fiy9aMw0tlB6AYlRkfl60FlffJnQ7cjhAOmO3jdL/Idzkwr6uFbsiRax/azy9QaxtvVA
         b9Bw==
X-Gm-Message-State: AOAM532K8zIZsUpg9XUA+cDzyE2B+DRmTz0EMveoKmxI57sWmkPraMGn
        lQDYL7+i3zbzRci0VmuVhg==
X-Google-Smtp-Source: ABdhPJw0Xj+6mEG6jN2omlWduAbKJ0fPWcMbtZ3P8d9+01QQakRw+AxE4WM7ZSN6duYbgegeVJnT1Q==
X-Received: by 2002:a05:6a00:2:b029:32e:3ef0:770a with SMTP id h2-20020a056a000002b029032e3ef0770amr1783208pfk.8.1626180684635;
        Tue, 13 Jul 2021 05:51:24 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id q12sm19617515pfj.220.2021.07.13.05.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Jul 2021 05:51:24 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        security@kernel.org, Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] video: fbdev: kyrofb: fix a DoS bug by restricting user input
Date:   Tue, 13 Jul 2021 12:51:14 +0000
Message-Id: <1626180674-25195-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The user can pass in any value to the driver through the 'ioctl'
interface. The driver dost not check, which may cause DoS bugs.

Fix this by checking if the divisor is 0

The following log reveals it:

divide error: 0000 [#1] PREEMPT SMP KASAN PTI
RIP: 0010:SetOverlayViewPort+0x133/0x5f0 drivers/video/fbdev/kyro/STG4000OverlayDevice.c:476
Call Trace:
 kyro_dev_overlay_viewport_set drivers/video/fbdev/kyro/fbdev.c:378 [inline]
 kyrofb_ioctl+0x2eb/0x330 drivers/video/fbdev/kyro/fbdev.c:603
 do_fb_ioctl+0x1f3/0x700 drivers/video/fbdev/core/fbmem.c:1171
 fb_ioctl+0xeb/0x130 drivers/video/fbdev/core/fbmem.c:1185
 vfs_ioctl fs/ioctl.c:48 [inline]
 __do_sys_ioctl fs/ioctl.c:753 [inline]
 __se_sys_ioctl fs/ioctl.c:739 [inline]
 __x64_sys_ioctl+0x19b/0x220 fs/ioctl.c:739
 do_syscall_64+0x32/0x80 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/video/fbdev/kyro/STG4000OverlayDevice.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
index 9fde0e3b69ec..29d692fe5e75 100644
--- a/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000OverlayDevice.c
@@ -407,6 +407,9 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		ulVertDecFactor = 1;
 	}
 
+	if ((ulDest + 1) == 0)
+		return -EINVAL;
+
 	ulDacYScale = ((ulSrc - 1) * 2048) / (ulDest + 1);
 
 	tmp = STG_READ_REG(DACOverlayVtDec);	/* Decimation */
@@ -471,6 +474,9 @@ int SetOverlayViewPort(volatile STG4000REG __iomem *pSTGReg,
 		 */
 		ulScaleLeft = ulSrcLeft;
 
+		if ((ulRight - ulLeft + 2) == 0)
+			return -EINVAL;
+
 		/* shift fxscale until it is in the range of the scaler */
 		ulhDecim = 0;
 		ulScale = (((ulSrcRight - ulSrcLeft) - 1) << (11 - ulhDecim)) / (ulRight - ulLeft + 2);
-- 
2.17.6

