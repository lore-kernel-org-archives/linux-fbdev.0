Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83803C433C1
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 14:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54825619D5
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 14:10:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbhCZOJe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 Mar 2021 10:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbhCZOJS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 Mar 2021 10:09:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F985C0613AA;
        Fri, 26 Mar 2021 07:09:18 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl21-20020a17090af695b02900c61ac0f0e9so5642812pjb.1;
        Fri, 26 Mar 2021 07:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=h+bhUb5pCuEYh025FUBqhTIp//Tbcm99mGV1EArYpWE=;
        b=Cd+G377/rdX6Bw06AG5m11TwNuzgPRsnhn0+penE/Q5ZwFX7VD6eQf1frs4G31+CAH
         aGcCei6VpcaqQrqfoTjQ3sRVJqsQTYubVfYrkgV9fkuLO4tKbAdKQ4mmxZaqy9bUAWFg
         a0Mita0wtS6ziHMdkrt3EGQd9g1AXg4QKVCxQN7S0DqLqpyNorqUglvSR08D7CuWpVdl
         E79cEr0A8aTQfxV9NRgseeg288n1PBdz5L3+58dj1LnD1jFQrgdaxCa9+yvS+zFSQNzQ
         Sx1zQ9iXDw7+Ory+S+3p3KHJ7ixhC5N9r3uN3Nl0Z6E/aNsXjNzeRDdZ9SuOUDHbjk3j
         N7ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=h+bhUb5pCuEYh025FUBqhTIp//Tbcm99mGV1EArYpWE=;
        b=EzenEeGXtuAbSKPCODZwX+spOMH2MGhRkmX9eMm4FlkNb1kwQXcWe6rroAp4hSzdwY
         WnF69ylVvRcHWrANFITXeIxp0MA/HODIT0jvfmU6M6YQ/rBsK4J19cnep7B8yWhPK9Ag
         5o2QrZnT+RF/TqK8wtMFJZW0DkxvOJu9BZTeXzJbOdquaJRbzCgnms7Nkq5QhOM5mgKN
         26hrf+jTww2x0XFpCnKll3D0s7YSei8mWyKpys44iLioHGIReO1ZPZrxmtHxZQ4ssZhc
         3yekTOq9VvmudGZFSb5KUTh1dcLg3ujPwmR50FdfQ6kiXRU7fwmfjdB6++8iMjPTm5or
         BWtA==
X-Gm-Message-State: AOAM533s2E10dNQIAC4lu/VjaMzkF8HqUZPlKsnFPknki/YM4syNdKUp
        +9AZ3PKyjS9IGqljVsoz6b2InfAfSBirAgGl
X-Google-Smtp-Source: ABdhPJxszqiKf4suKiwiqLf+J7gikvo+wVRhKUs8+Qga0N4et1pAwlcxfGUpK7kIzTFACqwWz1cjeg==
X-Received: by 2002:a17:902:7792:b029:e6:caba:f836 with SMTP id o18-20020a1709027792b02900e6cabaf836mr15272990pll.41.1616767757973;
        Fri, 26 Mar 2021 07:09:17 -0700 (PDT)
Received: from bf-rmsz-10.ccdomain.com ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id mr5sm8923717pjb.53.2021.03.26.07.09.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Mar 2021 07:09:17 -0700 (PDT)
From:   Carlis <zhangxuezhi3@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: fbtft: change '16 bit' to '16-bit'
Date:   Fri, 26 Mar 2021 22:09:30 +0800
Message-Id: <1616767770-70063-1-git-send-email-zhangxuezhi3@gmail.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: "carlis.zhang_cp" <zhangxuezhi1@yulong.com>

Change '16 bit' to '16-bit' for a same style.

Signed-off-by: carlis.zhang_cp <zhangxuezhi1@yulong.com>
---
 drivers/staging/fbtft/fbtft-bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
index 63c65dd..7040131 100644
--- a/drivers/staging/fbtft/fbtft-bus.c
+++ b/drivers/staging/fbtft/fbtft-bus.c
@@ -117,7 +117,7 @@ void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
  *
  *****************************************************************************/
 
-/* 16 bit pixel over 8-bit databus */
+/* 16-bit pixel over 8-bit databus */
 int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 {
 	u16 *vmem16;
@@ -172,7 +172,7 @@ int fbtft_write_vmem16_bus8(struct fbtft_par *par, size_t offset, size_t len)
 }
 EXPORT_SYMBOL(fbtft_write_vmem16_bus8);
 
-/* 16 bit pixel over 9-bit SPI bus: dc + high byte, dc + low byte */
+/* 16-bit pixel over 9-bit SPI bus: dc + high byte, dc + low byte */
 int fbtft_write_vmem16_bus9(struct fbtft_par *par, size_t offset, size_t len)
 {
 	u8 *vmem8;
@@ -228,7 +228,7 @@ int fbtft_write_vmem8_bus8(struct fbtft_par *par, size_t offset, size_t len)
 }
 EXPORT_SYMBOL(fbtft_write_vmem8_bus8);
 
-/* 16 bit pixel over 16-bit databus */
+/* 16-bit pixel over 16-bit databus */
 int fbtft_write_vmem16_bus16(struct fbtft_par *par, size_t offset, size_t len)
 {
 	u16 *vmem16;
-- 
1.9.1

