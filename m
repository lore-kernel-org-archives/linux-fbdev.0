Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1370C433EF
	for <linux-fbdev@archiver.kernel.org>; Sun, 26 Jun 2022 08:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbiFZIt2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 26 Jun 2022 04:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiFZIt1 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 26 Jun 2022 04:49:27 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C7011453
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 01:49:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id ej4so9072464edb.7
        for <linux-fbdev@vger.kernel.org>; Sun, 26 Jun 2022 01:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GNdchxRslazyj5SgOwFKdUehViH56RrEi3mJbYurW6k=;
        b=V++vrujWFfFurayWgFtPQXQi4iRTnmlF1pUXa1JKynRk2W22zd2T2d6ZYefTtjep6w
         w0B80maccWuW7EGNnZLf8gOCYJFQ9I2Ve9OhVxf3ZhVRGvb6Z7AsW//PMVO7MFc23BpX
         v7yI/TXTw9eVKFBDLrZ4nzPbcvpP2OeMYM+fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GNdchxRslazyj5SgOwFKdUehViH56RrEi3mJbYurW6k=;
        b=3M+ojPQoZdafS5TgUL706JCy9jCKdf2GhiSzzDEvSzh+q6yIWb0Vj12TZScUv6R7Am
         a9F13MpQAHxHrAwPaXZVm4t24V96avHM2R7yJRhvivvINCn6ymvcaEv3S4yQkSc3XP1n
         nQ+tdCnAv6lbKpUaK6Ydn/EKL3Khx7Rm9czOWmmH61aYSwZ9adnDVCG1S8wwuBr8qpw9
         sD7y6TzGODCxHSAx2n94lbECNkxKL2OG+hFO6IVA/1a5KCpmDN4XQKd2EjQi3e8SRfPC
         FgryhQBSPZu+YP+Gqc1wQYiqwVdvdrcZcBAc92fCii/Y/kNtzFi1agjsNUl2xJIqvtGX
         VDng==
X-Gm-Message-State: AJIora9yAandlwPVszlhoiWUvXiSwuUI3SgUr9qu0NFeuS+QMBd1R87S
        g5POJqt7k4x3F7jYaWfzHSOjkw==
X-Google-Smtp-Source: AGRyM1uW8dGNEUmEIE/IQi2CP0GV3oL6OLmpPM0j+lP6lahpDtZ3SpDU6V4zlM9APKzgFWAbZqi9jg==
X-Received: by 2002:aa7:c45a:0:b0:435:d7a4:99bc with SMTP id n26-20020aa7c45a000000b00435d7a499bcmr9565349edr.158.1656233364443;
        Sun, 26 Jun 2022 01:49:24 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o7-20020a170906860700b00722d5f07864sm3444932ejx.225.2022.06.26.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 01:49:23 -0700 (PDT)
Date:   Sun, 26 Jun 2022 10:49:21 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Helge Deller <deller@gmx.de>
Cc:     Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org,
        daniel.vetter@ffwll.ch, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fbmem: Check screen resolution change against
 font size
Message-ID: <YrgdkWEvxrh5Wam9@phenom.ffwll.local>
References: <20220625220630.333705-1-deller@gmx.de>
 <20220625220630.333705-4-deller@gmx.de>
 <YreNUfv8d9QeJT8C@phenom.ffwll.local>
 <YreODaSXhAhipJKa@phenom.ffwll.local>
 <5e03d6c5-e254-f5f6-9e02-bc996d41718d@gmx.de>
 <92f2ca1e-20f7-c456-0cd2-609202e337a2@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92f2ca1e-20f7-c456-0cd2-609202e337a2@gmx.de>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Jun 26, 2022 at 01:56:18AM +0200, Helge Deller wrote:
> On 6/26/22 01:12, Helge Deller wrote:
> > On 6/26/22 00:37, Daniel Vetter wrote:
> >> On Sun, Jun 26, 2022 at 12:33:53AM +0200, Daniel Vetter wrote:
> >>> On Sun, Jun 26, 2022 at 12:06:29AM +0200, Helge Deller wrote:
> >>>> Enhance the check in the FBIOPUT_VSCREENINFO ioctl handler to verify if the
> >>>> user-provided new screen size is bigger than the current font size.
> >>>>
> >>>> Signed-off-by: Helge Deller <deller@gmx.de>
> >>>> Cc: stable@vger.kernel.org # v5.4+
> >>>
> >>> Please squash with previous patch. You might also want to add a note there
> >>> that on older kernels backporters need to open-code
> >>> fbcon_info_from_console instead, since it only exists since
> >>> 409d6c95f9c6 ("fbcon: Introduce wrapper for console->fb_info lookup")
> >>
> >> Maybe easier would be to include that patch in the backports instead of
> >> open coding.
> >
> > I was afraid that WARN_CONSOLE_UNLOCKED() hadn't been backported.
> > But it seems it's in v4.19+ (from patch 56e6c104e4f15), so that's ok.
> >
> > So, yes, it seems pushing 409d6c95f9c6 backwards is probably best.
> 
> It would be the best solution, but sadly 409d6c95f9c6 can't easily be backported.
> So, probably my other approach (fix up afterwards with extra patch) is
> the way to go.

Ah right there's some conflicts with the restoration/removal of scroll
accel.

> What's your thought on this ?

I guess just open code in a separate backport is simplest.
-Daniel

> 
> Helge
> 
> 
> 
> > Will try that approach now.
> >
> > Helge
> >
> >  I think that's what Greg generally prefers at least, less
> >> divergence between stable kernels.
> >> -Daniel
> >>
> >>>
> >>> With these two nits: Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> >>>
> >>>> ---
> >>>>  drivers/video/fbdev/core/fbmem.c | 4 +++-
> >>>>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> >>>> index afa2863670f3..160389365a36 100644
> >>>> --- a/drivers/video/fbdev/core/fbmem.c
> >>>> +++ b/drivers/video/fbdev/core/fbmem.c
> >>>> @@ -1106,7 +1106,9 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> >>>>  			return -EFAULT;
> >>>>  		console_lock();
> >>>>  		lock_fb_info(info);
> >>>> -		ret = fb_set_var(info, &var);
> >>>> +		ret = fbcon_modechange_possible(info, &var);
> >>>> +		if (!ret)
> >>>> +			ret = fb_set_var(info, &var);
> >>>>  		if (!ret)
> >>>>  			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
> >>>>  		unlock_fb_info(info);
> >>>> --
> >>>> 2.35.3
> >>>>
> >>>
> >>> --
> >>> Daniel Vetter
> >>> Software Engineer, Intel Corporation
> >>> http://blog.ffwll.ch
> >>
> >
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
