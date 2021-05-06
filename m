Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EFAC433B4
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 May 2021 03:03:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B69161222
	for <linux-fbdev@archiver.kernel.org>; Thu,  6 May 2021 03:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhEFDEo (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 May 2021 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhEFDEn (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 May 2021 23:04:43 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0266EC061574;
        Wed,  5 May 2021 20:03:46 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id v24so4207613oiv.9;
        Wed, 05 May 2021 20:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=K5oeKhWnfTWljork6kG9sjbCOLkcBK1xWa+5KaC6FfA=;
        b=UItIGd7fy9lsjOKrGP51zo5biHp/hQ/qj8iEs7ows6xMHHZEOVCCwh/oCqJqhv7QyP
         GpVpfRCLRhEcdWvHM3S45/tuTNnTHr1cnmB780Clarf0Ni3xz8NtNqvmqrrWN3qmUxle
         SljoP9JJ81W8g5OAM8qrbLvloB/N+DJxN+e3bw8NvHwBZvjmTLOQmZSvonEaVkhcLzz3
         jeO2laQrsWp9z5eYTbMXbUddswgcVQERss0lxJTns4VW8iiv+WNjX/u62SAf7dNB9HPz
         ba2tIvVIqsSEpegW7iiBlhidbKXSp4VqdduclITPSzbqCKYF2EdMhX0CWF3sONTr8Cwv
         BC0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=K5oeKhWnfTWljork6kG9sjbCOLkcBK1xWa+5KaC6FfA=;
        b=cp6wSIcaK1ZXWTTWcL6jlu1UoDWX/RPVO4W0JDidpnKCI2haFyq2PFnQzFOhuE9/dU
         TQhKE38XbXjQOzjcOM+hhf7PJVd/7TA7taIv9h/GzpetTCGbss0ycweKEwt0U+8+MY8s
         koAOLqyNLHKVX0EyiA1YZZLZUVqJjKK4GIJXpy4COWLXhSHsOptcc8sSaQds62ozvh2f
         f2HbOGjCgPYz/l69rutgXD3VSKtZzWnJyxkDhneN+sac59JAZW9EurLTpXOLJHiyZzzw
         c0otQMQBbJaHPE8eQQN51J2LQ3KG3kHrjtx1Cvi6j7nmiNEijSrXGF0mEGaFTpev3DP3
         jMaA==
X-Gm-Message-State: AOAM533eFHEdH/2KM6um2omjwg9rgvZcHxu7CseIXn5SW++QZVVDkMw4
        UBPCH90RoC/KWaPTL40eZ+3wINL4buk=
X-Google-Smtp-Source: ABdhPJzJF8Vcj0ULOhre2WMz85zKPLyV9PDxnCgEyzDtZmmFR3z5ebRss2D5d0LbII8uCzq6wp4GXw==
X-Received: by 2002:a05:6808:20d:: with SMTP id l13mr1459416oie.158.1620270225476;
        Wed, 05 May 2021 20:03:45 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h12sm314064otk.55.2021.05.05.20.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 20:03:45 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 5 May 2021 20:03:43 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Nick Desaulniers <ndesaulniers@google.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] fbmem: Correct position of '__maybe_unused' in
 proc_fb_seq_ops
Message-ID: <20210506030343.GA741106@roeck-us.net>
References: <20210505182808.3855516-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210505182808.3855516-1-nathan@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, May 05, 2021 at 11:28:08AM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
>  drivers/video/fbdev/core/fbmem.c:736:21: warning: attribute
>  declaration must precede definition [-Wignored-attributes]
>  static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
>                      ^
>  ./include/linux/compiler_attributes.h:273:56: note: expanded from macro
>  '__maybe_unused'
>  #define __maybe_unused                  __attribute__((__unused__))
>                                                         ^
>  ./include/linux/seq_file.h:31:8: note: previous definition is here
>  struct seq_operations {
>         ^
>  1 warning generated.
> 
> The attribute should not split the type 'struct seq_operations'. Move it
> before the struct keyword so that it works properly and there is no more
> warning.
> 

Oops, sorry.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> Fixes: b9d79e4ca4ff ("fbmem: Mark proc_fb_seq_ops as __maybe_unused")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1371
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> ---
>  drivers/video/fbdev/core/fbmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 52c606c0f8a2..84c484f37b4a 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -733,7 +733,7 @@ static int fb_seq_show(struct seq_file *m, void *v)
>  	return 0;
>  }
>  
> -static const struct __maybe_unused seq_operations proc_fb_seq_ops = {
> +static const __maybe_unused struct seq_operations proc_fb_seq_ops = {
>  	.start	= fb_seq_start,
>  	.next	= fb_seq_next,
>  	.stop	= fb_seq_stop,
> 
> base-commit: b9d79e4ca4ff23543d6b33c736ba07c1f0a9dcb1
> -- 
> 2.31.1.362.g311531c9de
> 
