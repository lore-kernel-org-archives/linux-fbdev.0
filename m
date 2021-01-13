Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EC6C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 19:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73B19207B5
	for <linux-fbdev@archiver.kernel.org>; Wed, 13 Jan 2021 19:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728328AbhAMTCT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 13 Jan 2021 14:02:19 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:37096 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbhAMTCT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 13 Jan 2021 14:02:19 -0500
Received: from ravnborg.org (unknown [188.228.123.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 6981F804E7;
        Wed, 13 Jan 2021 20:01:20 +0100 (CET)
Date:   Wed, 13 Jan 2021 20:01:18 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Jakub Jelinek <jakub@redhat.com>, linux-fbdev@vger.kernel.org,
        Anthony Tong <atong@uiuc.edu>, Alex Kern <alex.kern@gmx.de>,
        dri-devel@lists.freedesktop.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Software Engineering <lg@denx.de>,
        Paul Mundt <lethal@chaoticdreams.org>,
        Frodo Looijaard <frodol@dds.nl>,
        "Thomas J. Moore" <dark@mama.indstate.edu>,
        "Mark D. Studebaker" <mdsxyz123@yahoo.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Thibaut VARENE <varenet@parisc-linux.org>,
        Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
        Evgeny Novikov <novikov@ispras.ru>,
        Helge Deller <deller@gmx.de>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Ani Joshi <ajoshi@unixbox.com>, daniel.mantione@freepascal.org,
        James Simmons <jsimmons@users.sf.net>,
        Emmanuel Marty <core@ggi-project.org>,
        carter@compsci.bristol.ac.uk, Alan Cox <alan@redhat.com>,
        Oliver Kropp <dok@directfb.org>,
        Jeff Garzik <jgarzik@pobox.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Eddie C. Dost" <ecd@skynet.be>,
        Ani Joshi <ajoshi@shell.unixbox.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        John Fremlin <vii@users.sourceforge.net>,
        Ilario Nardinocchi <nardinoc@cs.unibo.it>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Jakub Jelinek <jj@ultra.linux.cz>, Urs Ganse <ursg@uni.de>,
        William Rucklidge <wjr@cs.cornell.edu>,
        Antonino Daplas <adaplas@pol.net>,
        Brad Douglas <brad@neruo.com>,
        Ralph Metzler <rjkm@thp.uni-koeln.de>,
        Alex Dewar <alex.dewar90@gmail.com>,
        Jim Hague <jim.hague@acm.org>,
        Egbert Eich <Egbert.Eich@physik.tu-darmstadt.de>,
        Jes Sorensen <jds@kom.auc.dk>,
        Gerd Knorr <kraxel@goldbach.in-berlin.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        linux-kernel@vger.kernel.org, Martin Mares <mj@ucw.cz>,
        Philip Edelbrock <phil@netroedge.com>,
        Ben Dooks <ben@simtec.co.uk>, Hannu Mallat <hmallat@cc.hut.fi>,
        Kristoffer Ericson <kristoffer.ericson@gmail.com>,
        Ghozlane Toumi <gtoumi@laposte.net>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH 00/31] Rid W=1 warnings from Video
Message-ID: <20210113190118.GA180942@ravnborg.org>
References: <20210113145009.1272040-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210113145009.1272040-1-lee.jones@linaro.org>
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=Itgwjo3g c=1 sm=1 tr=0
        a=S6zTFyMACwkrwXSdXUNehg==:117 a=S6zTFyMACwkrwXSdXUNehg==:17
        a=kj9zAlcOel0A:10 a=agyv3xnNEhhBd4aT2ugA:9 a=CjuIK1q_8ugA:10
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Lee,

On Wed, Jan 13, 2021 at 02:49:38PM +0000, Lee Jones wrote:
> This set is part of a larger effort attempting to clean-up W=1
> kernel builds, which are currently overwhelmingly riddled with
> niggly little warnings.
> 
> This patch-set clears all of the W=1 warnings currently residing
> in drivers/video.

I am sorry to say that I expect most of your nice patches to clash
with patches that is already present in drm-misc-next.

drivers/video/ are warning free with W=1 in drm-misc-next today.

I do not know why drm-misc-next is not yet pullled into linux-next.

	Sam
