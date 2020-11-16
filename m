Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7FEC2D0A3
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 18:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A1BD21D7E
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 18:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zL3QR8va"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgKPSm3 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:42:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:45622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726519AbgKPSm3 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 16 Nov 2020 13:42:29 -0500
Received: from coco.lan (ip5f5ad5de.dynamic.kabel-deutschland.de [95.90.213.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5954217A0;
        Mon, 16 Nov 2020 18:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605552149;
        bh=PKf1mrbQSMMCl7kXOxvqWnUL+SpVIOm/wqvhMfGOZjo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=zL3QR8vaSXFPeXVOJrU0zE3M2CkJiOe/scDAEqonDmxy98+64KoiKnGDgc4Ugp7ho
         G3/lqQzTQnAoVnRRnSIjUNYanXAjjkf1CFuRPY73f3TwEfxAOAdqvFEvQfybuJ0gaG
         svOlDy2aujIq7vXqcGBtNWw3mdpvegq+xMSx2gkA=
Date:   Mon, 16 Nov 2020 19:42:20 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/27] video: fix some kernel-doc markups
Message-ID: <20201116194220.15cc9a33@coco.lan>
In-Reply-To: <20201116172404.GD401619@phenom.ffwll.local>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
        <21661aed9892a1bacc7ef76a5dc9f5c7b37f5d8f.1605521731.git.mchehab+huawei@kernel.org>
        <20201116153606.GC401619@phenom.ffwll.local>
        <20201116173804.7d64f55f@coco.lan>
        <20201116172404.GD401619@phenom.ffwll.local>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Em Mon, 16 Nov 2020 18:24:04 +0100
Daniel Vetter <daniel@ffwll.ch> escreveu:

> On Mon, Nov 16, 2020 at 05:38:04PM +0100, Mauro Carvalho Chehab wrote:
> > Em Mon, 16 Nov 2020 16:36:06 +0100
> > Daniel Vetter <daniel@ffwll.ch> escreveu:
> >   
> > > On Mon, Nov 16, 2020 at 11:18:06AM +0100, Mauro Carvalho Chehab wrote:  
> > > > Some identifiers have different names between their prototypes
> > > > and the kernel-doc markup.
> > > > 
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>    
> > > 
> > > Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> > > 
> > > I'm assuming you're sending a pull request for this.  
> > 
> > Feel free to just merge it via your tree. Patches here are pretty
> > much independent ;-)  
> 
> Ok I put it into drm-misc-next. I kinda assumed since there's also a huge
> effort going on to shut up warnings, plus I think kerneldoc issues are
> reported by a bunch of build bots nowadays. So assumed you pile this all
> up.

Currently, this doesn't generate any warnings (which, IMHO, it is a
very bad thing). The final patch on this series actually such warning. 
My plan is to have the final patch merged for Kernel 5.11.

So, at least from PoV of shut up warnings[1], this patch be either
be merged for 5.11 or earlier.

Regards,
Mauro

-

[1] Basically, if you do:

	/**
	 * foo - some foo func
	 */
	int bar(...)

the documentation will be for "bar()" function, instead of
"foo()", as Kernel-doc currently simply ignores "foo".

On several places, this is due to a typo or a function
rename, but there are a few places where a "bar()" function
got added between the kernel-doc markup and "foo()" function,
thus producing wrong docs. Don't remember if are there any
such issues under drivers/video or drivers/gpu.
