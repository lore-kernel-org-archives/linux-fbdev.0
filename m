Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6FE0C4361B
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Dec 2020 09:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E39B207CC
	for <linux-fbdev@archiver.kernel.org>; Tue, 15 Dec 2020 09:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgLOJ4V (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 15 Dec 2020 04:56:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgLOJ4L (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 15 Dec 2020 04:56:11 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DB2C0617A6
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Dec 2020 01:55:23 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id m5so19182414wrx.9
        for <linux-fbdev@vger.kernel.org>; Tue, 15 Dec 2020 01:55:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=wzp3he7Ldny5qGk+iBqbQJSYyDnKTWBE9sD2zWexFDQ=;
        b=i64SMDpxEEYAZao4CPsxjLKjN7RssgNCUSuu5waKnYgHLhBnbHShnKX/Q9LEcxS8kV
         bhBcbYio180Tsw5l8YAkUTXDY+U/xBsXx/aMBla6MCkY+t+xdXTdWHbG12BGVFNxLYOh
         zUhH1B036Nouv10Kn5vkzZK9bbO5//MM/9ZDY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=wzp3he7Ldny5qGk+iBqbQJSYyDnKTWBE9sD2zWexFDQ=;
        b=iABGzHgLPT/dAQj7eEJZu303xS/PC0+q2p5r7NTTS6ueDZOeU3aaH0ACgU/jgcGOkD
         rHSVuG54FI22XyV243AtRH3bgZEDcAAW7vVsXL03V7IsUcGrvrv1a32orH9p7uGJ/Rld
         ILxgHiIo8u7F+x+ATQw50adbxN/SK8IoYqQQQ/VRYszwEqj2RLOezD50KSGh+EpcX4Y4
         apMDRSW+B0Wx1uVVdTLRbNLOHocnTjrAnwOpSmPYEHmj6fG1F/HD3hSZU4XPIU2Wvh1S
         vaK/cgIkHnLrF1CCgx03J6fzVFMY1ff/9NBmAq1Nu4pNDohWmofEQYfTrOWnfxq68juA
         R1Iw==
X-Gm-Message-State: AOAM533TTqEIpiaqQMa9V9VQmo3irNE3FspumoJTvD6TUqHc+triHxu2
        j/IcuFCHZKqCgAFn1t/gbhsY2w==
X-Google-Smtp-Source: ABdhPJz6KDBEAbW3w8wUgDzwxnuw5x1wOy9//Vfnp/AzdlTA/tnX2btyV0/7hxnvpTcmHuPMK7/TTg==
X-Received: by 2002:a5d:5604:: with SMTP id l4mr32732419wrv.127.1608026122572;
        Tue, 15 Dec 2020 01:55:22 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o13sm34024033wmc.44.2020.12.15.01.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 01:55:21 -0800 (PST)
Date:   Tue, 15 Dec 2020 10:55:20 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     qiang.zhang@windriver.com
Cc:     b.zolnierkie@samsung.com, linux-fbdev@vger.kernel.org,
        mpatocka@redhat.com, bernie@plugable.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] udlfb: Fix memory leak in dlfb_usb_probe
Message-ID: <X9iICN/VX0whV8Es@phenom.ffwll.local>
Mail-Followup-To: qiang.zhang@windriver.com, b.zolnierkie@samsung.com,
        linux-fbdev@vger.kernel.org, mpatocka@redhat.com,
        bernie@plugable.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20201215063022.16746-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201215063022.16746-1-qiang.zhang@windriver.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Dec 15, 2020 at 02:30:22PM +0800, qiang.zhang@windriver.com wrote:
> From: Zqiang <qiang.zhang@windriver.com>
> 
> The dlfb_alloc_urb_list function is called in dlfb_usb_probe function,
> after that if an error occurs, the dlfb_free_urb_list function need to
> be called.
> 
> BUG: memory leak
> unreferenced object 0xffff88810adde100 (size 32):
>   comm "kworker/1:0", pid 17, jiffies 4294947788 (age 19.520s)
>   hex dump (first 32 bytes):
>     10 30 c3 0d 81 88 ff ff c0 fa 63 12 81 88 ff ff  .0........c.....
>     00 30 c3 0d 81 88 ff ff 80 d1 3a 08 81 88 ff ff  .0........:.....
>   backtrace:
>     [<0000000019512953>] kmalloc include/linux/slab.h:552 [inline]
>     [<0000000019512953>] kzalloc include/linux/slab.h:664 [inline]
>     [<0000000019512953>] dlfb_alloc_urb_list drivers/video/fbdev/udlfb.c:1892 [inline]
>     [<0000000019512953>] dlfb_usb_probe.cold+0x289/0x988 drivers/video/fbdev/udlfb.c:1704
>     [<0000000072160152>] usb_probe_interface+0x177/0x370 drivers/usb/core/driver.c:396
>     [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
>     [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
>     [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
>     [<00000000de0a5a5c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
>     [<00000000463fbcb4>] __device_attach+0x122/0x250 drivers/base/dd.c:912
>     [<00000000b881a711>] bus_probe_device+0xc6/0xe0 drivers/base/bus.c:491
>     [<00000000364bbda5>] device_add+0x5ac/0xc30 drivers/base/core.c:2936
>     [<00000000eecca418>] usb_set_configuration+0x9de/0xb90 drivers/usb/core/message.c:2159
>     [<00000000edfeca2d>] usb_generic_driver_probe+0x8c/0xc0 drivers/usb/core/generic.c:238
>     [<000000001830872b>] usb_probe_device+0x5c/0x140 drivers/usb/core/driver.c:293
>     [<00000000a8d6726f>] really_probe+0x159/0x480 drivers/base/dd.c:554
>     [<00000000c3ce4b0e>] driver_probe_device+0x84/0x100 drivers/base/dd.c:738
>     [<00000000e942e01c>] __device_attach_driver+0xee/0x110 drivers/base/dd.c:844
>     [<00000000de0a5a5c>] bus_for_each_drv+0xb7/0x100 drivers/base/bus.c:431
> 
> Reported-by: syzbot+c9e365d7f450e8aa615d@syzkaller.appspotmail.com
> Signed-off-by: Zqiang <qiang.zhang@windriver.com>

Queued up in drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/video/fbdev/udlfb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
> index f9b3c1cb9530..b9cdd02c1000 100644
> --- a/drivers/video/fbdev/udlfb.c
> +++ b/drivers/video/fbdev/udlfb.c
> @@ -1017,6 +1017,7 @@ static void dlfb_ops_destroy(struct fb_info *info)
>  	}
>  	vfree(dlfb->backing_buffer);
>  	kfree(dlfb->edid);
> +	dlfb_free_urb_list(dlfb);
>  	usb_put_dev(dlfb->udev);
>  	kfree(dlfb);
>  
> -- 
> 2.17.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
