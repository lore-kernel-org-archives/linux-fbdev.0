Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF09C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Apr 2022 16:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbiDMQIS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Apr 2022 12:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235176AbiDMQIR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Apr 2022 12:08:17 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6236472B
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Apr 2022 09:05:54 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id b19so3291584wrh.11
        for <linux-fbdev@vger.kernel.org>; Wed, 13 Apr 2022 09:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nPdGkgfedd/A4OP8KwTTe+FHIMRJcA3jhSUiZu8tE4s=;
        b=SMSq1vzhpdQ78zUIkOaNXUt3O9fifj0rXSBWRdwImunuLxqHLuE58sPWO9jCz+Rqps
         JUzCFp9Yp9LHRB2XxmnmQ9qMlaMqOe/uqH8ZYfYk5GGsbLwpVLKfasf4LLCNxk4lJP5O
         Njosm3BtBMYcp5sEyZed8HqQKM9BYZM73WQO4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nPdGkgfedd/A4OP8KwTTe+FHIMRJcA3jhSUiZu8tE4s=;
        b=AKwmymWNQ3ZgdGNsSBEoT3sFWcS3Dm4z7kOfpwxorK8eOPa2HCitSo7Y4KP1w4cJcz
         D4UIy3jTKObjFU3RjmpQkW/sE6W8nqfFAvOv/VlOjDL5XH6x1hmodSGRp8ybCWEpb0Wl
         3pAFdU/BJd5kK9YQZJ8j+8vZOKsbige68zXtN86i0o82rVXCU19L7bdAabIkJ+BMXpwz
         ZR0PHhH9HUwZboMDODE49PnyO6Iir7YJHxEC/XvCr1YxjKFF04xaX25azpVJKSYVhBX6
         oUo9ygB9pw+aHBeov6sr8uk+nBqMmdTddP9cUF6FznD9riHWF2dsPcu5DrkpWidYzuv0
         +m7A==
X-Gm-Message-State: AOAM530rXaYIx2b92pU3+Xmz3IvBgDacGYyfrMMn2TFPkvHkIiwQwQy5
        P0HVK8nDSSsx3krxamgc48ikKg==
X-Google-Smtp-Source: ABdhPJxCHSZR6sOhR82MWDqkHkKQxYBi5t7yzBdb+67OAJKLu81jjVxRF6LbEco5kZi775i1Cfk2zw==
X-Received: by 2002:adf:e944:0:b0:207:af9e:a4e7 with SMTP id m4-20020adfe944000000b00207af9ea4e7mr6330680wrn.296.1649865953497;
        Wed, 13 Apr 2022 09:05:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o6-20020a05600c378600b0038eca3cdbb3sm2716964wmr.13.2022.04.13.09.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 09:05:53 -0700 (PDT)
Date:   Wed, 13 Apr 2022 18:05:51 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>, robh+dt@kernel.org,
        frowand.list@gmail.com, daniel@ffwll.ch, deller@gmx.de,
        sam@ravnborg.org, linux@roeck-us.net, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] fbdev: Remove hot-unplug workaround for framebuffers
 without device
Message-ID: <Ylb0316ABOhOe1Rb@phenom.ffwll.local>
References: <20220413092454.1073-1-tzimmermann@suse.de>
 <20220413092454.1073-3-tzimmermann@suse.de>
 <2e183cc9-603d-f038-54aa-5601f11b0484@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e183cc9-603d-f038-54aa-5601f11b0484@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 13, 2022 at 12:50:50PM +0200, Javier Martinez Canillas wrote:
> On 4/13/22 11:24, Thomas Zimmermann wrote:
> > A workaround makes fbdev hot-unplugging work for framebuffers without
> > device. The only user for this feature was offb. As each OF framebuffer
> > now has an associated platform device, the workaround is no longer
> > needed. Remove it. Effectively reverts commit 0f525289ff0d ("fbdev: Fix
> > unregistering of framebuffers without device").
> > 
> > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > ---
> >  drivers/video/fbdev/core/fbmem.c | 9 +--------
> >  1 file changed, 1 insertion(+), 8 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > index bc6ed750e915..bdd00d381bbc 100644
> > --- a/drivers/video/fbdev/core/fbmem.c
> > +++ b/drivers/video/fbdev/core/fbmem.c
> > @@ -1579,14 +1579,7 @@ static void do_remove_conflicting_framebuffers(struct apertures_struct *a,
> >  			 * If it's not a platform device, at least print a warning. A
> >  			 * fix would add code to remove the device from the system.
> >  			 */
> > -			if (!device) {
> > -				/* TODO: Represent each OF framebuffer as its own
> > -				 * device in the device hierarchy. For now, offb
> > -				 * doesn't have such a device, so unregister the
> > -				 * framebuffer as before without warning.
> > -				 */
> > -				do_unregister_framebuffer(registered_fb[i]);
> 
> Maybe we could still keep this for a couple of releases but with a big
> warning that's not supported in case there are out-of-tree drivers out
> there that still do this ?
> 
> Or at least a warning if the do_unregister_framebuffer() call is removed.

Yeah dying while holding console_lock isn't fun, and not having a WARN_ON
+ bail-out code pretty much forces bug reporters to do a bisect here to
give us something more than "machine dies at boot with no messages".

I'd just outright keep the WARN_ON here for 1-2 years even to really make
sure we got all the bug reports, since often these older machines only
update onto LTS releases.

And it needs to be a WARN_ON + bail out since BUG_ON is as bad as just
oopsing.
-Daniel

> 
> Regardless of what you chose to do, the patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> 
> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
