Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 085D1C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Feb 2022 15:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbiBBPA6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Feb 2022 10:00:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiBBPA6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Feb 2022 10:00:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F86C061714
        for <linux-fbdev@vger.kernel.org>; Wed,  2 Feb 2022 07:00:57 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n8so15482667wmk.3
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Feb 2022 07:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UJke/v7BookoKPmUftKhzlH99saDDZec7hBQIKAqw5U=;
        b=d8I1PbMJHfr4TJxDxSAz34w6Oci/V59mn0RqiiInIaIu9ctRblniRaeWAVJ5zCCCma
         /LeNLsZ8Jeq0x/wx1FO52r3w79G34zfbWmHoT8k7jj87dYibpGuiK5AIiLEUWTbHyeR4
         ogeFP/U6orewfwdjNmudD/2TN3mYhsyyS3WWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UJke/v7BookoKPmUftKhzlH99saDDZec7hBQIKAqw5U=;
        b=xMraqaRNT8rfwdWX5Zgpa12HX+H2XPS4muEd0V1ZMRqpLHFPQrkeoFx+MIi6Gm//PV
         pxyugBdrRTkivP0V5gilJDFfGFx7rl5jRpDWjA8M3W4U5KIoMtet/yJVaxTkfc0OIjPN
         xcvdt4rF4HSOoxg6MLIbOHu2HBh6mesQUinFkdaSCyD5s2QIXazStwtCEqfwnfFJgLNx
         7XT3Omm/+eyspGzUo2jOcpQ03JHbIejALXqkLdWpWFcRKgLSnWrn9+YIdonV4IGm1hXj
         ZBlgDdUiWMlGOpZxUmUAFe/VZUUZvhI/fr4HdHLDW4RaR0LZ0+hLcjGKTiMmflI8WtDt
         cVWg==
X-Gm-Message-State: AOAM530RxdfAamQymkyDjFBsNmvck9u7Xi7OYp8zrMZBsbxvY20StBJe
        uNv7aSa/esx7jOMT4H/fKJXZZQ==
X-Google-Smtp-Source: ABdhPJxzsXob9MfZd84+Frg9QRyH4CTfDv8r32BhiPca6etLb34+hmE2I/kw7LE1AM7L2ncRsuZg8w==
X-Received: by 2002:a1c:1f54:: with SMTP id f81mr6505147wmf.22.1643814056525;
        Wed, 02 Feb 2022 07:00:56 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id p42sm4859278wms.28.2022.02.02.07.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 07:00:56 -0800 (PST)
Date:   Wed, 2 Feb 2022 16:00:54 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-fbdev@vger.kernel.org,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 0/3] Fix regression introduced by disabling
 accelerated scrolling in fbcon
Message-ID: <Yfqcprlj/2AuibvG@phenom.ffwll.local>
References: <20220202135531.92183-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202135531.92183-1-deller@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Feb 02, 2022 at 02:55:28PM +0100, Helge Deller wrote:
> This series reverts two patches which disabled scrolling acceleration in
> fbcon/fbdev. Those patches introduced a regression for fbdev-supported graphic
> cards because of the performance penalty by doing screen scrolling by software
> instead of using existing 2D hardware acceleration.
> 
> The third patch introduces a new config option
> CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION, which -if enabled- switches
> fbcon to utilize the bitblt and fillrect hardware acceleration in the
> framebuffer console. If disabled, such acceleration will not be used, even if
> it is supported by the graphics hardware driver.
> 
> This series is being discussed on linux-fbdev and dri-devel mailing lists.
> 
> Updates in v3:
> - respin with fixes to build rotation code
> 
> Updates in v4:
> - changed the Kconfig option and Kconfig help text
> 
> Helge Deller (3):
>   Revert "fbdev: Garbage collect fbdev scrolling acceleration, part 1
>     (from TODO list)"
>   Revert "fbcon: Disable accelerated scrolling"
>   fbcon: Add option to enable legacy hardware acceleration

Applied to drm-misc-fixes, thanks for the patches.

Cheers, Daniel

> 
>  Documentation/gpu/todo.rst              |  24 -
>  drivers/video/console/Kconfig           |  20 +
>  drivers/video/fbdev/core/bitblit.c      |  16 +
>  drivers/video/fbdev/core/fbcon.c        | 557 +++++++++++++++++++++++-
>  drivers/video/fbdev/core/fbcon.h        |  72 +++
>  drivers/video/fbdev/core/fbcon_ccw.c    |  28 +-
>  drivers/video/fbdev/core/fbcon_cw.c     |  28 +-
>  drivers/video/fbdev/core/fbcon_rotate.h |   9 +
>  drivers/video/fbdev/core/fbcon_ud.c     |  37 +-
>  drivers/video/fbdev/core/tileblit.c     |  16 +
>  drivers/video/fbdev/skeletonfb.c        |  12 +-
>  include/linux/fb.h                      |   2 +-
>  12 files changed, 753 insertions(+), 68 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
