Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 175A1C77B61
	for <linux-fbdev@archiver.kernel.org>; Sat,  8 Apr 2023 08:22:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjDHIWk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 8 Apr 2023 04:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDHIWj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 8 Apr 2023 04:22:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3AE6C148;
        Sat,  8 Apr 2023 01:22:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A8E604EF;
        Sat,  8 Apr 2023 08:22:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9908EC433EF;
        Sat,  8 Apr 2023 08:22:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680942158;
        bh=cXMKqHwqy1azEvJGrcgTgrzawxthoP+aOHgL4NnX4zw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=A1bnkTfopSpWCvF9LWS+1I6fUOzCoCAC9grNMLiUxSsmNGM5z+a9SIMzFJ2depn3h
         SaMzO4gSuaHxG83AmviwxG1ur9C8l935m4I+SDqI0AeXJLhv4hV7zXUn3h0/4o+Cbx
         WCIg//NJVoAWybARQfuvuC8Na7MGwggYqrLkZtG0=
Date:   Sat, 8 Apr 2023 10:22:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: fbtft: fbtft-bus: fixed extra space and
 parenthesis issue
Message-ID: <2023040814-unfixable-recognize-73d0@gregkh>
References: <20230408050323.70919-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230408050323.70919-1-kartikey406@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Apr 08, 2023 at 10:33:23AM +0530, Deepanshu Kartikey wrote:
> Fixed a coding styling issue
> 
> Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
> ---
>  drivers/staging/fbtft/fbtft-bus.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/staging/fbtft/fbtft-bus.c b/drivers/staging/fbtft/fbtft-bus.c
> index 3d422bc11641..02a16671f2a1 100644
> --- a/drivers/staging/fbtft/fbtft-bus.c
> +++ b/drivers/staging/fbtft/fbtft-bus.c
> @@ -62,9 +62,9 @@ out:									      \
>  }                                                                             \
>  EXPORT_SYMBOL(func);
>  
> -define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8, )
> +define_fbtft_write_reg(fbtft_write_reg8_bus8, u8, u8)
>  define_fbtft_write_reg(fbtft_write_reg16_bus8, __be16, u16, cpu_to_be16)
> -define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16, )
> +define_fbtft_write_reg(fbtft_write_reg16_bus16, u16, u16)
>  
>  void fbtft_write_reg8_bus9(struct fbtft_par *par, int len, ...)
>  {
> -- 
> 2.25.1
> 
> 

Any specific reason why you did not test-build your patch before sending
it?
