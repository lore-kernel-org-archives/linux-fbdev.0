Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 581BDC63777
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 22:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258E922228
	for <linux-fbdev@archiver.kernel.org>; Fri, 27 Nov 2020 22:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgK0WzA (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 27 Nov 2020 17:55:00 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:32952 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731413AbgK0Wgs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 27 Nov 2020 17:36:48 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id 33C1420033;
        Fri, 27 Nov 2020 23:36:17 +0100 (CET)
Date:   Fri, 27 Nov 2020 23:36:15 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Joe Perches <joe@perches.com>
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
        Ferenc Bakonyi <fero@drama.obuda.kando.hu>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        George Kennedy <george.kennedy@oracle.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gustavo Silva <gustavoars@kernel.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Jason Yan <yanaijie@huawei.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jiri Slaby <jirislaby@kernel.org>,
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
Subject: Re: [PATCH v1 02/28] video: fbcon: Use pr_debug() in fbcon
Message-ID: <20201127223615.GA872093@ravnborg.org>
References: <20201127195825.858960-1-sam@ravnborg.org>
 <20201127195825.858960-3-sam@ravnborg.org>
 <f8b2737702e295b9f780b98f27faac759ffff7ae.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f8b2737702e295b9f780b98f27faac759ffff7ae.camel@perches.com>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=VOK_sTC4ckVJP7rGVwkA:9 a=wPNLvfGTeEIA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Joe.

On Fri, Nov 27, 2020 at 01:16:41PM -0800, Joe Perches wrote:
> On Fri, 2020-11-27 at 20:57 +0100, Sam Ravnborg wrote:
> > Replacing DPRINTK() statements with pr_debug fixes
> > W=1 warnings.
> > And moves to a more standard logging setup at the same time.
> []
> > diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> []
> > @@ -1015,9 +1007,9 @@ static const char *fbcon_startup(void)
> >  	rows /= vc->vc_font.height;
> >  	vc_resize(vc, cols, rows);
> >  
> > 
> > -	DPRINTK("mode:   %s\n", info->fix.id);
> > -	DPRINTK("visual: %d\n", info->fix.visual);
> > -	DPRINTK("res:    %dx%d-%d\n", info->var.xres,
> > +	pr_debug("mode:   %s\n", info->fix.id);
> > +	pr_debug("visual: %d\n", info->fix.visual);
> > +	pr_debug("res:    %dx%d-%d\n", info->var.xres,
> >  		info->var.yres,
> >  		info->var.bits_per_pixel);
> 
> It'd be nicer to reindent the subsequent lines too.
> 
> > @@ -3299,7 +3291,7 @@ static void fbcon_exit(void)
> >  
> > 
> >  		if (info->queue.func)
> >  			pending = cancel_work_sync(&info->queue);
> > -		DPRINTK("fbcon: %s pending work\n", (pending ? "canceled" :
> > +		pr_debug("fbcon: %s pending work\n", (pending ? "canceled" :
> >  			"no"));
> 
> perhaps:
> 
> 		pr_debug("fbcon: %s pending work\n", pending ? "canceled" : "no");
> 
Good suggestions, I will update accordingly in v2 or when applying in
case someone acks/r-b's the patches.

	Sam
