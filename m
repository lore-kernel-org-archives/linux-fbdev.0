Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04915C433F5
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 00:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D52FE60F90
	for <linux-fbdev@archiver.kernel.org>; Wed, 27 Oct 2021 00:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236205AbhJ0A6J (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 26 Oct 2021 20:58:09 -0400
Received: from x127130.tudelft.net ([131.180.127.130]:47124 "EHLO
        djo.tudelft.nl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232410AbhJ0A6J (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 26 Oct 2021 20:58:09 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 26 Oct 2021 20:58:08 EDT
Received: by djo.tudelft.nl (Postfix, from userid 2001)
        id CC9461C42C4; Wed, 27 Oct 2021 02:51:10 +0200 (CEST)
Date:   Wed, 27 Oct 2021 02:51:10 +0200
From:   wim <wim@djo.tudelft.nl>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Pavel V. Panteleev" <panteleev_p@mcst.ru>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, wim <wim@djo.tudelft.nl>
Subject: Re: [PATCH] vgacon: Propagate console boot parameters before calling
 `vc_resize'
Message-ID: <20211027005110.GA26354@djo.tudelft.nl>
Reply-To: wim@djo.tudelft.nl
References: <alpine.DEB.2.21.2110252317110.58149@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2110252317110.58149@angie.orcam.me.uk>
User-Agent: Mutt/1.11.2 (2019-01-07)
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 26, 2021 at 12:26:22AM +0200, Maciej W. Rozycki wrote:
> Fix a division by zero in `vgacon_resize' with a backtrace like:
> ...
> linux-vt-vgacon-init-cell-height-fix.diff
> Index: linux-macro-ide-tty/drivers/video/console/vgacon.c
> ===================================================================
> --- linux-macro-ide-tty.orig/drivers/video/console/vgacon.c
> +++ linux-macro-ide-tty/drivers/video/console/vgacon.c
> @@ -366,11 +366,17 @@ static void vgacon_init(struct vc_data *
>  	struct uni_pagedir *p;
>  
>  	/*
> -	 * We cannot be loaded as a module, therefore init is always 1,
> -	 * but vgacon_init can be called more than once, and init will
> -	 * not be 1.
> +	 * We cannot be loaded as a module, therefore init will be 1
> +	 * if we are the default console, however if we are a fallback
> +	 * console, for example if fbcon has failed registration, then
> +	 * init will be 0, so we need to make sure our boot parameters
> +	 * have been copied to the console structure for vgacon_resize
> +	 * ultimately called by vc_resize.  Any subsequent calls to
> +	 * vgacon_init init will have init set to 0 too.
>  	 */
>  	c->vc_can_do_color = vga_can_do_color;
> +	c->vc_scan_lines = vga_scan_lines;
> +	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
>  
>  	/* set dimensions manually if init != 0 since vc_resize() will fail */
>  	if (init) {
> @@ -379,8 +385,6 @@ static void vgacon_init(struct vc_data *
>  	} else
>  		vc_resize(c, vga_video_num_columns, vga_video_num_lines);
>  
> -	c->vc_scan_lines = vga_scan_lines;
> -	c->vc_font.height = c->vc_cell_height = vga_video_font_height;
>  	c->vc_complement_mask = 0x7700;
>  	if (vga_512_chars)
>  		c->vc_hi_font_mask = 0x0800;


Just to let you know that the above patch fixes the crashes I experienced.
Tried in kernel 4.9.287.
The git tree is broken in the sense that it doesn't know the tags v4.9.284,
v4.9.285, v4.9.286 and v2.4.287.

Wim.
