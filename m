Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92345C43334
	for <linux-fbdev@archiver.kernel.org>; Sat, 23 Jul 2022 19:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233301AbiGWTXu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 23 Jul 2022 15:23:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGWTXt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 23 Jul 2022 15:23:49 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com (mailrelay2-1.pub.mailoutpod1-cph3.one.com [46.30.210.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C80B17050
        for <linux-fbdev@vger.kernel.org>; Sat, 23 Jul 2022 12:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=rsa1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=6IRy9wdgj5j6hNzobpx2Pi5xIAbuzYTiiIOB6SMg2b8=;
        b=PB/kbnKLmJ5nsq4YwYmZbmq/KA5h/2te9VzfBzNcCQCb4FgsSoSUGFK8KVaOJCvYUFh3iQ51dCJbV
         W/tAo8hNxv5mEdrfU9nVhfP3n8xA1suWl1qRexQmlBeC7yLBrSqBuYyCceLiDQ80IxM/Dxdq4M+CRg
         EN8xaN+1U014gwiFtwoZpMvQLkm/UQ/TOZBbKVTYCYd86fFV3HO2fhxKrEByZhXx8e7ox342q+KX06
         NAL86e8RPczRClZlW5Ag0UkW5/NcUxLuPR/j2oekk3aipmFU1ctLR2m7GGvuVAfGbq9Fm2cVvNp5PA
         6la1WNHfeBB67d21WUHnQxPfWwO6vYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
        d=ravnborg.org; s=ed1;
        h=in-reply-to:content-transfer-encoding:content-type:mime-version:references:
         message-id:subject:cc:to:from:date:from;
        bh=6IRy9wdgj5j6hNzobpx2Pi5xIAbuzYTiiIOB6SMg2b8=;
        b=sA4L8zl/aiL/F8OblMUue1kbHyS87aeQAjJJV26dwRGNJTwba6SRLn1MrUcxjZ3R2fWNoyU8T9OMl
         qiqARtiDw==
X-HalOne-Cookie: 61b0e4df886929e66f144dd5e876ff9ba5318de3
X-HalOne-ID: f7ab0055-0abc-11ed-a918-d0431ea8a290
Received: from mailproxy3.cst.dirpod4-cph3.one.com (2-105-2-98-cable.dk.customer.tdc.net [2.105.2.98])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id f7ab0055-0abc-11ed-a918-d0431ea8a290;
        Sat, 23 Jul 2022 19:23:44 +0000 (UTC)
Date:   Sat, 23 Jul 2022 21:23:43 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Helge Deller <deller@gmx.de>, Shawn Guo <shawnguo@kernel.org>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/4] video: fb: imxfb: Drop platform data support
Message-ID: <YtxKv0ZUbg6V+a2w@ravnborg.org>
References: <20220723175720.76933-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220723175720.76933-1-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Uwe,

On Sat, Jul 23, 2022 at 07:57:17PM +0200, Uwe Kleine-König wrote:
> No source file but the driver itself includes the header containing the
> platform data definition. The last user is gone since commit
> 8485adf17a15 ("ARM: imx: Remove imx device directory").
> 
> So we can safely drop platform data support.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Do imxfb offer something that is not supported by the DRM drivers?
If yes then the clean-up is good, if not then we could drop the driver?

	Sam
