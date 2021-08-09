Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC24C4338F
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Aug 2021 14:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C47F60F38
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Aug 2021 14:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234883AbhHIOT5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Aug 2021 10:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234877AbhHIOTu (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Aug 2021 10:19:50 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA100C061798
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Aug 2021 07:19:29 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id m28-20020a05600c3b1cb02902b5a8c22575so141041wms.0
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Aug 2021 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=asxuMfNmFDWbe1m96nTaMaCjzDZkLvcWUtq3w1gIv78=;
        b=hVtNv1XFAgn8MUGa02a/+tdWVdwlEUGaeV68PhLvuybTC7YGe6NTPO9Zb6P06nuhWL
         2xE8f5IIL5uz+Dm+bEPjXApIwtrCn5V269188Dz9vzSdmGYfC1Xab1w7phY/l/x+MsdY
         Ai33OPC4NjMYl4ETLa7Hzfjn1nRT5NG+Kh1WA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=asxuMfNmFDWbe1m96nTaMaCjzDZkLvcWUtq3w1gIv78=;
        b=Vd/FXSztXPuW2eE0+scPJSvm62I+A56dszjUH+JWVJnJ/bBFnzKW4tKEUX/w/CDLt0
         UrAcYTFPFz7ajS4JHhOBXpLL7LDgv+RUqBs65dPaehbdui7RGIMpEAPK0vzCGOFRCkpN
         A8RPY46cI4fde226WRyQBZXbJwBI/uFksLlgB8VYjiJJHDWQfeyTF3piYXmevCSlfzRn
         Y0JqCWNTtAFobgbYMURPArFXXQqDGtdN+zVyrS+U+FwTuEcFWsJKpGcT4LTpegBfW4d+
         aQFN1mS9Qa7Nj4GATc0CZNB9jBdZ1j8ruWLEMUVL0EeSVTdJjWRE/AAgZ9oaHXmPei7J
         wMKw==
X-Gm-Message-State: AOAM530QFeMTMyMG/TvL7fUTdjtNmIUiVf8bSUlnXI1bYcXdHE4gTymQ
        FnpCTgyGj8Z/rP5K2j1J57sX1w==
X-Google-Smtp-Source: ABdhPJzCprHZRWVc+gVADu7DGEw4x5JaA6CKsPhvZyVNbvyGY5GvZgsgoXI/ydusr4z3zDID/L6Piw==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr34033986wmh.99.1628518768465;
        Mon, 09 Aug 2021 07:19:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id u25sm4526123wml.8.2021.08.09.07.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Aug 2021 07:19:27 -0700 (PDT)
Date:   Mon, 9 Aug 2021 16:19:25 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Imre Deak <imre.deak@intel.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [Intel-gfx] [PATCH] fbdev/efifb: Release PCI device's runtime PM
 ref during FB destroy
Message-ID: <YRE5bbarqMW9AV5T@phenom.ffwll.local>
References: <20210802133551.1904964-1-imre.deak@intel.com>
 <YQsTWSGIgY00XEU7@phenom.ffwll.local>
 <20210807152110.GA2390730@ideak-desk.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210807152110.GA2390730@ideak-desk.fi.intel.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Aug 07, 2021 at 06:21:10PM +0300, Imre Deak wrote:
> On Thu, Aug 05, 2021 at 12:23:21AM +0200, Daniel Vetter wrote:
> > On Mon, Aug 02, 2021 at 04:35:51PM +0300, Imre Deak wrote:
> > > Atm the EFI FB driver gets a runtime PM reference for the associated GFX
> > > PCI device during driver probing and releases it only when removing the
> > > driver.
> > > 
> > > When fbcon switches to the FB provided by the PCI device's driver (for
> > > instance i915/drmfb), the EFI FB will get only unregistered without the
> > > EFI FB driver getting unloaded, keeping the runtime PM reference
> > > acquired during driver probing. This reference will prevent the PCI
> > > driver from runtime suspending the device.
> > > 
> > > Fix this by releasing the RPM reference from the EFI FB's destroy hook,
> > > called when the FB gets unregistered.
> > > 
> > > Fixes: a6c0fd3d5a8b ("efifb: Ensure graphics device for efifb stays at PCI D0")
> > > Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
> > > Signed-off-by: Imre Deak <imre.deak@intel.com>
> > 
> > Patch looks good:
> > 
> > Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > 
> > But I've found a bunch of ordering issues here:
> > - we should probably get the runtime pm reference _before_ we register the
> >   framebuffer. There's a race right now about there.
> 
> Yea, missed this will send a v2 moving it earlier.
> 
> > - the sysfs_remove_groups and framebuffer_release should also be moved
> >   into the destroy callback. This is more a leak type of situation.
> 
> Those sysfs entries belong to the efifb platform device, showing the
> bootup screen_info.lfb_* info, not related to fb_info, so imo
> efifb_remove() is the correct place to remove those. But yes, freeing
> fb_info seems to belong to fb_destroy().

