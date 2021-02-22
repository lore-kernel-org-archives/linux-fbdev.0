Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A000C433DB
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Feb 2021 17:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC8F64F04
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Feb 2021 17:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbhBVRqM (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 22 Feb 2021 12:46:12 -0500
Received: from mga02.intel.com ([134.134.136.20]:24831 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231424AbhBVRqJ (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 22 Feb 2021 12:46:09 -0500
IronPort-SDR: rlaw+47Kcov8FKANGLsYuu9VT0dgmZsgQ510JHT8pWTrZfabxG5HlUZXrjSdIo1pByIwQUFXpj
 xzm45moi5EPw==
X-IronPort-AV: E=McAfee;i="6000,8403,9903"; a="171667212"
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="171667212"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2021 09:44:23 -0800
IronPort-SDR: ERgDbyS7rqIZAZc0h//AyX3Ku7nLtBisSAASciYbwNNcDLF0KMtxkdQMFXT34Ugo3gMZyDDjF2
 yRRtgG3l83Lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,197,1610438400"; 
   d="scan'208";a="441454668"
Received: from stinkbox.fi.intel.com (HELO stinkbox) ([10.237.72.171])
  by orsmga001.jf.intel.com with SMTP; 22 Feb 2021 09:44:05 -0800
Received: by stinkbox (sSMTP sendmail emulation); Mon, 22 Feb 2021 19:44:03 +0200
Date:   Mon, 22 Feb 2021 19:44:03 +0200
From:   Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fbdev: atyfb: add stubs for aty_{ld,st}_lcd()
Message-ID: <YDPtYx1uU5Y4HNZ7@intel.com>
References: <20210222032853.21483-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210222032853.21483-1-rdunlap@infradead.org>
X-Patchwork-Hint: comment
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Feb 21, 2021 at 07:28:53PM -0800, Randy Dunlap wrote:
> Fix build errors when these functions are not defined.
> 
> ../drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_power_mgmt':
> ../drivers/video/fbdev/aty/atyfb_base.c:2002:7: error: implicit declaration of function 'aty_ld_lcd'; did you mean 'aty_ld_8'? [-Werror=implicit-function-declaration]
>  2002 |  pm = aty_ld_lcd(POWER_MANAGEMENT, par);
> ../drivers/video/fbdev/aty/atyfb_base.c:2004:2: error: implicit declaration of function 'aty_st_lcd'; did you mean 'aty_st_8'? [-Werror=implicit-function-declaration]
>  2004 |  aty_st_lcd(POWER_MANAGEMENT, pm, par);
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> ---
>  drivers/video/fbdev/aty/atyfb_base.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> --- linux-next-20210219.orig/drivers/video/fbdev/aty/atyfb_base.c
> +++ linux-next-20210219/drivers/video/fbdev/aty/atyfb_base.c
> @@ -175,6 +175,15 @@ u32 aty_ld_lcd(int index, const struct a
>  		return aty_ld_le32(LCD_DATA, par);
>  	}
>  }
> +#else /* defined(CONFIG_PMAC_BACKLIGHT) || defined(CONFIG_FB_ATY_BACKLIGHT) \
> +	 defined(CONFIG_FB_ATY_GENERIC_LCD) */

A better fix would seem to be to include these functions if
CONFIG_PPC_PMAC is enabled. Otherwise the PM code will surely
not work correctly. Though I'm not sure if that PPC PM
code makes any sense w/o LCD/backlight support anyway.

> +void aty_st_lcd(int index, u32 val, const struct atyfb_par *par)
> +{ }
> +
> +u32 aty_ld_lcd(int index, const struct atyfb_par *par)
> +{
> +	return 0;
> +}
>  #endif /* defined(CONFIG_PMAC_BACKLIGHT) || defined (CONFIG_FB_ATY_GENERIC_LCD) */
>  
>  #ifdef CONFIG_FB_ATY_GENERIC_LCD
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Ville Syrjälä
Intel
