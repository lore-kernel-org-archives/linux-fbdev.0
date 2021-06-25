Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34040C49EA7
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Jun 2021 08:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2EE613EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Jun 2021 08:44:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhFYIrJ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Jun 2021 04:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhFYIrI (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Jun 2021 04:47:08 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2796EC061574
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Jun 2021 01:44:48 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h11so9685462wrx.5
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Jun 2021 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=CeLIgK7phntxuaeQvPCnk2ZyJcdGeb6jadwfkvYxxgM=;
        b=vXsFLLSmooZPxNu5MeItcer3hbOrLr7vuzPntpRAKSJDQDP50GigF6mB/+YGJPQ6Qi
         q1xJXzWsnJlQE0sI+cTJKDCoFYFrF2u0gxI15ckp7cr9XDrQM9FjRPO51PvEeANGHL1W
         46c3eofsBeTcqCUoHry7gzKMde/py9SMCq9y8LCibLzMpAR6UDrxTG3Aksl/fn1abUG/
         qUT7DM8SNwJEhV2KbJNUQ0P/2BbSZaHL8wFYyJ8oys9wC+qeOLtaoFk3ghxsxzP5wd6y
         arVd0bXMxsiUM1cpGDMlcgxxz3KUoNrNgi0ieNE6NFRSld3h1RCFuj1QoZU6nmKgiA6v
         EZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=CeLIgK7phntxuaeQvPCnk2ZyJcdGeb6jadwfkvYxxgM=;
        b=DcqirZQLD+5sCBAHlXefRd5m55C5ie5jB6ncbGOnxgXdBoF1Fwdi+o3QLGZMdkt0Z2
         gCr0FAT5ORiJDlMFXoVhNznnrqsoPNOdB4jfBSWyK/LvcuV/oQzv5nDyHMJJdeKJo7Iw
         sCRP40cEhnRbexarXq6sXitBTbTnvdhLSiu+uJaE5Na9yrC+d+iieNXxb8jKE4gnQYhs
         0FxIuVpnhi72BbGNrpy4XpHqOeaAhuqISm0PxrrVwQ1ytwHZ5yKiFVpkvL56HmCspxPP
         LwtVHkixZlBnpiBbEBOehlsQ8f8V0oVovUnbUkVRWzUucUfix9le57z5xLT851F9MctR
         X9iw==
X-Gm-Message-State: AOAM533XT/0vUh+waA/5a+zBneN8nNIFYLQrVULoIkTP8r8LAkJJc3y5
        8bT+KxBaUhaXPQ2U8dy3BmY8eXB/6JOpDBv7
X-Google-Smtp-Source: ABdhPJy6QPvA46rrabm8WK7MpmyNlT70x3mmpSQDGdKnjvoL839Qo+4WZsph4rnpzLh8DptMMKfy6A==
X-Received: by 2002:a5d:4983:: with SMTP id r3mr9484655wrq.184.1624610686789;
        Fri, 25 Jun 2021 01:44:46 -0700 (PDT)
Received: from dell (92.40.180.154.threembb.co.uk. [92.40.180.154])
        by smtp.gmail.com with ESMTPSA id o17sm9632530wmh.19.2021.06.25.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 01:44:46 -0700 (PDT)
Date:   Fri, 25 Jun 2021 09:44:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Thierry Reding <thierry.reding@gmail.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH v3 2/2] backlight: lm3630a: convert to atomic PWM API and
 check for errors
Message-ID: <YNWXe9OhS3o4iRGi@dell>
References: <20210621122148.116863-1-u.kleine-koenig@pengutronix.de>
 <20210621122148.116863-3-u.kleine-koenig@pengutronix.de>
 <YNHh2cdcyzLWSCkK@dell>
 <20210624201009.5se7o27b7m6bff4g@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210624201009.5se7o27b7m6bff4g@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 24 Jun 2021, Uwe Kleine-König wrote:

> Hi Lee,
> 
> On Tue, Jun 22, 2021 at 02:12:57PM +0100, Lee Jones wrote:
> > On Mon, 21 Jun 2021, Uwe Kleine-König wrote:
> > 
> > > The practical upside here is that this only needs a single API call to
> > > program the hardware which (depending on the underlaying hardware) can
> > > be more effective and prevents glitches.
> > > 
> > > Up to now the return value of the pwm functions was ignored. Fix this
> > > and propagate the error to the caller.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > ---
> > >  drivers/video/backlight/lm3630a_bl.c | 42 +++++++++++++---------------
> > >  1 file changed, 19 insertions(+), 23 deletions(-)
> > 
> > Fixed the subject line and applied, thanks.
> 
> It's not obvious to me what needed fixing here, and I don't find where
> you the patches, neither in next nor in
> https://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git; so I
> cannot check what you actually changed.
> 
> I assume you did s/lm3630a/lm3630a_bl/ ? I didn't because it felt
> tautological.

No, but perhaps I should have.  Format goes:

<backlight>: <driver_file_name>: <Subject starting with uppercase>

Where <driver_file_name> has the file extension removed.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
