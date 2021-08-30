Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAC8C432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEA260E90
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 14:59:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhH3PAY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Aug 2021 11:00:24 -0400
Received: from mail-vk1-f178.google.com ([209.85.221.178]:36384 "EHLO
        mail-vk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233162AbhH3PAX (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Aug 2021 11:00:23 -0400
Received: by mail-vk1-f178.google.com with SMTP id s126so4082844vkd.3;
        Mon, 30 Aug 2021 07:59:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfdnjnEp4XpXIUeX6ZT76KgIhW9q66X8YC+x/oa8NO4=;
        b=fgXVKDEUHqO6J0gddP5WlEP1rq5umP73PGVjqFlxL/8B6Amu9ZuuQtHA6CtCD8HE8L
         iiWbmByDR2MGWlAwqQxek9ChtdkmhhWlZkyqM0IYHQC+Rw9i5u6pqGBK+qrogldLXLJ1
         Dx2/vPXG0ghI0M8xJVtXUdz6i4qhGOGhES+zGM5sD+UJNrxxI54HUKV2taL9mRJCFwoy
         WIuKMn/6BDsREup5RCAfuZ5PTUDHxpK2oyjXzogRS/af6+LKMn0K/yhURJem1z1sXjvP
         95fDxjjFRSJMVEVV8Pw7+PSGUd5GB2JWvNoNOG0LK2sZTnK6gyh0YAFYlThgJLKZPvvg
         fNwA==
X-Gm-Message-State: AOAM530i/DDXf20yhPC0cmJcGyWMDPO60kBzytVgrjOTq3zvE/WH5EEj
        kS+eW+t+hc9pkb3e5nMV+W+SEWkGv6Op2DnZq2o=
X-Google-Smtp-Source: ABdhPJydLpFB2lNgVuMM9bZ4mnyHRiF4P8TW4Q5UiskyqqH0bqGTbirT4idHoa56DrU3sA/4b/qArusq4rnN12XhXmw=
X-Received: by 2002:a05:6122:809:: with SMTP id 9mr14007873vkj.4.1630335569285;
 Mon, 30 Aug 2021 07:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
 <YSyTzlUEhrxD7rU4@phenom.ffwll.local> <f9fda3fa-b2b7-57aa-8c37-69d93ae26045@i-love.sakura.ne.jp>
In-Reply-To: <f9fda3fa-b2b7-57aa-8c37-69d93ae26045@i-love.sakura.ne.jp>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 30 Aug 2021 16:59:18 +0200
Message-ID: <CAMuHMdV9cWSs0Hn2XJxj6HU1rAN0jYcOKLRn=1Z64nmGDp7bQQ@mail.gmail.com>
Subject: Re: [PATCH V4] fbcon: fix fbcon out-of-bounds write in sys_imageblit
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Daniel Vetter <daniel@ffwll.ch>, tcs.kernel@gmail.com,
        Matthew Wilcox <willy@infradead.org>,
        George Kennedy <george.kennedy@oracle.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Haimin Zhang <tcs_kernel@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Tetsuo,

On Mon, Aug 30, 2021 at 12:25 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2021/08/30 17:16, Daniel Vetter wrote:
> > On Mon, Aug 30, 2021 at 11:30:23AM +0800, tcs.kernel@gmail.com wrote:
> >> From: Haimin Zhang <tcs_kernel@tencent.com>
> >>
> >> yres and vyres can be controlled by user mode parameters, and cause
> >> p->vrows to become a negative value. While this value be passed to real_y
> >> function, the ypos will be out of screen range.This is an out-of-bounds
> >> write bug.
> >> some driver will check xres and yres in fb_check_var callback,but some not
> >> so we add a common check after that callback.
> >>
> >> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> >> Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
>
> Please s/Signed-off-by: Tetsuo Handa/Suggested-by: Tetsuo Handa/ .
> It is Haimin who debugged this problem and wrote this patch.
>
> >
> > Does this fix a syzbot crash or how was this discovered?
>
> Yes, Haimin's team is running syzkaller locally and found this bug.
> Therefore, no Reported-by: syzbot tag for this patch.
>
>
> -------- Forwarded Message --------
> Subject: Re: [PATCH v2] fbcon: fix Out-Of-Bounds write in sys_imageblit
> Message-ID: <33fc0e30-b94c-939f-a708-4b939af43100@gmail.com>
> Date: Mon, 2 Aug 2021 14:50:24 +0800
>
> hi, Tetsuo Handa
>
> i made a test with your suggested code, it can block the out-of-bound bug.
>
> where to add this check logic, i suggest to add it after the driver's
> fb_check_var callback.because what we plan to add is a common check by
> framework,but some driver can fault-tolerant invalid parameters(like
> yres_virtual > yres)
>
>         /* exist common check */
>         if (var->xres < 8 || var->yres < 8)
>                 return -EINVAL;
>
>         /* callback to drivers, some driver can fix invalid virtual
> xres or virtual yres */

Yes. Fbdev drivers are supposed to round up invalid or unsupported
values, or return -EINVAL.

>         ret = info->fbops->fb_check_var(var, info);
>         if (ret)
>                 return ret;
>         /* we add a more check here, if some drivers can't fix invalid x,y
> virtual values, we return a -EINVAL */
>         if (var->yres_virtual < var->yres || var->xres_virtual < var->xres)
>                 return -EINVAL;
>
> how about this fix ?  i can make a v3 patch.
>
>
>
> diff --git a/drivers/video/fbdev/core/fbmem.c
> b/drivers/video/fbdev/core/fbmem.c
> index 1c85514..9fb7e94 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1012,6 +1012,10 @@ static int fb_check_caps(struct fb_info *info,
> struct fb_var_screeninfo *var,
>
>         if (ret)
>                 return ret;
> +
> +       /* Virtual resolution cannot be smaller than visible resolution. */
> +       if (var->yres_virtual < var->yres || var->xres_virtual < var->xres)
> +               return -EINVAL;

So if this happens, it's a driver bug, not a userspace bug.

>
>         if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
>                 return 0;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
