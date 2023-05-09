Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03155C77B7C
	for <linux-fbdev@archiver.kernel.org>; Tue,  9 May 2023 13:28:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235284AbjEIN1n (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 9 May 2023 09:27:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230060AbjEIN1m (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 9 May 2023 09:27:42 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CB8130D8
        for <linux-fbdev@vger.kernel.org>; Tue,  9 May 2023 06:27:39 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3063433fa66so3786468f8f.3
        for <linux-fbdev@vger.kernel.org>; Tue, 09 May 2023 06:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683638858; x=1686230858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YuQ2FBeCRoqgngylaRdOh7aqiqlvdZtnW5rbAbkcgXI=;
        b=AH1IzWoKD1GbxcF9ng7uQsTL872w02GkxK1Q77af/6B74iG8+N4tcxgxkyb7OF7cca
         Un3CHwFvJCOe9jANPaUvgVp3z6qPeSkMv78Q31nEc+DzNcFSqduVfxqpERiiTgbIxEiL
         uYMUNm2pcXy7AVAl7+aOS38etpxSM74rgG1X9Vn2TIAwXNuN0nU4CXYcCbL+WmYruQEi
         apXr7BQg6zkxzn3spKQUkefPlrDVExBq5LPRdpsYJdRwqgi+PMhrS6V0tRCETTl07OO5
         LrlqLsPxnoVZa2FKaXipGlrepsiGlXi0YGBODqPF6rQGfvwQW0ALnAAUm7XW8EftFs0Y
         qQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683638858; x=1686230858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YuQ2FBeCRoqgngylaRdOh7aqiqlvdZtnW5rbAbkcgXI=;
        b=Q6SNp+opQJngMGMuX+Tl8gk4DojfXeFz6xjlo5HcoClghKpVfi46t1qvaKwYzSgp0g
         TpNZgbs4hDWbhv52K/DixzZ2inGom/AHaQR8s1x6F7coLVrYxXQIPR3yUY7ba/gr+xXQ
         kaJ2HKDWlV7ZHpumEHYE9GxZpzUFIblX9Qx3ntj4w8Sv0RS0NOoIHBm3THOgOYj8Vo1m
         yHNzOzNcaaHV7ivz29M1ndXP7Kek1RLih5akfQpn1PLvPHMAe3cMN31VWm3/pOmaXIa6
         pJTr+MSDA33VVKG13UetssyyEAmkI4ypn4ccLkzR74Z4/tbfgURTVc+x7v4cvkdv0bAu
         jF+Q==
X-Gm-Message-State: AC+VfDxEaMVBzU/scsc8A9cqFI5RZVyPbuxISkcESujGKAwfrTralI9w
        LsbXdxZCstwmPfOp33mZXUBeDw==
X-Google-Smtp-Source: ACHHUZ60LQ2w7jDdb1KfIt1LYeUDMCEJrCrpzMKg5XLc7SVJ/RpGIRMx0wqXtIAXfShUhg+fn2JRHA==
X-Received: by 2002:adf:f491:0:b0:306:31b7:abe4 with SMTP id l17-20020adff491000000b0030631b7abe4mr11390420wro.14.1683638857874;
        Tue, 09 May 2023 06:27:37 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id d6-20020a056000114600b00306344eaebfsm14415375wrx.28.2023.05.09.06.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 06:27:37 -0700 (PDT)
Date:   Tue, 9 May 2023 14:27:35 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org,
        Maximilian Weigand <mweigand@mweigand.net>
Subject: Re: [PATCH v1] backlight: lm3630a: turn off both led strings when
 display is blank
Message-ID: <20230509132735.GA31274@aspen.lan>
References: <20230505185752.969476-1-mweigand2017@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505185752.969476-1-mweigand2017@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, May 05, 2023 at 08:57:52PM +0200, Maximilian Weigand wrote:
> From: Maximilian Weigand <mweigand@mweigand.net>
>
> Use display_is_blank() to determine if the led strings should be turned

Shouldn't this be backlight_is_blank()?


> off in the update_status() functions of both strings.

Once the description is fixed this is:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
