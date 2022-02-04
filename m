Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F6FCC433EF
	for <linux-fbdev@archiver.kernel.org>; Sat,  5 Feb 2022 23:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381272AbiBEXL7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 5 Feb 2022 18:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381235AbiBEXL7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 5 Feb 2022 18:11:59 -0500
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DA8C061353
        for <linux-fbdev@vger.kernel.org>; Sat,  5 Feb 2022 15:11:57 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id 97c9b91f-85f4-11ec-b20b-0050568c148b;
        Fri, 04 Feb 2022 19:56:50 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id ED940194B91;
        Fri,  4 Feb 2022 20:55:49 +0100 (CET)
Date:   Fri, 4 Feb 2022 20:55:47 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org, Du Cheng <ducheng2@gmail.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Claudio Suarez <cssk@net-c.es>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH 17/21] fbcon: Move more code into fbcon_release
Message-ID: <Yf2Ew7CJb7xrWHAn@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-18-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-18-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 31, 2022 at 10:05:48PM +0100, Daniel Vetter wrote:
> con2fb_release_oldinfo() has a bunch more kfree() calls than
> fbcon_exit(), but since kfree() on NULL is harmless doing that in both
> places should be ok. This is also a bit more symmetric now again with
> fbcon_open also allocating the fbcon_ops structure.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Daniel Vetter <daniel@ffwll.ch>
> Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Du Cheng <ducheng2@gmail.com>
> Cc: Claudio Suarez <cssk@net-c.es>

Thanks, like I wrote earlier this makes sense.
Acked-by: Sam Ravnborg <sam@ravnborg.org>
