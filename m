Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BB0C05027
	for <linux-fbdev@archiver.kernel.org>; Fri, 20 Jan 2023 14:00:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbjATOAl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 20 Jan 2023 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjATOAk (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 20 Jan 2023 09:00:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C926AC13F5;
        Fri, 20 Jan 2023 06:00:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A78061F73;
        Fri, 20 Jan 2023 14:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ADF2C433A0;
        Fri, 20 Jan 2023 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674223238;
        bh=ORrJE8vOco1eLw2jztPBELhptUUuXdkDMpLsQBHBOiY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P726KZlsuKXFXkFmDMRZtbhZTqgBevjzH5e1y1uThnsNMEjOmjRa1tHauvJgQX9Es
         zV5b7lwXSFeztnsXwpZpC8oC2iW6Tb3N9sO33NMmgjtZETct3I+l/mjmGgqsr+piku
         KbzA36OZFQzwGtIQ9AkvMEFiTq+Fa5HkqjbgYvwqKOyH85thDsAmwx4hlt43fEU1ik
         rEG6ujm3PPniijsgEdTI9FNZejcSUjzSyOO40vWT78K6+Jh2mn1LBzJeRCN6NIibOx
         IkJM/cCUOY+RDFRVN1k01ybr1tREBxougZ7juPfDGTJ2aBowBfO/+ULeEDHryTo7Im
         j/KoxZulm3HtQ==
Date:   Fri, 20 Jan 2023 14:00:32 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 09/27] backlight: remove pxa tosa support
Message-ID: <Y8qegC966dxF7cE7@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134622.254560-10-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 05 Jan 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The PXA tosa machine was removed, so this backlight driver is no
> longer needed.
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: linux-fbdev@vger.kernel.org (open list:FRAMEBUFFER LAYER)
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/video/backlight/Kconfig    |  14 --
>  drivers/video/backlight/Makefile   |   2 -
>  drivers/video/backlight/tosa_bl.c  | 172 -----------------
>  drivers/video/backlight/tosa_bl.h  |   8 -
>  drivers/video/backlight/tosa_lcd.c | 284 -----------------------------
>  5 files changed, 480 deletions(-)
>  delete mode 100644 drivers/video/backlight/tosa_bl.c
>  delete mode 100644 drivers/video/backlight/tosa_bl.h
>  delete mode 100644 drivers/video/backlight/tosa_lcd.c

Applied, thanks

-- 
Lee Jones [李琼斯]
