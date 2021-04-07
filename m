Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7512C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAB96139E
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:32:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbhDGIdF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:33:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:55270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244921AbhDGIdE (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 7 Apr 2021 04:33:04 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CEB861246;
        Wed,  7 Apr 2021 08:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617784375;
        bh=YnQM4Dntg6MnBX1n5CpMjAINjqZ8OgHrYo45v3FHX10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tn7dNqH1vKL0Rig5ICBourpNf7ZvbdSNFRcVB1q1W68R1RmEmXGlztoXbllHKBc8u
         WfL73vHS08P3vkRBpIQyJjMO8yugTS7+q5UcRPxrcIz3L6UzZBMHJCE8rc28QAexUw
         IUVy6sXR+AcsTyLAWYRpAwCIQqmZH1kfEtRKRKz4=
Date:   Wed, 7 Apr 2021 10:32:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <YG1uNX1ZaZ106iy8@kroah.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <YG1aVx3UuXR2JrC+@kroah.com>
 <YG1cCtbvINJ52tGT@localhost.localdomain>
 <YG1gDV6vqnUtDnbT@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1gDV6vqnUtDnbT@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 07, 2021 at 09:32:29AM +0200, Greg KH wrote:
> On Wed, Apr 07, 2021 at 12:15:22AM -0700, Pavle Rohalj wrote:
> > On Wed, Apr 07, 2021 at 09:08:07AM +0200, Greg KH wrote:
> > > On Tue, Apr 06, 2021 at 11:35:54PM -0700, Pavle Rohalj wrote:
> > > > Changes in v2:
> > > >     - Removed type information from variable names
> > > >     - Broken up the changes into smaller patches
> > > 
> > > Your subject is very odd :(
> > 
> > Sorry about that, I overlooked the fact that I reran format-patch. The
> > subject should be:
> > 
> > [PATCH] staging: sm750fb: Convert camel case to snake case
> > 
> > Should I resubmit?
> 
> Not yet, let me review these first, I think they might need some work...
> 

Ok, now you can fix them up, I stopped after reviewing patch 02/49,
these need some work.

thanks,

greg k-h
