Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76133D8903
	for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 12:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778761108; cv=none; b=ef7aP8ADOhtknb+RqKU3IA6R8b22RTRhk3fYHEJaNV+VbigpgqkpdfwB9GNXGsp/q96GJtPNMLxUKQvtuo9DucuKAOPAsaqEHMNrOT9W8qLIEYTOs5oXnR/EdQ4ajcq3Y5Q0F7vmIOU7zeKlhcD1RYn+bjE/fO1eJixKXziH6J8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778761108; c=relaxed/simple;
	bh=gXR2IZNMnwEUAg2UR4zcBwDXGq8bNswBPoqCKMbgS3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CBTiQi3tw1b6ALh3Cvl+BkBjtpg4aW8Y1GryVrgcdO3Rm9eG3mX1mRFx39bwG8roZC56HR/214r15UyaWUXoBI3+HOTsvj3qmgosRRu7tenbo81dAekBMv9/q5gpR7WruazM+MXG6iV7n8p8llL4YKrr3sAGuCqrRw0H0MKJntY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=meAbXVfS; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="meAbXVfS"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4891c00e7aeso65893625e9.2
        for <linux-fbdev@vger.kernel.org>; Thu, 14 May 2026 05:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778761103; x=1779365903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AG1lvR6pl4BzaSh04axvEB6iGN2Hc8q6AwQQAJp6LYs=;
        b=meAbXVfSIy05EFENvwH7px2TnxvHRiMuxS1iLWYQeowYf6UQzdmPRtkBIMtco9lyvV
         hb4FT3M9nWMf1j53OLQbrNK1aYSxWNuzAX4yl7c7IldpUpp9w8ItnTa5UG0EUmxXUXMo
         E1V+PTP1eOh3jUADZpewBWaT63yORbejHKZzPckd41cjP3qyVsBg8lk+mUbqkgH/lyc6
         HFuzvf+l42+GNa7nsyPGMEz299xGLroJBwUOE5+FctHRTvWLWEJSIDt57b85HNL7iZzH
         /4uQrDkcUBEO3wuRgxoQGYGE/hC6f6jIRkPtGpQbm83YPL/5vzh5yWucaMyR0Xu6PfGP
         DIng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778761103; x=1779365903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AG1lvR6pl4BzaSh04axvEB6iGN2Hc8q6AwQQAJp6LYs=;
        b=byHw3k+W6HqxCI1X6KTqp6rrXua5OGlwtN72oJwcUt2Ouqb/gnPeEg2T6H7F289/DP
         SYbpzzKUFOYiGkWyvifF4k9QUaHh03kjnCJzkSpovT1wyXyTCk8Y96scsr+zEqUJlhwR
         LoOs7Uv7cR0XN3+8HkDO5t/daCptb9ogkh/4v47wCnlGXo1lNFFzi2ku2m/NBHXazGHY
         D41CtjKv5mkDFrdAdlEVNRGkBsa4jrxBM6ZDSw3RPv9L1cAFzfbmPg5y4kYYRKJw5L7C
         gkyziz0oBhvtjdUr8VNOo3FRdvTay4G1So4npexC0yAUX/1orWUlaxq/s4LYk7XHcyGq
         081Q==
X-Forwarded-Encrypted: i=1; AFNElJ80Xahnla7yj71TP79H8U+rl3Y0BU8FEtNNON9V+Cu72c4vGeAQkm8LnM0r54AHFyM/w3OMfqF3pEZbmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwQnXqKJ8mEfxz48+XwDDFoGIiNxs8yslwsiQMcukT9gaDqsLO9
	Y4ne5eVvQTVEjeinRT6tWj7Hgv8Gs5LEgeTG7HD1QpPqsykbhNwzw5fS
