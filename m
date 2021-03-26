Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15F2C433C1
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 08:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54A061A44
	for <linux-fbdev@archiver.kernel.org>; Fri, 26 Mar 2021 08:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbhCZIh5 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 26 Mar 2021 04:37:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:50322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229573AbhCZIhv (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 26 Mar 2021 04:37:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47D6861A44;
        Fri, 26 Mar 2021 08:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616747870;
        bh=HGsGnoth2ZOZS+sjsAFalgHFAKd065RGy6pi92g7wx0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BJ8z8x6vuSW6qeM5GEtRUqkwRr9Zc4YHEx1EzbEMy9KlkAep15GklBnnZlMMqEOlI
         i+4EMw6EyHbAok6ri9e+irAT1PXuX4PwPNDFryc97mEKcvmc2Ur1yK138ZwE49889E
         ZhQiMMpRtlbJlvAe38UUpknc/Ofh1MQ0zwiDtepY=
Date:   Fri, 26 Mar 2021 09:37:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     zhangxuezhi1@yulong.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: fix a typo
Message-ID: <YF2dXIxMOUyLzfnQ@kroah.com>
References: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616745915-194644-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Mar 26, 2021 at 04:05:15PM +0800, Carlis wrote:
> From: "Carlis" <zhangxuezhi1@yulong.com>
> 
> Change 'tft' to 'TFT'

Why?  What is wrong with "tft"?

> 
> Signed-off-by: Carlis <zhangxuezhi1@yulong.com>

Full name please.

thanks,

greg k-h
