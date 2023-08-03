Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A99C0015E
	for <linux-fbdev@archiver.kernel.org>; Thu,  3 Aug 2023 08:52:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234815AbjHCIwt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 3 Aug 2023 04:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjHCIwq (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 3 Aug 2023 04:52:46 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C17C115
        for <linux-fbdev@vger.kernel.org>; Thu,  3 Aug 2023 01:52:44 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-5216095a698so196016a12.0
        for <linux-fbdev@vger.kernel.org>; Thu, 03 Aug 2023 01:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1691052763; x=1691657563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cn0cLl3gGNWIyCVwa8rBi5Yd6oueHSEN6EFsNN/UTTY=;
        b=U4d9eLqC/hMSyDQxtWAP0hEsjDTC4AA9f7Iphglq7loBGmCnM4i08cE+rMbN/4Mhl1
         rBF6t5lLQTu8RqXY6N1/islVKoLsTQjpa9cWfHVl/C+Uz287LMIV3FB0qbahzAjEOBcF
         ZAIUYmJRSNRXnM92h3LZ0YFxbtgoaS3uS1sVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691052763; x=1691657563;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cn0cLl3gGNWIyCVwa8rBi5Yd6oueHSEN6EFsNN/UTTY=;
        b=MjEi2AxJqDZGlDLc3tZu5hW7oGP8z2p7CRMrIemJwnm5bTJB/pJ0dsAfj5AF3SXcTc
         F5Voqjq5V+STLMoO5ce4ss6NcodoGHaek3PHvEy8W5SWDrTKxRjwsD/cXYGTRgAJBwVs
         eHITE2eTN+xNKjlz9hPKx/V0ZiTY4yjPwYZ83egSK1Jup/GWQsJTZ6T2pvAuZwdQqu3g
         BJTxXddDXx6etxJObKAzG2MhpqcfgAfevCbYsHObKOuxvGg5OGUKxQrDHQ8Wf/1gozG6
         /dD51Nbpc3ZbRV+lqThLj6GfK34e3si8UxcD8q8UTvRAgWtBGgX8degQJ+hDw2EWV9th
         uYbQ==
X-Gm-Message-State: ABy/qLZn5/yUMD1HxQLgUaXzHU4lLJcTJzptlyQ9OAWoYpWiac7XPJTI
        XC6Vy4TABUs1Rg3h1swMtYw1Qw==
X-Google-Smtp-Source: APBJJlFlZjdIo145ZsuoyiR5X6oVNswQeQBdefA6vl2wvZ5BdU6o6TdY6tmPc92TXrgNqLmx3Za9WA==
X-Received: by 2002:a05:6402:4404:b0:522:e6b0:8056 with SMTP id y4-20020a056402440400b00522e6b08056mr5623245eda.4.1691052762855;
        Thu, 03 Aug 2023 01:52:42 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x4-20020aa7d6c4000000b0051e2cde9e3esm9879941edr.75.2023.08.03.01.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 01:52:42 -0700 (PDT)
Date:   Thu, 3 Aug 2023 10:52:40 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     daniel@ffwll.ch, deller@gmx.de, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] fbcon: Make fbcon_registered_fb and
 fbcon_num_registered_fb static
Message-ID: <ZMtq2NtCIQxKRqPh@phenom.ffwll.local>
References: <20230803020939.491-1-guozihua@huawei.com>
 <ZMtoA/cYt6rtTpAD@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMtoA/cYt6rtTpAD@phenom.ffwll.local>
X-Operating-System: Linux phenom 6.3.0-2-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Aug 03, 2023 at 10:40:35AM +0200, Daniel Vetter wrote:
> On Thu, Aug 03, 2023 at 10:09:39AM +0800, GUO Zihua wrote:
> > fbcon_registered_fb and fbcon_num_registered_fb is not referred outside
> > drivers/video/fbdev/core/fbcon.c, so make them static.
> > 
> > Signed-off-by: GUO Zihua <guozihua@huawei.com>
> 
> Applied both of your patches to drm-misc-next.

Correction, I dropped the agpgart patch again because amd gart x86 arch
code needs that symbol.

> -Daniel
> 
> > ---
> >  drivers/video/fbdev/core/fbcon.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> > index 887fad44e7ec..976900d6893c 100644
> > --- a/drivers/video/fbdev/core/fbcon.c
> > +++ b/drivers/video/fbdev/core/fbcon.c
> > @@ -102,8 +102,8 @@ enum {
> >  
> >  static struct fbcon_display fb_display[MAX_NR_CONSOLES];
> >  
> > -struct fb_info *fbcon_registered_fb[FB_MAX];
> > -int fbcon_num_registered_fb;
> > +static struct fb_info *fbcon_registered_fb[FB_MAX];
> > +static int fbcon_num_registered_fb;
> >  
> >  #define fbcon_for_each_registered_fb(i)		\
> >  	for (i = 0; WARN_CONSOLE_UNLOCKED(), i < FB_MAX; i++)		\
> > -- 
> > 2.17.1
> > 
> 
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
