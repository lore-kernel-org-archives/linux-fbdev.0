Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C99C4332F
	for <linux-fbdev@archiver.kernel.org>; Tue, 18 Oct 2022 07:51:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiJRHvZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 18 Oct 2022 03:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJRHvY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 18 Oct 2022 03:51:24 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A330F79;
        Tue, 18 Oct 2022 00:51:23 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id o21so10657979ple.5;
        Tue, 18 Oct 2022 00:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vl1/9ecW7HlTpZtLd+FURiia+/oZgLLP0reQXEaxp9o=;
        b=XwJwK3PJkvykkn0S5pGaZYkikEofEiVjJheRW4oOoKev2JE3DDM3XariJP/edXDo81
         ZkdksitDaNko4Nm7vlh8MzlIJaQ9t3QfQdni+SaYCed4k1QIVsl5GRfZYfuTiQk8Lc6r
         FUOsM4C92LPDmilPmf+5KPJulsnGAnER5cJl/WfocCGF/EeIQdjaFZ2+zdN5sedq18kr
         mD6w4HhzHgH4j/7tHj2LYCdZ5cHyCoGkvwa8np3mPpejWuwsAQs2DJ7qeferWZfwcbGF
         79+w+myDh7BiacNkQpvUp8fmyOLVFV7GqyQ2jn/Q/uwT0Tk8PwMHbzAXzxwFWyZhZSPN
         R9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vl1/9ecW7HlTpZtLd+FURiia+/oZgLLP0reQXEaxp9o=;
        b=0yVy7jitAq6QxDeSBdB5pv8rLnB2vRSOJRw0CDb64l6rEtOYNxzph0zsvlJgn1/S7w
         8pLPZyrcCwOIPMeVZjyQe8q1LRa4pzO0WzpV+IC2y9PPVRdn9qhnxkScMNtlEwjn6S+t
         +RK4TIRsRMBn9SaPlpUI/6M+CDeN1wcfxb4nOLPaFQKCSqvwEr7blba56XrDGwnEi8Fi
         JJFd6RXowTOtLQbkOpBE2clwKd67VLL069Ok5xFLafVUqdfWx8K/2GSIrWKD0hrjSWmh
         i0zn5ktYd6yMpeIkF3GidgbcAkUNwtO8wMks+nmMXcW48ZQKrMHHEbZyN8fO/LnP+bKa
         hnCg==
X-Gm-Message-State: ACrzQf1O/cUxWbuyPtnvOhihyCWryLPRSK7fIdqClSnfdO9Mr4KVUOxA
        QxfWj/pt3d/gaZxzKXYofF4=
X-Google-Smtp-Source: AMsMyM7phLraWst4ozJkYCzYw63EtiFbS/zuVQszTlq88IO4Xq/7s4KAOuCblGjNUCz26cSQVTrpaQ==
X-Received: by 2002:a17:902:d4d1:b0:185:52c4:f4c6 with SMTP id o17-20020a170902d4d100b0018552c4f4c6mr1794027plg.154.1666079482728;
        Tue, 18 Oct 2022 00:51:22 -0700 (PDT)
Received: from carlis-virtual-machine.localdomain ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id y16-20020a17090264d000b00176e6f553efsm7901882pli.84.2022.10.18.00.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 00:51:22 -0700 (PDT)
From:   Xuezhi Zhang <zhangxuezhi3@gmail.com>
To:     zhangxuezhi1@coolpad.com, deller@gmx.de, jiasheng@iscas.ac.cn
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: gbefb: convert sysfs snprintf to sysfs_emit
Date:   Tue, 18 Oct 2022 15:51:18 +0800
Message-Id: <20221018075118.922212-1-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Xuezhi Zhang <zhangxuezhi1@coolpad.com>

Follow the advice of the Documentation/filesystems/sysfs.rst
and show() should only use sysfs_emit() or sysfs_emit_at()
when formatting the value to be returned to user space.

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/video/fbdev/gbefb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index 1582c718329c..000b4aa44241 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -1060,14 +1060,14 @@ static const struct fb_ops gbefb_ops = {
 
 static ssize_t gbefb_show_memsize(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%u\n", gbe_mem_size);
+	return sysfs_emit(buf, "%u\n", gbe_mem_size);
 }
 
 static DEVICE_ATTR(size, S_IRUGO, gbefb_show_memsize, NULL);
 
 static ssize_t gbefb_show_rev(struct device *device, struct device_attribute *attr, char *buf)
 {
-	return snprintf(buf, PAGE_SIZE, "%d\n", gbe_revision);
+	return sysfs_emit(buf, "%d\n", gbe_revision);
 }
 
 static DEVICE_ATTR(revision, S_IRUGO, gbefb_show_rev, NULL);
-- 
2.25.1

