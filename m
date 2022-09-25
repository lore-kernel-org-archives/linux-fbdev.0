Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A231CC04A95
	for <linux-fbdev@archiver.kernel.org>; Sun, 25 Sep 2022 12:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiIYMfB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 25 Sep 2022 08:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbiIYMe5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 25 Sep 2022 08:34:57 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA00912D21
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 05:34:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso4363271pjm.5
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=LBp7JKxATp3LGnBGQNabl2KMyCnQgfKt+agAmeM5KNw=;
        b=Uihs80S/aPoq+XHSizkaK+Qs8n3lDL52h5QSHCwiMu60QZFFFE2LykzHXkK+IZSwHI
         KLQTozB8oFRhPCsD1UjBouMgJX3In713/ey0vmumnCYq8SzdJYLm72uMfcf1U9l3UTQO
         rKnH6fnx26nEh5gVY0pyI/o0QYAQhE4nL6/v9PKxlYdAePpCGL7ThM7ekKiavfoq5cGd
         LDjYmSv9mLBMzDXJ0p9qQBp1EjKBVluaAnlkdERnVZKkhHJQK46HwUi3UHxHqF19Z5bP
         Mg9lD0U99s5ECVr5EzJa95TxcHORpnw1vVY3S4XIj2QUQVEhJ1K2Dx7FYIUVmu/XG/fd
         wbjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=LBp7JKxATp3LGnBGQNabl2KMyCnQgfKt+agAmeM5KNw=;
        b=1KvsxtZPoO6bqS8vSBiXL+iG/G8HWDe5k+1QQ9s8h7boAZG+e0yy1hTVISYjnM8nQo
         m7AAVqX2u2YdC6MyrCCsrSNQvprhKiXp8B1vU0LpuorcCpHf86BWXVLyKTXXh61Uzg3V
         r392em08MvHW0Kb42XJ47vDKNoqo7SXoVtXH6+JPEWLGlKRu1qmi9MvPnhuOGx18fEpf
         MUJ6Wf0+r09uxGGdCztWOLDUVKtR87hKxwojQv6MLpWjppJ5w5z7v4UQa3Cld+MqNoOi
         UmB6ySbihIDV3lRQ/4S+She5WenEe6ClHdePCHiYT5mQRauoHmm0256ByXkOD/ETBb1q
         MXfA==
X-Gm-Message-State: ACrzQf3RwgEqF2u0nLUW3idrc98H8xSWmMl5T05blYcYpNUW++f96j4q
        nqgrxqalT8vpK+f/UjahI6PG6Emyg9s=
X-Google-Smtp-Source: AMsMyM7rnBk8hQaiy/2yufZKFQ1309b2xwoWvl29Nt846j55qnNX31lEz/leDndE53f8qHCuxbTjtA==
X-Received: by 2002:a17:902:e74e:b0:178:b4c4:5ac4 with SMTP id p14-20020a170902e74e00b00178b4c45ac4mr17487255plf.11.1664109293374;
        Sun, 25 Sep 2022 05:34:53 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001768517f99esm9190610plf.244.2022.09.25.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 05:34:53 -0700 (PDT)
Date:   Sun, 25 Sep 2022 05:34:49 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     steve.glendinning@shawell.net, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] video: fbdev: smscufx: Fix use-after-free in
 ufx_ops_open()
Message-ID: <20220925123449.GA382038@ubuntu>
References: <20220925110329.GA380036@ubuntu>
 <dcccfc86-1bfe-e37a-fa6f-28a159e35f14@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dcccfc86-1bfe-e37a-fa6f-28a159e35f14@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Sep 25, 2022 at 01:57:46PM +0200, Helge Deller wrote:
> On 9/25/22 13:03, Hyunwoo Kim wrote:
> > A race condition may occur if the user physically removes the
> > USB device while calling open() for this device node.
> > 
> > This is a race condition between the ufx_ops_open() function and
> > the ufx_usb_disconnect() function, which may eventually result in UAF.
> > 
> > So, add a mutex to the ufx_ops_open() and ufx_usb_disconnect() functions
> > to avoid race contidion of krefs.
> > 
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >   drivers/video/fbdev/smscufx.c | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/video/fbdev/smscufx.c b/drivers/video/fbdev/smscufx.c
> > index d7aa5511c361..a4378a7241f7 100644
> > --- a/drivers/video/fbdev/smscufx.c
> > +++ b/drivers/video/fbdev/smscufx.c
> > @@ -1065,6 +1067,8 @@ static int ufx_ops_open(struct fb_info *info, int user)
> >   {
> >   	struct ufx_data *dev = info->par;
> > 
> > +	mutex_lock(&disconnect_mutex);
> > +
> 
> The next few lines show:
>         if (user == 0 && !console)
>                 return -EBUSY;
> 
> in this case this function exits with the mutex held.
> 
> Please check all possible exit paths and unlock the mutex
> where necessary.

yes. I made a mistake.
I submitted a fixed v2 patch.


Best Regards,
Hyunwoo Kim.
