Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F1EC18E57
	for <linux-fbdev@archiver.kernel.org>; Sat,  5 Dec 2020 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E75023125
	for <linux-fbdev@archiver.kernel.org>; Sat,  5 Dec 2020 20:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgLEU7p (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 5 Dec 2020 15:59:45 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:33232 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgLEU7p (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 5 Dec 2020 15:59:45 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 27823804D5;
        Sat,  5 Dec 2020 21:58:55 +0100 (CET)
Date:   Sat, 5 Dec 2020 21:58:53 +0100
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
Subject: Re: [PATCH v2 23/28] video: fbdev: omapfb: Fix set but not used
 warnings in hdmi*_core
Message-ID: <20201205205853.GA1045000@ravnborg.org>
References: <20201128224114.1033617-1-sam@ravnborg.org>
 <20201128224114.1033617-24-sam@ravnborg.org>
 <e6664921-cc89-6814-8d63-33f43df63ed4@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6664921-cc89-6814-8d63-33f43df63ed4@suse.de>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=7gkXJVJtAAAA:8 a=i0EeH86SAAAA:8 a=KKAkSRfTAAAA:8
        a=_u4_8sTnNstuJUXPl18A:9 a=CjuIK1q_8ugA:10 a=E9Po1WZjFZOl8hwRPBS3:22
        a=cvBusfyB2V15izCimMoJ:22
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Dec 01, 2020 at 11:06:15AM +0100, Thomas Zimmermann wrote:
> Hi
> 
> Am 28.11.20 um 23:41 schrieb Sam Ravnborg:
> > Fix a few W=1 warnings about unused assignments.
> > Drop the unused error code.
> > 
> > v2:
> >    - Subject updated (Lee)
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Sam Ravnborg <sam@ravnborg.org>
> > Cc: Qilong Zhang <zhangqilong3@huawei.com>
> > Cc: "Alexander A. Klimov" <grandmaster@al2klimov.de>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Lee Jones <lee.jones@linaro.org>
> > ---
> >   drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c | 4 ++--
> >   drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c | 4 ++--
> >   2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
> > index 726c190862d4..e6363a420933 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
> > @@ -679,7 +679,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
> >   	struct hdmi_audio_format audio_format;
> >   	struct hdmi_audio_dma audio_dma;
> >   	struct hdmi_core_audio_config acore;
> > -	int err, n, cts, channel_count;
> > +	int n, cts, channel_count;
> >   	unsigned int fs_nr;
> >   	bool word_length_16b = false;
> > @@ -741,7 +741,7 @@ int hdmi4_audio_config(struct hdmi_core_data *core, struct hdmi_wp_data *wp,
> >   		return -EINVAL;
> >   	}
> > -	err = hdmi_compute_acr(pclk, fs_nr, &n, &cts);
> > +	hdmi_compute_acr(pclk, fs_nr, &n, &cts);
> 
> I'd rather return the error reported by hdmi_compute_acr()

The DRM version of the same driver does not bother, so I think we should
avoid it here too.

The better fix would be to sunset the omapfb driver - dunno how far we
are from that. There is still a lot of patch chrunch on the omapdrm
driver.

	Sam
