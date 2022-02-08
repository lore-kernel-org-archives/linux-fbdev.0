Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56E6C433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  8 Feb 2022 22:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386437AbiBHWX7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 8 Feb 2022 17:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386587AbiBHU4r (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 8 Feb 2022 15:56:47 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E8A9C0612C3
        for <linux-fbdev@vger.kernel.org>; Tue,  8 Feb 2022 12:56:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id i15so563011wrb.3
        for <linux-fbdev@vger.kernel.org>; Tue, 08 Feb 2022 12:56:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=8rCyE259QoTAuF9ujcMI8WQXkRdDBnGG4G9shkzQjfs=;
        b=TClcMH3/O8IpIo3td4YsN56mO1iC7OT2x7WX2FMn/DpIGkX8EwvlmyzJbHfyaO9kmA
         QR+OyCNEr5uu9lVSwWwjtgl0lfk3CYGV3p3l0yw3SkRJWXcGZ93pUtqvBqM9Zhqox2W1
         OsfUI+doa0d/YIr1nV4EX0pA8AvKm9sFFLitM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=8rCyE259QoTAuF9ujcMI8WQXkRdDBnGG4G9shkzQjfs=;
        b=EFC39sMalbbM71lkUQ1xTm7qj/U8C8qjjHZbuYXFaXnd3jWd6ugsjEKZ3KSgmkKezQ
         4W0LzG9thBVIArYMO7PmkziUNc9VLcFh2fgdpquM5+khVloUPwC9Wwixi03WA25sPkrC
         OxUg48ApxgKRbRAATEfaklDIX+79PzjXAbPCCxfK0NGeUv7B9qy1Oe9OMXuQObGx+EpE
         E75AGSJU63Nhk4AAI1FjFEIZFFBotN3TIB9Q2SczY1hQ7Tcje61wMK2KhZwFsJFFytrJ
         H4mPm3R+qJdSziZ0mcIfhSZTJUDX+KJ9nCkfkXQ/sWifv0YhZuQ2o8iKMLq3mwSMwmQP
         fsyQ==
X-Gm-Message-State: AOAM533Q1EEYtDZBeUDwKjVC1iF6nbD5I6gUacS72ylYc75PujjZ0hTY
        aGZz/XyHz5sz3AyRwLkB8WwLuA==
X-Google-Smtp-Source: ABdhPJz/N9Po0VxZ50ccE3Hf10GsDJ0883pAqCSvxgXcU5GA5wUMfraP7XMA8MXRBfr2C51K9jlMiQ==
X-Received: by 2002:a05:6000:1a89:: with SMTP id f9mr5048305wry.573.1644353801125;
        Tue, 08 Feb 2022 12:56:41 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id b16sm3490549wrj.26.2022.02.08.12.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 12:56:40 -0800 (PST)
Date:   Tue, 8 Feb 2022 21:56:38 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Jens Frederich <jfrederich@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Helge Deller <deller@gmx.de>
Subject: Re: [PATCH 21/21] fbdev: Make registered_fb[] private to fbmem.c
Message-ID: <YgLZBlrXW+DYNkFN@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Zheyu Ma <zheyuma97@gmail.com>,
        Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Jens Frederich <jfrederich@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        linux-staging@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Helge Deller <deller@gmx.de>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-22-daniel.vetter@ffwll.ch>
 <YgK91i6zHWPBwYOq@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YgK91i6zHWPBwYOq@ravnborg.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Feb 08, 2022 at 08:00:38PM +0100, Sam Ravnborg wrote:
> Hi Daniel,
> 
> On Mon, Jan 31, 2022 at 10:05:52PM +0100, Daniel Vetter wrote:
> > Well except when the olpc dcon fbdev driver is enabled, that thing
> > digs around in there in rather unfixable ways.
> > 
> > Cc oldc_dcon maintainers as fyi.
> > 
> > Cc: Jens Frederich <jfrederich@gmail.com>
> > Cc: Jon Nettleton <jon.nettleton@gmail.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: linux-staging@lists.linux.dev
> > Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> > Cc: Daniel Vetter <daniel@ffwll.ch>
> > Cc: Helge Deller <deller@gmx.de>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
> > Cc: Zhen Lei <thunder.leizhen@huawei.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Xiyu Yang <xiyuyang19@fudan.edu.cn>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: Zheyu Ma <zheyuma97@gmail.com>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> 
> with the build thingy fixed:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
> 
> I do wonder if there is a more clean way to trigger a blank
> in the main fbdev driver from the olpc driver.
> 
> The current hack is not nice and it would be good to see it gone.

Yeah this is just badly engineered. In drm we'd do this with the self
refresh helpers, which pretty much give you this exact functionality, but
in the helpers, while not randomly breaking actual visible behaviour of
the display driver.

Well ok the illusion is not perfect, since if the display is suspended the
next page flip will take a tad longer. But that's it.

I'll also add this to the TODO.
-Daniel

> 
> 	Sam
> 
> > ---
> >  drivers/video/fbdev/core/fbmem.c | 8 ++++++--
> >  include/linux/fb.h               | 7 +++----
> >  2 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index 904ef1250677..dad6572942fa 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -48,10 +48,14 @@
> >  static DEFINE_MUTEX(registration_lock);
> >  
> >  struct fb_info *registered_fb[FB_MAX] __read_mostly;
> > -EXPORT_SYMBOL(registered_fb);
> > -
> >  int num_registered_fb __read_mostly;
> > +#if IS_ENABLED(CONFIG_OLPC_DCON)
> > +EXPORT_SYMBOL(registered_fb);
> >  EXPORT_SYMBOL(num_registered_fb);
> > +#endif
> > +#define for_each_registered_fb(i)		\
> > +	for (i = 0; i < FB_MAX; i++)		\
> > +		if (!registered_fb[i]) {} else
> >  
> >  bool fb_center_logo __read_mostly;
> >  
> > diff --git a/include/linux/fb.h b/include/linux/fb.h
> > index a8a00d2ba1f3..e236817502c2 100644
> > --- a/include/linux/fb.h
> > +++ b/include/linux/fb.h
> > @@ -622,16 +622,15 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
> >  extern int fb_get_options(const char *name, char **option);
> >  extern int fb_new_modelist(struct fb_info *info);
> >  
> > +#if IS_ENABLED(CONFIG_OLPC_DCON)
> >  extern struct fb_info *registered_fb[FB_MAX];
> > +
> >  extern int num_registered_fb;
> > +#endif
> >  extern bool fb_center_logo;
> >  extern int fb_logo_count;
> >  extern struct class *fb_class;
> >  
> > -#define for_each_registered_fb(i)		\
> > -	for (i = 0; i < FB_MAX; i++)		\
> > -		if (!registered_fb[i]) {} else
> > -
> >  static inline void lock_fb_info(struct fb_info *info)
> >  {
> >  	mutex_lock(&info->lock);
> > -- 
> > 2.33.0

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
