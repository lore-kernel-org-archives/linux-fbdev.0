Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E846C83038
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F982224C
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:12:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKkBRCT9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389470AbgK1VuB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731740AbgK1SzO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 13:55:14 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972C4C02B8E7
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 00:28:25 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id s8so7897761wrw.10
        for <linux-fbdev@vger.kernel.org>; Sat, 28 Nov 2020 00:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cTkHTcSrLgZszRAVwj45rxiuIrfPvRKqnrUG46P7sq0=;
        b=cKkBRCT9v3oLHM8wav0akpMQBP5NQv6bQKs+GZ/8ukgTgbOwh1PuqROZURCCkNwi3T
         SMdHme0S8PmFhAuBAjz7gWpNURcXbFOsyZXGUbYn2fj+yfX7HYHyirHocDl3LiMNeqPd
         UtYUN1gfGUh+Hi15h+UHpO44QyIPVkuyG82ZOMrmqTc94dnrldHSf0Q9PIP0kep3mPch
         thvjtJasTUNy2zutYM2Nu6EY40cQow+/BXRMbZr/T6FWXL2YMRRwaI2XO/xdrDDOQ+sI
         +Xt4OSwpB8LRJeNy2zANynlgqFw7ryU38BPxYOnqZiS2EgYTfCyhy2yFdKKcpORqZ82K
         NMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cTkHTcSrLgZszRAVwj45rxiuIrfPvRKqnrUG46P7sq0=;
        b=Ib/2vAtdegFFgSPYtZlv9VzPpp2pOGDxXlpaJxuz+zZYt7Zgy/TuK7NCWPOFOj1QpL
         vCdqs+BloTJhzUKMRwRhbREYWsBttLjh39R+0VHqIq92FvByMnEMdf9gzBBO+GLAc4ZE
         Ee0xByIfQ0FZ/Soqy0pD63EVZp0IiN8jcEmnAvjCBAQSf49nVBk5eTOoqVMSkdbfgxJM
         VGT+8AhR/sGUaFZJ+ZlauAGafJ01kzWarJM8pQ9FUa2cf1RUR/r1bhKUAkKwPdhyXVR6
         XfqVCV6oNlrqWSlWp+nX1iPTOaI03ThWiN3c2WbLkAyrt7moe3aHPkosHc8MRBshhUe8
         Vskw==
X-Gm-Message-State: AOAM533/s5CkcKeNQiVWlyGPrc3HgH7C5w1K2+jB1YALtWIU57hbrvEq
        O1M6L7UO71t9rdspfLjfv6pIWg==
X-Google-Smtp-Source: ABdhPJzeYRmsxFZn2ZwidIPjzPMgaEV7J3TB5ydD8HIA0sG5PSBN25cXxEFEWF0I3IINU4+ZI56Q1Q==
X-Received: by 2002:adf:e449:: with SMTP id t9mr16202556wrm.257.1606552104332;
        Sat, 28 Nov 2020 00:28:24 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id z19sm16842255wmk.12.2020.11.28.00.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Nov 2020 00:28:23 -0800 (PST)
Date:   Sat, 28 Nov 2020 08:28:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH v1 01/28] video: Fix W=1 warnings in of_videomode +
 of_display_timing
Message-ID: <20201128082820.GX2455276@dell>
References: <20201127195825.858960-1-sam@ravnborg.org>
 <20201127195825.858960-2-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201127195825.858960-2-sam@ravnborg.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, 27 Nov 2020, Sam Ravnborg wrote:

> Fix trivial W=1 warnings.
> Update kernel-doc to avoid the warnings.

Can you put what's being fixed in the subject line please?

"fix w=1 warnings" is very bland and this it is unlikely to be the
only w=1 warning that gets fixed in these files, so has a high likely
hood of having an identical subject-line as a previous/future patch.

With regards to the latter point; I have personally found subject
lines to be a pretty reliable way of maintaining/backporting older
kernels.  The nomenclature here would taint that pretty readily.

> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: linux-fbdev@vger.kernel.org
> ---
>  drivers/video/of_display_timing.c | 1 +
>  drivers/video/of_videomode.c      | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
> index abc9ada798ee..f93b6abbe258 100644
> --- a/drivers/video/of_display_timing.c
> +++ b/drivers/video/of_display_timing.c
> @@ -52,6 +52,7 @@ static int parse_timing_property(const struct device_node *np, const char *name,
>  /**
>   * of_parse_display_timing - parse display_timing entry from device_node
>   * @np: device_node with the properties
> + * @dt: display_timing that contains the result. I may be partially written in case of errors
>   **/
>  static int of_parse_display_timing(const struct device_node *np,
>  		struct display_timing *dt)
> diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.c
> index 67aff2421c29..a5bb02f02b44 100644
> --- a/drivers/video/of_videomode.c
> +++ b/drivers/video/of_videomode.c
> @@ -13,10 +13,10 @@
>  #include <video/videomode.h>
>  
>  /**
> - * of_get_videomode - get the videomode #<index> from devicetree
> - * @np - devicenode with the display_timings
> - * @vm - set to return value
> - * @index - index into list of display_timings
> + * of_get_videomode: get the videomode #<index> from devicetree
> + * @np: devicenode with the display_timings
> + * @vm: set to return value
> + * @index: index into list of display_timings
>   *	    (Set this to OF_USE_NATIVE_MODE to use whatever mode is
>   *	     specified as native mode in the DT.)
>   *

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
