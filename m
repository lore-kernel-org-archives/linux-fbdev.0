Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E50DC3E8C5
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Nov 2020 11:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DBB20771
	for <linux-fbdev@archiver.kernel.org>; Sun, 29 Nov 2020 11:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgK2LW5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 29 Nov 2020 06:22:57 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:50820 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgK2LW4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 29 Nov 2020 06:22:56 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 9F9A620026;
        Sun, 29 Nov 2020 12:22:07 +0100 (CET)
Date:   Sun, 29 Nov 2020 12:22:06 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Alexander Klimov <grandmaster@al2klimov.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Antonino Daplas <adaplas@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Evgeny Novikov <novikov@ispras.ru>,
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
        Mike Rapoport <rppt@kernel.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Peter Rosin <peda@axentia.se>,
        Qilong Zhang <zhangqilong3@huawei.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Xiaofei Tan <tanxiaofei@huawei.com>
Subject: Re: [PATCH v2 01/28] video: Fix kernel-doc warnings in
 of_display_timing + of_videomode
Message-ID: <20201129112206.GB1094053@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-2-sam@ravnborg.org>
 <ca28a1e4-3e73-fdfc-e288-eaac4b228610@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca28a1e4-3e73-fdfc-e288-eaac4b228610@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=KKAkSRfTAAAA:8 a=VwQbUJbxAAAA:8
        a=gzKDScf-u2H0hSbXR7QA:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22 a=AjGcO6oz07-iQ99wixmX:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sun, Nov 29, 2020 at 11:01:13AM +0100, Thomas Zimmermann wrote:
> 
> 
> Am 28.11.20 um 23:40 schrieb Sam Ravnborg:
> > Fix kernel-doc warnings reported when using W=1.
> > 
> > v2:
> >    - Improve subject (Lee)
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: linux-fbdev@vger.kernel.org
> > ---
> >   drivers/video/of_display_timing.c | 1 +
> >   drivers/video/of_videomode.c      | 8 ++++----
> >   2 files changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/of_display_timing.c b/drivers/video/of_display_timing.c
> > index abc9ada798ee..f93b6abbe258 100644
> > --- a/drivers/video/of_display_timing.c
> > +++ b/drivers/video/of_display_timing.c
> > @@ -52,6 +52,7 @@ static int parse_timing_property(const struct device_node *np, const char *name,
> >   /**
> >    * of_parse_display_timing - parse display_timing entry from device_node
> >    * @np: device_node with the properties
> > + * @dt: display_timing that contains the result. I may be partially written in case of errors
> >    **/
> >   static int of_parse_display_timing(const struct device_node *np,
> >   		struct display_timing *dt)
> > diff --git a/drivers/video/of_videomode.c b/drivers/video/of_videomode.c
> > index 67aff2421c29..a5bb02f02b44 100644
> > --- a/drivers/video/of_videomode.c
> > +++ b/drivers/video/of_videomode.c
> > @@ -13,10 +13,10 @@
> >   #include <video/videomode.h>
> >   /**
> > - * of_get_videomode - get the videomode #<index> from devicetree
> 
> What's wrong with this line? We use the dash in lots of places?
I think my OCD kicked in and I made all lines use ':'.
I will re-add the dash when I apply.

> 
> Besides this,
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

	Thanks
