Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC55C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 21:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8D61440
	for <linux-fbdev@archiver.kernel.org>; Fri, 14 May 2021 21:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbhENVfT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 14 May 2021 17:35:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:56462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhENVfS (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 14 May 2021 17:35:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3D10E6143F;
        Fri, 14 May 2021 21:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621028046;
        bh=hJes5fVwFMyBeanoe97q1M/H0pXkUh5gZ9KDWMORWxE=;
        h=From:To:Cc:Subject:Date:From;
        b=cU1uvUz4dnLZFAGf0hBvsDMANh2A6Nn29EdaIlH2ApxigmLn5llJ2MOYkOge9CLiM
         DktbmKF0dGNg+xjxBwE/9nP4x3sxxyLiC2UoS6JsyewiIlBeIAQEDIDTf6RHkWbBrn
         gxiY3BwLVI7/kd8MdCaFARy4NR29rIYihzGAG3DXSUL/DXqhSdGvvOdbEKyvVL3zKh
         jq1Jh5+G5gRKCeYwqRHj562jd6FOOyEBq9GUgsD8h3n+S6Nwl3nUQp+boAdzMOwwZq
         WFqjZmp+YEqZs0gmwyzPn+34UkaOLtDznl44dXJprpQ/g5+r4B7io7jbWpAzSFMkJh
         fSd9/V+anuz3g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: matrox: use modern module_init()
Date:   Fri, 14 May 2021 23:33:05 +0200
Message-Id: <20210514213316.635070-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is one of the last drivers with a global init_module() function
instead of the modern module_init() annotation. Convert it over.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/matrox/matroxfb_base.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 4325bf7f388c..5c82611e93d9 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -2486,8 +2486,6 @@ static int __init matroxfb_init(void)
 	return err;
 }
 
-module_init(matroxfb_init);
-
 #else
 
 /* *************************** init module code **************************** */
@@ -2572,7 +2570,7 @@ module_param_named(cmode, default_cmode, int, 0);
 MODULE_PARM_DESC(cmode, "Specify the video depth that should be used (8bit default)");
 #endif
 
-int __init init_module(void){
+static int __init matroxfb_init(void){
 
 	DBG(__func__)
 
@@ -2603,6 +2601,7 @@ int __init init_module(void){
 }
 #endif	/* MODULE */
 
+module_init(matroxfb_init);
 module_exit(matrox_done);
 EXPORT_SYMBOL(matroxfb_register_driver);
 EXPORT_SYMBOL(matroxfb_unregister_driver);
-- 
2.29.2

