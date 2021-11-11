Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 259C1C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 10:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FFEE61107
	for <linux-fbdev@archiver.kernel.org>; Thu, 11 Nov 2021 10:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbhKKKDQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 11 Nov 2021 05:03:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbhKKKDO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 11 Nov 2021 05:03:14 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BB0C061767
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Nov 2021 02:00:25 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id d5so8868698wrc.1
        for <linux-fbdev@vger.kernel.org>; Thu, 11 Nov 2021 02:00:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=BeDfp/nK9lSUSUWAhhEjNV/IhoMqbQJXqg22eg9X+MU=;
        b=lb3JXOGodMxV2649MpmUTo9DaCY2ncfGgmXMO/RiUafH21GI7W3MoKgF82Fy6SiBe9
         rK/l31rQ5vHLDrvsDin3ZTpyuo9uRHd0uxZYad6dOg7eubOpr+161tGhbx+UiN1wQb/H
         A/QM8DhzX1k4/DXyTDeBT57RxY4B3ENzh27Lo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=BeDfp/nK9lSUSUWAhhEjNV/IhoMqbQJXqg22eg9X+MU=;
        b=XMdFup+gB1KHDzTh4JO+oNZKXebPtZcmQfzA3XiFTiY6fYrwL/qHj4u9p/XyKPx3v4
         CGYjlSJm1P+HTYY+TIFHe0BQxXBdXiEXFjk5htxe9PO2EAG81U2BlF7h2iu3W/18gD0x
         hxuTMB1WkE7j+dZNeS5gGnUd3lfemH6/Hu65f2z5bQ6b81l9JmQhwb4sUWaF5GvXzgna
         rqge/Eb//B2HAq1JFvJAhJ4oztXzVZw3JRkP7GDE9ihrsC81XsHbQkjTAzhpWbdxHn62
         U4oFojO4l/ZnRGVg/uVlhfnNkOfPxSL60LZdBp4tGHtH1uOcM8LBy31/IYdIGbEL3JKC
         pYNw==
X-Gm-Message-State: AOAM533lCgIke2IpoVjpeNmAOUqadD6gV3KH+1eHNkhWEhrKFzB3YB/d
        uUKisDfvIKE2c7c7hCOHmB5ggw==
X-Google-Smtp-Source: ABdhPJzpBtqCUCQOsJzkp2s554FJuiUdwZYIJCTv2/2PyvuJCdSYVL3REQF6pfzOgB661xRB5SJwig==
X-Received: by 2002:a05:6000:1885:: with SMTP id a5mr7339975wri.258.1636624824180;
        Thu, 11 Nov 2021 02:00:24 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id x1sm2315470wmc.22.2021.11.11.02.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 02:00:23 -0800 (PST)
Date:   Thu, 11 Nov 2021 11:00:22 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] fbdev: Prevent probing generic drivers if a FB is
 already registered
Message-ID: <YYzptg1V+lyO0iVP@phenom.ffwll.local>
Mail-Followup-To: Thorsten Leemhuis <regressions@leemhuis.info>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Ilya Trukhanov <lahvuun@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
References: <20211111092053.1328304-1-javierm@redhat.com>
 <23b693d5-0335-8f42-a206-65e170ab6e52@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23b693d5-0335-8f42-a206-65e170ab6e52@leemhuis.info>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 11, 2021 at 10:58:14AM +0100, Thorsten Leemhuis wrote:
> On 11.11.21 10:20, Javier Martinez Canillas wrote:
> > The efifb and simplefb drivers just render to a pre-allocated frame buffer
> > and rely on the display hardware being initialized before the kernel boots.
> > 
> > But if another driver already probed correctly and registered a fbdev, the
> > generic drivers shouldn't be probed since an actual driver for the display
> > hardware is already present.
> > 
> > Reported-by: Ilya Trukhanov <lahvuun@gmail.com>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> 
> TLDR: Javier, in case you need to send an improved patch, could you
> please add this before the 'Reported-by:'
> 
> Link: https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/

Uh I thought Link: was for the patch submission chain, and we've used
References: for bug reports and everything else. Is the extension of Link:
a new thing?
-Daniel

> 
> And if the patch is already good to go: could the subsystem maintainer
> please add it when applying?
> 
> 
> Long story: hi, this is your Linux kernel regression tracker speaking.
> Thanks for working on a fix for a regression I'm keeping an eye on.
> 
> There is one small detail that could be improved: the commit message
> would benefit from a link to the regression report, for reasons
> explained in Documentation/process/submitting-patches.rst. To quote:
> 
> ```
> If related discussions or any other background information behind the
> change can be found on the web, add 'Link:' tags pointing to it. In case
> your patch fixes a bug, for example, add a tag with a URL referencing
> the report in the mailing list archives or a bug tracker;
> ```
> 
> This concept is old, but the text was reworked recently to make this use
> case for the Link: tag clearer. For details see:
> https://git.kernel.org/linus/1f57bd42b77c
> 
> Yes, that "Link:" is not really crucial; but it's good to have if
> someone needs to look into the backstory of this change sometime in the
> future. But I care for a different reason. I'm tracking this regression
> (and others) with regzbot, my Linux kernel regression tracking bot. This
> bot will notice if a patch with a Link: tag to a tracked regression gets
> posted and record that, which allowed anyone looking into the regression
> to quickly gasp the current status from regzbot's webui
> (https://linux-regtracking.leemhuis.info/regzbot ) or its reports. The
> bot will also notice if a commit with a Link: tag to a regression report
> is applied by Linus and then automatically mark the regression as
> resolved then.
> 
> IOW: this tag makes my life a regression tracker a lot easier, as I
> otherwise have to tell regzbot manually about the fix. ;-)
> 
> Ciao, Thorsten (while carrying his Linux kernel regression tracker hat)
> 
> #regzbot ^backmonitor
> https://lore.kernel.org/r/20211110200253.rfudkt3edbd3nsyj@lahvuun/

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
