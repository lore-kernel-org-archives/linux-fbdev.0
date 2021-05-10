Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D944C433B4
	for <linux-fbdev@archiver.kernel.org>; Mon, 10 May 2021 10:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8FE613AF
	for <linux-fbdev@archiver.kernel.org>; Mon, 10 May 2021 10:13:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbhEJKOe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 10 May 2021 06:14:34 -0400
Received: from fgw20-7.mail.saunalahti.fi ([62.142.5.81]:31614 "EHLO
        fgw20-7.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230158AbhEJKOd (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 10 May 2021 06:14:33 -0400
X-Greylist: delayed 964 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 May 2021 06:14:33 EDT
Received: from localhost (88-115-248-186.elisa-laajakaista.fi [88.115.248.186])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id 1b869fa5-b176-11eb-ba24-005056bd6ce9;
        Mon, 10 May 2021 12:57:20 +0300 (EEST)
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Brian Masney <masneyb@onstation.org>,
        Dan Murphy <dmurphy@ti.com>
Subject: [PATCH v1 1/1] backlight: lm3630a_bl: Put fwnode in error case during ->probe()
Date:   Mon, 10 May 2021 12:57:16 +0300
Message-Id: <20210510095716.3302910-1-andy.shevchenko@gmail.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

device_for_each_child_node() bumps a reference counting of a returned variable.
We have to balance it whenever we return to the caller.

Fixes: 8fbce8efe15cd ("backlight: lm3630a: Add firmware node support")
Cc: Brian Masney <masneyb@onstation.org>
Cc: Dan Murphy <dmurphy@ti.com>
Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/video/backlight/lm3630a_bl.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index e88a2b0e5904..662029d6a3dc 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -482,8 +482,10 @@ static int lm3630a_parse_node(struct lm3630a_chip *pchip,
 
 	device_for_each_child_node(pchip->dev, node) {
 		ret = lm3630a_parse_bank(pdata, node, &seen_led_sources);
-		if (ret)
+		if (ret) {
+			fwnode_handle_put(node);
 			return ret;
+		}
 	}
 
 	return ret;
-- 
2.31.1

