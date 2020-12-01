Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2155C71156
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 10:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89B2320770
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 10:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bIQv4DWo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgLAK1z (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:27:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725861AbgLAK1y (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Dec 2020 05:27:54 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60396C0613D3
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Dec 2020 02:27:08 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id t4so1785924wrr.12
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Dec 2020 02:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TkHSBf0Y4Aa6IfCBB6BqBgjrMxTCo4yUD4NQ14lHsWg=;
        b=bIQv4DWorFQLSLt/f4sNxk/jXVMt/gaBYE2nZDruE/OcBlTjIHUcPkFvvIP6Rq457o
         UmgC3mAQ8uTxfw+G1VtOvYIY4nResMg2/rxevaldljJv2HrNP5B6M8PYbfC2XOjq1WrW
         ZCsYwBNprlxq1ZJj5vIrCKMIVUn2EinN55I7ohumkPrSg3ylW88LxmjkRMLpHdMzhtDh
         oA8G5pPaPgYbqzra3k9+3MSQ9btbo/x0JE7R752W9fvpcw445GtMwP3jDWKCkCjrvs9B
         CrZb7tAvj9DNDhIeZJFdjeKC9ryJbNgyJgb79GlUpc3npkfGO5N7wseeoySyY9GG63d4
         YySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=TkHSBf0Y4Aa6IfCBB6BqBgjrMxTCo4yUD4NQ14lHsWg=;
        b=Ua56c6Th0rOcVjUuQPwptK9ovOzC/hDcOnf0MsvRY0BsA0lhjOjVRiEpMTh2y2ZwET
         QaVP6LtyDXeps8YQb1IO3mAW2oDZicR9dD6qMPKWy3QaX7Qc+/b6tn+LPLCcoiCrYqSU
         oE/eZUdTxpqzbMLPUumHFXs8BMwxsrT9u307yMATQ9OnvDdgugJJ6aeaYnDQ02yopbcU
         Rsk7kq4h57wEJWnBu+V4r510mfQenn6eoypO5OvO9+skVv6gTVZtAik3F2ixnNKCAaRg
         FjBFqrW/VD6TEY3sY0EUEbpc235sLun35OiDpZgLSIP5kU3PfSDh7qw0XtENAR7isfvo
         egZQ==
X-Gm-Message-State: AOAM531c3NI2e1/+q+SP5X+NEDF1B8J2cqoFRtLugACv5JHZMUufmQTG
        eDuabqbW6kBzINJm7xOJMGH2Fw==
X-Google-Smtp-Source: ABdhPJwdcN76+wHTOWuOVVwHQy1GYZ7hUQ0G3fUBGdjzsMySPZ6Xld4ZKzt10eIo3P0un/x1Mtmmow==
X-Received: by 2002:a5d:4802:: with SMTP id l2mr2914270wrq.424.1606818427006;
        Tue, 01 Dec 2020 02:27:07 -0800 (PST)
Received: from dell ([91.110.221.235])
        by smtp.gmail.com with ESMTPSA id v7sm2218419wma.26.2020.12.01.02.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 02:27:06 -0800 (PST)
Date:   Tue, 1 Dec 2020 10:27:04 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Aditya Pakki <pakki001@umn.edu>,
        Xiaofei Tan <tanxiaofei@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jason Yan <yanaijie@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Peter Rosin <peda@axentia.se>,
        George Kennedy <george.kennedy@oracle.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Joe Perches <joe@perches.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v2 13/28] video: fbdev: riva: Fix kernel-doc and set but
 not used warnings
Message-ID: <20201201102704.GH4801@dell>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-14-sam@ravnborg.org>
 <53f3e91e-d8da-bce6-878c-7842250a7a7c@suse.de>
 <20201130183549.GA1498572@ravnborg.org>
 <20201201084718.GF4801@dell>
 <20201201090745.GA1980788@ravnborg.org>
 <20201201094629.GG4801@dell>
 <CAKMK7uGUJbVRVTO8xL8Kc8BbYMXzqS2KAVYL8bgex3Zz=aF9EQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKMK7uGUJbVRVTO8xL8Kc8BbYMXzqS2KAVYL8bgex3Zz=aF9EQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, 01 Dec 2020, Daniel Vetter wrote:

> On Tue, Dec 1, 2020 at 10:46 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Tue, 01 Dec 2020, Sam Ravnborg wrote:
> >
> > > Hi Lee,
> > >
> > > >
> > > > Cop-out!
> > > >
> > > > Do what I do and make something up (joke)! :'D
> > >
> > > If I thought anyone would actually read the comments then maybe yes.
> > > But I assume that apart from this thread no-one will read it.
> > >
> > > >
> > > > > > Well, it fixes the warning ;)
> > > > >
> > > > > Yeah, I could not dig up anything useful to say here.
> > > > > Was tempted to just drop all the kernel-doc syntax but that
> > > > > was a larger change.
> > > >
> > > > Did you trace it from it's origin down to it's final use?
> > > Yeah, but not something that seemed useful.
> > > I could have added "translating from pixels->bytes" as they
> > > are described somewhere else. But I could not convince myself
> > > this was right so I just silenced the warning.
> > >
> > > The only reason I kept the kernel-doc in the first place is
> > > that I am told some editors use it.
> > >
> > > The only effect the kernel-doc in fbdev has right now is burning
> > > effort that could have been spent (better?) somewhere else, and
> > > I would personally prefer to drop the kernel-doc annotations.
> > >
> > > But I already discussed this in another thread (not fbdev related)
> > > and I was told it was useful for some, so it is kept.
> >
> > I personally think they should be kept.  Despite not being referenced
> > by any kernel-doc:: key-words.  As you say, it can be helpful as an
> > in-code reference for driver writers, people debugging code, et al.
> >
> > Not sure I would just repeat the variable name just to silence the
> > warning though - that is definitely a hack.  In the thousands
> > (literally!) of these that I've fixed thus far, I haven't needed to do
> > that.
> 
> Personally what I've done is to just remove the kerneldoc marker (and
> anything else that's obviously wrong) and leave plain comments behind.
> At least for old outdated code that no one actively maintains anymore.
> Keeps the comment as maybe something useful, and avoids pointless busy
> work of inventing kerneldoc which might or might not actually be
> correctly describing what's going on.

Right.  Demoting is also a good option if in doubt.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
