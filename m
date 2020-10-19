Return-Path: <SRS0=r1i4=D2=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9449EC433E7
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Oct 2020 09:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 382522224D
	for <linux-fbdev@archiver.kernel.org>; Mon, 19 Oct 2020 09:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aP7DWCBS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727533AbgJSJ4F (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 19 Oct 2020 05:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgJSJ4F (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 19 Oct 2020 05:56:05 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C462C0613CE;
        Mon, 19 Oct 2020 02:56:05 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id p21so5050437pju.0;
        Mon, 19 Oct 2020 02:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DQpTimuAzlDszY/84TRziF9dlZoz9pu8dPHqAyzWiC0=;
        b=aP7DWCBSkCGEQpiV7lINj+OlwLMXmBFhs/Wk/5sbR3y/Hjg2LVFGUZbHZiC30JdoaY
         CwCNSwBEpHUBJJT3/aYOT2iKuByfg9gMrMnJWxmSlGKhJJ3+HXfGV07D1bK6j9jyQxFt
         Y2EhO4037v/3glXJcDPGiDeLRBk7mz695vGQVtTGVslJSuNVFe4ggZHbS9I12tFRNmdL
         Tzg6oNZURMD0aueG2V9CC/vB9l8zV0GW4rAfM8GJYV2Tn9/gM5PSb26RbzGK1Od6na1M
         q7uR5vxPbn61CSJHwY2EvoSco/wv2vgGWkeeDqmBxMA2efvnE3GqAfGZuWmGHti2my7Z
         9giA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DQpTimuAzlDszY/84TRziF9dlZoz9pu8dPHqAyzWiC0=;
        b=txZmIWKju+LIgsJl2v2MSj1TESYF4tVTHyfzDaLLT4ohUNrWB0mA7yr/7zi2oRRc+q
         UA8jJ0H+oRleiiN/F+pbAuO7cJtm9pRxZW2ZqiSW3Q2ASe8ljVClAgy/C4YO04TjFPBJ
         VEsABeKVELvdwICfgV/hkYAxxZPv5BOwNzj2iBzevy6qoQ9FvlrtnpuSsX/1cZOLrNIc
         oZDEuVfDVq8H46aCdNu4zbs8fRksy831MZBzTrrelTJ/pevOEb2i0fJMyHNVxUWjQP4M
         cFd8FMFUEIwwgO1vw3Afzo/oU7lz17KAC1V88C68RFL2YVH4gJmNNVfqJLwIkWhrlHIi
         0KXg==
X-Gm-Message-State: AOAM531V0GDw1jqkvQRYYE5nvDZxywZwzyvAL7bYLcmbB5bw6buuoKUT
        CiggvK071my0VnCXbHT1Fw==
X-Google-Smtp-Source: ABdhPJyGyYH9MTCeR5rG3OoYXSgt0G+X5ge3qXoDmm42aLzcfzs8qR32UB2f4T0EJpvvUr5jV9mn8Q==
X-Received: by 2002:a17:90a:f685:: with SMTP id cl5mr16490738pjb.210.1603101365246;
        Mon, 19 Oct 2020 02:56:05 -0700 (PDT)
Received: from PWN ([161.117.41.183])
        by smtp.gmail.com with ESMTPSA id t19sm1111202pji.18.2020.10.19.02.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 02:56:04 -0700 (PDT)
Date:   Mon, 19 Oct 2020 05:55:56 -0400
From:   Peilin Ye <yepeilin.cs@gmail.com>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sven Schneider <s.schneider@arkona-technologies.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] Fonts: Support FONT_EXTRA_WORDS macros for font_6x8
Message-ID: <20201019095556.GA702017@PWN>
References: <20200820082137.5907-1-s.hauer@pengutronix.de>
 <926453876c92caac34cba8545716a491754d04d5.1603037079.git.yepeilin.cs@gmail.com>
 <CAKMK7uF9E24P=vzKt28=1_iaFTYD7obHs+tEPwwZPNMhh7DBrg@mail.gmail.com>
 <20201018201811.GA697615@PWN>
 <CAKMK7uFEmNnBdpoHYqvCUYS=nxh99gKs6P1-1pgp-ouvTSioGw@mail.gmail.com>
 <20201018204456.GA697766@PWN>
 <CAKMK7uEoCqaPifM7CiaNwtSe8uZ9V-7joJfXSYLjy5pedAcjOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKMK7uEoCqaPifM7CiaNwtSe8uZ9V-7joJfXSYLjy5pedAcjOg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org
Message-ID: <20201019095556.M1U2kLLJ6A8MA5S6xCmGsCQry8Nv2NQ7Nd87uRyVrIE@z>

On Sun, Oct 18, 2020 at 11:51:19PM +0200, Daniel Vetter wrote:
> On Sun, Oct 18, 2020 at 10:45 PM Peilin Ye <yepeilin.cs@gmail.com> wrote:
> > I'm confused, I see it on LKML in the link above. Sure I'll resend soon.
> 
> My brain didn't work, sorry about the confusion.
> 
> I'll pick up the patches tomorrow, probably not a good idea I do
> anything more today :-)

Ah, no worries, thanks!

Peilin Ye

