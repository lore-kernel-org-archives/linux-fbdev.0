Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DC9ECAAD8
	for <linux-fbdev@archiver.kernel.org>; Wed, 14 Sep 2022 09:15:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiINJPZ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 14 Sep 2022 05:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiINJNr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 14 Sep 2022 05:13:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E585F99C;
        Wed, 14 Sep 2022 02:06:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71FBE619EB;
        Wed, 14 Sep 2022 09:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7FEC433D6;
        Wed, 14 Sep 2022 09:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663146372;
        bh=jQHFSnENIQUD3uKsd0Jp00wrCKEODhqOZ+8EumLlAH8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a0vKFL3hTLa8V6gdnbWM/eezfKaYS7Fqu6iQhifPHU8i92gK/v/pxXgYkpRcEUfCn
         Kft19AbMWbo3tZSOYJnH5h8HzifZV1nwApEmq0l6coikdVa+VnbHInZYGT3V9uuk2W
         F9kaagzYxCUuj4YPPKyFZC1EVLfFsQnH4uddTzugF1KWQioFJbVGaEEHT7MMeiP/8F
         nDsXFKKL84S9o/FlrUZZOIbRRHFmy3omjl8OLE+vpmXSvdo+Rp6/NOtOLhMPkp2Rkp
         anIq+ZUyfrb9HH2VzSGyB2jd13S9//JxlalC5cdNSyrQV06soPRgSfG2fOeh6QuZGD
         EmmZjhGmC5jqQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hyunwoo Kim <imv4bel@gmail.com>, Helge Deller <deller@gmx.de>,
        Sasha Levin <sashal@kernel.org>, yangyingliang@huawei.com,
        cai.huoqing@linux.dev, yang.lee@linux.alibaba.com,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.9 07/13] video: fbdev: pxa3xx-gcu: Fix integer overflow in pxa3xx_gcu_write
Date:   Wed, 14 Sep 2022 05:05:34 -0400
Message-Id: <20220914090540.471725-7-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220914090540.471725-1-sashal@kernel.org>
References: <20220914090540.471725-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Hyunwoo Kim <imv4bel@gmail.com>

[ Upstream commit a09d2d00af53b43c6f11e6ab3cb58443c2cac8a7 ]

In pxa3xx_gcu_write, a count parameter of type size_t is passed to words of
type int.  Then, copy_from_user() may cause a heap overflow because it is used
as the third argument of copy_from_user().

Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/pxa3xx-gcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/pxa3xx-gcu.c b/drivers/video/fbdev/pxa3xx-gcu.c
index 184773b6b9e4f..2cca4b763d8dc 100644
--- a/drivers/video/fbdev/pxa3xx-gcu.c
+++ b/drivers/video/fbdev/pxa3xx-gcu.c
@@ -391,7 +391,7 @@ pxa3xx_gcu_write(struct file *file, const char *buff,
 	struct pxa3xx_gcu_batch	*buffer;
 	struct pxa3xx_gcu_priv *priv = to_pxa3xx_gcu_priv(file);
 
-	int words = count / 4;
+	size_t words = count / 4;
 
 	/* Does not need to be atomic. There's a lock in user space,
 	 * but anyhow, this is just for statistics. */
-- 
2.35.1

