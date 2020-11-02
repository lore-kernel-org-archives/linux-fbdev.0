Return-Path: <SRS0=+7Ut=EI=vger.kernel.org=linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C1EC55179
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 10:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 28C9A22275
	for <linux-fbdev@archiver.kernel.org>; Mon,  2 Nov 2020 10:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="FPWp/swl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKBKKv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 2 Nov 2020 05:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728316AbgKBKKt (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 2 Nov 2020 05:10:49 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DCC061A04
        for <linux-fbdev@vger.kernel.org>; Mon,  2 Nov 2020 02:10:48 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id n15so13898786wrq.2
        for <linux-fbdev@vger.kernel.org>; Mon, 02 Nov 2020 02:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=/jCBLmaCudwHAJHAidbrPtDf5EnkITSIWvI62MHOukQ=;
        b=FPWp/swlBnqBkl1B3JK7NsX6n/++Ji0QGa1CPTVP5ISH9HOzOklGZggjcUq1dkZAuK
         1P9ufpBGRckno/zLlghYzi8qdLKLX3zphP4QfhOrjq2VvILw1Ty75o8c5uUha3pggSli
         vxiQfKC4O+5Zgxyx5SEefhRd5y3XmyOU96K3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=/jCBLmaCudwHAJHAidbrPtDf5EnkITSIWvI62MHOukQ=;
        b=IuvQyYEMY9+3ZiuvaeBOPAEOp4lJDdGYpLbUgisDHpQ+mK9CT5hBRwmN/7XWnWF9R6
         t9+lWAK64gG3bLL0y0HEOoDTR29UsYB9f1sX8cqm+qDQA62SlUJ/upoIteTD8KcNGdJc
         vpxw8E5CHgwL1f5BaED3Fb/JjrXptDdUal2RoX+W1tHCvUe2rKgpntjZtWqynexBycK1
         y595QLsFll2hMSGNPAqGOk6ViwOOXNYVOHIVKe9OtABwLjl47wkqPiuzAJu2KgtjLLdh
         DV9Pc14A96o7HLfubpk6lWDFUVGykITheLrfFoktTpQWOsURlaJTWaCWGPtyMtxEAyW7
         +HrQ==
X-Gm-Message-State: AOAM5335I2o+lyq9/GiaN2HWizyAGNQuxLZJBvwkGdveXcYNY3Wn1hYr
        Stu1MdbJylm6jbCPk73sCTJf3w==
X-Google-Smtp-Source: ABdhPJy6jfLVwkZqySMOwLFsx4xGyqy0UGSjPX4MTh1s9JXutyGH4qa+vJ2YyDxaw4XFdjk/eWh61Q==
X-Received: by 2002:adf:fc07:: with SMTP id i7mr14102371wrr.223.1604311847466;
        Mon, 02 Nov 2020 02:10:47 -0800 (PST)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id t12sm22032523wrm.25.2020.11.02.02.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2020 02:10:46 -0800 (PST)
Date:   Mon, 2 Nov 2020 11:10:44 +0100
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Peilin Ye <yepeilin.cs@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] tty/vt: Avoid passing struct console_font_op to
 con_font_copy()
Message-ID: <20201102101044.GM401619@phenom.ffwll.local>
Mail-Followup-To: Peilin Ye <yepeilin.cs@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Thomas Winischhofer <thomas@winischhofer.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Nicolas Pitre <nico@fluxnic.net>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        George Kennedy <george.kennedy@oracle.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Peter Rosin <peda@axentia.se>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
References: <c5563eeea36aae7bd72ea2e985bc610d585ece40.1604306433.git.yepeilin.cs@gmail.com>
 <72c954371ed9b1d050901b2d498a979017de8a3c.1604306433.git.yepeilin.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72c954371ed9b1d050901b2d498a979017de8a3c.1604306433.git.yepeilin.cs@gmail.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Nov 02, 2020 at 04:37:55AM -0500, Peilin Ye wrote:
