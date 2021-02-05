Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87393C433DB
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Feb 2021 09:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45F9260230
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Feb 2021 09:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhBEJfF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 5 Feb 2021 04:35:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:37662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhBEJc5 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 5 Feb 2021 04:32:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5013864F4A;
        Fri,  5 Feb 2021 09:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1612517527;
        bh=jgQzZhuJanUyFvcQr/pf0vZbG+herQxEJyaMFM6t8H8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YoOAO7Nhlr9nQ6q72H/0ZYP45xoHs91spyqIrqoJx6yr8RMyyZkym3Sy8guJI5k2D
         aU30TY9u/yc5Gmn9LJBIq4ygboX1AWUiL4CvTeSjYCz9HSbJj7sONQa30xbVEjqPHS
         chcauDLHwRzWhIeICuBFxV+Zjn6J0Rv39D0rwShg=
Date:   Fri, 5 Feb 2021 10:32:04 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Mayank Suman <mayanksuman@live.com>
Cc:     sfr@canb.auug.org.au, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] staging: fbtft replaced udelay with usleep_range
Message-ID: <YB0QlMk4Gae1IGjd@kroah.com>
References: <PS1PR04MB29341C7117657B1F312444FBD6B29@PS1PR04MB2934.apcprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PS1PR04MB29341C7117657B1F312444FBD6B29@PS1PR04MB2934.apcprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Feb 05, 2021 at 02:41:13PM +0530, Mayank Suman wrote:
> According to Documentation/timers/timers-howto.rst, usleep_range is
> preffered over udelay for >=10us delay.
> 
> Signed-off-by: Mayank Suman <mayanksuman@live.com>

ALWAYS test build your patches before sending them out to the world for
review.  You don't want to make maintainers grumpy by breaking the tree
with changes that can not compile, right?  :)

thanks,

greg k-h
