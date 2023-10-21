Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEF8C001E0
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 Oct 2023 07:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjJUHBQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 21 Oct 2023 03:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjJUHBP (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 21 Oct 2023 03:01:15 -0400
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Oct 2023 00:01:13 PDT
Received: from smtp.smtpout.orange.fr (smtp-13.smtpout.orange.fr [80.12.242.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B880D6E
        for <linux-fbdev@vger.kernel.org>; Sat, 21 Oct 2023 00:01:13 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id u5reqyZLtd4Wtu5rfqqNO4; Sat, 21 Oct 2023 08:53:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1697871220;
        bh=q+6YiMf4FjJqpY2woNDtEvfJ1SZWEDzhFtZ1+ypv620=;
        h=From:To:Cc:Subject:Date;
        b=EysZyvuNjvivikTZz1HV6uPNxwar1FxYeIW3ZPl6RB94dHadJkAhx/cMu/4K4ad/V
         N1VEKRFwKHTh8ZUL5HRXQptbuvrhFE3V+gUP/lZ+2mpFJoKjKpgpcB9uEdNttXL8dW
         FEYGs7+OdgBqoZ86yNQ6UFX0tz2V0Lky44jfLSnysdNY4nth95725mV4TlqLVEiToW
         fvX6Z+teSxGjh1Tb5asFg2GSfGrbpwongRfMXRnXjDc4vAWv8GbbK2jydBIPoNdnTe
         0vl8DSe2v/n3hiR7lqTtgo/V7vctb5Qjlzc55Nkmgqm66B2/+EDwU8wGR/38okyH8y
         hSOtX7pWH5BaA==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 21 Oct 2023 08:53:40 +0200
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] fbdev/offb: Simplify offb_init_fb()
Date:   Sat, 21 Oct 2023 08:53:37 +0200
Message-Id: <1c94c99117617c1a844f6551b7bca27f23c5f0c8.1697871190.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Turn a strcpy()+strncat()+'\0' into an equivalent snprintf().

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is *not* even compile tested because cross-compiling leads to
some errors like on my machine:
   cc1: error: cannot load plugin ./scripts/gcc-plugins/randomize_layout_plugin.so: ./scripts/gcc-plugins/randomize_layout_plugin.so: undefined symbol: _ZNK6frange6acceptERK14vrange_visitor

So review with care!
---
 drivers/video/fbdev/offb.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/offb.c b/drivers/video/fbdev/offb.c
index dcb1b81d35db..b421b46d88ef 100644
--- a/drivers/video/fbdev/offb.c
+++ b/drivers/video/fbdev/offb.c
@@ -423,11 +423,9 @@ static void offb_init_fb(struct platform_device *parent, const char *name,
 	fix = &info->fix;
 	var = &info->var;
 
-	if (name) {
-		strcpy(fix->id, "OFfb ");
-		strncat(fix->id, name, sizeof(fix->id) - sizeof("OFfb "));
-		fix->id[sizeof(fix->id) - 1] = '\0';
-	} else
+	if (name)
+		snprintf(fix->id, sizeof(fix->id), "OFfb %s", name);
+	else
 		snprintf(fix->id, sizeof(fix->id), "OFfb %pOFn", dp);
 
 
-- 
2.34.1

