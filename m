Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB24C433B4
	for <linux-fbdev@archiver.kernel.org>; Fri,  2 Apr 2021 15:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E28661057
	for <linux-fbdev@archiver.kernel.org>; Fri,  2 Apr 2021 15:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbhDBPh2 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 2 Apr 2021 11:37:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPh1 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 2 Apr 2021 11:37:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2F7DC61057;
        Fri,  2 Apr 2021 15:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617377846;
        bh=ioyAbsNNoGGXzGD1/C5Xleu3NV1KP8ccBCEkZhjdmsM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UkgsOfG2RhojvrNREIt+ny4CmVkZ60qQovPx1i42hvMZsTYtJHpufv9bVEL9KjskX
         oDOEU4K1q3ilfG9DXHWwRUiJXQCDltpvmgeiXJUqBVOhZEfChN0ZW6898cNZc0VuaR
         BEevPTWBaTjWDCf3gV1bLL3HR0Kjmf+BJDi1GCKs=
Date:   Fri, 2 Apr 2021 17:37:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     mchehab+huawei@kernel.org, daniel.vetter@ffwll.ch,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zero-fill colormap in drivers/video/fbdev/core/fbcmap.c
Message-ID: <YGc6M4jao4ZbCqzJ@kroah.com>
References: <20210331220719.1499743-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210331220719.1499743-1-phil@philpotter.co.uk>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Mar 31, 2021 at 11:07:19PM +0100, Phillip Potter wrote:
> Use kzalloc() rather than kmalloc() for the dynamically allocated parts
> of the colormap in fb_alloc_cmap_gfp, to prevent a leak of random kernel
> data to userspace under certain circumstances.
> 
> Fixes a KMSAN-found infoleak bug reported by syzbot at:
> https://syzkaller.appspot.com/bug?id=741578659feabd108ad9e06696f0c1f2e69c4b6e
> 
> Reported-by: syzbot+47fa9c9c648b765305b9@syzkaller.appspotmail.com
> Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
> ---
>  drivers/video/fbdev/core/fbcmap.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Daniel, want me to take this?

thanks,

greg k-h
