Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92791CDB47E
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Oct 2023 10:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjJMKsQ (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 Oct 2023 06:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjJMKsO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 Oct 2023 06:48:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14413BE
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Oct 2023 03:48:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4054496bde3so20149485e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Oct 2023 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697194091; x=1697798891; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HLLFkGf7Achrz0z+pSaE//aRnm/rW1Ix0xcw7kiGLrg=;
        b=YMBZzBsvWrXzr+2Lui3vC3LGzmnhKWRPLcnD4DAH2B9gmTZ5mUfChkGGZg6KPRV1xG
         QSixK2jNL/qY7uGbPDRtSsFncVVHCwVLbynkm/PfgWaembmTl4WmDR++KAsJftCXUOzy
         MhaeA3fOQoTLLd/2vul/otNAluMEVvTA4oplvHiCIhblBcwV909SZW6LKEWSfRH0DIrc
         aAFIcgfBJOEgjerNi4qtt7Kd+7+6lfboEBDw9xgK/ngYtAHBHdksxBNv0cXKxtxSR8/A
         ORiSSzXHjjQEKuX231JVpptaBd+owl43k1XgCDvk5foZO3S5i5kUINDU7rfandIqRZRE
         kBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697194091; x=1697798891;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HLLFkGf7Achrz0z+pSaE//aRnm/rW1Ix0xcw7kiGLrg=;
        b=OkX/1GgoPCy3lATYW+mieIqK9OdKcXJg74MDKeDELX4SuRwppMG8CBzMqas8/9K3/m
         vpRnI658QRUne1ofIEznEZBRPPI+l8wNOIX64r8yLcgD6nuICkOsvFOiTzk0zjr5Ome5
         iOTdBBMPZ8Cuph7+sry4UzuN1w9YXsW3nEertPpb2ASmgPhjueuQNuBMDb4BfF9LYqaD
         DzNdIWnM2hnWuQVLlAUiw6pgAiwFq+VP4+/BF08AikPvSnoOdgHRH6Updptgahx+Fg8l
         mrpytKm5BPhivbA26w3ykOqtP42YgnrId/WGfMf+FqFxQtZqPnWdLZPn8WmULBfq/uWV
         UEuQ==
X-Gm-Message-State: AOJu0YyaONoc0wTokWkbeaJULXpCHtj7R2OLzmE0RLrM7FKcROJ/FlM0
        VRXgH1blONPaSRVZnWzP6ZsCnA==
X-Google-Smtp-Source: AGHT+IER8Qmwq0wdK9VvhE99s0OeRpYmMCCnwuM07qasuEB0UUtmtrLXlArFm5b/BD98dc49TPg9zw==
X-Received: by 2002:a5d:4b48:0:b0:319:7a91:7107 with SMTP id w8-20020a5d4b48000000b003197a917107mr21319385wrs.48.1697194091127;
        Fri, 13 Oct 2023 03:48:11 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id d7-20020adfa347000000b0032d72f48555sm5239011wrb.36.2023.10.13.03.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 03:48:10 -0700 (PDT)
Date:   Fri, 13 Oct 2023 13:48:08 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PATCH]Staging: sm750fb:Add snakecase naming style
Message-ID: <efcb4734-0349-493e-be93-b95381eb6c78@kadam.mountain>
References: <20231013104220.7527-1-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013104220.7527-1-anonolitunya@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Oct 13, 2023 at 01:42:15PM +0300, Dorcas AnonoLitunya wrote:
> From: Dorcas Anono Litunya <anonolitunya@gmail.com>
> 
> Change camelCase variables in file to snake_case for consistent naming
> practices. Issue found by checkpatch.
> 
> Signed-off-by: Dorcas Anono Litunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 86 +++++++++++++--------------
>  drivers/staging/sm750fb/ddk750_mode.h |  2 +-
>  drivers/staging/sm750fb/sm750_hw.c    |  2 +-
>  3 files changed, 45 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/staging/sm750fb/ddk750_mode.c b/drivers/staging/sm750fb/ddk750_mode.c
> index e00a6cb31947..f08dcab29172 100644
> --- a/drivers/staging/sm750fb/ddk750_mode.c
> +++ b/drivers/staging/sm750fb/ddk750_mode.c
> @@ -14,13 +14,13 @@
>   * in bit 29:27 of Display Control register.
>   */
>  static unsigned long
> -displayControlAdjust_SM750LE(struct mode_parameter *pModeParam,
> -			     unsigned long dispControl)
> +display_control_adjust_SM750LE(struct mode_parameter *p_mode_param,

The p stands for pointer.  We don't like that naming style.  Just call
it mode_param.

Thes are the renamed things.

displayControlAdjust_SM750LE => display_control_adjust_SM750LE
pModeParam => p_mode_param
dispControl => disp_control
programModeRegisters => program_mode_registers
ddk750_setModeTiming => ddk750_set_mode_timing

I feel like this would be better broken up probably into one variable
per patch.  It's jumping around between files.  These variables are not
closely related.

regards,
dan carpenter

