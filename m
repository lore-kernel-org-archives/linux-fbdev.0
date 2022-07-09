Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD8C8C43334
	for <linux-fbdev@archiver.kernel.org>; Sat,  9 Jul 2022 10:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiGIKa6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 9 Jul 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGIKa5 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 9 Jul 2022 06:30:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A22643C5;
        Sat,  9 Jul 2022 03:30:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 71CA5B81910;
        Sat,  9 Jul 2022 10:30:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E90C3411C;
        Sat,  9 Jul 2022 10:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1657362654;
        bh=+StW1gOLTZgdcvRatpGmh7s1OknwJrHLQ9GRWP9NdC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pq0+JUbS8bqFQopWY7oG/wgS3nVVemFHzsgErgrU8PhKix5W7hEKYR00OQoTTbLj6
         AyPtvlTxYKaQs2yAtMR4m6WqGOmM5cKLm+jHp4m3Nqdyt47+z7zMDR5IIZqbFNlz1f
         /URWkB56i7OyC8F/r/2ewjWYTVYROKlIwxo/uNLE=
Date:   Sat, 9 Jul 2022 12:30:51 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Christos Kollintzas <c.kollintzas.92@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: replace udelay with usleep_range
Message-ID: <YslY25NnW6O5Tn+p@kroah.com>
References: <YslTQLhM7GSaGXki@mandalorian.koija>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YslTQLhM7GSaGXki@mandalorian.koija>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jul 09, 2022 at 01:06:56PM +0300, Christos Kollintzas wrote:
> Adhere to Linux kernel coding style.
> 
> Reported by checkpatch:
> 
> CHECK: usleep_range is preferred over udelay
> 
> Signed-off-by: Christos Kollintzas <c.kollintzas.92@gmail.com>
> ---
>  drivers/staging/fbtft/fb_upd161704.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fb_upd161704.c b/drivers/staging/fbtft/fb_upd161704.c
> index c680160d6380..eeafbab4ace1 100644
> --- a/drivers/staging/fbtft/fb_upd161704.c
> +++ b/drivers/staging/fbtft/fb_upd161704.c
> @@ -32,27 +32,27 @@ static int init_display(struct fbtft_par *par)
>  
>  	/* oscillator start */
>  	write_reg(par, 0x003A, 0x0001);	/*Oscillator 0: stop, 1: operation */
> -	udelay(100);
> +	usleep_range(100, 110);

When doing these types of changes, you really need access to the
hardware involved in order to be able to properly test it.

Especially for this type of function which is trying to do timing
changes which the hardware requires.

Did you test this on the real hardware and did it work properly?

thanks,

greg k-h
