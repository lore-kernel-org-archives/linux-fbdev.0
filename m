Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B272C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86E66139E
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 08:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbhDGIcQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 04:32:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:54922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235328AbhDGIcQ (ORCPT <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 7 Apr 2021 04:32:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4F94A61246;
        Wed,  7 Apr 2021 08:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1617784326;
        bh=r74abV0HnQhwcnFE9x4s3tE7D4/Va11TGitx5tmoBZk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gAkFggY4GxEY5JTKLyGWfpcqP55G6bHc6irB5KEyY/OOTYZKBH9sBMeC7/bGmvNDY
         ndlIcfYmf3/fINPA/suIvyrSL+R6V80rDuSRodJo9X3An160as6vvgU3ma1hNTJvxM
         1Q7fv6QEirV8ZBLUcQ24CV3V9n+eQjd59jJ5z45U=
Date:   Wed, 7 Apr 2021 10:32:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavle Rohalj <pavle.rohalj@gmail.com>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 02/49] staging: sm750fb: Rename dviInit to dvi_init
 and update param names
Message-ID: <YG1uBAIOgwA2FYUB@kroah.com>
References: <cover.1617776878.git.pavle.rohalj@gmail.com>
 <6c6ecf7eee7d41492dbbcc4410db7eefd1fbb13d.1617776878.git.pavle.rohalj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c6ecf7eee7d41492dbbcc4410db7eefd1fbb13d.1617776878.git.pavle.rohalj@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 11:36:01PM -0700, Pavle Rohalj wrote:
> Fix "Avoid CamelCase" checkpatch.pl checks for the function dviInit and
> its parameter names in ddk750_dvi.h.
> 
> Signed-off-by: Pavle Rohalj <pavle.rohalj@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_dvi.c |  2 +-
>  drivers/staging/sm750fb/ddk750_dvi.h | 20 ++++++++++----------
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_dvi.c b/drivers/staging/sm750fb/ddk750_dvi.c
> index db19bf732482..943cbcafcffa 100644
> --- a/drivers/staging/sm750fb/ddk750_dvi.c
> +++ b/drivers/staging/sm750fb/ddk750_dvi.c
> @@ -30,7 +30,7 @@ static struct dvi_ctrl_device dcft_supported_dvi_controller[] = {
>  #endif
>  };
>  
> -int dviInit(unsigned char edge_select,
> +int dvi_init(unsigned char edge_select,

Why is this a global function?  Just make it static and remove it from
the .h file.

thanks,

greg k-h
