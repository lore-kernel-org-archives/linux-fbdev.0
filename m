Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BA4C71156
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49F042222C
	for <linux-fbdev@archiver.kernel.org>; Sat, 28 Nov 2020 22:12:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgK1VuA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 28 Nov 2020 16:50:00 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:40072 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgK1SyZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 28 Nov 2020 13:54:25 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6BB9380540;
        Sat, 28 Nov 2020 16:15:36 +0100 (CET)
Date:   Sat, 28 Nov 2020 16:15:34 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joe Perches <joe@perches.com>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-nvidia@lists.surfsouth.com,
        Michal Januszewski <spock@gentoo.org>,
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Thomas Zimemrmann <tzimmermann@suse.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH v1 01/28] video: Fix W=1 warnings in of_videomode +
 of_display_timing
Message-ID: <20201128151534.GA981314@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
 <20201127195825.858960-2-sam@ravnborg.org>
 <20201128082820.GX2455276@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201128082820.GX2455276@dell>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=PMmVyNwjNFpPq2a28g8A:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Lee,
On Sat, Nov 28, 2020 at 08:28:20AM +0000, Lee Jones wrote:
> On Fri, 27 Nov 2020, Sam Ravnborg wrote:
> 
> > Fix trivial W=1 warnings.
> > Update kernel-doc to avoid the warnings.
> 
> Can you put what's being fixed in the subject line please?
> 
> "fix w=1 warnings" is very bland and this it is unlikely to be the
> only w=1 warning that gets fixed in these files, so has a high likely
> hood of having an identical subject-line as a previous/future patch.
> 
> With regards to the latter point; I have personally found subject
> lines to be a pretty reliable way of maintaining/backporting older
> kernels.  The nomenclature here would taint that pretty readily.

Thanks for the feedback and the background for your comment.
Will fix them all for v2,

	Sam
