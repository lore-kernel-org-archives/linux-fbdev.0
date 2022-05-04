Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A93EC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 10:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347970AbiEDKSm (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 06:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234488AbiEDKSl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 06:18:41 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE6F022525
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 03:15:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bv19so1940580ejb.6
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 03:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=DtdZXt+SmpFrTqYzesf1kphNYf64qbUXNNBxD4Vh4gg=;
        b=NQ/nVH3+I5wmrMuaf5Igp+9JPz9VnJMklXL6usvarWEUcE3q01DMETuxdCABgYWZS9
         Fv81L2lH1UnnY8DSTyCyRtENnwA25rykS9Z3g+xZo51wLgykM1xR/OX9neUeC2wl+HyV
         DR57VBOYRIBwPpXhDOeFBoq0Q9HL6+wFidm5g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=DtdZXt+SmpFrTqYzesf1kphNYf64qbUXNNBxD4Vh4gg=;
        b=MTIXyGsbT/9VCZ7iL0CTIIa1UNF5o/KfsmcbaxPtVQr7ZnkgG70ebuZ5lp4m2SpBFK
         WXVgQVxIRbDW67TMPOmy3PqYujoBi4q352HEAlQ3jIqP0hGy6/IxyhSn3D/xFBsOaJk/
         igQh5wu0DdZVrzmfKzD/x00hZGTtQEWY9mnJkhQ4pmYoiLH5LZRrBM5yphxB6WViTZP2
         BUNHL2gtsCrCwwNfA+fzuX1QrHzGcsfcyuNRonEmJKfdqnrn+/QHVS9vrYzP8I1A7Pjh
         7bBBThuYktzildx5blwPDn9QcJJO550+vb7wNv/4RUsf4c1ZgGowsgiSDk/07NrirVPL
         o6SA==
X-Gm-Message-State: AOAM53176ta2c9dhozhV5jBnCYr/2qiavF1yAAEfYkvMA/+J7EzLEQ6w
        Rr+YWpPYwB9OjHZi9ragxtJJVQ==
X-Google-Smtp-Source: ABdhPJz0H56c29EX1eI0wf0rZke27JXxOA9/8s1bZYMKsmv1nfRfAWELn2LuYxHYEzxR1YOIACFKBQ==
X-Received: by 2002:a17:906:eb82:b0:6f3:9044:5fba with SMTP id mh2-20020a170906eb8200b006f390445fbamr19213483ejb.715.1651659304347;
        Wed, 04 May 2022 03:15:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id gx4-20020a1709068a4400b006f3ef214dc1sm5591621ejc.39.2022.05.04.03.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:15:04 -0700 (PDT)
Date:   Wed, 4 May 2022 12:15:02 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Guenter Roeck <linux@roeck-us.net>,
        Helge Deller <deller@gmx.de>, Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 2/2] fbdev: Make fb_release() return -ENODEV if fbdev was
 unregistered
Message-ID: <YnJSJideWoEF+ZE0@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        Changcheng Deng <deng.changcheng@zte.com.cn>,
        Guenter Roeck <linux@roeck-us.net>, Helge Deller <deller@gmx.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Zheyu Ma <zheyuma97@gmail.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <20220502130944.363776-1-javierm@redhat.com>
 <20220502130944.363776-3-javierm@redhat.com>
 <YnJLzY7Yiax/AwMx@phenom.ffwll.local>
 <8a4d6469-d3c0-833d-40c8-3a786d04eba4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a4d6469-d3c0-833d-40c8-3a786d04eba4@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, May 04, 2022 at 12:09:57PM +0200, Javier Martinez Canillas wrote:
> Hello Daniel,
> 
> On 5/4/22 11:47, Daniel Vetter wrote:
> > On Mon, May 02, 2022 at 03:09:44PM +0200, Javier Martinez Canillas wrote:
> >> A reference to the framebuffer device struct fb_info is stored in the file
> >> private data, but this reference could no longer be valid and must not be
> >> accessed directly. Instead, the file_fb_info() accessor function must be
> >> used since it does sanity checking to make sure that the fb_info is valid.
> >>
> >> This can happen for example if the fbdev driver was one that is using a
> >> framebuffer provided by the system firmware. In that case, the fbdev core
> >> could unregister the framebuffer device if a real video driver is probed.
> >>
> >> Reported-by: Maxime Ripard <maxime@cerno.tech>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > 
> > Doesn't this mean we just leak the references? Also anything the driver
> > might refcount in fb_open would be leaked too.
> >
> 
> It maybe result in leaks, that's true. But I don't think we can do anything
> at this point since the fb_info just went away and the file->private_data
> reference is no longer valid...
>  
> > I'm not sure what exactly you're trying to fix here, but this looks a bit
> > wrong.
> >
> 
> This is fixing a NULL pointer deref that at least 3 people reported, i.e:
> 
> https://github.com/raspberrypi/linux/issues/5011
> 
> Because if a real DRM driver is probed, then the registered framebuffer
> is unregistered and the fb_info just freed. But user-space has no way to
> know and on close the kernel will try to dereference a NULL pointer.

The fb_info shouldn't go boom because that's refcounted with
get/put_fb_info. Maybe we go boom on something else, but the fb_info
itself should work out ok. If it doesn't work, then there's a bug and
papering over it by just leaking it all isn't a solution.

> > Maybe stepping back what fbdev would need, but doesn't have (see the
> > commit reference I dropped on the previous version) is drm_dev_enter/exit
> > around hw access. the file_fb_info check essentially provides that, but
> > with races and everything.
> >
> 
> Yes, but I don't know how that could work since user-space can just open
> the fbdev, mmap it, write to the mmap'ed memory and then close it. The
> only way that this could be done safely AFAICT is if we prevent the real
> video drivers to be registered if the fbdev is currently mmap'ed.
> 
> Otherwise, the firmware initialized framebuffer will go away anyways and
> things will break for the user-space process that's currently using it.

We should probably nuke the mmap and make it SIGBUS. This is essentially
the hotunplug problem, and fixing it properly is very nasty.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
