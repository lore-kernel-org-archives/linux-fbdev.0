Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A40C5519F
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Nov 2020 08:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C25822224E
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Nov 2020 08:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snNm9pC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbgKTIiN (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Nov 2020 03:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgKTIiM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Nov 2020 03:38:12 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32959C0613CF;
        Fri, 20 Nov 2020 00:38:11 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id 18so4487066pli.13;
        Fri, 20 Nov 2020 00:38:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QAUc4Ub5+Y3djr8Wh3AbCUd5SdWIv4X0tY5hn9hKdt8=;
        b=snNm9pC6XV1go7TTASQGweKXyAqpCr/SaohJmx+I2RzFXmitx7H/F02KJuuzXTfT1+
         cwSuCOIvlPm2GDpZOCinB+Iboyw79hJ2j7Ev39CHHihaudEtEnK2yJsuT9CcDm76qWMp
         LDEgTAsi1yoSEtlcEGwOTNR6dwc0POo5XRsV6caDp2Rhk9X71FsRLR8URL9kFRu+sCIf
         ZLL0D5IJVZ8cg858ij2Z8ofV7ebFDkjYC4+hrVDNbSD/6xUHbXa25BCrLTFz4gUEbAXE
         7tvzOrF8nuOuQXhaKzQoUqT0JZmYct1CIp3H778ndnMVDazSjFGkIMkIdGym98hYVL9b
         khaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QAUc4Ub5+Y3djr8Wh3AbCUd5SdWIv4X0tY5hn9hKdt8=;
        b=SHvONzuV7SsoMjJH3XMJIZ5n+7QgjuClMGCJdyhYHOwwlXt6ekvYSP22VU/FQEawLs
         xosd5AZFsxmpCaTz+rFxu1kaElpEjrM4ryyWCrPd3HBOd/gEoDcFoI0eSW5QjTtX3wCm
         ebllDtGnwG4m9vC3H2Kgx/yFEXXtaoR6hf7Rq0cAmA5YoZio/Tzhb8vMq6yfuL1gBdZC
         mU78jIDZn29Yx5NvGuA4jK4gWA8Xm9crCPMrYZDLIWwR8D+eRZ6CwN+Jh/9IALctjt15
         h1pil/HB+5l8C6axI4d7/xANamZPEwMfNUb+2zmfc7ShYcXuuMBsGvnncSH+Pc3edeqQ
         mB4w==
X-Gm-Message-State: AOAM532rZY/3njJTYNJR23eJGL3Mz4XLvsM/KUrEY/QWGnzXnhwjK3aI
        eU6/VKsu+v+W0TEMjP0eS3dV1x388yDMtbQ=
X-Google-Smtp-Source: ABdhPJwlu2LHYylFDBD6KVOQDJWBCCnjVfbH4aRAQvBloxHrVnSqnSMTzRPOEsTTU1UbmLD35qMokg==
X-Received: by 2002:a17:902:244:b029:d6:c451:8566 with SMTP id 62-20020a1709020244b02900d6c4518566mr12441583plc.46.1605861490749;
        Fri, 20 Nov 2020 00:38:10 -0800 (PST)
Received: from PWN (59-125-13-244.HINET-IP.hinet.net. [59.125.13.244])
        by smtp.gmail.com with ESMTPSA id w18sm2715971pfi.216.2020.11.20.00.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 00:38:10 -0800 (PST)
Date:   Fri, 20 Nov 2020 03:37:39 -0500
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
Message-ID: <20201120073245.GA24568@PWN>
References: <cover.1605169912.git.yepeilin.cs@gmail.com>
 <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com>
 <20201114081021.GA11811@PWN>
 <X6/K/S9V7rj2hI5p@kroah.com>
 <X6/L/lE2pA7csBwd@kroah.com>
 <20201119083257.GA9468@PWN>
 <CAKMK7uF_AOrfTDVZwmxn_C-5sTBDu_v9KGH07wO5hTa98Z8Ucg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uF_AOrfTDVZwmxn_C-5sTBDu_v9KGH07wO5hTa98Z8Ucg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 19, 2020 at 04:10:57PM +0100, Daniel Vetter wrote:
> On Thu, Nov 19, 2020 at 9:33 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > setfont seems to work fine, I tried Georgian-Fixed16 (256 chars) and
> > Uni2-VGA16 (512 chars) under /usr/share/consolefonts/ in my Ubuntu box,
> > including setting all consoles to the same font:
> >
> > for i in {1..6}; do
> >         sudo setfont -C /dev/tty${i} /usr/share/consolefonts/Georgian-Fixed16.psf.gz
> > done
> >
> > Font rotation also seems to work fine:
> >
> > for i in {1..4}; do
> >         echo $i | sudo tee /sys/class/graphics/fbcon/rotate
> >         sleep 1
> > done
> 
> Thanks a lot for checking all this.

Not a problem, watching my console rotating was fun :)

> > One last thing I can think of is tile blitting, but I don't have the
> > hardware (e.g. a Matrox G400 card, see FB_TILEBLITTING in
> > drivers/video/fbdev/Kconfig) at hand, nor did I figure out how to
> > simulate it after searching for a while.  However based on the other
> > tests above I believe vc->vc_font.charcount is set properly.
> 
> tbh I'll just go ahead and delete it if it's broken :-)
> 
> Userspace we have to keep working (and there's actually people
> creating new products on top of drm display drivers using fbdev
> emulation and /dev/fb/0 interface!), but kernel internal stuff like
> fbcon acceleration we can trim pretty aggressively I think.

Ah, I see, I'll leave it be, then.

Thanks,
Peilin Ye

