Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03B2C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Mar 2021 22:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6A364EE8
	for <linux-fbdev@archiver.kernel.org>; Wed,  3 Mar 2021 22:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhCCWLf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 3 Mar 2021 17:11:35 -0500
Received: from mga04.intel.com ([192.55.52.120]:52819 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1452887AbhCCQvI (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 3 Mar 2021 11:51:08 -0500
IronPort-SDR: R4QS8hHr7VM3sE3oiaYNbuLaN4/xDJyVVIZdyBkIEyon8SQXDV2kuT58MQm9wS4clVSjvJxcyJ
 cwm489Xohzew==
X-IronPort-AV: E=McAfee;i="6000,8403,9912"; a="184815986"
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="184815986"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2021 08:40:35 -0800
IronPort-SDR: 0XYFIBMlOFlhWrfU3MSu1x9ikTgf40abOhUWdwDLCGy2CZdDDLAmlj71YmJ3iUYccdsxg6kSbq
 YXr27WKPzxQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,220,1610438400"; 
   d="scan'208";a="406518537"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga007.jf.intel.com with SMTP; 03 Mar 2021 08:40:30 -0800
Received: by stinkbox (sSMTP sendmail emulation); Wed, 03 Mar 2021 18:40:29 +0200
Date:   Wed, 3 Mar 2021 18:40:29 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH -next v2] fbdev: atyfb: use LCD management functions for
 PPC_PMAC also
Message-ID: <YD+7/alPK5NtDnTq@intel.com>
References: <20210226173008.18236-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210226173008.18236-1-rdunlap@infradead.org>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Feb 26, 2021 at 09:30:08AM -0800, Randy Dunlap wrote:
> Include PPC_PMAC in the configs that use aty_ld_lcd() and
> aty_st_lcd() implementations so that the PM code may work
> correctly for PPC_PMAC.
> 
> Suggested-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Nick Desaulniers <ndesaulniers@google.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> ---
> Daniel- We also need this patch:
> https://lore.kernel.org/dri-devel/20210224215528.822-1-rdunlap@infradead.org/
> to fix a kernel test robot build error.
> 
> v2: send the correct version of this patch (thanks, Ville)

Both patches pushed to drm-misc-fixes. Thanks.

> 
>  drivers/video/fbdev/aty/atyfb_base.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
> +++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
> @@ -133,7 +133,7 @@
>  #define PRINTKE(fmt, args...)	printk(KERN_ERR "atyfb: " fmt, ## args)
>  
>  #if defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_GENERIC_LCD) || \
> -defined(CONFIG_FB_ATY_BACKLIGHT)
> +defined(CONFIG_FB_ATY_BACKLIGHT) || defined (CONFIG_PPC_PMAC)
>  static const u32 lt_lcd_regs[] = {
>  	CNFG_PANEL_LG,
>  	LCD_GEN_CNTL_LG,
> @@ -175,8 +175,8 @@ u32 aty_ld_lcd(int index, const struct a
>  		return aty_ld_le32(LCD_DATA, par);
>  	}
>  }
> -#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
> -	 defined(CONFIG_FB_ATY_GENERIC_LCD) */
> +#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) ||
> +	 defined(CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_PPC_PMAC) */
>  void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
>  { }
>  
> @@ -184,7 +184,8 @@ u32 aty_ld_lcd(int index, const struct a
>  {
>  	return 0;
>  }
> -#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
> +#endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) ||
> +	  defined (CONFIG_FB_ATY_GENERIC_LCD) || defined(CONFIG_PPC_PMAC) */
>  
>  #ifdef CONFIG_FB_ATY_GENERIC_LCD
>  /*

-- 
Ville Syrjälä
Intel