> con_font_op() is passing an entire `struct console_font_op *` to
> con_font_copy(), but con_font_copy() only uses `op->height`. Additionally,
> con_font_copy() is silently assigning the unsigned `op->height` to the
> signed `con`, then pass it to fbcon_copy_font().
> 
> Let con_font_copy() and fbcon_copy_font() pass an unsigned int directly.
> Also, add a comment in con_font_op() for less confusion, since ideally
> `op->height` should not be used as a console index, as the field name
> suggests.
> 
> This patch depends on patch "console: Remove dummy con_font_op() callback
> implementations".
> 
> Suggested-by: Daniel Vetter <daniel@ffwll.ch>
> Signed-off-by: Peilin Ye <yepeilin.cs@gmail.com>
> ---
> con_font_set(), con_font_get() and con_font_default() also pass an entire
> `console_font_op`.
> 
> con_font_get() and con_font_default() actually update the structure (later
> copied to userspace), so let them be.
> 
> con_font_set() does not update the structure, but it uses all fields of it
> except `op`. Avoiding passing `console_font_op` to con_font_set() will
> thus make its signature pretty long (6 parameters).
> 
> Changes in v2:
>   - Remove redundant `con < 0` check in con_font_copy() (kernel test robot
>     <lkp@intel.com>)
>   - Remove unnecessary range check in fbcon_copy_font(). con_font_copy()
>     calls vc_cons_allocated(), which does the check
>   - Do not Cc: stable
>   - Rewrite the title and commit message accordingly
> 
>  drivers/tty/vt/vt.c              | 8 ++++----
>  drivers/video/fbdev/core/fbcon.c | 2 +-
>  include/linux/console.h          | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

I'm not sure switching from int to unsigned just here makes much sense.
All the console code is still using int con to index all the various
arrays (I just checked fbcon.c code), and using int to index arrays is
pretty standard. As long as we have the con < 0 check to catch evil
userspace.

There's still the switch from op to int for con_font_copy, but I think
that's better done as part of the larger cleanup we already discussed. And
then maybe also include patch 1 from this series in that rework.
-Daniel

> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index 9506a76f3ab6..27821ef97b13 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -4704,9 +4704,8 @@ static int con_font_default(struct vc_data *vc, struct console_font_op *op)
>  	return rc;
>  }
>  
> -static int con_font_copy(struct vc_data *vc, struct console_font_op *op)
> +static int con_font_copy(struct vc_data *vc, unsigned int con)
>  {
> -	int con = op->height;
>  	int rc;
>  
>  
> @@ -4715,7 +4714,7 @@ static int con_font_copy(struct vc_data *vc, struct console_font_op *op)
>  		rc = -EINVAL;
>  	else if (!vc->vc_sw->con_font_copy)
>  		rc = -ENOSYS;
> -	else if (con < 0 || !vc_cons_allocated(con))
> +	else if (!vc_cons_allocated(con))
>  		rc = -ENOTTY;
>  	else if (con == vc->vc_num)	/* nothing to do */
>  		rc = 0;
> @@ -4735,7 +4734,8 @@ int con_font_op(struct vc_data *vc, struct console_font_op *op)
>  	case KD_FONT_OP_SET_DEFAULT:
>  		return con_font_default(vc, op);
>  	case KD_FONT_OP_COPY:
> -		return con_font_copy(vc, op);
> +		/* uses op->height as a console index */
> +		return con_font_copy(vc, op->height);
>  	}
>  	return -ENOSYS;
>  }
> diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
> index cef437817b0d..cb5b5705ea71 100644
> --- a/drivers/video/fbdev/core/fbcon.c
> +++ b/drivers/video/fbdev/core/fbcon.c
> @@ -2451,7 +2451,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h,
>  	return 0;
>  }
>  
> -static int fbcon_copy_font(struct vc_data *vc, int con)
> +static int fbcon_copy_font(struct vc_data *vc, unsigned int con)
>  {
>  	struct fbcon_display *od = &fb_display[con];
>  	struct console_font *f = &vc->vc_font;
> diff --git a/include/linux/console.h b/include/linux/console.h
> index 4b1e26c4cb42..34855d3f2afd 100644
> --- a/include/linux/console.h
> +++ b/include/linux/console.h
> @@ -62,7 +62,7 @@ struct consw {
>  	int	(*con_font_get)(struct vc_data *vc, struct console_font *font);
>  	int	(*con_font_default)(struct vc_data *vc,
>  			struct console_font *font, char *name);
> -	int	(*con_font_copy)(struct vc_data *vc, int con);
> +	int	(*con_font_copy)(struct vc_data *vc, unsigned int con);
>  	int     (*con_resize)(struct vc_data *vc, unsigned int width,
>  			unsigned int height, unsigned int user);
>  	void	(*con_set_palette)(struct vc_data *vc,
> -- 
> 2.25.1
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
