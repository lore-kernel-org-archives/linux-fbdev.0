Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B27DCC47096
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 16:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74787613E4
	for <linux-fbdev@archiver.kernel.org>; Tue,  1 Jun 2021 16:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFAQG7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 1 Jun 2021 12:06:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFAQG6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 1 Jun 2021 12:06:58 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBCDC061574
        for <linux-fbdev@vger.kernel.org>; Tue,  1 Jun 2021 09:05:17 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id j14so14915674wrq.5
        for <linux-fbdev@vger.kernel.org>; Tue, 01 Jun 2021 09:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=6hYvV1ZLP+xMrFDhtMUMFiYVGTkJ+UiqIQSVG/EohRE=;
        b=HLjN80P0ak7Jx9CtCQYucHtcNmJ6urFt2HolmpDzUZ2je8iVTeqGx8fQ1TOJrci8bv
         xHosrB8C2ihkl3nQJwyf/Qs+xfI33Eod1BG/RkgRt3CmFQRoYCg6qTNtKzpAdjKOiWmB
         kCfu9Jm3JAyBAi0QkbqJYy0h+f7jR698S8DrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=6hYvV1ZLP+xMrFDhtMUMFiYVGTkJ+UiqIQSVG/EohRE=;
        b=sg1n0gmRVdcFryHBZ5KHlWajSvIPycBJY5w9GSOeiCKRkFLMLbw5XsHkGamg28Yqx7
         1cyEuM/sXRI+jrLVJ1R5nmuu+ICWDz9tpTllclkI+N8O9wmc8MaQfkwli48WaBhFqq6b
         dNEj/kyVMhdJBheONavKCsGyLCiELS+5jIwJY3Epp7OsQcvszIKN6WRTutgQZ7rKQafO
         eNT8GUqYO2tKslo+oEXigTeeSeYU6X9mhUCbhmZQfK+40jFNqz6ARMO5O4HeAsAWVl1g
         fKw8dE3VS4W/5he9aeL1ZrOFLZvXPZ+Z/+mmU0nVjnHYgz6cH0tXJ1k1nT6CX88M2ob4
         tZgA==
X-Gm-Message-State: AOAM5305Fpx01jRL4/ea0wptgLMFJmP0N0xpYCesHMeyj2MN0Bf3fPA2
        NdSzs+AbzA1eVi5YQmNojb+AOw==
X-Google-Smtp-Source: ABdhPJzq2ewoSxbWvhQouYQM3hTC5PtMTjQisz0uB+MLFo9IL0F9rkkfvAdPT+tbNS77wjgurbim8g==
X-Received: by 2002:adf:e58d:: with SMTP id l13mr28459183wrm.369.1622563516048;
        Tue, 01 Jun 2021 09:05:16 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id d131sm3143120wmd.4.2021.06.01.09.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 09:05:15 -0700 (PDT)
Date:   Tue, 1 Jun 2021 18:05:13 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     lijian_8010a29@163.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lijian <lijian@yulong.com>
Subject: Re: [PATCH] video: fbdev: atyfb: mach64_cursor.c: deleted the
 repeated word
Message-ID: <YLZauT5Awwf3UlOw@phenom.ffwll.local>
Mail-Followup-To: lijian_8010a29@163.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijian <lijian@yulong.com>
References: <20210601012747.38884-1-lijian_8010a29@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601012747.38884-1-lijian_8010a29@163.com>
X-Operating-System: Linux phenom 5.10.32scarlett+ 
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jun 01, 2021 at 09:27:47AM +0800, lijian_8010a29@163.com wrote:
> From: lijian <lijian@yulong.com>
> 
> deleted the repeated word 'be' in the comments.
> 
> Signed-off-by: lijian <lijian@yulong.com>

Applied to drm-misc-next, thanks for your patch.
-Daniel

> ---
>  drivers/video/fbdev/aty/mach64_cursor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
> index b06fa6e42e6e..4ad0331a8c57 100644
> --- a/drivers/video/fbdev/aty/mach64_cursor.c
> +++ b/drivers/video/fbdev/aty/mach64_cursor.c
> @@ -46,7 +46,7 @@
>   * The Screen position of the top left corner of the displayed
>   * cursor is specificed by CURS_HORZ_VERT_POSN. Care must be taken
>   * when the cursor hot spot is not the top left corner and the
> - * physical cursor position becomes negative. It will be be displayed
> + * physical cursor position becomes negative. It will be displayed
>   * if either the horizontal or vertical cursor position is negative
>   *
>   * If x becomes negative the cursor manager must adjust the CURS_HORZ_OFFSET
> -- 
> 2.25.1
> 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
