Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E4F1C433E6
	for <linux-fbdev@archiver.kernel.org>; Sun, 21 Feb 2021 00:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5046B64EDB
	for <linux-fbdev@archiver.kernel.org>; Sun, 21 Feb 2021 00:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBUABk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 20 Feb 2021 19:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbhBUAB3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 20 Feb 2021 19:01:29 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC58C061786;
        Sat, 20 Feb 2021 16:00:42 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id k17so1772976ioc.5;
        Sat, 20 Feb 2021 16:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eyv75EVqtjc5sQV9MZqlAZakzRqPKcB25AWLRe+93L4=;
        b=EeEEtR5leYnNT9Sg+XnH3v351ZDvCxVEBjBfcUET5qi1u/cmUQkdNKI9mUIlJo7Q3s
         5UIS16soeZu9Ggp3Y/TUbOFBgxAZLL1YthsBzdJVSC9gsOZ25285t5TXzbPw6rJ4cQ4L
         DSkculSrmw7+55COZVPqPw/oOsYis1xq41wYAaeGtUQTsdf0k3oxsg7B90zktWnb7ort
         dhA86+BOwdVgoapWJ/Jxm3KZshiESGcd0tRtyPguIWBOH+l6ECeu2WMk000w0ldrYUP9
         4Rqaq/Eiz3bclqRUoBwzKxxPIutKWSfmiSGUC0j+XoIfVBNJ+LoxTRZqRQAbXi6x1DpW
         H75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eyv75EVqtjc5sQV9MZqlAZakzRqPKcB25AWLRe+93L4=;
        b=eNPC8lgH5gRyS16D1dK6EnlN+CN/9wioPSLYI7HXnReVVP481eLJ9oHxdFFueROyLq
         AOm1PaJ8Pn88++feZf/gORmYk5dDdQYzV156XWO5q1Kt2YRk8/7ze+b7wOJtBWoznK41
         nFgDZAEmsMFVZsEpBFBgTtGM8IQS2ZrGWeXNZp9M0oBeGK5muee0LN+10rmc9mjPAwQ6
         KBxknKtTFW/amCMuh9xYeaWpKXqrfqS70m9FrQnNjOlbsxvKrPZQe9cdONsxFhqmOZ80
         MWWxVNFBA6Lk+++ey5swEGqjxrZAWFnHJMPaqiWvh+U4IEPPLbjX028ohMyluBrtl4IL
         V8ZA==
X-Gm-Message-State: AOAM531HXJ+xa3plUp03aZfi5Qq49fbppqK78I+QQNfCSAirogT+3u66
        ryvROy332LQK6/t08EfhU5wjmcohYLIQFOAX4y8=
X-Google-Smtp-Source: ABdhPJz3rxxFjCPyN29YDDBIIwzFQM+arC6T2FY7bbj046hdU3CXgyZf6jieSBzvW96n+pRuJB+O6FpE2+XZRZLta08=
X-Received: by 2002:a6b:8dcc:: with SMTP id p195mr9669717iod.74.1613865642373;
 Sat, 20 Feb 2021 16:00:42 -0800 (PST)
MIME-Version: 1.0
References: <20210220230248.320870-1-ztong0001@gmail.com> <ea1c5ff3-0b24-71c9-7a44-08b184c4854d@infradead.org>
In-Reply-To: <ea1c5ff3-0b24-71c9-7a44-08b184c4854d@infradead.org>
From:   Tong Zhang <ztong0001@gmail.com>
Date:   Sat, 20 Feb 2021 19:00:31 -0500
Message-ID: <CAA5qM4D0y9-gL7AAMQvtwrfJC_UvSTB5_S5PX3qkYSxHRUS-Qw@mail.gmail.com>
Subject: Re: [PATCH] video: fbdev: pm2fb: avoid stall on fb_sync
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Randy,
Thanks for the comment.
I currently have this problem on my machine.
I have submitted a revised patch -- which includes the console log.
Thanks!
- Tong

On Sat, Feb 20, 2021 at 6:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> Hi--
>
> On 2/20/21 3:02 PM, Tong Zhang wrote:
> > pm2fb_sync is called when doing /dev/fb read or write.
> > The original pm2fb_sync wait indefinitely on hardware flags which can
> > possibly stall kernel and make everything unresponsive.
> > Instead of waiting indefinitely, we can timeout to give user a chance to
> > get back control.
>
> Is this a real problem or theoretical?
> Does someone still use this driver?
>
>
> > Signed-off-by: Tong Zhang <ztong0001@gmail.com>
> > ---
> >  drivers/video/fbdev/pm2fb.c | 29 ++++++++++++++++++++++++++---
> >  1 file changed, 26 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
> > index 27893fa139b0..8578c64a0c54 100644
> > --- a/drivers/video/fbdev/pm2fb.c
> > +++ b/drivers/video/fbdev/pm2fb.c
> > @@ -183,12 +183,23 @@ static inline void pm2v_RDAC_WR(struct pm2fb_par *p, s32 idx, u32 v)
> >
> >  #ifdef CONFIG_FB_PM2_FIFO_DISCONNECT
> >  #define WAIT_FIFO(p, a)
> > +#define WAIT_FIFO_TIMEOUT(p, a) (0)
> >  #else
> >  static inline void WAIT_FIFO(struct pm2fb_par *p, u32 a)
> >  {
> >       while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a)
> >               cpu_relax();
> >  }
> > +static int inline void WAIT_FIFO_TIMEOUT(struct pm2fb_par *p, u32 a)
>
> drop      void       ^^^
> It's already "int".
> Did you compile this?
>
> > +{
> > +     int timeout = 10000;
> > +     while (pm2_RD(p, PM2R_IN_FIFO_SPACE) < a) {
> > +             cpu_relax();
> > +             if (--timeout==0)
>
> spaces around ==
>
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> >  #endif
> >
> >  /*
> > @@ -1031,15 +1042,27 @@ static int pm2fb_blank(int blank_mode, struct fb_info *info)
> >  static int pm2fb_sync(struct fb_info *info)
> >  {
> >       struct pm2fb_par *par = info->par;
> > +     int timeout_sync = 10000;
> > +     int timeout_fifo;
> >
> > -     WAIT_FIFO(par, 1);
> > +     if (WAIT_FIFO_TIMEOUT(par, 1))
> > +             goto end;
> >       pm2_WR(par, PM2R_SYNC, 0);
> >       mb();
> >       do {
> > -             while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0)
> > +             timeout_fifo = 10000;
> > +             while (pm2_RD(par, PM2R_OUT_FIFO_WORDS) == 0) {
> >                       cpu_relax();
> > -     } while (pm2_RD(par, PM2R_OUT_FIFO) != PM2TAG(PM2R_SYNC));
> > +                     if (--timeout_fifo==0)
>
> spaces around ==
>
> > +                             goto end;
> > +             }
> > +             if (pm2_RD(par, PM2R_OUT_FIFO) == PM2TAG(PM2R_SYNC))
> > +                     break;
> > +     } while (--timeout_sync>0);
>
> spaces around >
>
> >
> > +end:
> > +     if ((!timeout_sync) || (!timeout_fifo))
> > +             printk_ratelimited(KERN_WARNING "pm2fb: sync timeout!\n");
> >       return 0;
> >  }
> >
> >
>
>
> thanks.
> --
> ~Randy
