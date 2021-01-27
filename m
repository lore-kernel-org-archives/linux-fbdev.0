Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164A1C433DB
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA0AE206C2
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:20:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbhA0OUD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:20:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233084AbhA0ORz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 09:17:55 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6BF1C061573;
        Wed, 27 Jan 2021 06:17:15 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id t29so1260512pfg.11;
        Wed, 27 Jan 2021 06:17:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=SBU3ke6fyTe5WhDbhpXLXYEkr+BqHP21ZqQYSRrwOXs=;
        b=Q5O8nvrkMwwMaxaEqijSY2y5joaR6h/NQ2dkol0M9GtexhWliJre8V2Fycbtml+4MI
         E2pbHs5wpZYfbJCnxdoxXgDgANbKAK2u12ZpxY3ksMl1VtiK6JosOfiOuiPhbYLCAeM9
         vMUXzRMhFdbnDb43rvl4YvOlW9IYkWrBkpiHPROLYLIyebh0RN1WDOEld5Nln7Axs5g4
         rJCPFE/ZkOPPFO7APRdtrPLLNC7ln2KqIii6YaBkkfJn90Y58ubwszV9DWFtaeDdtlJO
         +sK/ybhRyCN1SSdON+HpfdJZWutf+6Zhy16rNyJAEwtw7klziC3BYFGOmg4jg4M1+nPA
         Kw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=SBU3ke6fyTe5WhDbhpXLXYEkr+BqHP21ZqQYSRrwOXs=;
        b=Haut9q0nFJb5xQ7mZjSL39X4sLitpmvQZytI9XE/vGMkFvvmT3P2m3yWrGbTukQcfR
         DxQJo+EUJWUYCVIW6CiDy71g0ruLsjZLOjt/rsbB3iFMOfpb9K2Aytuq55TWjhxBBydR
         e224HjhP3DKXlxKhtPkFpUAU2aP20mhIDGjm6+6xzVSU8xPoG5eJt/QksRc3n5iy2ncs
         AXWnllYPywByCWklxCdygJvHmSR/VUmN09/Rj5jmRHQJtfFaqWx4HzsSjzZhNVZSu8CH
         6ba0CRHwDjuGdPzcR/oFmobXosWUR/Vz4a+J2a0AX08gtLbvFwpE8NsCh5o6w1NZ8E6w
         hxEw==
X-Gm-Message-State: AOAM5335NsiHvw9EO1fWASgRtF24E/YzEHDw6WfGeG+YsPr4MKfPITSp
        AWRh4kNp01OFRn/PYQHAOMA=
X-Google-Smtp-Source: ABdhPJxCJImDA6E9Uooenclpkv0Ck2OHxQ2VhnjVf7XXOlKRkkDt0sWmIOf2xGknjCNxTRopaoTIqw==
X-Received: by 2002:a62:160b:0:b029:1bf:56ca:a594 with SMTP id 11-20020a62160b0000b02901bf56caa594mr10748988pfw.57.1611757035311;
        Wed, 27 Jan 2021 06:17:15 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id s15sm2492502pfh.107.2021.01.27.06.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jan 2021 06:17:14 -0800 (PST)
Date:   Wed, 27 Jan 2021 22:17:08 +0800
From:   carlis <zhangxuezhi3@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
Message-ID: <20210127221708.00002568@gmail.com>
In-Reply-To: <YBF08Xf7qaZx3YZ1@kroah.com>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
        <YBFv+12xfsoxacDb@kroah.com>
        <20210127220809.000026fb@gmail.com>
        <YBF08Xf7qaZx3YZ1@kroah.com>
Organization: Tyzmig-ryrjum-8kedto
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 27 Jan 2021 15:13:05 +0100
Greg KH <gregkh@linuxfoundation.org> wrote:

> On Wed, Jan 27, 2021 at 10:08:09PM +0800, carlis wrote:
> > On Wed, 27 Jan 2021 14:51:55 +0100
> > Greg KH <gregkh@linuxfoundation.org> wrote:
> >   
> > > On Wed, Jan 27, 2021 at 09:42:52PM +0800, Carlis wrote:  
> > > > From: zhangxuezhi <zhangxuezhi1@yulong.com>
> > > > 
> > > > For st7789v ic,when we need continuous full screen refresh, it
> > > > is best to wait for the TE signal arrive to avoid screen tearing
> > > > 
> > > > Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>    
> > > 
> > > Please slow down and wait at least a day between patch
> > > submissions, there is no rush here.
> > > 
> > > And also, ALWAYS run scripts/checkpatch.pl on your submissions, so
> > > that you don't have a maintainer asking you about basic problems,
> > > like are in this current patch :(
> > > 
> > > thanks,
> > > 
> > > greg k-h  
> > 
> > hi,
> >   This is my first patch contribution to Linux, so some of the rules
> > are not very clear .In addition, I can confirm that before sending
> > patch, I check it with checkPatch.py every time.Thank you very much
> > for your help  
> 
> Please read Documentation/SubmittingPatches which has a link to the
> checklist and other documentation you should read.
> 
> And I doubt you are running checkpatch on your submission, as there is
> obvious coding style issues in it.  If so, please provide the output
> as it must be broken :(
> 
> thanks,
> 
> greg k-h
hi, the patch v11 checkpatch.pl output is below:

carlis@bf-rmsz-10:~/work/linux-kernel/linux$ ./scripts/checkpatch.pl
0001-staging-fbtft-add-tearing-signal-detect.patch total: 0 errors, 0
warnings, 0 checks, 176 lines checked

0001-staging-fbtft-add-tearing-signal-detect.patch has no obvious style
problems and is ready for submission.


regards
zhangxuezhi

