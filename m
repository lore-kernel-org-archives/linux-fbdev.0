Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 523CAC43600
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Apr 2021 09:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FB5C613E2
	for <linux-fbdev@archiver.kernel.org>; Tue,  6 Apr 2021 09:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbhDFJhK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 6 Apr 2021 05:37:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:55060 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244899AbhDFJg4 (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 6 Apr 2021 05:36:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9FFD0613C9;
        Tue,  6 Apr 2021 09:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617701805;
        bh=J009fz95W1yp7dSEEvcQHAB/rNi9vWwOuHc1FlLXl0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oKQBQARblV68vQSDK3VKfeoxmvxv7g81RjXpQ8RzCHbVVtiEfZvwE+AMvGNbCLaPA
         /NussvoRNsbHm53jXgIfSjGxUKGXv6jlUVZSBKf8qb6qRHx/fCexFNLvtBwio1lWZV
         GVTzlP4Eg3YgQUcqFl/X1mTT49Xe86VKu7oi3qCw=
Date:   Tue, 6 Apr 2021 11:36:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Convert camel case to snake case
Message-ID: <YGwrqUkAUWzccKA2@kroah.com>
References: <YGwncT6RGvYlL9yj@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGwncT6RGvYlL9yj@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 02:18:41AM -0700, Pavle Rohalj wrote:
> -	struct dvi_ctrl_device *pCurrentDviCtrl;
> +	struct dvi_ctrl_device *p_current_dvi_ctrl;

Does this change make sense?  Why keep the "p_" here?  We do not need or
use, this type of variable naming in the kernel.

Also, please break this up into a patch series where you do one
structure change at a time.

thanks,

greg k-h
