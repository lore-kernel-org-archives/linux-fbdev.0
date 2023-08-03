Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3827AC0015E
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Aug 2023 08:40:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjHCIkz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Aug 2023 04:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232287AbjHCIkl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 3 Aug 2023 04:40:41 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C141734
        for <linux-fbdev@vger.kernel.org>; Thu,  3 Aug 2023 01:40:39 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98273ae42d0so21288266b.0
        for <linux-fbdev@vger.kernel.org>; Thu, 03 Aug 2023 01:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691052038; x=1691656838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jQgEg5B5Jwbom41puO2crNqoRpzcJxGGs9a7kVHaqcM=;
        b=LOyJKTqR4y7Z8JdQe+Q/05Hvg3zCDREbBf8/T2hZE9gArOA+jF5Qfke/SWLOXbcdOg
         Ei2I60ArUa4wOVdGCqW9jexmhyLX42hnF1AjSgTu+PusK6TnT6esl2ZgS6KCuHAtsb7S
         ietNAFIEFpWqlIeVr9VU5jEDl4TFww0ekJ/zw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052038; x=1691656838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQgEg5B5Jwbom41puO2crNqoRpzcJxGGs9a7kVHaqcM=;
        b=WwWRgeJQSmGt2jqIurQDnz+pOZyl7gR1Wh/WlQp79efcgetTkGQhkhaG1R3VFPz3i9
         peBKvYIt7W71cvHUnbv/G3xuIT3K44RrwcL0iBs4FvZHVIQzCiOkfKs8gvYJbSE56FHp
         D1DlmxfpACrATX9eM11eHBuU46k5pHA1woNsIb2AiOQRFjzMPtDm6ZAmbAf7yrYZ5CEX
         jjVIGgpHwFluFciRwK9IWv2vc+7E9HvdQkHIYZ5S+d1B3eQP1Rltxe0RDwZd79tEbEDF
         LPE4Xkrgha90wbSi6AixabyWocyq+dfVJjtFuNnYAPvJe/X8k5cKd7Bg9AuktIxGkslZ
         +f5w==
X-Gm-Message-State: ABy/qLZVW3PgOX9IvekEJbDx9fv1agFb19ivsWqxnpdn738ovuckRFyV
        ndlmA/d+BgWsMv+8fXcZR0COJw==
X-Google-Smtp-Source: APBJJlER/Lh8OCkWnRKwDqViYiJoVhvhRnV+caX0CdFJEvlO3FsZx1fRLprcQVnnsb3V0W+2W4tPPg==
X-Received: by 2002:a17:906:77d5:b0:993:d54b:3e4b with SMTP id m21-20020a17090677d500b00993d54b3e4bmr12710490ejn.0.1691052038416;
        Thu, 03 Aug 2023 01:40:38 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id jp21-20020a170906f75500b00988c0c175c6sm10163014ejb.189.2023.08.03.01.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:40:37 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:40:35 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     daniel@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbcon: Make fbcon_registered_fb and
 fbcon_num_registered_fb static
Message-ID: <ZMtoA/cYt6rtTpAD@phenom.ffwll.local>
References: <20230803020939.491-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803020939.491-1-guozihua@huawei.com>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Aug 03, 2023 at 10:09:39AM +0800, GUO Zihua wrote:
> fbcon_registered_fb and fbcon_num_registered_fb is not referred outside
> drivers/video/fbdev/core/fbcon.c, so make them static.
> 
> Signed-off-by: GUO Zihua <guozihua@huawei.com>

Applied both of your patches to drm-misc-next.
-Daniel

> ---
>  drivers/video/fbdev/core/fbcon.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index 887fad44e7ec..976900d6893c 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -102,8 +102,8 @@ enum {
>  
>  static struct fbcon_display fb_display[MAX_NR_CONSOLES];
>  
> -struct fb_info *fbcon_registered_fb[FB_MAX];
> -int fbcon_num_registered_fb;
> +static struct fb_info *fbcon_registered_fb[FB_MAX];
> +static int fbcon_num_registered_fb;
>  
>  #define fbcon_for_each_registered_fb(i)		\
>  	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
> -- 
> 2.17.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
