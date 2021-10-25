Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289FBC433EF
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Oct 2021 19:07:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F53D600D3
	for <linux-fbdev@archiver.kernel.org>; Mon, 25 Oct 2021 19:07:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbhJYTJz (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 25 Oct 2021 15:09:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230201AbhJYTJw (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 25 Oct 2021 15:09:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C645C60E08;
        Mon, 25 Oct 2021 19:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1635188849;
        bh=QkD0aIubb77MfLaXkA4RVCyqVSSVXP4CNLjP63IkeVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DnQBmEObnLjI/kHoynHgptbLC0L02jt4LCdyS243gJXYt4vnvNZH6UY6PEbgoGTVG
         5KdBh4stQvZ3HONTL7xdIip44r91p1GA6+gDA1AYLFmGXeeRmAWIckxf8z8xuw2JSi
         uJO2d46gy/OVFAn9XCzstEo1zMAssIl4zYYHXs58=
Date:   Mon, 25 Oct 2021 21:07:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     George Kennedy <george.kennedy@oracle.com>
Cc:     tzimmermann@suse.de, sam@ravnborg.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] video: fbdev: cirrusfb: check pixclock to avoid divide
 by zero
Message-ID: <YXcAbXJfg/jKCo5h@kroah.com>
References: <1635188490-15082-1-git-send-email-george.kennedy@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1635188490-15082-1-git-send-email-george.kennedy@oracle.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Oct 25, 2021 at 02:01:30PM -0500, George Kennedy wrote:
> Do a sanity check on pixclock value before using it as a divisor.
> 
> Syzkaller reported a divide error in cirrusfb_check_pixclock.
> 
> divide error: 0000 [#1] SMP KASAN PTI
> CPU: 0 PID: 14938 Comm: cirrusfb_test Not tainted 5.15.0-rc6 #1
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-2
> RIP: 0010:cirrusfb_check_var+0x6f1/0x1260
> 
> Call Trace:
>  fb_set_var+0x398/0xf90
>  do_fb_ioctl+0x4b8/0x6f0
>  fb_ioctl+0xeb/0x130
>  __x64_sys_ioctl+0x19d/0x220
>  do_syscall_64+0x3a/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Signed-off-by: George Kennedy <george.kennedy@oracle.com>
> ---
>  drivers/video/fbdev/cirrusfb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/video/fbdev/cirrusfb.c b/drivers/video/fbdev/cirrusfb.c
> index 93802ab..099ddcb 100644
> --- a/drivers/video/fbdev/cirrusfb.c
> +++ b/drivers/video/fbdev/cirrusfb.c
> @@ -477,6 +477,9 @@ static int cirrusfb_check_pixclock(const struct fb_var_screeninfo *var,
>  	struct cirrusfb_info *cinfo = info->par;
>  	unsigned maxclockidx = var->bits_per_pixel >> 3;
>  
> +	if (!var->pixclock)
> +		return -EINVAL;

Shouldn't you be checking further up the call chain where this got set
to 0?

What logic allows this to be a valid value?  What about all other fb
drivers?

thanks,

greg k-h
