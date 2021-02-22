Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9754C433E6
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Feb 2021 16:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C7364E76
	for <linux-fbdev@archiver.kernel.org>; Mon, 22 Feb 2021 16:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbhBVQ0G (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 22 Feb 2021 11:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231577AbhBVQ0A (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 22 Feb 2021 11:26:00 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DCCDC0617A7
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Feb 2021 08:25:20 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id x16so14064577wmk.3
        for <linux-fbdev@vger.kernel.org>; Mon, 22 Feb 2021 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=VfspxvK2qmutul/HQI6CP6zvXTYbfiqNuFTl1ngzl9A=;
        b=Sa8IDK+hjxW/KTwxOZ5cq7ouchiX/NM/KOQCL18K15EPiODDMsHZ5XqNTpLH/qkUUW
         KsBasPKkGtF0X/YrvGKLM5qVd4Vaz1rXyh/DiLg9X1/ThY4/yoombEH4PrR4ER87vNGv
         aZ2YA+LXeyVFw8c4Vb+mdPGr0wpAL3bZhh+JE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=VfspxvK2qmutul/HQI6CP6zvXTYbfiqNuFTl1ngzl9A=;
        b=GrgkVhsi4xznrcj0ymwQFyTfeRgTf13HL+IWDDz4De8WD57Z1yPz9wyE6kehxKTrqj
         EwLsNA34euU2gim+dL2asmnWkbgCBh6DhTI8LjIt5Ui2VHDY5fw07aRdCUa+FrfmuM+0
         v8GS7JQqtlc5egMnLzdGQDD/5X1pnAUI00QDM16myz0c225A0RoPxChtDK6++NjZ7jgf
         uP2ncM1UCw4M7BKlVM2sKxw3zdndWOeNEYuy1XFeQFufhm3R+FCR0lAXBZMy6vCzXFww
         OYT01YeqJKGIhRe71AOB+yLtktW7YtEuGiaR7dtxbA7Tlbjy3XY9KEPGPOXVMwFUTqsl
         7DsQ==
X-Gm-Message-State: AOAM532a1gFpROccvp8ztQwmHCWMWhWWu5F63ncPaZfW5VShYPdJrCgE
        DnZUoAwMs450xsfI35BPAkAQZ5nQAEGnXg==
X-Google-Smtp-Source: ABdhPJyuox2nDrjMuRIMD73wg/ViwXcOZnkt/HhU49o9yGozLgztr5S8eyNLgIrHTwiFvZpcE+bwNQ==
X-Received: by 2002:a1c:41d6:: with SMTP id o205mr20217128wma.80.1614011119077;
        Mon, 22 Feb 2021 08:25:19 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u6sm31326161wmg.41.2021.02.22.08.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 08:25:17 -0800 (PST)
Date:   Mon, 22 Feb 2021 17:25:15 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH] fbdev: atyfb: add stubs for aty_{ld,st}_lcd()
Message-ID: <YDPa6zThEuW9Mynu@phenom.ffwll.local>
Mail-Followup-To: Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sam Ravnborg <sam@ravnborg.org>, David Airlie <airlied@linux.ie>,
        Jani Nikula <jani.nikula@linux.intel.com>
References: <20210222032853.21483-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222032853.21483-1-rdunlap@infradead.org>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
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
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kernel test robot <lkp@intel.com>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>

stuffed into drm-misc-next-fixes for 5.12, thanks for your patch.
-Daniel

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

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
