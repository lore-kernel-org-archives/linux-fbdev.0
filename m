Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC1BC38145
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Sep 2022 19:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiIFTRJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 6 Sep 2022 15:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229676AbiIFTRI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 6 Sep 2022 15:17:08 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C6EA8949
        for <linux-fbdev@vger.kernel.org>; Tue,  6 Sep 2022 12:16:59 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id bd26-20020a05600c1f1a00b003a5e82a6474so8020364wmb.4
        for <linux-fbdev@vger.kernel.org>; Tue, 06 Sep 2022 12:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=JEvsSrJgYklFhGk6ahEcCPzEIfyEDAvxEZnTiVWC9eA=;
        b=cdseVbcCEW+0adnYE1ZJVO9jG5brWhQdSFqN3fOdlrEMZH5usP0dx1z/CJ0XD0J0RL
         bAkiZpqCPSjVrxFM44dQKbC/U98L530af+pqaLl1etXUF0NmN9x37EU2WVo8cMWKcIDI
         7lb6E97Ia78hjxUPcO4toxnqlaOGHpwjpM0oU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=JEvsSrJgYklFhGk6ahEcCPzEIfyEDAvxEZnTiVWC9eA=;
        b=0OXZfAzm2CyKs1nrImpnbx6D7YVcTDoqJFJXjryRA1gmra6XjrbwT3dPvC/Bl/59gV
         uPtI5JowGEA1SLxD0+7mQrj5xt4FDbdrEg0O6gBU8oGQN1QmTXU9m1rentIuDfDNmpZg
         sgccAN9AA49R/Q2cqki0KhshG/TrK2KBdcCD3XbIFmuAdNPUfolXSYb1QCK2Ho1BXy6W
         E5P0EqXtNLTH6Q5LHq9lxNU0flH81tA50JFduKt1Xt40QV5wkdoJKuiJXX6WL4vm+ZFW
         4kIouNli2eb32z/1Q2to8xe9NMPe0rOun2K0q0Idr6QE9ju6feKKGXa1Zd6mfKiIxNkV
         UThw==
X-Gm-Message-State: ACgBeo1CYdnJZKccVptdhrLZO0PrGFugiF3NAlxoxd98ddAXsawGWvrH
        EsmWK2664R05vhikas4fsLf4qQ==
X-Google-Smtp-Source: AA6agR6OuHVb2pFJPiq3+DrxkjfxbowfIdQDMa1KkVrRU9rkHXQXlViPuHiqyxK7ZR4ooN7yTicD5Q==
X-Received: by 2002:a05:600c:2e03:b0:3a5:3928:7958 with SMTP id o3-20020a05600c2e0300b003a539287958mr2411wmf.77.1662491817741;
        Tue, 06 Sep 2022 12:16:57 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id i14-20020a05600c354e00b003a5dde32e4bsm23272538wmq.37.2022.09.06.12.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:16:56 -0700 (PDT)
Date:   Tue, 6 Sep 2022 21:16:54 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Sam Ravnborg <sam@ravnborg.org>,
        Michal Suchanek <msuchanek@suse.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 04/10] drm/simpledrm: Compute framebuffer stride if
 not set
Message-ID: <YxecprE8c8pwy5PB@phenom.ffwll.local>
References: <20220720142732.32041-1-tzimmermann@suse.de>
 <20220720142732.32041-5-tzimmermann@suse.de>
 <CAMuHMdWEah62Ho4C8NQr-qwz62pKQiJiTi8Fa4KcXNRzo7ySJA@mail.gmail.com>
 <4a7c2c1d-2bf9-84e7-9257-41fcfd66ab9d@redhat.com>
 <20f4e5e6-2ff2-af21-1f85-70a545d147bc@suse.de>
 <CAKMK7uGr_SbHAm7r5VNWgpM2cPMFYpCmyE_Aq8TYc84rOAtJpA@mail.gmail.com>
 <33ce5744-5d41-2501-6105-2585529820d2@suse.de>
 <b22b363c-187b-0783-32ab-f9683af2e20a@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b22b363c-187b-0783-32ab-f9683af2e20a@suse.de>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Aug 11, 2022 at 08:27:42PM +0200, Thomas Zimmermann wrote:
