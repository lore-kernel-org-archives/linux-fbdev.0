Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D922DEB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jun 2023 14:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjFZOjv (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jun 2023 10:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjFZOjo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jun 2023 10:39:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63A6010C8
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Jun 2023 07:39:42 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-313f3a6db22so896483f8f.3
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Jun 2023 07:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687790381; x=1690382381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GbmG/0Wb9nQ6z/PJEyshEPOBYP8Ve8ZuPqHoAlT0PBU=;
        b=v+xGmGJ0qIKRU0aurzhYHzIhjNpseb32nFxtt0cVXyZgxRKLexvjA1I7WRCD30AJL5
         Eh+qbIjAP4NQcnlNR1I/NzBsJKqid+podoDPCDocJl+LEfk/pJHXsu1L4EtQQNKsx5dP
         fef50DtyMYVYCyHso5OggdKwQmH6wr7etq++Nio8hL9QiYjg2gVJtWMqiO7yErYgevzf
         8IKienQinE4jICssw7dY926yyBUebZc/1seLsWOtDpNlnlmAc6/i5uAzbdv+jtLbsHnA
         hNiVcwkKf/6G4yupLdqBQJX93vw8ruAa85Bj++UM8ySsTwFkZPPROGk10fcd/nOaXpWw
         /H4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687790381; x=1690382381;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GbmG/0Wb9nQ6z/PJEyshEPOBYP8Ve8ZuPqHoAlT0PBU=;
        b=OZhmNzLNPYvwg/XyDmXfopgQW5p42cmKVUSACOxRL0KKtsR7tN0+Q5dBnFc6zZka4N
         X+ClgWK36+SGDFWd+6W0hZG4R9pqEcNmvTv6lKu9E/TaDVBJ2KTrPBy/gL/Kb7t2+6/n
         OmWc/uqp8PIYvdiOi2zgAJF7lqzC4hj8CMrzrhyOPSFDq3O9ubGqaQBvrWHtLEAfeQEY
         QRPCFas068zPhCsWzwBhCkqE2CvR6qjQupzow2gfKfulMySWAj8jo0EjmI8uJXZHb7fQ
         dBMOrxLloVLs6M9Sjcff55p6syDFkR1ZGGWWMMV5RhVM/2xqEV2ioUFDUiWJz+zrgzRU
         5spQ==
X-Gm-Message-State: AC+VfDyPXANiti7lkbxiUENvV9Rm3IhGzDpHbRdxZEG2ASkpCN/zBNKr
        pZpH5p/5xdHwTgSrZK7Fi/60hA==
X-Google-Smtp-Source: ACHHUZ5u0xLo84AQuU8IWtL8/XKYwsSCcaLqPaN0OzwE1PROPfhND29UAU7NVe45aBYE+KDJ8dq3Jw==
X-Received: by 2002:a5d:4250:0:b0:311:170e:8d with SMTP id s16-20020a5d4250000000b00311170e008dmr23526468wrr.26.1687790380687;
        Mon, 26 Jun 2023 07:39:40 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id u14-20020adfdb8e000000b003112ab916cdsm7675793wri.73.2023.06.26.07.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 07:39:40 -0700 (PDT)
Date:   Mon, 26 Jun 2023 15:39:38 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Maximilian Weigand <mweigand2017@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Maximilian Weigand <mweigand@mweigand.net>
Subject: Re: [PATCH 1/3] backlight: lm3630a: add support for changing the
 boost frequency
Message-ID: <20230626143938.GC95170@aspen.lan>
References: <20230602-lm3630a_boost_frequency-v1-0-076472036d1a@mweigand.net>
 <20230602-lm3630a_boost_frequency-v1-1-076472036d1a@mweigand.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602-lm3630a_boost_frequency-v1-1-076472036d1a@mweigand.net>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Jun 14, 2023 at 09:08:52PM +0200, Maximilian Weigand wrote:
> From: Maximilian Weigand <mweigand@mweigand.net>
>
> The led driver supports changing the switching frequency of the boost
> converter by two means: the base switching frequency can be changed from
> 500 kHz to 1 MHz, and a frequency shift can be activated, leading to
> switching frequencies of 560 kHz or 1.12 Mhz, respectively.
>
> Add this functionality to the led driver by introducing two dts entries
> that control the boost frequency (500 kHz by default) and the frequency
> shift (no shift by default).
>
> Signed-off-by: Maximilian Weigand <mweigand@mweigand.net>

Driver changes look ok (or at least will be when the DT bindings are
finalized).

However... I think patches 1 and 2 of this series are in the wrong
order. See #5 in
https://docs.kernel.org/devicetree/bindings/submitting-patches.html
for details.


Daniel.
