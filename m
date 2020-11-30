Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8379DC63777
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 18:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DDA20705
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Nov 2020 18:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgK3Srk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Nov 2020 13:47:40 -0500
Received: from asavdk3.altibox.net ([109.247.116.14]:38086 "EHLO
        asavdk3.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgK3Srk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Nov 2020 13:47:40 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk3.altibox.net (Postfix) with ESMTPS id BC0D72002C;
        Mon, 30 Nov 2020 19:46:49 +0100 (CET)
Date:   Mon, 30 Nov 2020 19:46:48 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Lee Jones <lee.jones@linaro.org>,
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
Subject: Re: [PATCH v2 21/28] video: fbdev: tmiofb: Fix set but not used
 warnings
Message-ID: <20201130184648.GA1502362@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-22-sam@ravnborg.org>
 <e2300be8-525f-f289-5e78-d4fd488c90d4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2300be8-525f-f289-5e78-d4fd488c90d4@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Ibmpp1ia c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=8nJEP1OIZ-IA:10 a=7gkXJVJtAAAA:8 a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8
        a=kG_Li1YSC5bgHzEcAboA:9 a=wPNLvfGTeEIA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas,

On Mon, Nov 30, 2020 at 03:36:44PM +0100, Thomas Zimmermann wrote:
> 
> 
> Am 28.11.20 um 23:41 schrieb Sam Ravnborg:
> > Fix W=1 warnings by avoiding local variables and use direct references.
> 
> What's the bug here?

sh define iounmap like this:
#define iounmap(addr)		do { } while (0)

So par is not used resulting in a warning.

My patch just papers over the real issue.
The right fix is to fix sh so we reference addr.
Will give that a shot.

	Sam

> 
> > 
> > v2:
> >    - Updated subject (Lee)
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/video/fbdev/tmiofb.c | 6 ++----
> >   1 file changed, 2 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
> > index 50111966c981..b70faa3850f2 100644
> > --- a/drivers/video/fbdev/tmiofb.c
> > +++ b/drivers/video/fbdev/tmiofb.c
> > @@ -802,10 +802,8 @@ static int tmiofb_remove(struct platform_device *dev)
> >   	const struct mfd_cell *cell = mfd_get_cell(dev);
> >   	struct fb_info *info = platform_get_drvdata(dev);
> >   	int irq = platform_get_irq(dev, 0);
> > -	struct tmiofb_par *par;
> >   	if (info) {
> > -		par = info->par;
> >   		unregister_framebuffer(info);
> >   		tmiofb_hw_stop(dev);
> > @@ -816,8 +814,8 @@ static int tmiofb_remove(struct platform_device *dev)
> >   		free_irq(irq, info);
> >   		iounmap(info->screen_base);
> > -		iounmap(par->lcr);
> > -		iounmap(par->ccr);
> > +		iounmap(((struct tmiofb_par *)info->par)->lcr);
> > +		iounmap(((struct tmiofb_par *)info->par)->ccr);
> >   		framebuffer_release(info);
> >   	}
> > 
> 
> -- 
> Thomas Zimmermann
> Graphics Driver Developer
> SUSE Software Solutions Germany GmbH
> Maxfeldstr. 5, 90409 Nürnberg, Germany
> (HRB 36809, AG Nürnberg)
> Geschäftsführer: Felix Imendörffer
> 



