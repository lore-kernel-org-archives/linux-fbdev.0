Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3090CC433DB
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 09:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD1B964D9F
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 09:10:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbhBPJKf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Feb 2021 04:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbhBPJKU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Feb 2021 04:10:20 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB8C061574
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Feb 2021 01:09:39 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id u14so12064760wri.3
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Feb 2021 01:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K5zC5Y1zvesaXwk7zKrXE6Sqg4y3GDAfdw86rtI8m6o=;
        b=apOi8qqe7jYCfTsdg9jYa8ZrUBRJbUmEArshiR1i9FfkUoecNLS9KkVJcm/QJRL5DL
         /9T3XDBGoBqCDzbr8zdH/7xPgZh8a/WcCs6TA+IjXaisFenEZ2KaMvQBJ5CSClTzVoot
         0g6vceEQPdrP5n158Jz2msejzcc589GAAqUtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K5zC5Y1zvesaXwk7zKrXE6Sqg4y3GDAfdw86rtI8m6o=;
        b=FCm8ZjozRnh/XBKfJ22kxhy368SnWdQkkMxUnDoiv7OZdWNuSRmNehRnxGKbGp4Z+P
         7SHMbMWn8cMWpp08XgC7pv2P3Au245pvf6nYjyCVfnRCN6a6kGe3Mtymrw7vvIdjvFB0
         WWTaSkaqXRqCIIoATSMa7FiHRr+6hsV4kfTYmAjALN1Ws5a/Pl8jf0rQ5U1ziA3RGePH
         MpF47jk91pldobn3gwrw3awu1eGl0xEjRHKnPBnQuCcClh1IHRv00t0P70oRQEwQWLHS
         1+DbMwFU3JIKKkwdNyMFgHYkK3dJW6D3EfAJKimrnYewQ/HoyBioM3EEYM7OrNrbWgjQ
         og+g==
X-Gm-Message-State: AOAM531MUzjMzW/5rV0C2cmWYXhCb75imtx57De2a6Xl3D4RF6zK7uiq
        +uY4AUstpiVQWd7pIp8BdZreWg==
X-Google-Smtp-Source: ABdhPJzdZcOoTuCKynHice6z5PD8IYy6n4mOt3kwBaTsySFHj1AcBgs/+6shoAJ1fW4RiLQTiIgn/Q==
X-Received: by 2002:a5d:6602:: with SMTP id n2mr22288886wru.150.1613466578573;
        Tue, 16 Feb 2021 01:09:38 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id z1sm221367wmi.22.2021.02.16.01.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 01:09:38 -0800 (PST)
Date:   Tue, 16 Feb 2021 10:09:36 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH 0/3] video: Remove in_interrupt() usage.
Message-ID: <YCuL0DR8CQXEKTjP@phenom.ffwll.local>
References: <20210208223810.388502-1-bigeasy@linutronix.de>
 <20210216083500.brcafu6mo2yiz3cg@linutronix.de>
 <YCuFli/TEl6gysTb@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YCuFli/TEl6gysTb@kroah.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Feb 16, 2021 at 09:43:02AM +0100, Greg Kroah-Hartman wrote:
> On Tue, Feb 16, 2021 at 09:35:00AM +0100, Sebastian Andrzej Siewior wrote:
> > On 2021-02-08 23:38:07 [+0100], To linux-fbdev@vger.kernel.org wrote:
> > > Folks,
> > > 
> > > in the discussion about preempt count consistency across kernel
> > > configurations:
> > > 
> > >  https://lore.kernel.org/r/20200914204209.256266093@linutronix.de/
> > > 
> > > it was concluded that the usage of in_interrupt() and related context
> > > checks should be removed from non-core code.
> > > 
> > > In the long run, usage of 'preemptible, in_*irq etc.' should be banned from
> > > driver code completely.
> > > 
> > > This series targets the video subsystem. The omap patches are a repost
> > > of [0], the amba-clcd is new after I received no feedback on my analysis
> > > [1].
> > > 
> > > [0] https://lkml.kernel.org/r/20210127172902.145335-1-bigeasy@linutronix.de
> > > [1] https://lkml.kernel.org/r/20210127174408.ududpwfrbg3dhyxj@linutronix.de
> > 
> > Could someone please apply the series? Video seems unmaintained.
> 
> It's the merge window, no one can apply the series...
> 
> Please resend once 5.12-rc1 is out.

drm trees are always open, to avoid the merge window blackout lol :-)

Reason I didn't merge anything is that I'm intentionally letting fbdev
hang in there, in the hopes someone picks up review&patch apply duties. It
already worked a few times but then people move on again ...

Anyway patches queued up in drm-misc-next for 5.13.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