> 
> 
> Am 11.08.22 um 20:26 schrieb Thomas Zimmermann:
> > Hi Daniel
> > 
> > Am 11.08.22 um 19:23 schrieb Daniel Vetter:
> > > On Wed, 27 Jul 2022 at 09:53, Thomas Zimmermann
> > > <tzimmermann@suse.de> wrote:
> > > > 
> > > > Hi
> > > > 
> > > > Am 25.07.22 um 17:13 schrieb Javier Martinez Canillas:
> > > > > Hello Geert,
> > > > > 
> > > > > On 7/21/22 16:46, Geert Uytterhoeven wrote:
> > > > > > Hi Thomas,
> > > > > > 
> > > > > > On Wed, Jul 20, 2022 at 4:27 PM Thomas Zimmermann
> > > > > > <tzimmermann@suse.de> wrote:
> > > > > > > Compute the framebuffer's scanline stride length if not given by
> > > > > > > the simplefb data.
> > > > > > > 
> > > > > > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > > > > 
> > > > > > Thanks for your patch!
> > > > > > 
> > > > > > > --- a/drivers/gpu/drm/tiny/simpledrm.c
> > > > > > > +++ b/drivers/gpu/drm/tiny/simpledrm.c
> > > > > > > @@ -743,6 +743,9 @@ static struct simpledrm_device
> > > > > > > *simpledrm_device_create(struct drm_driver *drv,
> > > > > > >                   drm_err(dev, "no simplefb configuration found\n");
> > > > > > >                   return ERR_PTR(-ENODEV);
> > > > > > >           }
> > > > > > > +       if (!stride)
> > > > > > > +               stride = format->cpp[0] * width;
> > > > > > 
> > > > > > DIV_ROUND_UP(drm_format_info_bpp(format) * width, 8)
> > > > > > 
> > > > > 
> > > > > I think you meant here:
> > > > > 
> > > > > DIV_ROUND_UP(drm_format_info_bpp(format, 0) * width, 8) ?
> > > > 
> > > > I guess, that's the right function. My original code is correct, but cpp
> > > > is also deprecated.
> > > 
> > > You all mean drm_format_info_min_pitch().
> > 
> > Thanks a lot. I wasn't even aware of this function, but I had almost
> > written my own implementation of it.  I'll update the patch accordingly.
> 
> Arghh, too late. I merged that patch already.

Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>

Preemptively, if you can do the fixup patch (and it's not yet merged)?
-Daniel

> 
> > 
> > Best regards
> > Thomas
> > 
> > > 
> > > I really don't want drivers to go grab any of the legacy format info
> > > fields like bpp or depth. switch() statements on the fourcc code for
> > > programming registers, or one of the real helper functions in
> > > drm_fourcc.c (there might be some gaps), but not ever going through
> > > legacy concepts. Anything else just leads to subtle bugs when new
> > > formats get added and oops suddenly the assumptions don't hold.
> > > 
> > > Those should be strictly limited to legacy (i.e. not drm_fourcc aware)
> > > interfaces. Heck I think even fbdev emulation should completely switch
> > > over to drm_fourcc/drm_format_info, but alas that's a pile of work and
> > > not much payoff.
> > > 
> > > I'm trying to volunteer Same to add a legacy_bpp tag to the above
> > > helper and appropriately limit it, I think limiting to formats with
> > > depth!=0 is probably the right thing. And then we should probably
> > > remove a pile of the cargo-culted depth!=0 entries too.
> > > -Daniel
> > > 
> > > > 
> > > > Best regards
> > > > Thomas
> > > > 
> > > > > 
> > > > > With that change,
> > > > > 
> > > > > Acked-by: Javier Martinez Canillas <javierm@redhat.com>
> > > > > 
> > > > 
> > > > -- 
> > > > Thomas Zimmermann
> > > > Graphics Driver Developer
> > > > SUSE Software Solutions Germany GmbH
> > > > Maxfeldstr. 5, 90409 Nürnberg, Germany
> > > > (HRB 36809, AG Nürnberg)
> > > > Geschäftsführer: Ivo Totev
> > > 
> > > 
> > > 
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Ivo Totev




-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
