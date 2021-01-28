Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6ADC433E0
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 01:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D18261492
	for <linux-fbdev@archiver.kernel.org>; Thu, 28 Jan 2021 01:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbhA1BQ0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 20:16:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbhA1BNr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 20:13:47 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08407C06174A;
        Wed, 27 Jan 2021 17:13:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id w14so2901484pfi.2;
        Wed, 27 Jan 2021 17:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=HTf847R2lSIm8x+zWW8zp5qWCZrtnr76dEbaeyoOfVQ=;
        b=DV1RYbjq2ydxVkQXTxqIB/LGIYnbt8W+hdU9FIOEHIA3+fD3h0dT0KLSCV2jHikRkx
         Bsj1ztj3Y+d24bzrwyklZVKjQC6QgOeUcKZvhyHfpxz13N/5ONNauPzl0IJ3bkIyYHA5
         O+XGHKHemFQ74auCEZnyP+P2mCJL0z9Wxqq5Ga3ClITei1ldOdfthuyHECrERU5xoHVe
         rcW+Cf/ZRodDAWB+OvacraPumZkGrE+scd4VURd87U+Ha3zxMeJTbuMODAGdNXeG/wgZ
         mVH/XyeGnG9Abto5R6purWKOe4YOuGtxZoh/kcJ8gRDb11nKUIHFOfKICfiR8V5Z+tHO
         GWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=HTf847R2lSIm8x+zWW8zp5qWCZrtnr76dEbaeyoOfVQ=;
        b=J1S+QP//Zndy8ItQSQgzHWeKffECXcj9ZN21LkiKS/dj8NU3mey18dS2Teg8qXCm6b
         q3WavpXiumLkgAnoPDGMsAGpYsbJZw1ZNl5hxG7kZcQV5yPkmvyino3M2VjhktKmualC
         KHAURncbN+vdbsB6jF1nOYsjLN0WlUcnxdmG23nDglWF6KsAwSjB9M5G6Qu4R0TrePd7
         x0pTOjzI16y38odT4DQewZ003PaEuqVdXg/nhZ2DYWaBbblHQfsSkX48Na8tQbKT5ZgC
         ahgRPD3vdNY047OpKwrIjp1ce6ZYP9b6TbiZXNh6YnCzSJ1zl5QKSXbbjYWFwgfzEPBP
         ugQA==
X-Gm-Message-State: AOAM532AQ/mqY83j273XtwZ1FmEufqJmYgXQko1a60XVrUrhw2jPY9nj
        zMZNPPhIc8bHyMkDZUWAs+A=
X-Google-Smtp-Source: ABdhPJwAVPIVABanGwOlp0fmVeuqXJz6+UxjKrII1NyFy/nqj3OsX7LyWJpiv2D6MLArHLZ7TbNu1w==
X-Received: by 2002:a63:ea4b:: with SMTP id l11mr13854886pgk.61.1611796386638;
        Wed, 27 Jan 2021 17:13:06 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id s9sm3731356pfd.38.2021.01.27.17.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 17:13:05 -0800 (PST)
Date:   Thu, 28 Jan 2021 09:12:59 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, sbrivio@redhat.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Joe Perches <joe@perches.com>,
        Andy Whitcroft <apw@canonical.com>, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <20210128091259.00003202@gmail.com>
In-Reply-To: <YBGAi+14PlXIdvxF@kroah.com>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
        <YBFv+12xfsoxacDb@kroah.com>
        <20210127220809.000026fb@gmail.com>
        <YBF08Xf7qaZx3YZ1@kroah.com>
        <20210127221708.00002568@gmail.com>
        <YBF30EEUkhEMY5ti@kroah.com>
        <20210127144946.GF2696@kadam>
        <YBGAi+14PlXIdvxF@kroah.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 16:02:35 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 27, 2021 at 05:49:46PM +0300, Dan Carpenter wrote:
> > On Wed, Jan 27, 2021 at 03:25:20PM +0100, Greg KH wrote:  
> > > On Wed, Jan 27, 2021 at 10:17:08PM +0800, carlis wrote:  
> > > > On Wed, 27 Jan 2021 15:13:05 +0100
> > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >   
> > > > > On Wed, Jan 27, 2021 at 10:08:09PM +0800, carlis wrote:  
> > > > > > On Wed, 27 Jan 2021 14:51:55 +0100
> > > > > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >     
> > > > > > > On Wed, Jan 27, 2021 at 09:42:52PM +0800, Carlis wrote:
> > > > > > >  
> > > > > > > > From: zhangxuezhi <zhangxuezhi1@yulong.com>
> > > > > > > > 
> > > > > > > > For st7789v ic,when we need continuous full screen
> > > > > > > > refresh, it is best to wait for the TE signal arrive to
> > > > > > > > avoid screen tearing
> > > > > > > > 
> > > > > > > > Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>
> > > > > > > >   
> > > > > > > 
> > > > > > > Please slow down and wait at least a day between patch
> > > > > > > submissions, there is no rush here.
> > > > > > > 
> > > > > > > And also, ALWAYS run scripts/checkpatch.pl on your
> > > > > > > submissions, so that you don't have a maintainer asking
> > > > > > > you about basic problems, like are in this current patch
> > > > > > > :(
> > > > > > > 
> > > > > > > thanks,
> > > > > > > 
> > > > > > > greg k-h    
> > > > > > 
> > > > > > hi,
> > > > > >   This is my first patch contribution to Linux, so some of
> > > > > > the rules are not very clear .In addition, I can confirm
> > > > > > that before sending patch, I check it with checkPatch.py
> > > > > > every time.Thank you very much for your help    
> > > > > 
> > > > > Please read Documentation/SubmittingPatches which has a link
> > > > > to the checklist and other documentation you should read.
> > > > > 
> > > > > And I doubt you are running checkpatch on your submission, as
> > > > > there is obvious coding style issues in it.  If so, please
> > > > > provide the output as it must be broken :(
> > > > > 
> > > > > thanks,
> > > > > 
> > > > > greg k-h  
> > > > hi, the patch v11 checkpatch.pl output is below:
> > > > 
> > > > carlis@bf-rmsz-10:~/work/linux-kernel/linux$
> > > > ./scripts/checkpatch.pl
> > > > 0001-staging-fbtft-add-tearing-signal-detect.patch total: 0
> > > > errors, 0 warnings, 0 checks, 176 lines checked
> > > > 
> > > > 0001-staging-fbtft-add-tearing-signal-detect.patch has no
> > > > obvious style problems and is ready for submission.  
> > > 
> > > Wow, my apologies!
> > > 
> > > Andy and Joe, there's something wrong here that is missing the
> > > fact that a line is being indented with spaces and not tabs in
> > > the patch at
> > > https://lore.kernel.org/r/1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com
> > > 
> > > Any ideas what broke?
> > >   
> > 
> >     /*Tearing Effect Line On*/
> > 
> > Comments are the exception to the "no spaces at the start of a line"
> > rule.  I was expecting that the kbuild-bot would send a Smatch
> > warning for inconsistent indenting, but comments are not counted
> > there either.
> > 
> > I'm sort of surprised that we don't have checkpatch rule about the
> > missing space characters.  It should be: "/* Tearing Effect Line On
> > */".  
> 
> That was going to be my next question, lots of comments added in this
> patch don't have spaces...
> 
> thanks,
> 
> greg k-h

Ok,i will fix it in patch v12 tomorrow

regards,
zhangxuezhi