Ah ok. Might be good to put a comment down that this isn't tied to fb_info
lifetime.

> Atm, things will blow up when unbinding the efifb device after the efifb
> framebuffer was unregistered while removing it as a conflicting FB
> (since unregister_framebuffer() will be called twice), so that would
> need to be solved as well. Maybe remove_conflicting_pci_framebuffers()
> could unregister the platform device instead of only unregistering the
> framebuffer, similarly to drm_aperture_detach_firmware(), but haven't
> checked this in more detail.

Yeah either that, or a double-unregister check (plus correct refcount) in
unregister_framebuffer. Ideally with a check so that only the
double-unregstier from remove_conflicting_pci_framebuffers is caught, and
not a driver that accidentally unregisters the fbdev twice.

Even better if this would be all devm_ wrapped so it's idiot proof.

I think generally I'd say "let's not invest in fbdev", but a) these
hotremove/unload bugs have been hurting us since forever, and b) efifb
seems to be bound to stay around for a very long time - the simpldrmfb
stuff isn't really moving forward very fast.

Anyway, would be good to get this all sorted eventually.
-Daniel

> 
> > Cheers, Daniel
> > 
> > > ---
> > >  drivers/video/fbdev/efifb.c | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/video/fbdev/efifb.c b/drivers/video/fbdev/efifb.c
> > > index 8ea8f079cde26..25cdea32b9633 100644
> > > --- a/drivers/video/fbdev/efifb.c
> > > +++ b/drivers/video/fbdev/efifb.c
> > > @@ -47,6 +47,8 @@ static bool use_bgrt = true;
> > >  static bool request_mem_succeeded = false;
> > >  static u64 mem_flags = EFI_MEMORY_WC | EFI_MEMORY_UC;
> > >  
> > > +static struct pci_dev *efifb_pci_dev;	/* dev with BAR covering the efifb */
> > > +
> > >  static struct fb_var_screeninfo efifb_defined = {
> > >  	.activate		= FB_ACTIVATE_NOW,
> > >  	.height			= -1,
> > > @@ -243,6 +245,9 @@ static inline void efifb_show_boot_graphics(struct fb_info *info) {}
> > >  
> > >  static void efifb_destroy(struct fb_info *info)
> > >  {
> > > +	if (efifb_pci_dev)
> > > +		pm_runtime_put(&efifb_pci_dev->dev);
> > > +
> > >  	if (info->screen_base) {
> > >  		if (mem_flags & (EFI_MEMORY_UC | EFI_MEMORY_WC))
> > >  			iounmap(info->screen_base);
> > > @@ -333,7 +338,6 @@ ATTRIBUTE_GROUPS(efifb);
> > >  
> > >  static bool pci_dev_disabled;	/* FB base matches BAR of a disabled device */
> > >  
> > > -static struct pci_dev *efifb_pci_dev;	/* dev with BAR covering the efifb */
> > >  static struct resource *bar_resource;
> > >  static u64 bar_offset;
> > >  
> > > @@ -603,8 +607,6 @@ static int efifb_remove(struct platform_device *pdev)
> > >  	unregister_framebuffer(info);
> > >  	sysfs_remove_groups(&pdev->dev.kobj, efifb_groups);
> > >  	framebuffer_release(info);
> > > -	if (efifb_pci_dev)
> > > -		pm_runtime_put(&efifb_pci_dev->dev);
> > >  
> > >  	return 0;
> > >  }
> > > -- 
> > > 2.27.0
> > > 
> > 
> > -- 
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
