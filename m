Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B71C83013
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 10:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9987206C0
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 10:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="G0+nZemJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgLAKFC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 05:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727590AbgLAKFC (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Dec 2020 05:05:02 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38EBC0613D3
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Dec 2020 02:04:12 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id 79so1101489otc.7
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Dec 2020 02:04:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=33/zkU0aBUbm6IWtg6RLVv0ESfiR5fSbnSusLdV9U28=;
        b=G0+nZemJpfABRr8a7b1eByhc6uhcVo6zsElrKMWHFxlZD+pLmEtjR2R59L01CQTmgO
         11NQOeiE3lZpqrLRN0KMSN6XGUyuxMo6oXInOnpnVf+0eN+M4aItZqOBobKdmDBPfGWL
         g9XvkWlzK3sCOIQew6TAJ/TLLTZXRaDqP9Zy0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=33/zkU0aBUbm6IWtg6RLVv0ESfiR5fSbnSusLdV9U28=;
        b=sMPR1EHfVzJ+SDaKCaSfp+4+IzgvLc3vK0GN2IMpzWcDThuCsZCqQV/y2NqhUH2fgr
         X88q6WitPvh/K9treh5E8FRz9+F4ozq80klVYhSUnmpYfhQf7JSysciYfE8vINlZMA4n
         oyP+rl7iJBTg6gvcDTEcgSYfCo22HVl1thU2hSutgw2Vnlm84WGWwz37tldWSHf2039U
         2UnBJYnTgx+Uf0oEA3pyHRDp8IMPmnNCBCXz9vCyJrs6epu6Y8g+pPLdGKVXCBPg/MRX
         XY0m3AS1hNIEnvrad7/4rbJlRGA7YWWtpaWQ+yIcE+TS2faTYzgS3/iUl+NVQYadeiXJ
         9eng==
X-Gm-Message-State: AOAM533w4yTh2+z3stKvq7g8EqKVF+v+x+a41oS1ip7Xa0j90SsFYpOU
        kMBIXxcQwIgx1k6pLdWlGKbDJ5r0qtKTR+ndCq/T0w==
X-Google-Smtp-Source: ABdhPJzqOqsKVD+FVmIaGGSHLAUt8mchKo3H7Mm8FVT7YBHYWw6zIst2LgZAOvDrbg95Sm8xGEWCTlx1bkkp+TClhn8=
X-Received: by 2002:a9d:4e08:: with SMTP id p8mr1325493otf.188.1606817052174;
 Tue, 01 Dec 2020 02:04:12 -0800 (PST)
MIME-Version: 1.0
References: <20201128224114.1033617-1-sam@ravnborg.org> <20201128224114.1033617-14-sam@ravnborg.org>
 <53f3e91e-d8da-bce6-878c-7842250a7a7c@suse.de> <20201130183549.GA1498572@ravnborg.org>
 <20201201084718.GF4801@dell> <20201201090745.GA1980788@ravnborg.org> <20201201094629.GG4801@dell>
In-Reply-To: <20201201094629.GG4801@dell>
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
Date:   Tue, 1 Dec 2020 11:04:01 +0100
Message-ID: <CAKMK7uGUJbVRVTO8xL8Kc8BbYMXzqS2KAVYL8bgex3Zz=aF9EQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/28] video: fbdev: riva: Fix kernel-doc and set but
 not used warnings
To:     Lee Jones <lee.jones@linaro.org>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Dec 1, 2020 at 10:46 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Tue, 01 Dec 2020, Sam Ravnborg wrote:
>
> > Hi Lee,
> >
> > >
> > > Cop-out!
> > >
> > > Do what I do and make something up (joke)! :'D
> >
> > If I thought anyone would actually read the comments then maybe yes.
> > But I assume that apart from this thread no-one will read it.
> >
> > >
> > > > > Well, it fixes the warning ;)
> > > >
> > > > Yeah, I could not dig up anything useful to say here.
> > > > Was tempted to just drop all the kernel-doc syntax but that
> > > > was a larger change.
> > >
> > > Did you trace it from it's origin down to it's final use?
> > Yeah, but not something that seemed useful.
> > I could have added "translating from pixels->bytes" as they
> > are described somewhere else. But I could not convince myself
> > this was right so I just silenced the warning.
> >
> > The only reason I kept the kernel-doc in the first place is
> > that I am told some editors use it.
> >
> > The only effect the kernel-doc in fbdev has right now is burning
> > effort that could have been spent (better?) somewhere else, and
> > I would personally prefer to drop the kernel-doc annotations.
> >
> > But I already discussed this in another thread (not fbdev related)
> > and I was told it was useful for some, so it is kept.
>
> I personally think they should be kept.  Despite not being referenced
> by any kernel-doc:: key-words.  As you say, it can be helpful as an
> in-code reference for driver writers, people debugging code, et al.
>
> Not sure I would just repeat the variable name just to silence the
> warning though - that is definitely a hack.  In the thousands
> (literally!) of these that I've fixed thus far, I haven't needed to do
> that.

Personally what I've done is to just remove the kerneldoc marker (and
anything else that's obviously wrong) and leave plain comments behind.
At least for old outdated code that no one actively maintains anymore.
Keeps the comment as maybe something useful, and avoids pointless busy
work of inventing kerneldoc which might or might not actually be
correctly describing what's going on.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
