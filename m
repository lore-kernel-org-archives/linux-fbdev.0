Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031EBC432BE
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 08:16:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D298060FF2
	for <linux-fbdev@archiver.kernel.org>; Mon, 30 Aug 2021 08:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbhH3IRU (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 30 Aug 2021 04:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbhH3IRU (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 30 Aug 2021 04:17:20 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E801DC061760
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Aug 2021 01:16:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eb14so11133180edb.8
        for <linux-fbdev@vger.kernel.org>; Mon, 30 Aug 2021 01:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=4V8zQGj1Gqf1F2tUDyAxGYR3CqJxPsTeRp5ZOBqSIDQ=;
        b=TuRY2sKW4BSfhJDjqVGbNRktK9LKQd2XLWSD40j4bkwxZWVIoWgb227dKGlbXTtTY5
         AEV0TuIGQPvrFZ6iy4MYEhgyGjzIMrilibmAUyqrwhDs4+AVxXMienXkDEGlpbaRnTFh
         hTFf9cDd5j+dozZN/drbUiSS0HawPZce23FDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=4V8zQGj1Gqf1F2tUDyAxGYR3CqJxPsTeRp5ZOBqSIDQ=;
        b=OfnIbH7G/M81GG1vQ69eZhvj9RQ8U2X8wEuYaUnMs5jIZDeYGb3Eir06nEsR4uHe9P
         TUSjttpfsuZTYcrgywL/UQXNQG9w0uVM+hkRUN67cYVkSP1WrDa7RFRCaCcllk7gi2e9
         ZJ3N/nwjJT0KvNuHXsIEdidFHDO/L/F3JW60Ie+1sSv3Q9gdGloEOxt1B4DxN8MRFkMK
         ifj5nBKJHaLXE4ACgpd3lCi/0/F5GWpCDAMm/EP7iTocDB3Pa8+5v/hANdTb0wI3zr2Z
         zI+ehLfVFE26MetJQHkC0FjR0gtCXJF/0iU5ZhVgjvjDOLFYOg9o4v8gRFxb12Mbh5fk
         j6ug==
X-Gm-Message-State: AOAM530yoH5EMWOme4jFvuv1rNh/wsU1tfjJoMMaFAN2K89GKFqri1pn
        +u+qaoMbvAaQ3/lFSG14le9XXQ==
X-Google-Smtp-Source: ABdhPJzrm65vrU6FbeDHBqEE0r78ZCI76NdXsgPcErghrJZM0wZPOGz21FvSxt91jZIRA0bIPWz8rg==
X-Received: by 2002:a50:998f:: with SMTP id m15mr22603150edb.193.1630311385540;
        Mon, 30 Aug 2021 01:16:25 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q5sm7275049edt.50.2021.08.30.01.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 01:16:25 -0700 (PDT)
Date:   Mon, 30 Aug 2021 10:16:14 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     tcs.kernel@gmail.com
Cc:     daniel.vetter@ffwll.ch, willy@infradead.org,
        george.kennedy@oracle.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        penguin-kernel@i-love.sakura.ne.jp,
        Haimin Zhang <tcs_kernel@tencent.com>
Subject: Re: [PATCH V4] fbcon: fix fbcon out-of-bounds write in sys_imageblit
Message-ID: <YSyTzlUEhrxD7rU4@phenom.ffwll.local>
Mail-Followup-To: tcs.kernel@gmail.com, willy@infradead.org,
        george.kennedy@oracle.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, gregkh@linuxfoundation.org,
        penguin-kernel@i-love.sakura.ne.jp,
        Haimin Zhang <tcs_kernel@tencent.com>
References: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630294223-7225-1-git-send-email-tcs_kernel@tencent.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Aug 30, 2021 at 11:30:23AM +0800, tcs.kernel@gmail.com wrote:
> From: Haimin Zhang <tcs_kernel@tencent.com>
> 
> yres and vyres can be controlled by user mode parameters, and cause
> p->vrows to become a negative value. While this value be passed to real_y
> function, the ypos will be out of screen range.This is an out-of-bounds
> write bug.
> some driver will check xres and yres in fb_check_var callback,but some not
> so we add a common check after that callback.
> 
> Signed-off-by: Haimin Zhang <tcs_kernel@tencent.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

Does this fix a syzbot crash or how was this discovered?
-Daniel

> ---
>  drivers/video/fbdev/core/fbmem.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
> index 1c85514..5599372 100644
> --- a/drivers/video/fbdev/core/fbmem.c
> +++ b/drivers/video/fbdev/core/fbmem.c
> @@ -1013,6 +1013,10 @@ static int fb_check_caps(struct fb_info *info, struct fb_var_screeninfo *var,
>  	if (ret)
>  		return ret;
>  
> +	/* virtual resolution cannot be smaller than visible resolution. */
> +	if (var->yres_virtual < var->yres || var->xres_virtual < var->xres)
> +		return -EINVAL;
> +
>  	if ((var->activate & FB_ACTIVATE_MASK) != FB_ACTIVATE_NOW)
>  		return 0;
>  
> -- 
> 1.8.3.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
