Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC45C433E6
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC11520799
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 14:14:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhA0OM6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 09:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233526AbhA0OIt (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 09:08:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 85FFB2100A;
        Wed, 27 Jan 2021 14:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611756489;
        bh=yqGnxCx5oZvyrJm+gp7Zb+WXFEubWq9jM3h88+rjhyg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iiDc6+xJvbdEqFiw0ZJd2eElatv9eP3dsYLHwWFb8xr2IUduGaRXSjNB53x91t2rz
         ZrXEyf4QE5UphvjfxbriUuiyARobfGjoKmk5G1/pPet2DJSi0GaXDgDV0u8G7v2ce5
         tyWgkMtFhXeO8t3RhTyj43UPZlzBg52JIu5jWWm8=
Date:   Wed, 27 Jan 2021 15:08:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v11] staging: fbtft: add tearing signal detect
Message-ID: <YBFzxucgqJCX8IBO@kroah.com>
References: <1611756149-165287-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611756149-165287-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jan 27, 2021 at 10:02:29PM +0800, Carlis wrote:
> From: zhangxuezhi <zhangxuezhi1@yulong.com>
> 
> For st7789v ic,when we need continuous full screen refresh, it is best to
> wait for the TE signal arrive to avoid screen tearing
> 
> Signed-off-by: zhangxuezhi <zhangxuezhi1@yulong.com>

Again, slow down, and wait for comments before responding so quickly, as
you missed all of my review...

greg k-h
