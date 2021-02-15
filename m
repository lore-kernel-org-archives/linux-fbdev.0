Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A18C433E6
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Feb 2021 15:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E58864ED7
	for <linux-fbdev@archiver.kernel.org>; Mon, 15 Feb 2021 15:32:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBOPcS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 15 Feb 2021 10:32:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbhBOPbF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 15 Feb 2021 10:31:05 -0500
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB500C061756;
        Mon, 15 Feb 2021 07:30:24 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id t11so4392796pgu.8;
        Mon, 15 Feb 2021 07:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nd5Yfn43BCBJomp6sHGwdTlb0IPHeJ9K8m6gaCF931g=;
        b=QlbaUqnzMU0C+clIlVwtHO1AAUS6hShwRtyZCDsTmZzZwcmd0MvlA67evCsxYKYrv9
         oKrDig8saJwiRnm4O6aUp1e4/ws+SKz6OIkEQBqzWkWYGXDiNbkIQfjhbtkRbYWfLd0G
         2/FCRBVDNjvBuweRiYhxsjRRVt0/QXtpRK6r/6gXOlSUzoqQ+5KOS5NRoasd9AldnGTg
         SQK3zITTU/cF1MExS0UmOE9w7TqHzbR8an+TKYTEacU5q3iZYLdZn5DWxkSYanN1sJHD
         AxS5K04hDJmBYp+SbaCJr6mhhZzQ9USz2aiea5q+oFgQ5wRm5VgMfP/Qyyzj+W3iEU0R
         jk/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nd5Yfn43BCBJomp6sHGwdTlb0IPHeJ9K8m6gaCF931g=;
        b=V8Lje2wq8WZENyo5MUs9H8/u2aTikQ6KPHDULfw5nc8hljET/o+cwlPj5n03iW0t6I
         6yd7F9trfsnVfWfMxtk/uCN5ZH9X8F3p3jAi1PlgmmOaUwvVdosJA0PqCDGcROe2sSMN
         DZtt+UfYman8wekh7hmIBW2wGDyIe8O74qmUCtfNqndFQ/ddnSN78ZD6ZGPhD0No2FF8
         apze0Pwj3OtNkq1Ms4pRuk9Mc2D/FkpY2vdfm68kO5XEkGABsJ7fPq+oDKrsDW1iLF90
         sWCxjunQqBfSOWRltJA7gtKtzVMrqCCZFlPgwOhb3O9zFEdQD6O5sZJlDmmiVFHBDMHZ
         0EbQ==
X-Gm-Message-State: AOAM533PGEUSFo7ws5PcQTT0jMQNB/To1PlZlwwbNUoZN73JtOQrhUvZ
        JrQpL6rNf9LvcrG2+s/PHaCLy6cvO/UrUc9msL8=
X-Google-Smtp-Source: ABdhPJylFq9d2tX3RjtahOe8hIgIQ4VN+QPYppcEIIbyB9lQQ4aHPmvHcrHpBNqSf8zEzCF2lh70YD492yPKz49qdps=
X-Received: by 2002:a65:4c08:: with SMTP id u8mr7118551pgq.203.1613403024154;
 Mon, 15 Feb 2021 07:30:24 -0800 (PST)
MIME-Version: 1.0
References: <1611838435-151774-1-git-send-email-zhangxuezhi3@gmail.com>
 <CAHp75Vd=ijxnamuSYuxNLeyhGMCod=HaXWrQ0W0+3QCsQAychg@mail.gmail.com>
 <20210129130110.00003bb1@gmail.com> <CAHp75Vdi4H_zY3+QPSq_wmdf20B9xPeqsOT10JHfMLJESX77gA@mail.gmail.com>
 <20210129215638.000047b0@gmail.com> <CAHp75VcdOibSRuSBZYhFtEcVxuammYMfcnrUQGvS6ttArFxj6g@mail.gmail.com>
 <20210130143924.00005432@gmail.com> <CAHp75VenJVOSbAXryGK_BWytRJF=T1zwk5xDimRQOTojoXbMFQ@mail.gmail.com>
 <20210202095234.000059ca@gmail.com>
In-Reply-To: <20210202095234.000059ca@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 15 Feb 2021 17:30:08 +0200
Message-ID: <CAHp75VdwdBtZLG9rMWMzVSy27i3HwVm4eWk7jyKuJ-60JYJSeg@mail.gmail.com>
Subject: Re: [PATCH v12] staging: fbtft: add tearing signal detect
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Colin King <colin.king@canonical.com>,
        oliver.graute@kococonnector.com, zhangxuezhi1@yulong.com,
        Deepak R Varma <mh12gx2825@gmail.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Feb 2, 2021 at 3:52 AM Carlis <zhangxuezhi3@gmail.com> wrote:
> On Mon, 1 Feb 2021 19:40:21 +0200
> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>
> > On Sat, Jan 30, 2021 at 8:39 AM carlis <zhangxuezhi3@gmail.com> wrote:
> > > On Fri, 29 Jan 2021 16:26:12 +0200
> > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> > > > On Fri, Jan 29, 2021 at 3:56 PM carlis <zhangxuezhi3@gmail.com>
> > > > wrote:
> > > > > On Fri, 29 Jan 2021 12:23:08 +0200
> > > > > Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > ...
> >
> > > > > Hi, I apologize for what I said in the previous two emails. I
> > > > > missed one email you sent before, and now I probably understand
> > > > > what you meant. Here is a version I modified according to your
> > > > > suggestion:
> >
> > I have realized that you are mocking stuff in the generic fbtft
> > structure for all drivers while only a single one is going to use
> > that. Consider moving everything to the driver in question.

>    Do you mean that i define the TE completion and irq_te in the
>    fb_st7789v.c as i did before?

Not in global variables. Perhaps it will require to add/update the
custom (to the specific driver) data structure.
But the idea is that all changes should be isolated to that driver.

-- 
With Best Regards,
Andy Shevchenko
