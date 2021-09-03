Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7026C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  3 Sep 2021 13:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1D3D61059
	for <linux-fbdev@archiver.kernel.org>; Fri,  3 Sep 2021 13:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347375AbhICN4p (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 3 Sep 2021 09:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:57352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235766AbhICN4p (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 3 Sep 2021 09:56:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BFA2460E77;
        Fri,  3 Sep 2021 13:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1630677345;
        bh=TIbAWhTZGeVzB0CS+6tdg41yfnyaP30d8USQVO4qjVg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wMZ2jbXBjk8UtWa32Me7qCGlPU2DPxDL+hN8pL+IOeAfrGSJvARtZ3NLQtfgAFufG
         ksoyincXUqW4wAkUe6P3tECH2ckwHS3WdzcB9K9vJPApOKB1HDMGFFtlSBEFWxBNbe
         8G15ASSQuqxJuC6B7zEIzGhabX/8ClUrnSewou6I=
Date:   Fri, 3 Sep 2021 15:55:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     stable@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        George Kennedy <george.kennedy@oracle.com>,
        syzbot+e5fd3e65515b48c02a30@syzkaller.appspotmail.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4.19] fbmem: add margin check to fb_check_caps()
Message-ID: <YTIpXrJmJTasAGJU@kroah.com>
References: <20210902061048.1703559-1-mudongliangabcd@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210902061048.1703559-1-mudongliangabcd@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Sep 02, 2021 at 02:10:48PM +0800, Dongliang Mu wrote:
> [ Upstream commit a49145acfb975d921464b84fe00279f99827d816 ]
> 
> A fb_ioctl() FBIOPUT_VSCREENINFO call with invalid xres setting
> or yres setting in struct fb_var_screeninfo will result in a
> KASAN: vmalloc-out-of-bounds failure in bitfill_aligned() as
> the margins are being cleared. The margins are cleared in
> chunks and if the xres setting or yres setting is a value of
> zero upto the chunk size, the failure will occur.
> 
> Add a margin check to validate xres and yres settings.
> 
> Note that, this patch needs special handling to backport it to linux
> kernel 4.19, 4.14, 4.9, 4.4.

Looks like this is already in the 4.4.283, 4.9.282, 4.14.246, and
4.19.206 kernel releases.  Can you check them to verify that it matches
your backport as well?

thanks,

greg k-h
