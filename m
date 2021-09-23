Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41AD7C433EF
	for <linux-fbdev@archiver.kernel.org>; Thu, 23 Sep 2021 13:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D3B60F24
	for <linux-fbdev@archiver.kernel.org>; Thu, 23 Sep 2021 13:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241247AbhIWNpF (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 23 Sep 2021 09:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239161AbhIWNpD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 23 Sep 2021 09:45:03 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819A1C061574
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Sep 2021 06:43:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so17392991wrb.3
        for <linux-fbdev@vger.kernel.org>; Thu, 23 Sep 2021 06:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=4vvUL3e0KnaoXbHygff1j5G+RP+eVvUFadYzHbYM5yg=;
        b=bJ/9dqxYZ+yDeJTQt2kNS4H2m8IPsSvr9qIFTk33V/6+ygT7/5ahVdLEEZZSShC60o
         MiOTpF9eTEClXfv+gm+DVrZ0z+iec6EG+gat7i0Pq0zMXe54QqEzadUAZpOxEV9nqCOu
         gHIQ0ZGhiDk5ccIVm07xCff/D6+VdOO2mBmy7KHNqBcXdnHEk0HhkUyH+MgTJGhBcSOU
         hX/HkVPy1WmOzUtMSV8N1MdYMMEfYPQhqvXj0BJMBRU91ov0UAkO20oemTFKzBw0UhvV
         CctiqQi+Pr4MKa4Nq3NFkHA+ozl5LK8uqW4szRAzXmP2B44jyAurEvNnQvsbpmnGZnoi
         MzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=4vvUL3e0KnaoXbHygff1j5G+RP+eVvUFadYzHbYM5yg=;
        b=A+aJShq++Y/486tmJfwzCEdQzRyKR4VfBKBr7PCrDdERFBgKn2+u4kLPbMAMwGmxN9
         JhdzosDOCXQQACS8fvAQTsuAydpjqbXKHXkuYoIbTtTWBiKWiXQkAaGBe8XwqVcJYkF9
         /T1+Qp5cbFSmvg/tGQzvM13rjwGeRpQ/PhscJptodGHOB6mzYOjX0hKvn3B8Kz3l45AK
         dyWVP8zTVdIh6pITUfat02t0zuU92jMU3owh+XNNHDTjc71BRhOT60x7Eeyhcrnaa0VC
         xA/bsA6YYudzBu5QV9qiorO1E329IteuzH2q26u5stBXTnIik+KabZW2/nTK/SHHVcvA
         NuSw==
X-Gm-Message-State: AOAM532erwfEobdVWxEvHJaizFLr9erCnczqxxn2hJ85lSeM2Xckwaj3
        /rsoShuZgwS8cmLjBsLppF9mZ8D9MPd2FA==
X-Google-Smtp-Source: ABdhPJyi3UZLScn4v2Ctypt2vtJmPaKpW9SI96CZeGRqpPXO1oNgQczRmKbml0MnljOLuNSCK8caQA==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr5145969wrt.57.1632404607073;
        Thu, 23 Sep 2021 06:43:27 -0700 (PDT)
Received: from google.com ([95.148.6.233])
        by smtp.gmail.com with ESMTPSA id a3sm5435583wrt.28.2021.09.23.06.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 06:43:26 -0700 (PDT)
Date:   Thu, 23 Sep 2021 14:43:24 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] backlight: propagate errors from get_brightness()
Message-ID: <YUyEfDJZT0hr5nI4@google.com>
References: <20210907124751.6404-1-linux@weissschuh.net>
 <YUxNczBccLQeQGA5@google.com>
 <4bb3051e-2550-43c3-afed-d4b00850126e@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4bb3051e-2550-43c3-afed-d4b00850126e@t-8ch.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, 23 Sep 2021, Thomas Weißschuh wrote:

> On 2021-09-23T10:48+0100, Lee Jones wrote:
> > On Tue, 07 Sep 2021, Thomas Weißschuh wrote:
> > 
> > > backlight.h documents "struct backlight_ops->get_brightness()" to return
> > > a negative errno on failure.
> > > So far these errors have not been handled in the backlight core.
> > > This leads to negative values being exposed through sysfs although only
> > > positive values are documented to be reported.
> > > 
> > > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > > ---
> > > 
> > > v1: https://lore.kernel.org/dri-devel/20210906215525.15418-1-linux@weissschuh.net/
> > > 
> > > v1 -> v2:
> > > * use dev_err() instead of dev_warn() (Daniel Thompson)
> > > * Finish logging format string with newline (Daniel Thompson)
> > > * Log errno via dedicated error pointer format (Daniel Thompson)
> > > 
> > >  drivers/video/backlight/backlight.c | 22 +++++++++++++++++-----
> > >  1 file changed, 17 insertions(+), 5 deletions(-)
> > 
> > Applied, thanks.
> 
> Hi Lee,
> 
> thanks!
> 
> Also I'm sorry about my nagging before.

No worries.

> I was not aware you were on vacation and saw you respond to other mails.

They were in the queue before this one.

I had hundreds of emails to get through on my return!

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
