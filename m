Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8098BC433DB
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 13:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD98619FB
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 13:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCZNDt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 Mar 2021 09:03:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:60186 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhCZNDj (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 Mar 2021 09:03:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3178E619F3;
        Fri, 26 Mar 2021 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616763816;
        bh=7nZUvZiNR1Ilz4n3bwQkwZDwZoMX0OktOORjC+8pYQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tVKC55fT54U9/yvEY1S6+OO/8e9HKSpvGLRlC/OwkVBjqoDsYnfhkJWAa9k41A103
         bVctoqZFNiynpQ5prWaqlepSKOGmR02JpK5zzfDSglSfrCArP63vrfP6KjiNTI+W10
         ny2gWoz0Bl+iR0U/wNdorBH1X+UnVnlxzuAIxKfA=
Date:   Fri, 26 Mar 2021 14:03:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: fbtft: fix a typo
Message-ID: <YF3bpuh8RVg+3Nx3@kroah.com>
References: <1616763351-7433-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616763351-7433-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Mar 26, 2021 at 08:55:51PM +0800, Carlis wrote:
> From: Xuezhi Zhang <zhangxuezhi1@yulong.com>
> 
> Change 'tft' to 'TFT'

That says what you did, but not _why_ you did it.

And this is not a "typo", as it is not misspelled and really is just
fine as-is.

thanks,

greg k-h
