Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC663C433FE
	for <linux-fbdev@archiver.kernel.org>; Sat,  5 Dec 2020 20:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81362246B
	for <linux-fbdev@archiver.kernel.org>; Sat,  5 Dec 2020 20:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgLEUTl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 5 Dec 2020 15:19:41 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:59220 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLEUTl (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 5 Dec 2020 15:19:41 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 624B3804CE;
        Sat,  5 Dec 2020 21:18:45 +0100 (CET)
Date:   Sat, 5 Dec 2020 21:18:43 +0100
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
Subject: Re: [PATCH v2 27/28] video: fbdev: cirrusfb: Fix kernel-doc and set
 but not used warnings
Message-ID: <20201205201843.GK332836@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-28-sam@ravnborg.org>
 <c8f1f756-15eb-cc50-caad-2a9391481884@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8f1f756-15eb-cc50-caad-2a9391481884@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
        a=QyXUC8HyAAAA:8 a=KKAkSRfTAAAA:8 a=ELFGstoh8s1JMG3t_vcA:9
        a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22 a=AjGcO6oz07-iQ99wixmX:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Thomas.

On Tue, Dec 01, 2020 at 03:21:59PM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 28.11.20 um 23:41 schrieb Sam Ravnborg:
> > Fix warnings:
> > - drop kernel-doc for the two debug functions to avoid the warnings
> > - delete unused code
> > 
> > v2:
> >    - Updated subject (Lee)
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Thomas Zimemrmann <tzimmermann@suse.de>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Saeed Mirzamohammadi <saeed.mirzamohammadi@oracle.com>
> > Cc: Jani Nikula <jani.nikula@intel.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/video/fbdev/cirrusfb.c | 20 +++++++++-----------
> >   1 file changed, 9 insertions(+), 11 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
> > index e9027172c0f5..93802abbbc72 100644
> > --- a/drivers/video/fbdev/cirrusfb.c
> > +++ b/drivers/video/fbdev/cirrusfb.c
> > @@ -2463,8 +2463,6 @@ static void AttrOn(const struct cirrusfb_info *cinfo)
> >    */
> >   static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
> >   {
> > -	unsigned char dummy;
> > -
> >   	if (is_laguna(cinfo))
> >   		return;
> >   	if (cinfo->btype == BT_PICASSO) {
> > @@ -2473,18 +2471,18 @@ static void WHDR(const struct cirrusfb_info *cinfo, unsigned char val)
> >   		WGen(cinfo, VGA_PEL_MSK, 0x00);
> >   		udelay(200);
> >   		/* next read dummy from pixel address (3c8) */
> > -		dummy = RGen(cinfo, VGA_PEL_IW);
> > +		RGen(cinfo, VGA_PEL_IW);
> 
> I hope these kinds of changes do not turn into an endless stream of warnings
> from static ananlysis. I git an email with that today about such a call.
Got the same mail, will type a patch for it.
> 
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>

This and the other acked patches are now applied to drm-misc-next.
Building for a few more architectures turned up new warnings, so I will
prepare a new set of patches with comments addressed.

	Sam
