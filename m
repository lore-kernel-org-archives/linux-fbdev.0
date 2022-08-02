Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33ABBC25B06
	for <linux-fbdev@archiver.kernel.org>; Tue,  2 Aug 2022 08:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiHBIA6 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 2 Aug 2022 04:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236254AbiHBIA4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 2 Aug 2022 04:00:56 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094FCCE13
        for <linux-fbdev@vger.kernel.org>; Tue,  2 Aug 2022 01:00:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y23so4446425ljh.12
        for <linux-fbdev@vger.kernel.org>; Tue, 02 Aug 2022 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Qp/fom4yzLGREQ6eeR8li3mYbaq2TiER/tBpXxkXygo=;
        b=TFKlaysWDIVNTrpIejCvdZ3ShsEZpGjK197WnOqTVDguDiHpHDaSiYtLkMZnv5nWVL
         Y4HNIrLz/rrChsreSuiWgemQ3g80PyFtDxrfZiE1E8sapn0v7ZIR5BzlDcJLmpMqqwT1
         wX++pYFLpakjvWeQhddWl3cAY9KW1symUlX6F6umXqO+4JZ3J8WmsgFz1JnpbIySrFgC
         DYlNBb8kW3xD+a/p7M+eAjUxNgc6Jhs/CzaA30VuYoKvl3k8wpnknxRdQjaIxDqRSMB2
         pAdELhDbrTvIN9g0syFGrU4L5TFeE8HeXYDIatMLL9ahGlsDrC5IHf6wi4UgNJP54G6P
         C2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Qp/fom4yzLGREQ6eeR8li3mYbaq2TiER/tBpXxkXygo=;
        b=4RKKkk8YlCr4CxFreqO2BSB1hMuj2CQSnarSDsyeDvKoAaTpSTQOyw3RIVjxgrfIeO
         S6FdNmYcVy1wnUtM6Xd2EUpjDZc90/1RERQAXD5ItFiuTGtovvTnlifaOSmAuoE7gssh
         v1Mciff2f14gpavht0DxcjaYzope8LdpdSXvrjWAOgkOo0I0lKgjd5WNZd2LbgTi617t
         w8fCikmlgb9G9Nyn/SiCw5qAXeZvo7pthdsDtrCOUgzJYETvR0kJnIbka+ZopjE4HNXx
         ByaNmGSC/QVb3m1KUsU7d3Gc3nUCTrVJd3f8lQBsxDADACRn4/48h3//GkXKQySan1k4
         QwSg==
X-Gm-Message-State: AJIora+q4DoGwpL5oz7uY5dSBSzV3eSVbPkDF0X425Fue0YhwScYbCUM
        9T4Jc4ydfslEbMb+zWeOqIimqg==
X-Google-Smtp-Source: AGRyM1tLMTHtWy8rLH1qccJY+573kjD3/apdLT7hUWRIsx3cmqkIWPYfI8rcWCVwsyah4kPGJxNplg==
X-Received: by 2002:a2e:a812:0:b0:25d:d922:d with SMTP id l18-20020a2ea812000000b0025dd922000dmr5895793ljq.181.1659427253194;
        Tue, 02 Aug 2022 01:00:53 -0700 (PDT)
Received: from [192.168.1.6] ([213.161.169.44])
        by smtp.gmail.com with ESMTPSA id v2-20020a2e2f02000000b0025deba4d9f1sm1818669ljv.86.2022.08.02.01.00.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 01:00:52 -0700 (PDT)
Message-ID: <426b98b9-95a0-eb5e-7f68-fbe1e45b4740@linaro.org>
Date:   Tue, 2 Aug 2022 10:00:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 00/10] dt-bindings: iio: use spi-peripheral-props.yaml
Content-Language: en-US
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Puranjay Mohan <puranjay12@gmail.com>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Alexandru Tachici <alexandru.tachici@analog.com>,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Tomislav Denis <tomislav.denis@avl.com>,
        Oleksij Rempel <linux@rempel-privat.de>, kernel@pengutronix.de,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Ricardo Ribalda <ribalda@kernel.org>,
        Dragos Bogdan <dragos.bogdan@analog.com>,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Stefan Popa <stefan.popa@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Melin <tomas.melin@vaisala.com>,
        Sean Nyekjaer <sean@geanix.com>,
        Beniamin Bia <beniamin.bia@analog.com>,
        Patrick Vasseur <patrick.vasseur@c-s.fr>,
        Charles-Antoine Couret <charles-antoine.couret@essensium.com>,
        Vladimir Barinov <vladimir.barinov@cogentembedded.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Philippe Reynes <tremyfr@yahoo.fr>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexandru Lazar <alazar@startmail.com>,
        Oskar Andero <oskar.andero@gmail.com>,
        =?UTF-8?Q?M=c3=a5rten_Lindahl?= <martenli@axis.com>,
        Bogdan Pricop <bogdan.pricop@emutex.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Dan Murphy <dmurphy@ti.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Phil Reid <preid@electromag.com.au>,
        Michael Welling <mwelling@ieee.org>,
        Robert Jones <rjones@gateworks.com>,
        Chris Coffey <cmc@babblebit.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Sankar Velliangiri <navin@linumiz.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
References: <20220727164646.387541-1-krzysztof.kozlowski@linaro.org>
 <20220730224643.GB11662@wunner.de>
 <bd829586-f052-03c3-aa68-e5a2be84b6bb@linaro.org>
 <20220801160410.GA6059@wunner.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220801160410.GA6059@wunner.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 01/08/2022 18:04, Lukas Wunner wrote:
> On Mon, Aug 01, 2022 at 05:45:07PM +0200, Krzysztof Kozlowski wrote:
>> On 31/07/2022 00:46, Lukas Wunner wrote:
>>> On Wed, Jul 27, 2022 at 06:46:36PM +0200, Krzysztof Kozlowski wrote:
>>>>  78 files changed, 324 insertions(+), 249 deletions(-)
>>>
>>> Pardon me for being dense, but what is the benefit of this series
>>> that justifies inflating the schema definitions by a total of 75 lines?
>>
>> The commits were explaining rationale, so let me bring it here. The
>> benefits are:
>> This allows using all properties typical for SPI-connected devices, even
>> these which device bindings author did not tried yet.
> 
> How do you know these untested properties work with the devices to which
> you're adding them?

These properties should be device independent and instead
controller-dependent. At least some of them (that's why CPHA/CPOL was
moved away and maybe the same we need to do with spi-3wire, spi-cs-high,
spi-lsb-first).

My approach here is no different than other subsystems. Take a look at
regulator - we allow all regulator.yaml properties, even though several
are not applicable (e.g. current for voltage regulators) and for sure no
tested.

Best regards,
Krzysztof
