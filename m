Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7C5C433E0
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Feb 2021 17:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CCF664E33
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Feb 2021 17:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhBZRa6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 Feb 2021 12:30:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbhBZRa5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 Feb 2021 12:30:57 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489D4C061574;
        Fri, 26 Feb 2021 09:30:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=cUpjOvqMFT82ciPpS3h3o5kw6NB7VHxKS03NBNLEB6M=; b=UaiPO/LgLQiER5zhsEULNyTVN+
        TmwnBO4Z/tFKMrmlKMmPfy3CB92WJPrWm5gY5caTqf6W5/a0GCMl3c9P6N7gNrEgS05wSFMbNwT5f
        2Rd6M7cLbjEKvtQK6mlk31Dm2p5NIlLYHD5f/LhIBPuKcviX1awZ5SCECfRzjo4T0j/hIHpa9CgLb
        kwu6NBNJ5ZyuQO9/JJTJ/0fdO6GEHHhDV+G5pb1PHkL5LH0J5X8VLh82czZzVss4OjsPZDJ2k1Jv5
        8yqDLkvGm/0/UmRwr4IA391AoLwSSjO8i+0uahbG8XMPGSmh+Gvlu6cMV0/+P3FBh2sqVx3IWR+pP
        CkJVfmaQ==;
Received: from [2601:1c0:6280:3f0::3ba4] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lFgwP-0008Ov-Tg; Fri, 26 Feb 2021 17:30:14 +0000
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
Subject: [PATCH -next v2] fbdev: atyfb: use LCD management functions for PPC_PMAC also
Date:   Fri, 26 Feb 2021 09:30:08 -0800
Message-Id: <20210226173008.18236-1-rdunlap@infradead.org>
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

v2: send the correct version of this patch (thanks, Ville)

 drivers/video/fbdev/aty/atyfb_base.c |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
+++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
@@ -133,7 +133,7 @@
 #define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
 
 #if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
-defined(CONFIG_FB_ATY_BACKLIGHT)
+defined(CONFIG_FB_ATY_BACKLIGHT) || defined (CONFIG_PPC_PMAC)
 static const u32 lt_lcd_regs[] = {
 	CNFG_PANEL_LG,
 	LCD_GEN_CNTL_LG,
@@ -175,8 +175,8 @@ u32 aty_ld_lcd(int index, const struct a
 		return aty_ld_le32(LCD_DATA, par);
 	}
 }
-#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
-	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
+#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) ||
+	 defined(CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_PPC_PMAC) */
 void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
 { }
 
@@ -184,7 +184,8 @@ u32 aty_ld_lcd(int index, const struct a
 {
 	return 0;
 }
-#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
+#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) ||
+	  defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_PPC_PMAC) */
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 /*
