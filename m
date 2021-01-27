Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A334C433E0
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 17:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AF1364DA9
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Jan 2021 17:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344309AbhA0Ry0 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 27 Jan 2021 12:54:26 -0500
Received: from smtprelay0213.hostedemail.com ([216.40.44.213]:41604 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344272AbhA0RyO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 27 Jan 2021 12:54:14 -0500
X-Greylist: delayed 625 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2021 12:54:13 EST
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 6FAF71801A08E
        for <linux-fbdev@vger.kernel.org>; Wed, 27 Jan 2021 17:43:46 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5D03B181D3026;
        Wed, 27 Jan 2021 17:43:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: crowd66_500673e27598
X-Filterd-Recvd-Size: 2238
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Wed, 27 Jan 2021 17:42:57 +0000 (UTC)
Message-ID: <3f7b25d21c10a4dc7da5d507d6d6a6a5bc93447b.camel@perches.com>
Subject: Re: [PATCH v10] staging: fbtft: add tearing signal detect
From:   Joe Perches <joe@perches.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     carlis <zhangxuezhi3@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, devel@driverdev.osuosl.org,
        linux-fbdev@vger.kernel.org, mh12gx2825@gmail.com,
        oliver.graute@kococonnector.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, sbrivio@redhat.com,
        colin.king@canonical.com, zhangxuezhi1@yulong.com
Date:   Wed, 27 Jan 2021 09:42:56 -0800
In-Reply-To: <20210127144946.GF2696@kadam>
References: <1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com>
         <YBFv+12xfsoxacDb@kroah.com> <20210127220809.000026fb@gmail.com>
         <YBF08Xf7qaZx3YZ1@kroah.com> <20210127221708.00002568@gmail.com>
         <YBF30EEUkhEMY5ti@kroah.com> <20210127144946.GF2696@kadam>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 2021-01-27 at 17:49 +0300, Dan Carpenter wrote:
> On Wed, Jan 27, 2021 at 03:25:20PM +0100, Greg KH wrote:

> > Andy and Joe, there's something wrong here that is missing the fact that
> > a line is being indented with spaces and not tabs in the patch
> > at https://lore.kernel.org/r/1611754972-151016-1-git-send-email-zhangxuezhi3@gmail.com
> > 
> > Any ideas what broke?
> 
>     /*Tearing Effect Line On*/
> 
> Comments are the exception to the "no spaces at the start of a line"
> rule.  I was expecting that the kbuild-bot would send a Smatch warning
> for inconsistent indenting, but comments are not counted there either.
> 
> I'm sort of surprised that we don't have checkpatch rule about the
> missing space characters.  It should be: "/* Tearing Effect Line On */".

You could always write your own rule...

checkpatch doesn't care if a comment looks like

    /********************/
or
    /*foobarfoobarfoobar*/


