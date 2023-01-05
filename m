Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C570C3DA7D
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Jan 2023 10:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233167AbjAEKbl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Jan 2023 05:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232538AbjAEKbW (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Jan 2023 05:31:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFFF35F905
        for <linux-fbdev@vger.kernel.org>; Thu,  5 Jan 2023 02:25:39 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o1-20020a17090a678100b00219cf69e5f0so1607396pjj.2
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Jan 2023 02:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Dt0BUqKwqWWibWQTb1wPCoKjm4VxsUkn0xweZKKMDlI=;
        b=YVRGKFa0easmpbhxNK49mPSwSm4p0yLlLolRTqAAayxsax3xiNb/DSU6taZNhLfwg2
         NwU/6V3PZ+hSXVdRw9G7LGmz5qE5R2f+uFoPn72pC1tJ2p7L4DjEcG1XFmIQqHqu2QH+
         jn+Z3syF3bwWcXBb55yis6EiEW7pTcDYekbDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dt0BUqKwqWWibWQTb1wPCoKjm4VxsUkn0xweZKKMDlI=;
        b=IwVwby6jsTJjQxkMLdgz85N8g/7aCzhDbCXsmOdYvVewbBBIYpBDHCfV5ec6tfimBG
         r/3jvs0E3r2MY8p8Ehx3IoawxOr6EWZnXOnjhDHlHWdkhNvAzgD2Fkxjw5yzY9Enkb8E
         YSOwyohXYkQZrui8ZcRgYGA2xfzUiA0fD+TxkcESqb4o7OWu2pIZ8su2+P6o4XetW006
         TYXG0FWifPFzxTyKU4neuLkZEyCCogWYWOR3Xr6+4mXsqZQwHtUO33bkOXaHQZV1aMJM
         06rHqMEqwjGm+y8vSf+XoZuGxHKbk+7RnXbs8YV0g9LcyqHjeexOY0vnO8b1g7oHMZQZ
         IVJg==
X-Gm-Message-State: AFqh2koHvg5kxAKVx7HGl3q18QRNfhT/VjszgKk25UHFvPVH2vlMcXHH
        Ki1v3O7pqmp9hf4SEAYbFDoJztf0Cp5WKtBiyXkHJw==
X-Google-Smtp-Source: AMrXdXtH8U8MGVN+aDur6Y5usog53kmDoioY+u7d3Z2CRLX/YuYF2BfABux+LurZUiHsDsT7IgRi8tjHf6ScJFu4mbA=
X-Received: by 2002:a17:902:bf45:b0:189:505b:73dd with SMTP id
 u5-20020a170902bf4500b00189505b73ddmr2984463pls.143.1672914317807; Thu, 05
 Jan 2023 02:25:17 -0800 (PST)
MIME-Version: 1.0
References: <20221230063528.41037-1-zh.nvgt@gmail.com> <2711de96-fcbe-5611-657a-ab29becd2ff6@gmx.de>
 <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
In-Reply-To: <CAKMK7uEOX5n64cjzMt9GRQaS13HFPFyOeqdrkmzc035U5_T8tg@mail.gmail.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 5 Jan 2023 11:25:06 +0100
Message-ID: <CAKMK7uE7CAXO50JPQ6ziQGGehqfDK2UanBQbfLdUH2RwrwXUvw@mail.gmail.com>
Subject: Re: [PATCH] fbmem: prevent potential use-after-free issues with console_lock()
To:     Helge Deller <deller@gmx.de>
Cc:     Hang Zhang <zh.nvgt@gmail.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 5 Jan 2023 at 11:21, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> Hi Helge
>
> On Mon, 2 Jan 2023 at 16:28, Helge Deller <deller@gmx.de> wrote:
> >
> > On 12/30/22 07:35, Hang Zhang wrote:
> > > In do_fb_ioctl(), user specified "fb_info" can be freed in the callee
> > > fbcon_get_con2fb_map_ioctl() -> set_con2fb_map() ->
> > > con2fb_release_oldinfo(), this free operation is protected by
> > > console_lock() in fbcon_set_con2fb_map_ioctl(), it also results in
> > > the change of certain states such as "minfo->dead" in matroxfb_remove(),
> > > so that it can be checked to avoid use-after-free before the use sites
> > > (e.g., the check at the beginning of matroxfb_ioctl()). However,
> > > the problem is that the use site is not protected by the same locks
> > > as for the free operation, e.g., "default" case in do_fb_ioctl()
> > > can lead to "matroxfb_ioctl()" but it's not protected by console_lock(),
> > > which can invalidate the aforementioned state set and check in a
> > > concurrent setting.
> > >
> > > Prevent the potential use-after-free issues by protecting the "default"
> > > case in do_fb_ioctl() with console_lock(), similarly as for many other
> > > cases like "case FBIOBLANK" and "case FBIOPAN_DISPLAY".
> > >
> > > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> >
> > applied to fbdev git tree.
>
> The patch above makes no sense at all to me:
>
> - fb_info is protected by lock_fb_info and
> - the lifetime of fb_info is protected by the get/put functions
> - yes there's the interaction with con2fb, which is protected by
> console_lock, but the lifetime guarantees are ensured by the device
> removal
> - which means any stuff happening in matroxfb_remove is also not a
> concern here (unless matroxfb completely gets all the device lifetime
> stuff wrong, but it doesn't look like it's any worse than any of the
> other fbdev drivers that we haven't recently fixed up due to the
> takeover issues with firmware drivers

I have also a really hard timing finding the con2fb map use in the
matroxfb ioctl code, but that just might be that I didn't look
carefully enough. Maybe that would shed some light on this.
-Daniel


>
> On the very clear downside this now means we take console_lock for the
> vblank ioctl (which is a device driver extension for reasons, despite
> that it's a standard fbdev ioctl), which is no good at all given how
> console_lock() is a really expensive lock.
>
> Unless I'm massively missing something, can you pls push the revert
> before this lands in Linus' tree?
>
> Thanks, Daniel
>
> > Thanks,
> > Helge
> >
> > > ---
> > >   drivers/video/fbdev/core/fbmem.c | 2 ++
> > >   1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> > > index 1e70d8c67653..8b1a1527d18a 100644
> > > --- a/drivers/video/fbdev/core/fbmem.c
> > > +++ b/drivers/video/fbdev/core/fbmem.c
> > > @@ -1182,6 +1182,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > >               console_unlock();
> > >               break;
> > >       default:
> > > +             console_lock();
> > >               lock_fb_info(info);
> > >               fb = info->fbops;
> > >               if (fb->fb_ioctl)
> > > @@ -1189,6 +1190,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
> > >               else
> > >                       ret = -ENOTTY;
> > >               unlock_fb_info(info);
> > > +             console_unlock();
> > >       }
> > >       return ret;
> > >   }
> >
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
