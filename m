Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B10FDC433B4
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Apr 2021 11:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61EF7613D0
	for <linux-fbdev@archiver.kernel.org>; Tue, 27 Apr 2021 11:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235097AbhD0LIU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 27 Apr 2021 07:08:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235592AbhD0LIT (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 27 Apr 2021 07:08:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 14609613BF;
        Tue, 27 Apr 2021 11:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1619521642;
        bh=BRo/eDbvQlGm4UOtynp97IJmtV6Q9jckxoge1aD3P8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh9JnGp093zCnvaYasdWoryRUgj3/L5MRDmtQuQg+BjWAOQ5OEKlzlzlPzObTz7JH
         VbDJ1wAQrKlzmrXhiU8SgoM45udYfooPBeyhxbiU1X+pP71xcuOFSxzRHtud+Rj1Yz
         hgjA3Lg0mDE/PVEvfTG0zXZmwOvFuEt3V2SijFM0=
Date:   Tue, 27 Apr 2021 13:07:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] fbtft: Replace custom ->reset() with generic one
Message-ID: <YIfwZ/oPVB9splQq@kroah.com>
References: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210416142044.17766-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Apr 16, 2021 at 05:20:41PM +0300, Andy Shevchenko wrote:
> The custom ->reset() repeats the generic one, replace it.
> 
> Note, in newer kernels the context of the function is a sleeping one,
> it's fine to switch over to the sleeping functions. Keeping the reset
> line asserted longer than 20 microseconds is also okay, it's an idling
> state of the hardware.
> 
> Fixes: b2ebd4be6fa1 ("staging: fbtft: add fb_agm1264k-fl driver")

What does this "fix"?  A bug or just a "it shouldn't have been done this
way"?

And as others pointed out, if you could put "staging: fbtft:" as a
prefix here, that would be much better.

thanks,

greg k-h
