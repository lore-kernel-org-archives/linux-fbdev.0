Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4301C25B07
	for <linux-fbdev@archiver.kernel.org>; Wed, 10 Aug 2022 16:02:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiHJQCf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 10 Aug 2022 12:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbiHJQCS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 10 Aug 2022 12:02:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108D65542
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Aug 2022 09:02:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso1754428wmq.1
        for <linux-fbdev@vger.kernel.org>; Wed, 10 Aug 2022 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc;
        bh=l8/2lnja9nL6p7OH6ZMKU6YrHDC9nL9IFx4bCiysLJE=;
        b=SoMYGdDBirjwK82ZiHhEwxiAU2LXgo/qmYKwj25kGDmr/2HQjxmBszjBG+ULV6eN/7
         +LPICEEUIULROP4JVJdX8Fw5tdWWZcrRdnATTDyJxvXDXn3OTvsv8XTktqud9gtj8wc7
         +y9+jUTHVYAuXJCsCx8wvPIMnMJVqxt22+liQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc;
        bh=l8/2lnja9nL6p7OH6ZMKU6YrHDC9nL9IFx4bCiysLJE=;
        b=tI4Kpb4raSccPCcWQsqguNQZkcmB05o4mSKcJaZU4RjhpNXjiluOdlGcgDQbVwcwVY
         DPiVJ5CGN/09siBwiv+ZQ+aqz5JDVHm6G9bUesTyVUVZGrA1ZvH5okri2QQgRmgmq19m
         gQeuyfbl3Eu25QLOYOBfdx2wYtMltuZTkCUGUjOr1Wdlk6EmyokV2ri6mBJQDAMCYTqF
         ACuRNKM4X6gSUC1r9+6pwV9L4PY9wR5wiYL9UI1TM+aEJFsH9ukXkw0Pe/kN1PVPtGIl
         zBXVtGTQA10CdALbFYyg98YvjUs6o5PWvotTx68umT0UMD0lJ1WxZ2mPIWC6ojqnUp8z
         OkvQ==
X-Gm-Message-State: ACgBeo2xUCS0f1C+goOqNJDGACzL/7z8VKQk6FHbg0a2avlpNh6bjjqp
        o4xvveCFKmFQGzGvwnrjfK7mWQ==
X-Google-Smtp-Source: AA6agR6ZnGhaEqcnZ+/Gihz1HN0O86s73EJ4JBla34lVdwPmBl6ZdnsId1glDTd6IlfJ2YXJxSqa2w==
X-Received: by 2002:a1c:f710:0:b0:394:1960:e8a1 with SMTP id v16-20020a1cf710000000b003941960e8a1mr2999393wmh.154.1660147333609;
        Wed, 10 Aug 2022 09:02:13 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id i5-20020a1c3b05000000b003a503a64e5esm2973492wma.15.2022.08.10.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:02:12 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:02:10 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
        linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] drm: Add support for low-color frame buffer
 formats
Message-ID: <YvPWghWg/+rmc5nx@phenom.ffwll.local>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <cover.1657294931.git.geert@linux-m68k.org>
 <YsmE1D8lGp4XKs99@ravnborg.org>
 <d6e5204e-5bbb-fe51-fd29-5452198bf368@suse.de>
 <Ysvpk4fzef6caO5y@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ysvpk4fzef6caO5y@ravnborg.org>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jul 11, 2022 at 11:12:51AM +0200, Sam Ravnborg wrote:
> Hi Thomas,
> 
> On Mon, Jul 11, 2022 at 10:50:00AM +0200, Thomas Zimmermann wrote:
> > Hi
> > 
> > Am 09.07.22 um 15:38 schrieb Sam Ravnborg:
> > > Hi Geert,
> > > 
> > > On Fri, Jul 08, 2022 at 08:20:45PM +0200, Geert Uytterhoeven wrote:
> > > > 	Hi all,
> > > > 
> > > > A long outstanding issue with the DRM subsystem has been the lack of
> > > > support for low-color displays, as used typically on older desktop
> > > > systems, and on small embedded displays.
> > 
> > For the patchset
> > 
> > Acked-by: Thomas Zimemrmann <tzimmermann@suse.de>
> > 
> > > 
> > > IT is super to have this addressed - thanks!
> > > 
> > > > 
> > > > This patch series adds support for color-indexed frame buffer formats
> > > > with 2, 4, and 16 colors.  It has been tested on ARAnyM using a
> > > > work-in-progress Atari DRM driver supporting 2, 4, 16, 256, and 65536
> > > > colors, with text console operation, fbtest, and modetest.
> > > > 
> > > > Overview:
> > > >    - Patch 1 introduces a helper, to be used by later patches in the
> > > >      series,
> > > >    - Patch 2 introduces a flag to indicate color-indexed formats,
> > > >    - Patches 3 and 4 correct calculations of bits per pixel for sub-byte
> > > >      pixel formats,
> > > >    - Patches 5 and 6 introduce the new C[124] formats,
> > > >    - Patch 7 fixes an untested code path,
> > > >    - Patch 8 documents the use of "red" for light-on-dark displays,
> > > >    - Patches 9 and 10 add more fourcc codes for light-on-dark and
> > > >      dark-on-light frame buffer formats, which may be useful for e.g. the
> > > >      ssd130x and repaper drivers.
> > > 
> > > Applied all patches to drm-misc (drm-misc-next), including the last two
> > > RFC patches as we then have the formats ready when a user pops up.
> > 
> > I know it's v3 already, but give people at least a workday for reviewing
> > before merging patches of this size and impact. Friday-evening patches are
> > not supposed to be merged on Saturday afternoons.
> 
> Sorry for being too enthusiastic on this one.
> Will wait a bit more in the future for these kind of patches.

Took me a bit longer to unburry and get to this, and lgtm except patch 1
where I have a semantic concern. Can you pls do the quick patch to adjust
that? Since this is all about the Cx/Rx/Dx formats I don't think it'll
matter really.

Thanks, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
