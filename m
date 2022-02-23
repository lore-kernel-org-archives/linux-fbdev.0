Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B535C433EF
	for <linux-fbdev@archiver.kernel.org>; Wed, 23 Feb 2022 20:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235991AbiBWU0S (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 23 Feb 2022 15:26:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbiBWU0R (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 23 Feb 2022 15:26:17 -0500
Received: from mx2.smtp.larsendata.com (mx2.smtp.larsendata.com [91.221.196.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E684D620
        for <linux-fbdev@vger.kernel.org>; Wed, 23 Feb 2022 12:25:49 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx2.smtp.larsendata.com (Halon) with ESMTPS
        id d5340349-94e6-11ec-b2df-0050568cd888;
        Wed, 23 Feb 2022 20:26:08 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id E7A57194B37;
        Wed, 23 Feb 2022 21:25:51 +0100 (CET)
Date:   Wed, 23 Feb 2022 21:25:45 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, kraxel@redhat.com, ppaalanen@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 4/5] fbdev: Improve performance of cfb_imageblit()
Message-ID: <YhaYSeyYIwqur2hy@ravnborg.org>
References: <20220223193804.18636-1-tzimmermann@suse.de>
 <20220223193804.18636-5-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223193804.18636-5-tzimmermann@suse.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Feb 23, 2022 at 08:38:03PM +0100, Thomas Zimmermann wrote:
> Improve the performance of cfb_imageblit() by manually unrolling
> the inner blitting loop and moving some invariants out. The compiler
> failed to do this automatically. This change keeps cfb_imageblit()
> in sync with sys_imagebit().
> 
> A microbenchmark measures the average number of CPU cycles
> for cfb_imageblit() after a stabilizing period of a few minutes
> (i7-4790, FullHD, simpledrm, kernel with debugging).
> 
> cfb_imageblit(), new: 15724 cycles
> cfb_imageblit(): old: 30566 cycles
> 
> In the optimized case, cfb_imageblit() is now ~2x faster than before.
> 
> v3:
> 	* fix commit description (Pekka)
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Sam Ravnborg <sam@ravnborg.org>

The code looks equally complicated now in the sys and cfb variants.

Question: What is cfb an abbreviation for anyway?
Not related to the patch - but if I have known the memory is lost..

	Sam
