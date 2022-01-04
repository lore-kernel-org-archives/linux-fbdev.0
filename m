Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E47EC433FE
	for <linux-fbdev@archiver.kernel.org>; Tue,  4 Jan 2022 14:20:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbiADOUt (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 4 Jan 2022 09:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiADOUs (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Tue, 4 Jan 2022 09:20:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3432FC061761
        for <linux-fbdev@vger.kernel.org>; Tue,  4 Jan 2022 06:20:48 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so76507697wra.6
        for <linux-fbdev@vger.kernel.org>; Tue, 04 Jan 2022 06:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WeeQCilTFNE7Nh007wpxMFboWE5lVX/qeHUt4Da2x6c=;
        b=KJiosB/89hqKX7GXGJC0SgqE7yLt3BnJ+gWDCoQ3Eh7n9pW11tyn5I2ygUov09Z4f+
         HvyzWkpUTZk89/jv9FhjAUHp0240JCKYZFML/yqGzz6seu2ob65gpk4jgkpE58p3PZ0X
         nU5NcJ7+8cBv9X94p+fp6GJcNwqzkuMbzi0l30NMfvWEIB3lRIImEP5SgZD9rSfBacbU
         64+XimNRphqL/JQ20UagMgU+h5dzPH+Ci+EicYq942IgGs2nkxiqWhvfxX18q58SoUw1
         lweURD7cElEXdJt+auTId7ok7ZlHT7jwiRNnrm08gJWgcsJsYDTjxUngOVm/ulV1KZIX
         OWxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WeeQCilTFNE7Nh007wpxMFboWE5lVX/qeHUt4Da2x6c=;
        b=avF/NMqLCYsP+icBKWPSHDz/IQADJyyNfx/8OEXXZXMQYhJHqqn3dBSBUBADJp8GSi
         ccDDhhu+tYq3mCBq5e7l8rAW9MmX7+DDjgu4yC5W7FGVR6J4oMpy5X3rX0TbLGiZCXd4
         S9cyHXydK9Z6K5ArvoFsU4028vXsgMlUD0L7pl/RrAoV0+N7ftSOYL59OIEtcyz35Pi3
         47RaMGiQjJjspJQO5mUT3Af/LAyqxl+lUQH3mopXTkNK1Z/ZHD0IUyg4+NUkyR1Fz0e4
         p1eqWlwB0ncJgGcX/PJXSHJA8njTtxgoo3AMQbwJaaysMUqshOZcrXT5cSttBVO5Is4b
         oWNw==
X-Gm-Message-State: AOAM530RimfN5q33rUAjBJTy26MX/4Jqxj8ltyphbdvx+AwK06mnF66K
        LdVWekk7KXTdFw6POIzdyukCkQ==
X-Google-Smtp-Source: ABdhPJwMrTzASSAtuAeHD13Uah3zwGwzHwTERozrKIQfJGj44BxpQ00MYPr62K/vCy7LTPB3/EduVA==
X-Received: by 2002:a5d:4c47:: with SMTP id n7mr42360529wrt.322.1641306046777;
        Tue, 04 Jan 2022 06:20:46 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j39sm35717478wms.0.2022.01.04.06.20.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 06:20:46 -0800 (PST)
Date:   Tue, 4 Jan 2022 14:20:44 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     linux-arm-msm@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] backlight: qcom-wled: Add PM6150L compatible
Message-ID: <20220104142044.iit5wnsrgzngu76w@maple.lan>
References: <20211229170358.2457006-1-luca.weiss@fairphone.com>
 <20211229170358.2457006-3-luca.weiss@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211229170358.2457006-3-luca.weiss@fairphone.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Dec 29, 2021 at 06:03:56PM +0100, Luca Weiss wrote:
> PM6150L contains WLED of version 5. Add support ofr it to the driver.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
