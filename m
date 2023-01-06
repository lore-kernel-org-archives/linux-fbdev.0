Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8098AC5479D
	for <linux-fbdev@archiver.kernel.org>; Fri,  6 Jan 2023 15:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjAFPyO (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 6 Jan 2023 10:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232981AbjAFPyK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 6 Jan 2023 10:54:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA208CD09;
        Fri,  6 Jan 2023 07:54:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BAE2616FF;
        Fri,  6 Jan 2023 15:54:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0429C433D2;
        Fri,  6 Jan 2023 15:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673020446;
        bh=7cB3UhToZf19WjldWyLHUYEnxMRKMO5WZVXBb1fRwRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j6p/ExogshxrCRekX6bJ3dnNQu8ehUl5v4Oq9PpfZ4QtduzTqmG+cCqr6f1z+7UOc
         HIbzWhBKwV2Vv5Fqz61ALO8qm6TGYpMMFx3AdlRn6oep788mro5a5/YpgDOlp3WBqR
         ZlRl1pMSZN6GczeFPeG/F3cVklimuLNMX4dSEYSAW5S5zUplTySkHUTypjgDUPtezu
         yfBoqAyEq3EUebZSRPlsI8bo2Bgg/850woK49aNhmPzliUmF+NoRmwr/HWMaRrCo5O
         yKEJkaEPke71vnT4AvI9NX/0aD607X5yEkLbPJUrEo1ROPZ6N8wg4UZYlkVClYMSIQ
         ZhGwLTrSSDeBg==
Date:   Fri, 6 Jan 2023 09:54:11 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] fbdev: Replace 0-length array with flexible array
Message-ID: <Y7hEIySgveQCEMUP@work>
References: <20230105192034.never.249-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105192034.never.249-kees@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 05, 2023 at 11:20:38AM -0800, Kees Cook wrote:
> Zero-length arrays are deprecated[1]. Replace struct aperture's "ranges"
> 0-length array with a flexible array. (How is the size of this array
> verified?) Detected with GCC 13, using -fstrict-flex-arrays=3:
> 
> samples/vfio-mdev/mdpy-fb.c: In function 'mdpy_fb_probe':
> samples/vfio-mdev/mdpy-fb.c:169:32: warning: array subscript 0 is outside array bounds of 'struct aperture[0]' [-Warray-bounds=]
>   169 |         info->apertures->ranges[0].base = info->fix.smem_start;
>       |         ~~~~~~~~~~~~~~~~~~~~~~~^~~
> In file included from samples/vfio-mdev/mdpy-fb.c:21:
> include/linux/fb.h:510:19: note: while referencing 'ranges'
>   510 |                 } ranges[0];
>       |                   ^~~~~~
> 
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#zero-length-and-one-element-arrays
> 
> Cc: Helge Deller <deller@gmx.de>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: linux-fbdev@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks!
--
Gustavo

> ---
>  include/linux/fb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/fb.h b/include/linux/fb.h
> index 96b96323e9cb..bf59d6a3590f 100644
> --- a/include/linux/fb.h
> +++ b/include/linux/fb.h
> @@ -507,7 +507,7 @@ struct fb_info {
>  		struct aperture {
>  			resource_size_t base;
>  			resource_size_t size;
> -		} ranges[0];
> +		} ranges[];
>  	} *apertures;
>  
>  	bool skip_vt_switch; /* no VT switch on suspend/resume required */
> -- 
> 2.34.1
> 
