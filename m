Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E80C4742C
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 18:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94937205CB
	for <linux-fbdev@archiver.kernel.org>; Mon, 16 Nov 2020 18:11:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730441AbgKPSLW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 16 Nov 2020 13:11:22 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:36316 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730200AbgKPSLV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 16 Nov 2020 13:11:21 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 31B6780541;
        Mon, 16 Nov 2020 19:11:14 +0100 (CET)
Date:   Mon, 16 Nov 2020 19:11:12 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Bernard Zhao <bernard@vivo.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 10/27] video: fix some kernel-doc markups
Message-ID: <20201116181112.GA103421@ravnborg.org>
References: <cover.1605521731.git.mchehab+huawei@kernel.org>
 <21661aed9892a1bacc7ef76a5dc9f5c7b37f5d8f.1605521731.git.mchehab+huawei@kernel.org>
 <20201116153606.GC401619@phenom.ffwll.local>
 <20201116173804.7d64f55f@coco.lan>
 <20201116172404.GD401619@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116172404.GD401619@phenom.ffwll.local>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=kjb6p09E1yaTWQ9aDqwA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel
> > Feel free to just merge it via your tree. Patches here are pretty
> > much independent ;-)
> 
> Ok I put it into drm-misc-next. I kinda assumed since there's also a huge
> effort going on to shut up warnings, plus I think kerneldoc issues are
> reported by a bunch of build bots nowadays. So assumed you pile this all
> up.

Any reason "drm: fix some kernel-doc markups" was not applied?

	Sam
