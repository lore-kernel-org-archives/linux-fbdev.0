Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870A2C43219
	for <linux-fbdev@archiver.kernel.org>; Mon, 21 Nov 2022 10:15:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiKUKPC (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 21 Nov 2022 05:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiKUKPA (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 21 Nov 2022 05:15:00 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A8412D1D
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 02:14:57 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id cl5so19091920wrb.9
        for <linux-fbdev@vger.kernel.org>; Mon, 21 Nov 2022 02:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NGp51oyhKN+C50Ky2rZ8/aNL2masc43yeuijWFHSU50=;
        b=XMyAfQ+bFmr+L9mCWAV9dfC0veCnWGzc0V7vrySwfdBeZ60Nh8F5gd6xBn+1eq/48C
         aZRwSpXAzBrfjhd6ky9N3lf/3fXyd4uB7Ykv5pQkTo7PPymDJIz/4W3y3Qgng8BTe8yj
         iq3ejY6/vhiSUvBAytVyrS6WUEuTWVwexXNE5SxzRGFOQrfbQfOMrcfVg+ML4Cj56YN9
         fPm4mjyPyrNug1cRSPPWbCUFacgw56qlBflI36WcAnFD5wLD/diW3w0/sUxV9GZLQ7dj
         OhlbxuEXWxpC8JS+WPq2LhciT4zSyeRZOeN/4kctK2/m88aM2EO7UTmJM+hzIiicT/g4
         1gLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NGp51oyhKN+C50Ky2rZ8/aNL2masc43yeuijWFHSU50=;
        b=xEDALInlU6xVhoR8Pw2VZQGQGFgemTzHn+D+HITfrhA3wjRYAG+lOmYI3GqHZiI72k
         B31QDwNLFueu1FFPopn55o2EODrRz9jKrmSOAROvEODdA5nzaeeYtwtovupbiYGeZmUB
         6rFROY/vP5IbsrGB7JjOYSExsdIX+XcchxfFEcWzXSX6/BZXIpktWH0wMWLPxmBSjPLq
         95xvAqNSp9NgN7Hi259tKtjmZ5yqYcGixS2HM4qFTVqpp0NhC80wxYFVXu9w/ng98nN7
         KrLOq/ZJLYITOl2k8XFMHtuKs2WuXdR97Iu0QKun1ELf6GJbAaNtyzHKiCfJgCrumaCZ
         SiQQ==
X-Gm-Message-State: ANoB5pn0NgR1YdnfQ3Qa0cjY7r7wxtF05Z7hWirrlYi0u5dnXPYI/e6r
        Z4a5yckM1eZXP7N4+5vCqdQlSA==
X-Google-Smtp-Source: AA0mqf6LxOnj7sRCPNn925ZmqDMfzLYPjKnqzEIZoA74SSnSE80opEBz9sbIik28wWr5VNxELLyI3g==
X-Received: by 2002:a5d:538b:0:b0:241:c3c2:24cf with SMTP id d11-20020a5d538b000000b00241c3c224cfmr1960700wrv.587.1669025695580;
        Mon, 21 Nov 2022 02:14:55 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c4f1200b003c6f3f6675bsm19260536wmq.26.2022.11.21.02.14.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 02:14:55 -0800 (PST)
Date:   Mon, 21 Nov 2022 10:14:53 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <uwe@kleine-koenig.org>
Cc:     Angel Iglesias <ang.iglesiasg@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Grant Likely <grant.likely@linaro.org>,
        Wolfram Sang <wsa@kernel.org>, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-i2c@vger.kernel.org,
        kernel@pengutronix.de,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 586/606] backlight: adp8870: Convert to i2c's .probe_new()
Message-ID: <Y3tPnd6xKu1bAIEd@maple.lan>
References: <20221118224540.619276-1-uwe@kleine-koenig.org>
 <20221118224540.619276-587-uwe@kleine-koenig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221118224540.619276-587-uwe@kleine-koenig.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Nov 18, 2022 at 11:45:20PM +0100, Uwe Kleine-König wrote:
> From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
>
> .probe_new() doesn't get the i2c_device_id * parameter, so determine
> that explicitly in the probe function.
>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
