Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A86C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 21:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B7864F03
	for <linux-fbdev@archiver.kernel.org>; Wed, 24 Feb 2021 21:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbhBXV4R (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 24 Feb 2021 16:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbhBXV4R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 24 Feb 2021 16:56:17 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5FC061574;
        Wed, 24 Feb 2021 13:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=KuWAhJtiZEuqWgaw7j/dWyBKuxamWBVDd55ICgSvMAE=; b=xDdFXRlVY0wF5OacC5EN8xJbnO
        LvAh1dCeRpg7YLz4a9lPEFFAHNylVaV7ymPTk1fcXAXrtjOz9nHpPYMnOpXwlhidmbeE71EDN2bcr
        E9410knr8bMuAkcjK9C6DtNROMdpMOICKU5u91tNuYhYK0MhyhlfGZ/kobrOXNyirFHY4GF+6g2nd
        xaLwE1clTPhIFRRsmYmjh6Ul124YcLxzQM1z/PpDd9s+TCFn2Ah4Zj9r9aDzu/dFYerSIUWart83C
        ehZYspwu25Q/7A8HshMdG0Pobg1XTtRYzZsduoWI0lY+hCpnwwCFWsNpN7D0AlMTODnFwqPKe1H0e
        Vmoi7eaw==;
Received: from [2601:1c0:6280:3f0::d05b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lF286-0002J1-0H; Wed, 24 Feb 2021 21:55:34 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH -next] fbdev: atyfb: always declare aty_{ld,st}_lcd()
Date:   Wed, 24 Feb 2021 13:55:28 -0800
Message-Id: <20210224215528.822-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

The previously added stubs for aty_{ld,}st_lcd() make it
so that these functions are used regardless of the config
options that were guarding them, so remove the #ifdef/#endif
lines and make their declarations always visible.
This fixes build warnings that were reported by clang:

   drivers/video/fbdev/aty/atyfb_base.c:180:6: warning: no previous prototype for function 'aty_st_lcd' [-Wmissing-prototypes]
   void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
        ^
   drivers/video/fbdev/aty/atyfb_base.c:180:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)

   drivers/video/fbdev/aty/atyfb_base.c:183:5: warning: no previous prototype for function 'aty_ld_lcd' [-Wmissing-prototypes]
   u32 aty_ld_lcd(int index, const struct atyfb_par *par)
       ^
   drivers/video/fbdev/aty/atyfb_base.c:183:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   u32 aty_ld_lcd(int index, const struct atyfb_par *par)

They should not be marked as static since they are used in
mach64_ct.c.

Fixes: bfa5782b9caa ("fbdev: atyfb: add stubs for aty_{ld,st}_lcd()")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/video/fbdev/aty/atyfb.h |    3 ---
 1 file changed, 3 deletions(-)

--- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb.h
+++ linux-next-20210219/drivers/video/fbdev/aty/atyfb.h
@@ -287,11 +287,8 @@ static inline void aty_st_8(int regindex
 #endif
 }
 
-#if defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) || \
-defined (CONFIG_FB_ATY_BACKLIGHT)
 extern void aty_st_lcd(int index, u32 val, const struct atyfb_par *par);
 extern u32 aty_ld_lcd(int index, const struct atyfb_par *par);
-#endif
 
     /*
      *  DAC operations
