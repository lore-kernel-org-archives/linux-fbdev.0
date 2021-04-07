Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF3CC433ED
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE86C6136A
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 07:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346660AbhDGHcp (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 03:32:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:32898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232598AbhDGHck (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 7 Apr 2021 03:32:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ADD0B6136A;
        Wed,  7 Apr 2021 07:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617780751;
        bh=JhHbXWg96et2FbLon6Fo7du212AuRnmOsWOSUA/bFJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eV98dBoe2wWOLSLWVdyE+Kpt9xIx6d2erqhu6mRzfRlHN6vg8/s/1OXQAMPmHPxpl
         F+yU672nRKCRJV9vXeM7RPpXt/etVEpnQclXf5kXNDAVp8JMr90zt5hE0nAag6Rbap
         ba/MSMPititFu+UlCGlHuH6NfBysFFoLiUudnkXM=
Date:   Wed, 7 Apr 2021 09:32:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/49] *** SUBJECT HERE ***
Message-ID: <YG1gDV6vqnUtDnbT@kroah.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <YG1aVx3UuXR2JrC+@kroah.com>
 <YG1cCtbvINJ52tGT@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YG1cCtbvINJ52tGT@localhost.localdomain>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Apr 07, 2021 at 12:15:22AM -0700, Pavle Rohalj wrote:
> On Wed, Apr 07, 2021 at 09:08:07AM +0200, Greg KH wrote:
> > On Tue, Apr 06, 2021 at 11:35:54PM -0700, Pavle Rohalj wrote:
> > > Changes in v2:
> > >     - Removed type information from variable names
> > >     - Broken up the changes into smaller patches
> > 
> > Your subject is very odd :(
> 
> Sorry about that, I overlooked the fact that I reran format-patch. The
> subject should be:
> 
> [PATCH] staging: sm750fb: Convert camel case to snake case
> 
> Should I resubmit?

Not yet, let me review these first, I think they might need some work...
