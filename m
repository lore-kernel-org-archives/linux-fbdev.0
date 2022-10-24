Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E33C38A2D
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Oct 2022 14:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236984AbiJXO2X (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Oct 2022 10:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234230AbiJXO2D (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Oct 2022 10:28:03 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4397CE18
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 06:01:30 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id m6so5976499qkm.4
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Oct 2022 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jCf/CbS4Ausj2wROnS6QLzmSsY7Fi0KDJ3zpPb3SGg=;
        b=yu4kVbpm5sjk0uyt4msUmiPwRnrzBrJXb+CwnL0ouXq7SePn/9fuNsiT8GD/ZgWFo3
         s5wuqPemURjhAYSIXWus7S7zJvwzCVhFW8HxmS+rV2cvns4vh0SqP5YNpSc476dJq3yb
         O1ox6mBHf1L3Mo0TapJeZ5r4BaaQTv+isWor/WRcAIipbWgApmtmXI9SnRrdTVz0MpYO
         +TSEMmMcNfCeEThilOJuKy7nukBTcJIQzdGAXdGImsRU/GlXgfgKZ7vNTJgTTVE65fTn
         lzgDyaN7Yy1tZYeplEVIBBwUPj4mJQPZ9Fyr2KrmIqglcVBtuRWIth/7otDAREHjEDl7
         4kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jCf/CbS4Ausj2wROnS6QLzmSsY7Fi0KDJ3zpPb3SGg=;
        b=lobfDz4QR76oFFCaj5GpbvQZhAYqV7tsQpvCJZmusBmpppvHqTQJ45Echn0/gCNkHv
         xC/fSI/Ddbmd1Y80cyA62AazR+1V3uFbqZ9FwBB3po0eRvJdJYZaEwMmiyB63C/a2cnh
         XSL0PR09O/oS/01ah6633OHBalc1X63FSNM3mYgQzMKmhuUHg8aE58SPRYKiG2/Bg7gM
         nu1JeBOg7r+7XnYEVcXkWxoDtaBjNSyBHWaR/JnsKZ7oEHBOQZvczNyc+2JBVSSStzKu
         SZS0IiIRM/tQMpz58Vc0dlNwcrKLVP4Um9wqqfFh5vQ5cz/E9LTh1SnQIwUiS/gslmr1
         Hrug==
X-Gm-Message-State: ACrzQf1w3Abl5vQBCRPF5i6Pl02jbhsXPfRQP/u4EA6U3lFiOIW7T1I1
        GzvSLeMK3ErOt5Z4K8c8IiGlQHbCUhzu9w==
X-Google-Smtp-Source: AMsMyM6tONSqnQie2CAY0VCT9/nEJoh4N5yZ/U3fumf9Qa2VnwON/dPLBe2dz6LDv9JldmqkG/kjmw==
X-Received: by 2002:ac8:5e0a:0:b0:39a:2960:d4a6 with SMTP id h10-20020ac85e0a000000b0039a2960d4a6mr26907024qtx.448.1666615800669;
        Mon, 24 Oct 2022 05:50:00 -0700 (PDT)
Received: from [192.168.1.8] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id y13-20020a37f60d000000b006e2d087fd63sm14707240qkj.63.2022.10.24.05.49.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Oct 2022 05:50:00 -0700 (PDT)
Message-ID: <d3f9b680-9c37-4dca-8ab9-6a3375251f5a@linaro.org>
Date:   Mon, 24 Oct 2022 08:49:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 16/21] fbdev: remove s3c2410 framebuffer
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-samsung-soc@vger.kernel.org
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-16-arnd@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021203329.4143397-16-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 21/10/2022 16:27, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The s3c24xx platform was removed, so the framebuffer driver is no longer
> needed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

