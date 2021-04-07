Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1011C433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BFB46136A
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346148AbhDGHIa (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:08:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56344 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233813AbhDGHI3 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 7 Apr 2021 03:08:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D664761139;
        Wed,  7 Apr 2021 07:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617779290;
        bh=NOnIAQXxZdATMpeyeL3MkgK4crH6oPRZFwvYMzaBbp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d//JSus7wZCfjTdulYxBIbwX0jSyh5hdO0vs0SVrXiGAwALiEjiXT9bNxLv3lbNle
         SYre9E3MkaTPZ1Vc2/OrrUcvImHA0olPCtq77syy0C+CFSIS4wXxGYz73ZcuAF7bDh
         lJ6+4QvQBDPILbtcvrqByoC18Mma1Xv3XtLDSQSI=
Date:   Wed, 7 Apr 2021 09:08:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <YG1aVx3UuXR2JrC+@kroah.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 11:35:54PM -0700, Pavle Rohalj wrote:
> Changes in v2:
>     - Removed type information from variable names
>     - Broken up the changes into smaller patches

Your subject is very odd :(
