Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147ECC43334
	for <linux-fbdev@archiver.kernel.org>; Mon,  4 Jul 2022 09:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiGDJE6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 4 Jul 2022 05:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233219AbiGDJE6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 4 Jul 2022 05:04:58 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7550BC27
        for <linux-fbdev@vger.kernel.org>; Mon,  4 Jul 2022 02:04:56 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id x3so14692854lfd.2
        for <linux-fbdev@vger.kernel.org>; Mon, 04 Jul 2022 02:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n4B9YLkKJASUbF6SDeFOUfEsE0vnt4+YdnmVDhP06z4=;
        b=PYvq706wWC49R4jolMknaPmpRLaoYvxAwS/yrvpFklnZZejweFemyL+imVd3ZQHAkf
         2/oXHaA9SGkarCtUTpJuT3rbr6E8/ZVClvuR1xBNSKo+a8wG5DTug1kwbGjWuOCBcI70
         dWGUwdFSDfUGxCvJG/zPrfbQm+BbCyObhS6xtSNndCwmGipu6Cfuvu+r8eMks7OKGo0b
         2YzZ/37v4uOxttWU2JFcYvY4M9Qr68hL1wTP8MZfoSjc1J2+2NJTNQry+5XTQR6atCko
         dT/Z9yNTRRG/tHVo63yXJDe5gp8/LH7Off+y7xl7ruy7e2ZiSNNwjEwSUYfXcOFTMnzE
         rrgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n4B9YLkKJASUbF6SDeFOUfEsE0vnt4+YdnmVDhP06z4=;
        b=SV6BVZL+9XrQYjNIxU+bDJuoBduF+hY51WusXw0o1+A+uIueimOtg86odfGXxnvZjX
         Gv1AuBHoUexQSdtm892ah6sQZmDQo/rYtixrMsmKuHTTpX4GfvJ7nkY+amDnfijPvhSl
         yzJTRvkqaRpi3jp2hKu4BQNQKQcdj8Fo2POJ8jyuwuZGqe80a4X9tyR2GFsKHty7Tw6J
         OM+ZJISeu5rDJhpUCm48MjzqBnC8sr37Oa0XCduZtlfVcYX2SmN3bAAFwLnzPKlY9e6O
         3V8PjDxeWHShdDLqakWLId2l2mefMH8P1ZkLKYJKK2R19JgWvXVr4XrzLsFZzTGiZS2O
         UCHA==
X-Gm-Message-State: AJIora9dodd5uht1AR4LzmY5UX3DzX6kXL5w8p+kZw7ocVbuEUtNs7U4
        izJxgNMQWwJO6mpUWHqzQiwTig==
X-Google-Smtp-Source: AGRyM1sLHkpEL/e3FbHHjgOt2aInxHNlxFrHeEIa0L1/Bz4GYdHDD1jIwPyFeJeq+08viN1qBJk27g==
X-Received: by 2002:a05:6512:acb:b0:481:cce:3c22 with SMTP id n11-20020a0565120acb00b004810cce3c22mr17601128lfu.45.1656925495041;
        Mon, 04 Jul 2022 02:04:55 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id 8-20020ac25f08000000b0047863382e3dsm5024155lfq.215.2022.07.04.02.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 02:04:54 -0700 (PDT)
Message-ID: <4513594b-ece6-a4c2-82ba-d334f5c4234b@linaro.org>
Date:   Mon, 4 Jul 2022 11:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4 02/13] dt-bindings: power: supply: Add Mediatek MT6370
 Charger
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, lee.jones@linaro.org,
        daniel.thompson@linaro.org, jingoohan1@gmail.com, pavel@ucw.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
References: <20220704053901.728-1-peterwu.pub@gmail.com>
 <20220704053901.728-3-peterwu.pub@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220704053901.728-3-peterwu.pub@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 04/07/2022 07:38, ChiaEn Wu wrote:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Add Mediatek MT6370 Charger binding documentation.
> 
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
