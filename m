Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E209EC83017
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 09:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9482F20674
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Dec 2020 09:21:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389295AbgLAJIl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Dec 2020 04:08:41 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:45192 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389281AbgLAJIk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Dec 2020 04:08:40 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id B8B5B2001F;
        Tue,  1 Dec 2020 10:07:46 +0100 (CET)
Date:   Tue, 1 Dec 2020 10:07:45 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
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
Message-ID: <20201201090745.GA1980788@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-14-sam@ravnborg.org>
 <53f3e91e-d8da-bce6-878c-7842250a7a7c@suse.de>
 <20201130183549.GA1498572@ravnborg.org>
 <20201201084718.GF4801@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201084718.GF4801@dell>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=t8GryHL0c4qf8DcNx-0A:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Lee,

> 
> Cop-out!
> 
> Do what I do and make something up (joke)! :'D

If I thought anyone would actually read the comments then maybe yes.
But I assume that apart from this thread no-one will read it.

> 
> > > Well, it fixes the warning ;)
> > 
> > Yeah, I could not dig up anything useful to say here.
> > Was tempted to just drop all the kernel-doc syntax but that
> > was a larger change.
> 
> Did you trace it from it's origin down to it's final use?
Yeah, but not something that seemed useful.
I could have added "translating from pixels->bytes" as they
are described somewhere else. But I could not convince myself
this was right so I just silenced the warning.

The only reason I kept the kernel-doc in the first place is
that I am told some editors use it.

The only effect the kernel-doc in fbdev has right now is burning
effort that could have been spent (better?) somewhere else, and
I would personally prefer to drop the kernel-doc annotations.

But I already discussed this in another thread (not fbdev related)
and I was told it was useful for some, so it is kept.

	Sam
