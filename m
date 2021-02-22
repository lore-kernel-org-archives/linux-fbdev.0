Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C090C433E0
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Feb 2021 03:29:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C845964ECD
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Feb 2021 03:29:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbhBVD3q (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 21 Feb 2021 22:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbhBVD3p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 21 Feb 2021 22:29:45 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC0CC061574;
        Sun, 21 Feb 2021 19:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=2/j5Lqy5dhvDPN7B6GDS9vPRNJDpnM+aTBfnWbXMC7w=; b=OtRJW4wqXmNWb5xMEq9F+WqDJf
        aPhAT9Xw3GzbfmQkSSruEZcR20orlmcwzomgY+Z/9sZGzmBOf/612nLV6aYXzAdJBN4N8PsovftZm
        IC0fXQbawnBjb6XS6CTsnthabiNdzyrH/Gz+GjHun2cyEShhnS5us5HO5+eCo759nN85IKjdGZOms
        Q3olCqW6gTnKPSfGFxeRrXA41UReb4818SsELVc8ZM3OpuaeWPzIkwyvXfbKoaC29NIZB3xR989st
        p7GCx1FWfJ1tmKDU+PCvgUc7JVqu/3y1EbBjDqiCEPwHvCWeR2D5nig3WPNEar2rTcDPLjj37CWqD
        KEWjUZzA==;
Received: from [2601:1c0:6280:3f0::d05b] (helo=merlin.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1lE1u7-0003dI-HH; Mon, 22 Feb 2021 03:29:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: [PATCH] fbdev: atyfb: add stubs for aty_{ld,st}_lcd()
Date:   Sun, 21 Feb 2021 19:28:53 -0800
Message-Id: <20210222032853.21483-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Fix build errors when these functions are not defined.

../drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_power_mgmt':
../drivers/video/fbdev/aty/atyfb_base.c:2002:7: error: implicit declaration of function 'aty_ld_lcd'; did you mean 'aty_ld_8'? [-Werror=implicit-function-declaration]
 2002 |  pm = aty_ld_lcd(POWER_MANAGEMENT, par);
../drivers/video/fbdev/aty/atyfb_base.c:2004:2: error: implicit declaration of function 'aty_st_lcd'; did you mean 'aty_st_8'? [-Werror=implicit-function-declaration]
 2004 |  aty_st_lcd(POWER_MANAGEMENT, pm, par);

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
---
 drivers/video/fbdev/aty/atyfb_base.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
+++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
@@ -175,6 +175,15 @@ u32 aty_ld_lcd(int index, const struct a
 		return aty_ld_le32(LCD_DATA, par);
 	}
 }
+#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
+	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
+void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
+{ }
+
+u32 aty_ld_lcd(int index, const struct atyfb_par *par)
+{
+	return 0;
+}
 #endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
 
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
