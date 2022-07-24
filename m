Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A526EC43334
	for <linux-fbdev@archiver.kernel.org>; Sun, 24 Jul 2022 09:40:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbiGXJka (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 24 Jul 2022 05:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233831AbiGXJk3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 24 Jul 2022 05:40:29 -0400
Received: from mailrelay1-1.pub.mailoutpod1-cph3.one.com (mailrelay1-1.pub.mailoutpod1-cph3.one.com [46.30.210.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B45B845
        for <linux-fbdev@vger.kernel.org>; Sun, 24 Jul 2022 02:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=aVS5uIC+mjDavci9rdhNl/UO0dQNLZJHDBatr8gkvyQ=;
        b=XYFrJ6eQ9qHYQFTETP6D7s5jTvRU1H+UsuWZO2R4/4NQST49fwxyoxMoI5A5dVnEHBe+FJlgC8VXb
         5Fdhx5i13jFu4zfGqv9CjmqNyEHguB8V8nIq6vnVQLrcZOr6EMRJQv7VN2VG9zLRZKxkihxvJfRiRO
         wzS9svJgvibw6HnLd3wasemm/ojW6lFkUX9tsQ9kAyn/zc1ekMbfoVGV215laXLBgJ8jRpIfgpWiFO
         vVQjJhIlx475ki7KbUiAaqFGNbuagcEivgxeEUe0DMzKWmPdzeAo1dagMRc7MsDaKDl0o90mpDa8ya
         3QO7+k3VRtDa0GYOm0OrBQUI/o2kEvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=aVS5uIC+mjDavci9rdhNl/UO0dQNLZJHDBatr8gkvyQ=;
        b=RyKALO8DhG6P2eEvPBtyr+Q8r66noN5Zph2oVHQyTMcFa4RHF7sGuAWBrfDjSSM89yjKgS2vi0NXS
         mtdInBbBw==
X-HalOne-Cookie: c2f428ac2057f2d00c557b432ba6528e15260b16
X-HalOne-ID: a3ec57f2-0b34-11ed-a6c8-d0431ea8a283
Received: from mailproxy1.cst.dirpod3-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay1.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id a3ec57f2-0b34-11ed-a6c8-d0431ea8a283;
        Sun, 24 Jul 2022 09:40:23 +0000 (UTC)
Date:   Sun, 24 Jul 2022 11:40:22 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-fbdev@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, Helge Deller <deller@gmx.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] video: fb: imxfb: Drop platform data support
Message-ID: <Yt0ThsMUi34pyuPL@ravnborg.org>
References: <20220723175720.76933-1-u.kleine-koenig@pengutronix.de>
 <YtxKv0ZUbg6V+a2w@ravnborg.org>
 <20220723220218.2jxejv55aix5sqra@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220723220218.2jxejv55aix5sqra@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Uwe,

On Sun, Jul 24, 2022 at 12:02:18AM +0200, Uwe Kleine-König wrote:
> Hi Sam,
> 
> On Sat, Jul 23, 2022 at 09:23:43PM +0200, Sam Ravnborg wrote:
> > On Sat, Jul 23, 2022 at 07:57:17PM +0200, Uwe Kleine-König wrote:
> > > No source file but the driver itself includes the header containing the
> > > platform data definition. The last user is gone since commit
> > > 8485adf17a15 ("ARM: imx: Remove imx device directory").
> > > 
> > > So we can safely drop platform data support.
> > > 
> > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > 
> > Do imxfb offer something that is not supported by the DRM drivers?
> > If yes then the clean-up is good, if not then we could drop the driver?
> 
> It's for different i.MX variants. imxfb is for i.MX2x while the DRM
> drivers in mainline are for i.MX6. (Not sure about the i.MX3 and i.MX5x
> variants.)
> 
> Somewhere in the middle of my todo list is to mainline an i.MX2x DRM
> driver that could replace the imxfb driver. If I only had a bit more
> time ...

There is drm/mxsfb, where Kconfig says:
"including i.MX23, i.MX28, i.MX6SX, i.MX7 and i.MX8M".

So there is already something but if this is a 1:1 replacement I dunno.

	Sam
