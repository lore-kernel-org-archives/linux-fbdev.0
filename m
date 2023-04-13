Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6346C77B6E
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 Apr 2023 20:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjDMUB3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 13 Apr 2023 16:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbjDMUB2 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 13 Apr 2023 16:01:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B28E98A4F
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Apr 2023 13:01:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-2ef1e98d6bfso526126f8f.0
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Apr 2023 13:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1681416085; x=1684008085;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LoVUNaZaM2XfpV6KT9jjTvveGKx0rUw/FJ3BSvzxFDA=;
        b=QeCMIubWV2ZxjUSHK/YaYnO6aOMuTOVF3qS7K8TyjovrtKBrfuYOPntlMgGyMFruap
         c2pdeQsFGbxIr4fcwVeuI0s1ofA8uh4RjAlceoeFGIgElrdzwRJLt3HV22O/VHwMWvPg
         g9WSb3e3rDnYTPjuzJDUr7MyGE1Sd0TR2PMXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681416085; x=1684008085;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LoVUNaZaM2XfpV6KT9jjTvveGKx0rUw/FJ3BSvzxFDA=;
        b=iBxEdlryxxSoYQ5XzDa13Q/pTLqkTwhSEp/aivleawH9E59SAw6wPbMRyEcQCozylB
         HGcKON7dgc1N05cUr3kRS/0wDShUcgekITJgqAJ5aq3vHM1pxaGFDl+lngaY0Kus7G5s
         2yfZxagYzI+yK74RhmUIUlcHWVOzBOr6BNnVA7jg1WulxIWUgQ9rV4HahtLl1wAmL8Ob
         s9erOoVZSfFvpw/Nx6m3P1s0YrQcU2jbivrBpyZ2+TGaOoBJ+9uCekBMHMKoHkOAkhvE
         itPZlQsji2xFkJYxchOErPYG5b9eahW6WmpehrSUZ4ITNhAKRodIAyshH9j82yKsBb8V
         emfA==
X-Gm-Message-State: AAQBX9dIk1lU8GIxAJPx6m+nGuXYzn8pLYjI6VLdr0GW50/+qREC45HB
        HWwiuPT8Z9UDS3VA0np+2UVdxA==
X-Google-Smtp-Source: AKy350Z+twkvFRjVeJgVSWcMWzX3CHPi3LHk5n6KqDKM64KPi/KoFdjY01LEeLcmORKirWVo8YW3iQ==
X-Received: by 2002:a05:600c:19cc:b0:3f0:80fe:212d with SMTP id u12-20020a05600c19cc00b003f080fe212dmr2932147wmq.3.1681416085158;
        Thu, 13 Apr 2023 13:01:25 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id l20-20020a7bc454000000b003ed2276cd0dsm2620041wmi.38.2023.04.13.13.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 13:01:24 -0700 (PDT)
Date:   Thu, 13 Apr 2023 22:01:22 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH] drm/fbdev-generic: fix potential out-of-bounds access
Message-ID: <ZDhfkq92hbGc630z@phenom.ffwll.local>
Mail-Followup-To: Thomas Zimmermann <tzimmermann@suse.de>,
        Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>, Li Yi <liyi@loongson.cn>,
        Helge Deller <deller@gmx.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, loongson-kernel@lists.loongnix.cn
References: <20230409132110.494630-1-15330273260@189.cn>
 <ZDV0Te65tSh4Q/vc@phenom.ffwll.local>
 <42f16d0d-4e1a-a016-f4cc-af24efa75f1c@189.cn>
 <ZDbuCWKfFlWyiOGp@phenom.ffwll.local>
 <dbac96b2-0fea-591b-517d-2a23cc36b8de@189.cn>
 <CAKMK7uG_h7htCDARudZpHOOMG4iOOLZmz0_WskvWGf+DKGwU1w@mail.gmail.com>
 <531f0bdf-2ae8-0361-183b-57b40df6345f@189.cn>
 <ZDhQW6El6ztyHK4M@phenom.ffwll.local>
 <1bbc7228-c2fe-0af0-c15c-b378bc4d111c@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1bbc7228-c2fe-0af0-c15c-b378bc4d111c@suse.de>
X-Operating-System: Linux phenom 6.1.0-7-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Apr 13, 2023 at 09:20:23PM +0200, Thomas Zimmermann wrote:
> Hi
> 
> Am 13.04.23 um 20:56 schrieb Daniel Vetter:
> [...]
> > 
> > This should switch the existing code over to using drm_framebuffer instead
> > of fbdev:
> > 
> > 
> > diff --git a/drivers/gpu/drm/drm_fb_helper.c b/drivers/gpu/drm/drm_fb_helper.c
> > index ef4eb8b12766..99ca69dd432f 100644
> > --- a/drivers/gpu/drm/drm_fb_helper.c
> > +++ b/drivers/gpu/drm/drm_fb_helper.c
> > @@ -647,22 +647,26 @@ static void drm_fb_helper_damage(struct drm_fb_helper *helper, u32 x, u32 y,
> >   static void drm_fb_helper_memory_range_to_clip(struct fb_info *info, off_t off, size_t len,
> >   					       struct drm_rect *clip)
> >   {
> > +	struct drm_fb_helper *helper = info->par;
> > +
> >   	off_t end = off + len;
> >   	u32 x1 = 0;
> >   	u32 y1 = off / info->fix.line_length;
> > -	u32 x2 = info->var.xres;
> > -	u32 y2 = DIV_ROUND_UP(end, info->fix.line_length);
> > +	u32 x2 = helper->fb->height;
> > +	unsigned stride = helper->fb->pitches[0];
> > +	u32 y2 = DIV_ROUND_UP(end, stride);
> > +	int bpp = drm_format_info_bpp(helper->fb->format, 0);
> 
> Please DONT do that. The code here is fbdev code and shouldn't bother about
> DRM data structures. Actually, it shouldn't be here: a number of fbdev
> drivers with deferred I/O contain similar code and the fbdev module should
> provide us with a helper. (I think I even had some patches somewhere.)

Well my thinking is that it's a drm driver, so if we have issue with limit
checks blowing up it makes more sense to check them against drm limits.
Plus a lot more people understand those than fbdev. They should all match
anyway, or if they dont, we have a bug. The thing is, if you change this
further to just pass the drm_framebuffer, then this 100% becomes a drm
function, which could be used by anything in drm really.

But also *shrug*.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
