Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C12AC05027
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Jan 2023 15:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjATPEy (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Jan 2023 10:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231305AbjATPEv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Jan 2023 10:04:51 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998ADDA129
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jan 2023 07:04:43 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h16so5086746wrz.12
        for <linux-fbdev@vger.kernel.org>; Fri, 20 Jan 2023 07:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uM/AZbTE0N3wZ9K7Id9185G9SFTYGVUQ4zyUZJh9c2w=;
        b=CMZNxqXQ9bGvQVB4/W/6bW3PRwNIRC70HtD6CJVTdSa9HMXFonB3kv/2HjpA3yAJYZ
         2Eej0Hg0oKuHk7A7GvhK911K0PUvz6QcPBrxWwUzAmK1zU7vF8JS0A4dTmjdTVo0WLxz
         bMao64u/Dkp3wTuQpMD898RVrGzo2AYyEll6Yg1fjU1Sm6o2M6W7181K66UiYEufB089
         I3SjVlGJ+o3k1ujThb7R7A+ZvC7uYm3vOdHlq+Y68eAhAkRjQpnzCpU5sfCZZw5P84OY
         yxBmT1RS1Kv5Ywa4oW1Hg9Y95w9I2ZogmB+44X6Gf6eVa/FkQW+I3vOT+PNh6u8GpUMe
         hLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uM/AZbTE0N3wZ9K7Id9185G9SFTYGVUQ4zyUZJh9c2w=;
        b=pPcalN8aU6mPjq7jkuZbn8zrC2na3quE66TH8CndskSVWIKtg3Ndgx5RxaIMgSoqJy
         lQD2ghCM9jkiIkf+t30pSHwUpuGl5PFH2EF2rxO0KMynD112vIyXx5F4oXHE5z1G7swG
         803aS5hcjCMtppq1y7N4qi7YZ9LxGCPyJW0Gjf13zEWy5vZ6KA1vjTHenjrX9kyArayK
         gRbJzUw6xBMBC5o4XrYCxLLs5JuynZmV9Gc+wRm3Wf+0fMPf6oJXIxkyiR69ee4dHf3O
         /J/IU3V1EIAr3zxMzpkA1ymOV0MKwd1O55Bkgdd6e8U7dCdEKqYnUdRALcjtxNKDHgcC
         XFVQ==
X-Gm-Message-State: AFqh2kpjfGhZIMv3Mp+jKGqwo2rTLsDjpQNnZER37kh7p7am3UvBcKZZ
        ScrjgmgnUUOvk19rD0gpHsIktg==
X-Google-Smtp-Source: AMrXdXsPQxYA6ZUOJLdOPKyWDyB3wvLu9sSjvk0brOwg0HIxvtJpTyjbgqStno4YTK6idzKQeiT5Sw==
X-Received: by 2002:a5d:5190:0:b0:2bd:fde4:885c with SMTP id k16-20020a5d5190000000b002bdfde4885cmr12005062wrv.63.1674227081607;
        Fri, 20 Jan 2023 07:04:41 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j15-20020adfd20f000000b002be2a4b521fsm8858850wrh.45.2023.01.20.07.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jan 2023 07:04:40 -0800 (PST)
Date:   Fri, 20 Jan 2023 15:04:38 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-pwm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 2/2] backlight: pwm_bl: Don't rely on a disabled PWM
 emiting inactive state
Message-ID: <Y8qthjHiCTO3OK/R@aspen.lan>
References: <20230120120018.161103-1-u.kleine-koenig@pengutronix.de>
 <20230120120018.161103-3-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230120120018.161103-3-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 20, 2023 at 01:00:18PM +0100, Uwe Kleine-König wrote:
> Most but not all PWMs drive the PWM pin to its inactive state when
> disabled. However if there is no enable_gpio and no regulator the PWM
> must drive the inactive state to actually disable the backlight.
>
> So keep the PWM on in this case.
>
> Note that to determine if there is a regulator some effort is required
> because it might happen that there isn't actually one but the regulator
> core gave us a dummy. (A nice side effect is that this makes the
> regulator actually optional even on fully constrained systems.)
>
> This fixes backlight disabling e.g. on i.MX6 when an inverted PWM is
> used.
>
> Hint for the future: If this change results in a regression, the bug is
> in the lowlevel PWM driver.

:-)


> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Thanks for the changes. Looks good:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
