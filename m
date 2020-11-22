Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E06C5519F
	for <linux-fbdev@archiver.kernel.org>; Sun, 22 Nov 2020 22:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDA3920757
	for <linux-fbdev@archiver.kernel.org>; Sun, 22 Nov 2020 22:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgKVWFp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 22 Nov 2020 17:05:45 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:51306 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKVWFp (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 22 Nov 2020 17:05:45 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id D662A80567;
        Sun, 22 Nov 2020 23:05:41 +0100 (CET)
Date:   Sun, 22 Nov 2020 23:05:40 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Andres Salomon <dilinger@queued.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-geode@lists.infradead.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 134/141] video: fbdev: lxfb_ops: Fix fall-through
 warnings for Clang
Message-ID: <20201122220540.GC566387@ravnborg.org>
References: <cover.1605896059.git.gustavoars@kernel.org>
 <9c1dcb12aae7c7ff0907ffb99ffd227656cbe444.1605896060.git.gustavoars@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c1dcb12aae7c7ff0907ffb99ffd227656cbe444.1605896060.git.gustavoars@kernel.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VafZwmh9 c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=iH7RfIX4AAAA:20 a=VwQbUJbxAAAA:8
        a=qwgYBgRIEWy96sd6CT4A:9 a=CjuIK1q_8ugA:10 a=VlZU0XKO32wA:10
        a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Gustavo,
On Fri, Nov 20, 2020 at 12:40:32PM -0600, Gustavo A. R. Silva wrote:
> In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
> by explicitly adding a break statement instead of letting the code fall
> through to the next case.
> 
> Link: https://github.com/KSPP/linux/issues/115
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks, applied this and the following patch to drm-misc-next.
Looks forward to have this warning enabled.

One can only wonder how many hours will be saved by lettting the
compiler tell you a break is missing. This is the kind of bugs you can
stare you blind at.

	Sam
