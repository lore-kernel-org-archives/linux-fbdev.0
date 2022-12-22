Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7892C001B2
	for <linux-fbdev@archiver.kernel.org>; Thu, 22 Dec 2022 08:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235060AbiLVIVg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 22 Dec 2022 03:21:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235001AbiLVIVf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 22 Dec 2022 03:21:35 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2379E
        for <linux-fbdev@vger.kernel.org>; Thu, 22 Dec 2022 00:21:34 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o6so1640029lfi.5
        for <linux-fbdev@vger.kernel.org>; Thu, 22 Dec 2022 00:21:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uAkQvA3Xh+SnjA47mehnFmJrTToVnvQtaeVXifEV6Rk=;
        b=RWoSYDbQMlbQ088uebiL+ygAsoUptTfvNBo/L9++PXhJBblh7qqCm3Pkse0QCPQZiL
         4AY+M34sAYZQ+4L7HQAqxkQKj5CMynrip2kJjQY2Cr8U325dXsQ5RecP7HhGinSFL6ed
         2HbQ0qRnU+tHTRl8ngGZWqVnWJtYco8xJyhFZEhmcrdHX5s3YrI+CNid2TP3zkK4Fjks
         IqT1xSblZ4pEegrPQeWidY3bCu1QW2QidkTFbdXFsns6KhABy42c38Up6mjlnRohFnqv
         VQ/CEnyafMBkl9DKHjnoYJnwXFA3HQW0GfGzTPaekHk2ZU2vAttm4pv6Tn2yEa7wKzlu
         CoLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uAkQvA3Xh+SnjA47mehnFmJrTToVnvQtaeVXifEV6Rk=;
        b=E8KLqp0mFoq6UZQ3uC7/BrJYdRzoNmXiAOP6ApKsbkgjW/RLA8z9LxGoRsVUlbCjUS
         pjkeFrMLaNBnHMF2dqFkGoBQLMrTRIL/d0JOjS9OO8/Bv+2G6du5Go1daReO+jh58fd9
         DX6ce6t29RdftsHuiK7vN8ZJTExS1an+63LLRjPgh7nJJm5Uw07KHz6OwmryKbPs6rub
         91c8vXCrX/bvV60pXQg27BGN1fEgMkrvnfzc6Y7b6eOWANgNRFEI8P6/b6d+51Hmcs74
         eoNJntlGh6J4zsxyN2VlvUERQ2CBsdKY+i7l7YrLyilEwfSG9so/AI5JdiBnVeZ+ZS8Q
         3Mrg==
X-Gm-Message-State: AFqh2krovMeoiDh8wdd81+JEj6urC9G2fCt81CIDsdkfryDwEKYj1/th
        jVhY6VEUGTVFzZQFQYCcp/jrfg==
X-Google-Smtp-Source: AMrXdXt37+6z3xr5biGtW60g1/enVSSlhcb6yauFfDNgy4Ip6QuFAVRlBq+qGgvqP00SOsqek4NptQ==
X-Received: by 2002:a19:f713:0:b0:4b6:bc3c:f457 with SMTP id z19-20020a19f713000000b004b6bc3cf457mr1272077lfe.34.1671697292821;
        Thu, 22 Dec 2022 00:21:32 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o9-20020a05651205c900b00497aa190523sm2110812lfo.248.2022.12.22.00.21.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Dec 2022 00:21:32 -0800 (PST)
Message-ID: <e2b0f5e2-8681-10e7-8924-a1bf5040f7d0@linaro.org>
Date:   Thu, 22 Dec 2022 09:21:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 2/2] dt-bindings: leds: backlight: Add Kinetic KTZ8866
 backlight
Content-Language: en-US
To:     Jianhua Lu <lujianhua000@gmail.com>, Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <20221221153154.25411-1-lujianhua000@gmail.com>
 <20221221153154.25411-2-lujianhua000@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221153154.25411-2-lujianhua000@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 21/12/2022 16:31, Jianhua Lu wrote:
> Add Kinetic KTZ8866 backlight binding documentation.
> 
> Signed-off-by: Jianhua Lu <lujianhua000@gmail.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

