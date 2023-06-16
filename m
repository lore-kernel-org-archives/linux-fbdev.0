Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49478EB64DA
	for <linux-fbdev@archiver.kernel.org>; Fri, 16 Jun 2023 12:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbjFPMHN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 16 Jun 2023 08:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234518AbjFPMHM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 16 Jun 2023 08:07:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDD5E2D73
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jun 2023 05:07:09 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8E77D3F16F
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jun 2023 12:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1686917228;
        bh=HXrbrNjx5wkbmZikN4dyh9skh67sgOUdUExxc/zzJTU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=C5vVY7DCWb+XWlyf/eb8f6T/8YVm+QwqG8ki5qc2Jah4kCjENpXIzvQySs9Rj8+Ec
         gvaj6b0YcuvJ77JLp9POeFUq50DZ7FX5Sax08VMH3/5ehnvhFHV/UjAr07GfiKjB0w
         LLtei/zyHGvtjjiLPgU8R2b7JUiHsJch3BXIBlZhPQGicry2p/t1QU8jI+ty1eHDzL
         ffWbJnmgYHZaVwcpAKpaQkRF0tYANx+UdIo5pYK8KvEhEBOEHqLW/yUbe9OUIFdJcY
         Vzea1orGhINbxLkDgtdDXQgMDhMLI2bX8DIvAX8N9UO2WTvowN1NUv//pTL9w9hA3m
         DH5eiboAuYqnQ==
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30c6060eb32so784191f8f.1
        for <linux-fbdev@vger.kernel.org>; Fri, 16 Jun 2023 05:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686917228; x=1689509228;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HXrbrNjx5wkbmZikN4dyh9skh67sgOUdUExxc/zzJTU=;
        b=ZdsQ+McwwV6o5H6VWYMok0Q+5oFJ3BbfpcyJHpgezLQgK1s4XaJW69qfjt8My4DgyG
         YgSKQ/6C1ZsPTahK9vNQer5qCQ+5TRk4F8t69QOitby05sn+KXzVk9o/X218Sx4XBxWq
         ZqUpzJhn73YTRwMe/7DAnTW9+VIoCPH/u9zNzev0X//I5iVKNtDuRfuLaZyC01F2frsF
         riXJKoy6LFxXlp4SGrNghDdL7v4xpNeK18z3/EpW3VLTLZBvLuyjgjluEt2X0hNsZCI2
         BEGvGiUemQN68UPA/Tw10Ph7+zDFY1cv3RCj/CEFdmX21pzvs3IJWe6apRx2ONFs0PWe
         TsEQ==
X-Gm-Message-State: AC+VfDwk4rCwg6CL9xBaWwfpfrO5tAtcH8DV0O7b3zb19RIzbiXQvlqx
        d4jxlFNercBF+dYyekzxchf9+U8jXMgsCMMgenLiUZ/2M8XaeO2wusrndszOTLiNsPqAowo7AL8
        EbNSvzR1EO8ac3jlwEJeOGYKPRFbGbSwGj/SQX4GNf2xcezQsZas=
X-Received: by 2002:adf:f30b:0:b0:311:1390:7b55 with SMTP id i11-20020adff30b000000b0031113907b55mr1318540wro.68.1686917228249;
        Fri, 16 Jun 2023 05:07:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6y5XukSe+P9vq+zfXWohqAIWdKqIQWbdE7ej4TGZZFMtoW9oJ1tfvYWN7PDP7vhBlrCWHGmQ==
X-Received: by 2002:adf:f30b:0:b0:311:1390:7b55 with SMTP id i11-20020adff30b000000b0031113907b55mr1318529wro.68.1686917227945;
        Fri, 16 Jun 2023 05:07:07 -0700 (PDT)
Received: from localhost ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id q7-20020adff947000000b0030af72bca98sm23428851wrr.103.2023.06.16.05.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jun 2023 05:07:07 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org, juerg.haefliger@canonical.com,
        u.kleine-koenig@pengutronix.de
Subject: [PATCH] fbdev: broadsheetfb: Add MODULE_FIRMWARE macro
Date:   Fri, 16 Jun 2023 14:07:05 +0200
Message-Id: <20230616120705.1030177-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The module loads firmware so add a MODULE_FIRMWARE macro to provide that
information via modinfo.

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 drivers/video/fbdev/broadsheetfb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/broadsheetfb.c b/drivers/video/fbdev/broadsheetfb.c
index b518cacbf7cd..678d182d187d 100644
--- a/drivers/video/fbdev/broadsheetfb.c
+++ b/drivers/video/fbdev/broadsheetfb.c
@@ -1223,3 +1223,5 @@ module_platform_driver(broadsheetfb_driver);
 MODULE_DESCRIPTION("fbdev driver for Broadsheet controller");
 MODULE_AUTHOR("Jaya Kumar");
 MODULE_LICENSE("GPL");
+
+MODULE_FIRMWARE("broadsheet.wbf");
-- 
2.37.2