X-Gm-Gg: Acq92OFztalqPtfttoHYu23K+q89OJACaXP/FtvIyNhXOBM8P8cHZdWP9n5S+L8vFBH
	xuQz8Wl18O/L+VioPhdAZbokijFCFpUcKMj3NEoNsQgkxTj563rhirwhZCUwbw8jtPLPx5lb0sW
	RxJv4nZt0vOa7V8bNb5doW5f0rQm9SJKNGOR/c0myASVv70tAOWlO7gXzgbdLCuiJUOUkk262hY
	GZPBgebq9yZDQs19WZZ1TFc+WZBAZMiLYi/M1RT/AxEnHTLADX2g3VlGOY8yhAVoJOKoz9bLm3Z
	vW62/FM6L+hhp3U+67ppMR4oqbM54URiy9PEPmwNJAHpDEznmvwb7JkXEM6PV70lO0s6ZcjIDxt
	45rwOnKCOmPuPiBQP9+gfzwY5AhLTvArbW3HjtkVr1McbWXxP5saos49ndyRklsIPooJZ8YlMQi
	KzbY4UCaxoEGOr26cm+A8=
X-Received: by 2002:a05:600c:c4ab:b0:48e:7f1c:8760 with SMTP id 5b1f17b1804b1-48fc9a45b3bmr120011915e9.27.1778761103365;
        Thu, 14 May 2026 05:18:23 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48fd76801f2sm22188035e9.7.2026.05.14.05.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2026 05:18:22 -0700 (PDT)
Date: Thu, 14 May 2026 15:18:19 +0300
From: Dan Carpenter <error27@gmail.com>
To: Chhabilal Dangal <yogeshdangal66@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>,
	linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
	devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: sm750fb: Add suspend checks to copyarea and
 imageblit
Message-ID: <agW9i3X6HOL4Zt5n@stanley.mountain>
References: <20260514120102.71615-1-yogeshdangal66@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fbdev@vger.kernel.org
List-Id: <linux-fbdev.vger.kernel.org>
List-Subscribe: <mailto:linux-fbdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fbdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514120102.71615-1-yogeshdangal66@gmail.com>

On Thu, May 14, 2026 at 05:46:02PM +0545, Chhabilal Dangal wrote:


> The suspend path calls fb_set_suspend(), which sets the framebuffer
> state to FBINFO_STATE_SUSPENDED. Add matching state checks in the
> remaining accelerated callbacks for consistency with fillrect().

This is stating obvious but unrelated things as if it means something.
It feels like information but it's a waste of time.  fillrect() does
not mirror fb_set_suspend().  This whole paragraph is garbage.

> lynxfb_ops_fillrect() already checks info->state before accessing
> the hardware 2D engine, but lynxfb_ops_copyarea() and
> lynxfb_ops_imageblit() do not.
> 

This paragraph is useful because it gives the motivation. But last
time you hadn't checked that the AI was correct.  You're just leaving
it up to us to check.  Why is your time more valuable than our time
that you can't be bothered to check this stuff?

We need to know:
1) Is the AI correct this time?
2) What is the implication of the bug.

Please do this research on your own, don't just enter my questions into
an AI.

3) Wouldn't it be better to do it at a lower level?

Smatch says that out of the callers only fbcon_bmove_rec(), ypan_up()
and ypan_down() don't check.  So check those to see if this is a
real bug.

drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |      fbcon_bmove_rec | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |    fbcon_redraw_blit | (struct fbcon_bitops)->bmove |        PARAM_VALUE |  1 |     info->state | 0
drivers/video/fbdev/core/fbcon.c |              ypan_up | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)
drivers/video/fbdev/core/fbcon.c |            ypan_down | (struct fbcon_bitops)->bmove |           INTERNAL | -1 |                 | void(*)(struct vc_data*, struct fb_info*, int, int, int, int, int, int)

> 
> Assisted-by: Claude Opus 4.6 (Anthropic LLM)
> Compile-tested only.

Put this under the --- cut off line.

> 
> Signed-off-by: Chhabilal Dangal <yogeshdangal66@gmail.com>
> ---
  ^^^
Here.

No Fixes tag.
Please wait a day between resends.

regards,
dan carpenter

