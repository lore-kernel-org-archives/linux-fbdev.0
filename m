Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 634FBC3DA7A
	for <linux-fbdev@archiver.kernel.org>; Thu,  5 Jan 2023 14:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjAEOXu (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 5 Jan 2023 09:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjAEOX3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Thu, 5 Jan 2023 09:23:29 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0023B559C3
        for <linux-fbdev@vger.kernel.org>; Thu,  5 Jan 2023 06:23:26 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id t15so27418102wro.9
        for <linux-fbdev@vger.kernel.org>; Thu, 05 Jan 2023 06:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2O8qAtal3UIh6dVVxKSeZtPNmNVJVzzTrbBSvkVmU/4=;
        b=OnBXfld0yK17k8BzxzH6dsorYAl/PqiA2lMaWW8T656ZlzW8aUSwRpgLiNsGEwoMSf
         WgTvcrFyjbBEXdpoXNYNVqT5BJyH6MNlLEHJjzF0FN9Lt/AHWz7hirl1C0m2NMVOkCiX
         EwNGVSxmcxTRJwHiX1bM1sa8rV4rgJKt6y3h4muOSA0ghYIawn+Oxq8bOLTgU4iw4u83
         VBFWNF4EJsCQGQMO0K2n3RWeR4FGMyQz9v+pVapkRfwXc46yjeBfPKvPe/HNhPCz9tok
         d4UcHzX623NtPkDCjzr9ePPPSFiSjxKCUMJOAysfFjy3trEa2EmqAmU08hGxUvlTKgYF
         ODXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2O8qAtal3UIh6dVVxKSeZtPNmNVJVzzTrbBSvkVmU/4=;
        b=cSElXS0GYPArRBf5qjVxAgTJH3NyBPOVT1daaKWgO1W0alIEOffdJ2z8U5NndL25Sa
         LiPUz/sKjIZ+ZDFOzSiR8nYT09IuKciHcBKuGwFi/2dPcDTYKus6m+0xY1iVIKPTh/pY
         4v4hdnNthq/ISHat/afpLBzRKSXdb2nKEBj+wD6RiME/F94YWJ3ymzR5ci6x2k0eGt4E
         6rcr5hrYZ7s1YW2oZcNfRMtcQs6ZX/i1EUnb/q9WGWG8Noj4OyFIb5u71mLSFekF8QXX
         iSTg9etVvyg3yGU0ArK+5UYr5NVJFCcF4WLIosWBYVBxdroL2fsdTuSqkEk9/XcLNI++
         4VZw==
X-Gm-Message-State: AFqh2kow5LeA5SsH5zC/MggV8Xn4t8K8UCS7c6CBEAdMTKQrmBfaUSiI
        zNzFg3GestVQugL1jjUGEpn2vg==
X-Google-Smtp-Source: AMrXdXuKaNUVjrQTANx/S3IuaYZuFDw62Vq63XtmQR6uWzRVkHezN/Wl0vZekaskc5e/xo+44czkqw==
X-Received: by 2002:adf:e307:0:b0:2b6:8a41:a949 with SMTP id b7-20020adfe307000000b002b68a41a949mr721487wrj.46.1672928605403;
        Thu, 05 Jan 2023 06:23:25 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h7-20020a5d4307000000b002a64e575b4esm3922790wrq.47.2023.01.05.06.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 06:23:24 -0800 (PST)
Date:   Thu, 5 Jan 2023 14:23:23 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 09/27] backlight: remove pxa tosa support
Message-ID: <Y7bdW4maNBCZinLz@aspen.lan>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105134622.254560-10-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 05, 2023 at 02:46:04PM +0100, Arnd Bergmann wrote:
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

OK by me ;-).

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
