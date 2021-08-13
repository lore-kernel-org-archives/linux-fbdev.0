Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D45FC4338F
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Aug 2021 15:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1934A610A4
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Aug 2021 15:00:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241072AbhHMPBB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:01:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241048AbhHMPBA (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 Aug 2021 11:01:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8564C61042;
        Fri, 13 Aug 2021 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1628866834;
        bh=I1FekdfmiRJknOkcQKVglzJj1Ot+dwBi5XK4Uv4qoLw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuY6lYyOpl7hDr0+1ihFss0W58HDyFd8HTcmfb6hCWldAsyNOZKLP6QDAubN5Ho30
         td0c9NzbhV791kLwVF6DHPULiHtRnJvQaECbafz7hKPIDiVcneNG5cn9fCumnYXiSs
         4gEgVbzkauaN+75E0Uq+qBMctxTS74Qaem0aZfoc=
Date:   Fri, 13 Aug 2021 17:00:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oliver Graute <oliver.graute@kococonnector.com>
Cc:     Carlis <zhangxuezhi1@yulong.com>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] fbtft: fb_st7789v: added reset on init_display()
Message-ID: <YRaJDyYquuklht6C@kroah.com>
References: <20210813062511.14537-1-oliver.graute@kococonnector.com>
 <YRYrPfEHrcvDL4va@kroah.com>
 <20210813125430.GA1527@optiplex>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813125430.GA1527@optiplex>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Aug 13, 2021 at 02:54:30PM +0200, Oliver Graute wrote:
> On 13/08/21, Greg KH wrote:
> > On Fri, Aug 13, 2021 at 08:25:10AM +0200, Oliver Graute wrote:
> > > staging: fbtft: fb_st7789v: reset display before initialization
> > 
> > What is this line here, and why is this not your subject line instead?
> 
> I'll put the line as subject instead.
> 
> > > In rare cases the display is flipped or mirrored. This was observed more
> > > often in a low temperature environment. A clean reset on init_display()
> > > should help to get registers in a sane state.
> > > 
> > > Signed-off-by: Oliver Graute <oliver.graute@kococonnector.com>
> > 
> > What commit does this fix?
> 
> this is a fix for a rare behavior of the fb_st7789v display. Not a
> bugfix for a specific commit.

So if it has always been broken, list the commit where the code was
added to the kernel, as this should be backported to the stable kernels,
right?

thanks,

greg k-h
