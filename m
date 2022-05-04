Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9ABC433F5
	for <linux-fbdev@archiver.kernel.org>; Wed,  4 May 2022 10:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiEDK7k (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 4 May 2022 06:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiEDK7j (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 4 May 2022 06:59:39 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604BA1AF3B
        for <linux-fbdev@vger.kernel.org>; Wed,  4 May 2022 03:56:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a21so1267107edb.1
        for <linux-fbdev@vger.kernel.org>; Wed, 04 May 2022 03:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BwmxO4LfRKvng41X4d9TcCe1iGtUUpTYikAKxiB/Gus=;
        b=Swq9OPFU/H4vH2Zso3oK+hWWf8Zk79dtPwZyJxnvxTO27XQ0mCO4ki2l3dD/76/HIg
         qrBoZeeReTzGg60P5BDnT9yXTZoUZfB+sXY6JI9sADjoNhJgBEUCy4Jh5L06/nx3e18+
         tdoPGenpO+xOsuPdsCP52sWU6g9Vh4J1Lvc3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BwmxO4LfRKvng41X4d9TcCe1iGtUUpTYikAKxiB/Gus=;
        b=RYJ/PdRh3kHvgqtyBV1wXgen+sEBATi3sd2x0PCLwflkP9muOnxE2dicyM3VaJtSQ7
         luyqmgSugneOv/t68BvXDjbFrLB8PdqIQylOYgL8LQe7cI5HMpp48qhnotmYQwbhk/dh
         2f6KcZUNUcgcOaZxDwQoGpdBqG2QE+isLQ2Vt9XkbPBIZeiPK5Vpu1A+x1U33bJ5h7Ip
         yEeVf6Xt3eyrl8ahsBnRYsMMf3xAIQOZ99f0/6yZQYjMWw6a963c4dTQ0cKgD5TfFDWR
         80PbFy65qblF/l5zsel4snajHKJs9r5D0fAe+LZSx44QMUXZhuro6IABFhF/53HfFFeA
         ae4A==
X-Gm-Message-State: AOAM530DPg7BfitPYtvsVRXgM+lTcDlkaZirCnCswPoObSXxKT7TwH1l
        h0xlxFVrF/1JVy6i/xDMoiq00w==
X-Google-Smtp-Source: ABdhPJy+B5Wk9GR7mKblkgeRGx069oBIqEL+VbT3G8TD0KUPLgPlnzfCa6TvbjeSkUISaS9jyUFQkw==
X-Received: by 2002:a05:6402:42c3:b0:427:d0e6:77e4 with SMTP id i3-20020a05640242c300b00427d0e677e4mr11472180edc.49.1651661759975;
        Wed, 04 May 2022 03:55:59 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id qx16-20020a170907b59000b006f3ef214e60sm5568170ejc.198.2022.05.04.03.55.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 03:55:59 -0700 (PDT)
Date:   Wed, 4 May 2022 12:55:57 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2] fbdev: Use helper to get fb_info in all file
 operations
Message-ID: <YnJbvb5TlHs4ckPM@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Junxiao Chang <junxiao.chang@intel.com>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>
References: <20220503201934.681276-1-javierm@redhat.com>
 <YnJBGpvlViLV+0/a@phenom.ffwll.local>
 <038f8365-b23b-9d81-f7b2-8f8c6eb3a065@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <038f8365-b23b-9d81-f7b2-8f8c6eb3a065@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, May 04, 2022 at 11:28:07AM +0200, Javier Martinez Canillas wrote:
> Hello Daniel,
> 
> On 5/4/22 11:02, Daniel Vetter wrote:
> > On Tue, May 03, 2022 at 10:19:34PM +0200, Javier Martinez Canillas wrote:
> >> A reference to the framebuffer device struct fb_info is stored in the file
> >> private data, but this reference could no longer be valid and must not be
> >> accessed directly. Instead, the file_fb_info() accessor function must be
> >> used since it does sanity checking to make sure that the fb_info is valid.
> >>
> >> This can happen for example if the registered framebuffer device is for a
> >> driver that just uses a framebuffer provided by the system firmware. In
> >> that case, the fbdev core would unregister the framebuffer device when a
> >> real video driver is probed and ask to remove conflicting framebuffers.
> >>
> >> Most fbdev file operations already use the helper to get the fb_info but
> >> get_fb_unmapped_area() and fb_deferred_io_fsync() don't. Fix those two.
> >>
> >> Since fb_deferred_io_fsync() is not in fbmem.o, the helper has to be
> >> exported. Rename it and add a fb_ prefix to denote that is public now.
> >>
> >> Reported-by: Junxiao Chang <junxiao.chang@intel.com>
> >> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > 
> > Note that fb_file_info is hilariously racy since there's nothing
> > preventing a concurrenct framebuffer_unregister. Or at least I'm not
> > seeing anything. See cf4a3ae4ef33 ("fbdev: lock_fb_info cannot fail") for
> > context, maybe reference that commit here in your patch.
> >
> > Either way this doesn't really make anything worse, so
> > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >
> 
> Yes, I noticed is racy but at least checking this makes less likely to
> occur. And thanks, I'll reference that commit in the description of v3.
> 
> BTW, I also noticed that the same race that happens with open(),read(),
> close(), etc happens with the VM operations:
> 
> int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
> {
> ...
> 	vma->vm_private_data = info;
> ...
> }
> 
> static vm_fault_t fb_deferred_io_fault(struct vm_fault *vmf)
> {
> ...
> 	struct fb_info *info = vmf->vma->vm_private_data;
> ...
> }
> 
> static vm_fault_t fb_deferred_io_mkwrite(struct vm_fault *vmf)
> {
> ...
> 	struct fb_info *info = vmf->vma->vm_private_data;
> ...
> }
> 
> So something similar to fb_file_fb_info() is needed to check if
> the vm_private_data is still valid. I guess that could be done
> by using the vmf->vma->vm_file and attempting the same trick that
> fb_file_fb_info() does ?

Yeah should work, except if the ptes are set up already there's kinda not
much that this will prevent. We'd need to tear down mappings and SIGBUS or
alternatively have something else in place there so userspace doesn't blow
up in funny ways (which is what we're doing on the drm side, or at least
trying to).

I'm also not sure how much we should care, since ideally for drm drivers
this is all taken care of by drm_dev_enter in the right places. It does
mean though that fbdev mmap either needs to have it's own memory or be
fully redirected to the drm gem mmap.

And then we can afford to just not care to fix fbdev itself.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
