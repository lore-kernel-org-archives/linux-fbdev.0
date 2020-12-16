Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B0C9C4361B
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Dec 2020 14:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A9DA2339F
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Dec 2020 14:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgLPOhB (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 16 Dec 2020 09:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725550AbgLPOhA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 16 Dec 2020 09:37:00 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C01C061794
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Dec 2020 06:36:20 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r7so23406782wrc.5
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Dec 2020 06:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1+xRvYA1pxFKx0XtDQ31iUMNpTfOzpYfWa3N+b1f36w=;
        b=D9tZo391U+Yk9iuy7EGvkpos9GG2gaP6lh8G8kbYcZbhPLW/ucCrLf5oSkYvVz4jUC
         kMqFUxBTvQCoj3KkuS6V35VGK9KegHusQzeK/hJ5FgEbt6klGf6JYtJ87MA0cuE8vPBP
         z8l0pVPZx/rNU6cfqxJIHMGSCWMAt4kScBC7o59D/2QzFJ7BPLD+jqxiTEIu6flAkXi5
         o6ilk+OtnZ58GRjv3g4aexcHpEoZ7S5WZ56bCKpMVHoCkBGWMhiVGT7U9Q2Mon1Bp0WB
         Fqn4DXcKrjIiKuamW7vmZ0GpkHkyHYFMsDvYschETw0d9ilE1GSKbSyBlhkmqaidaZbu
         h6YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1+xRvYA1pxFKx0XtDQ31iUMNpTfOzpYfWa3N+b1f36w=;
        b=RZZRC+pjvpTSvdYlzdWAQ4nSjB7Kbz3vjAD/+NmI5eIiXPNV8OALyhmybjpslsjGjr
         jnac1HeBjiY6pjMk0VbewL9MVUtdmNZUWLusd9y9Ejq/6GVjp+oYlyHD2tZ6KqQfcQOl
         HEMgN1iWcCZRs/xMrIIrMXvh02hiWh9YoDGyQaKLlQz1Mh+dL+x+hbG4frbQYd09ay3Z
         hBfRhoI/63oK4xSornR/Ie+I/ROZETNhmsbKn79nsKXn1aG9+qZhuz/Z2ItIhLyFFjje
         nwpKlNJmx7/YGx2A1QSeXNOAIbwidsW/+iNmzfd4raTV23FatmUFNj0UtUhQxqYmikqF
         MJoA==
X-Gm-Message-State: AOAM531zUfVfn68qEcZ5bDLkIwAYRZjOaQg8Jo+4qwXmu2rPfjXlFG8B
        AiW89BIg+2oqb/ZO21TG1MuiCg==
X-Google-Smtp-Source: ABdhPJylSqFMc/S45ragP2Y9ol6Qr2fab8KKBxJIm8g8W2JghL0Rj2OlBZ6f2z6RYm4SALaC6v22ig==
X-Received: by 2002:a5d:554e:: with SMTP id g14mr38990021wrw.264.1608129379055;
        Wed, 16 Dec 2020 06:36:19 -0800 (PST)
Received: from dell ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id h20sm3675336wrb.21.2020.12.16.06.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 06:36:18 -0800 (PST)
Date:   Wed, 16 Dec 2020 14:36:16 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Zheng Yongjun <zhengyongjun3@huawei.com>
Cc:     daniel.thompson@linaro.org, jingoohan1@gmail.com,
        b.zolnierkie@samsung.com, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] backlight: sky81452-backlight: convert comma to
 semicolon
Message-ID: <20201216143616.GF207743@dell>
References: <20201214133458.3729-1-zhengyongjun3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201214133458.3729-1-zhengyongjun3@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, 14 Dec 2020, Zheng Yongjun wrote:

> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Zheng Yongjun <zhengyongjun3@huawei.com>
> ---
>  drivers/video/backlight/sky81452-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
