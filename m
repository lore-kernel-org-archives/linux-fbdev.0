Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BDF8C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Nov 2021 13:19:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E836103B
	for <linux-fbdev@archiver.kernel.org>; Fri,  5 Nov 2021 13:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232705AbhKENVf (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 5 Nov 2021 09:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbhKENVe (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 5 Nov 2021 09:21:34 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA2DC061714
        for <linux-fbdev@vger.kernel.org>; Fri,  5 Nov 2021 06:18:55 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d27so13706387wrb.6
        for <linux-fbdev@vger.kernel.org>; Fri, 05 Nov 2021 06:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=7/iipoqAGtlWfjdTn7pIa/UV1IVALV2EMEK2Ldis3ok=;
        b=ifXSu3YxdOWGJi9BpmMWnOWrVxdbHBjFXP/MC6gBHwOfp/tRp602TJzZp83L8zi9gC
         4TIiZETw5Zfvmnlrgma13J0NB9/IY0RnIftxjY3qyORHJOa5ft2S1MDCKespwqBDHy5X
         2fSiRlliFxIdbfA/46iK/DBjX9P8+jmEVwNSbaw7U6MYM/0VZFN9X1l18+oV7is/ugE/
         Ldzd1ayvE5qOPCENJlcA2S9ktEb3FwxBlyvHejTgnGM5nsut7MW47QXuVPlY2SYQ5iaN
         EZ/N4vTS6X4oKsJhsaaQ1ItC5COwZR3Gc4xUwW9jGB+JnS8YzhUZ98BISrACH8u0YqK7
         74rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=7/iipoqAGtlWfjdTn7pIa/UV1IVALV2EMEK2Ldis3ok=;
        b=7g2a27sOr9WrQa2Is+Rng6LdEdxbjceLp8R76U88vand4HVS1s71ijgaz3Ex1FWyjp
         FNsAlZFhOe8pQdcY2DDrr6uLT8duTz0x7FHmxnIhVhXgntfN0Fka5EMwCT2MYq/v4AFX
         RfpySDoONv8ikCuXp4XLFdWlLo9Wm6Oo30L5pW+S1alTCt6PzhCDYN5j6ZLZ0GmRxyYO
         7T3ImqpptjyejK+2fOb8pomtfaD/kyQWuXiXK6n3wh1hrOXd6x0P1WDJN50ZSV9afrKj
         jilVaNjgNmuCtC7IoMOaYkSo7NROLE98QZM6pPWAiyi10o8k8p3sN2l6SOd1pRlSLPUA
         PvIA==
X-Gm-Message-State: AOAM5311yKZnL6pd1ZvCzWgE6/KVB7u0sCaHl0YtgR0ZUioNPcj8oGMS
        mcweMNJSpIvmeoD6Au9uqxpmAA==
X-Google-Smtp-Source: ABdhPJwQHnoAVNWxU1bfYrJ+W2Anf3+K6IUO09ZgJAtRW1a3a3m9FMJj2FO8krg/xKbG0Vzc18WZlg==
X-Received: by 2002:adf:f10d:: with SMTP id r13mr74756968wro.414.1636118333680;
        Fri, 05 Nov 2021 06:18:53 -0700 (PDT)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id o26sm11155063wmc.17.2021.11.05.06.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 06:18:53 -0700 (PDT)
Date:   Fri, 5 Nov 2021 13:18:51 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     =?utf-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        thierry.reding@gmail.com, u.kleine-koenig@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v6] backlight: lp855x: Switch to atomic PWM API
Message-ID: <20211105131851.6p2jmo54b4jts2mo@maple.lan>
References: <YYQfThRqabp4A7Dz@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YYQfThRqabp4A7Dz@fedora>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Nov 04, 2021 at 02:58:38PM -0300, Maíra Canal wrote:
> Remove legacy PWM interface (pwm_config, pwm_enable, pwm_disable) and
> replace it for the atomic PWM API.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
