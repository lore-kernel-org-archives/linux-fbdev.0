Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A641C433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Feb 2022 20:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240537AbiBQUho (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Feb 2022 15:37:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239580AbiBQUho (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Feb 2022 15:37:44 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 394691029D1
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 12:37:28 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 77042c1d-9031-11ec-baa1-0050568c148b;
        Thu, 17 Feb 2022 20:37:46 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 5205B194B4A;
        Thu, 17 Feb 2022 21:37:28 +0100 (CET)
Date:   Thu, 17 Feb 2022 21:37:24 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/8] drm: Add support for low-color frame buffer formats
Message-ID: <Yg6yBOVTEqyPqRUc@ravnborg.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215165226.2738568-1-geert@linux-m68k.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Geert,

On Tue, Feb 15, 2022 at 05:52:18PM +0100, Geert Uytterhoeven wrote:
> 	Hi all,
> 
> A long outstanding issue with the DRM subsystem has been the lack of
> support for low-color displays, as used typically on older desktop
> systems and small embedded displays.

This is one of the pieces missing for a long time - great to see
something done here. Thanks Geert!

	Sam
