Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15670C433E6
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Feb 2021 00:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D42D564F21
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Feb 2021 00:06:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhBZAGa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 25 Feb 2021 19:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbhBZAGa (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 25 Feb 2021 19:06:30 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE10FC061574;
        Thu, 25 Feb 2021 16:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=24dyXhbUb6BL7Gvc/cK7SPB9p+BywOZYcYYdftrrIeU=; b=fRv0oPAPX5XbjEKm5/EQWt1L+A
        U5Lr/DpfM3BaNtbQPUMjeNsLZFBoggvQzn4Ry00EMtcjAY7ouP0dqwIGapb70DNkhOtjMOpeSCM0X
        q3xoXoDecVJcjJiHimtshgtcPMTE6gns2PHaKI+4YSvO8jEOGEi2lcfbIpL9aTQ2xE2PY62SUcI0f
        Yh8VPvCejcEAiMmTw42bYisAMa6r+PNKO3Wa/PJBGH8oiB1RPbeXvXP3IWs5sWIBh1pGxCVaIEHgQ
        yZv+oyydwkCfo4rPtb1q5W8U4Hv0GvFmAS7Ol0xvE4j2KrQP5hTaa3EaNvol9DzOikGWhcOZkxYQQ
        c/oXIatA==;
Received: from [2601:1c0:6280:3f0::3ba4] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFQdc-0006Ha-H8; Fri, 26 Feb 2021 00:05:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH -next] fbdev: atyfb: use LCD management functions for PPC_PMAC also
Date:   Thu, 25 Feb 2021 16:05:37 -0800
Message-Id: <20210226000537.8674-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Include PPC_PMAC in the configs that use aty_ld_lcd() and
aty_st_lcd() implementations so that the PM code may work
correctly for PPC_PMAC.

Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
Daniel- We also need this patch:
https://lore.kernel.org/dri-devel/20210224215528.822-1-rdunlap@infradead.org/
to fix a kernel test robot build error.

 drivers/video/fbdev/aty/atyfb_base.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
+++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
@@ -132,8 +132,7 @@
 #define PRINTKI(fmt, args...)	printk(KERN_INFO "atyfb: " fmt, ## args)
 #define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
 
-#if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
-defined(CONFIG_FB_ATY_BACKLIGHT)
+#if defined(CONFIG_PPC_PMAC)
 static const u32 lt_lcd_regs[] = {
 	CNFG_PANEL_LG,
 	LCD_GEN_CNTL_LG,
@@ -175,8 +174,7 @@ u32 aty_ld_lcd(int index, const struct a
 		return aty_ld_le32(LCD_DATA, par);
 	}
 }
-#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
-	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
+#else /* defined(CONFIG_PPC_PMAC) */
 void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 { }
 
@@ -184,7 +182,7 @@ u32 aty_ld_lcd(int index, const struct a
 {
 	return 0;
 }
-#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
+#endif /* defined(CONFIG_PPC_PMAC) */
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 /*
