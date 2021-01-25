Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACB2C433E0
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jan 2021 09:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC9E21D79
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Jan 2021 09:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbhAYJUT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Jan 2021 04:20:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:38700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbhAYJSu (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Jan 2021 04:18:50 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4681322CF6;
        Mon, 25 Jan 2021 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1611564608;
        bh=8R/dDVa/hq2LeuM0260+HWRNutMZSEiafO+90owIq/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=weq9SpnMXwrA+VZ/5vfxP964jkqA/Gr0znk6NIJpNLgAuFvTjS4znC/8won2G8FOx
         SLkHzz0TE/S4vl8IQoW6w6zYfWSmaRnIaKRjrl6sxA3JCuCKKwn5p+O1idzX2md5ut
         VP+DKWLss7qo78tBQSRGDyDKD2btuAgbDsJ8Mu4E=
Date:   Mon, 25 Jan 2021 09:50:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Carlis <zhangxuezhi3@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-fbdev@vger.kernel.org,
        mh12gx2825@gmail.com, oliver.graute@kococonnector.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        sbrivio@redhat.com, colin.king@canonical.com,
        zhangxuezhi1@yulong.com
Subject: Re: [PATCH v2] fbtft: add tearing signal detect
Message-ID: <YA6GPqYbhFzfySDc@kroah.com>
References: <1611564252-84205-1-git-send-email-zhangxuezhi3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611564252-84205-1-git-send-email-zhangxuezhi3@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Jan 25, 2021 at 04:44:12PM +0800, Carlis wrote:
> From: "carlis.zhang_cp" <zhangxuezhi1@yulong.com>

I need a "real" name here, and in the signed-off-by: area as I do not
think you sign documents with a "." and "_", right?

thanks,

greg k-h
