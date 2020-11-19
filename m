Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EAFFC6369E
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Nov 2020 15:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A83E322264
	for <linux-fbdev@archiver.kernel.org>; Thu, 19 Nov 2020 15:11:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="KrpNjX0W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbgKSPLL (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbgKSPLL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 19 Nov 2020 10:11:11 -0500
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CD3CC0613CF
        for <linux-fbdev@vger.kernel.org>; Thu, 19 Nov 2020 07:11:09 -0800 (PST)
Received: by mail-oi1-x242.google.com with SMTP id m13so6631774oih.8
        for <linux-fbdev@vger.kernel.org>; Thu, 19 Nov 2020 07:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JdqkWSW9a1z1SVdGoG8hy8zdS0knZMDZmMXxm1Wmdt8=;
        b=KrpNjX0WODmJF84y1iHPQX2qZzuES2LX2P221m9sJNTfwuwxu6hpK4JWFdrL2/H5lY
         Pu2WuXCypBceXoEf03QRJdC7ZJdypKeOjpID7SvyV9Kp8PqELasCnGMV2vabViZccRXg
         Z3lf1rvu/Q6tKBeVdO3AFO9IamwuuvldZgG68=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JdqkWSW9a1z1SVdGoG8hy8zdS0knZMDZmMXxm1Wmdt8=;
        b=Dmw92cMIL73P7x9atg2UKlfGF8xePmxxYbR+p1XPAjrEAcbwisKpsx+z/hBs04FwIz
         sLqp6ReLot2VOfsUK3GV7BcEBBS7+GNNnQu8S0sjGoqbOmgxGqqgqpvpChLKLgrgmMCW
         M33CILCVc2ZHCERvwN63MhKQ5hVLztfzAB14KQ78hAMckapq8WdYdBujvWGhDOn6HgJi
         cTEDPTFIQX+hor7DgwITwcDEJitpCa/1Aq1jy+wwuVe2TYLkKmINjOLAaOlfRx2zsOpS
         hknueL/DWac5ahJ+xxcmre9TiS3Vm97+RZaCHq7n+IoZ8CwKqtleNgZ7LCIeFukg0Q3B
         jjmg==
X-Gm-Message-State: AOAM532Kg5ePELjMwa3tFOYnou7MkQgf/wYxVPtk2j4D4tmTGtxwhqQz
        3RwtsN/QPDJ52HfOgQtXhXXD5LJnOuLo4nirphab1Q==
X-Google-Smtp-Source: ABdhPJyc3DHapCPUR/HHhc1a36YrqgEuXr50FTsLT0tmaXXDtJYaO8t+L+SGEMGffyuWBGHKy8w0p+PMlAMqkU19f0Q=
X-Received: by 2002:aca:7506:: with SMTP id q6mr3200770oic.128.1605798668916;
 Thu, 19 Nov 2020 07:11:08 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605169912.git.yepeilin.cs@gmail.com> <20201113211633.GY401619@phenom.ffwll.local>
 <X68NFzaAuImemnqh@kroah.com> <20201114081021.GA11811@PWN> <X6/K/S9V7rj2hI5p@kroah.com>
 <X6/L/lE2pA7csBwd@kroah.com> <20201119083257.GA9468@PWN>
In-Reply-To: <20201119083257.GA9468@PWN>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 19 Nov 2020 16:10:57 +0100
Message-ID: <CAKMK7uF_AOrfTDVZwmxn_C-5sTBDu_v9KGH07wO5hTa98Z8Ucg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] console: Miscellaneous clean-ups, do not use
 FNTCHARCNT() in fbcon.c
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 19, 2020 at 9:33 AM Peilin Ye <yepeilin.cs@gmail.com> wrote:
>
> On Sat, Nov 14, 2020 at 01:22:22PM +0100, Greg Kroah-Hartman wrote:
> > Ah, here's a hint:
> >       https://wiki.archlinux.org/index.php/Linux_console#Fonts
> >
> > The setfont tool should help you out here.
>
> setfont seems to work fine, I tried Georgian-Fixed16 (256 chars) and
> Uni2-VGA16 (512 chars) under /usr/share/consolefonts/ in my Ubuntu box,
> including setting all consoles to the same font:
>
> for i in {1..6}; do
>         sudo setfont -C /dev/tty${i} /usr/share/consolefonts/Georgian-Fixed16.psf.gz
> done
>
> Font rotation also seems to work fine:
>
> for i in {1..4}; do
>         echo $i | sudo tee /sys/class/graphics/fbcon/rotate
>         sleep 1
> done

Thanks a lot for checking all this.

> One last thing I can think of is tile blitting, but I don't have the
> hardware (e.g. a Matrox G400 card, see FB_TILEBLITTING in
> drivers/video/fbdev/Kconfig) at hand, nor did I figure out how to
> simulate it after searching for a while.  However based on the other
> tests above I believe vc->vc_font.charcount is set properly.

tbh I'll just go ahead and delete it if it's broken :-)

Userspace we have to keep working (and there's actually people
creating new products on top of drm display drivers using fbdev
emulation and /dev/fb/0 interface!), but kernel internal stuff like
fbcon acceleration we can trim pretty aggressively I think.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
