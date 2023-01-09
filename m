Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF6BC54EBD
	for <linux-fbdev@archiver.kernel.org>; Mon,  9 Jan 2023 10:21:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237054AbjAIKVD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 9 Jan 2023 05:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237107AbjAIKUM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 9 Jan 2023 05:20:12 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ACC13E05
        for <linux-fbdev@vger.kernel.org>; Mon,  9 Jan 2023 02:18:19 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso6240196wmq.1
        for <linux-fbdev@vger.kernel.org>; Mon, 09 Jan 2023 02:18:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=le6UecpYkd6s1IgJwYmbxfNn3ne8GJa+7Qrb/t3pfow=;
        b=rEIZ4b7rHvMLjUxSavtHGZU0O5u3LYUtMqgSKHcfjCdrnTrIWUMsr+u1hqBzU7vfHC
         l7dy5RmZg8dA7J9Rw8tBJnrim29yh9CREnZ0g1ybTnj4CpbeZeCwg/f2zte6fEjrmvCV
         WYc6qJw94uR/XCq1j46mVITpd5fd2bDsZngLbvcUqVxGXkzPzPNLnM+hLgrLSYjJZH2U
         nPpx4q+rihKDzMjPLp31vLu0ACkJyN1qNvHvKsBcehBLBGHcCeLv1XM7pqtLRo4NWv5a
         CshF9EYYs9kOBq1MJkyB5YqkNHotlpXDgZKTMumKfDIQuip9Wl78em20c+l59hY03NEx
         VapQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=le6UecpYkd6s1IgJwYmbxfNn3ne8GJa+7Qrb/t3pfow=;
        b=ktbfa1r/tNaeubsx6SxkbV9ubTCsmHABZNGMhG8IZp4QlE5m3f8LRDrj8AsC7wQjOO
         q+r14DWYQO3QyRWOqSyFbU9YpoW+bGPjmwiNnqJXPkVWKAfWP7+DX0xFXon22BRIehlj
         BLJv7rCqP7enVSqSEdMyO+aT5+a9q7zmItj7hrYj7GmnW/zD/CpuG4e6SR5dxfI6SvjY
         1G6P35AAcV4wRT2RSWKbJ6BQ5gK/U7fUUoliLX1trhnJ6zwjHU7bIu3Us4cXMNitaR32
         K6nLanFS7uFxmZWpPckAFGS+QnCDpzU8z6ZMbXefKhLUFz4l48VK6rSMhJQvivuvFwdh
         l3uA==
X-Gm-Message-State: AFqh2kpA8oTIcxm2JFzOSyGOFWNnLFbXYgy3KqevsPSne5EYogCsDiEM
        HzfX93HXc/OgZ8T79M3eubGBZg==
X-Google-Smtp-Source: AMrXdXt08Gf1g3sCj195fhecOdNnHaC4SmsdCQ+KvR4WGo5EayS3wHMCJ77TSvczIqZSzIRcvtVLsw==
X-Received: by 2002:a7b:cd99:0:b0:3d3:5506:1bac with SMTP id y25-20020a7bcd99000000b003d355061bacmr46541929wmj.30.1673259498469;
        Mon, 09 Jan 2023 02:18:18 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003d04e4ed873sm17288894wmq.22.2023.01.09.02.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 02:18:17 -0800 (PST)
Date:   Mon, 9 Jan 2023 10:18:16 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND 4/4] backlight: tosa: Use backlight helper
Message-ID: <Y7vp6AvXg3HtJtPZ@aspen.lan>
References: <20230106164856.1453819-5-steve@sk2.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230106164856.1453819-5-steve@sk2.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Jan 06, 2023 at 05:48:55PM +0100, Stephen Kitt wrote:
> Instead of retrieving the backlight brightness in struct
> backlight_properties manually, and then checking whether the backlight
> should be on at all, use backlight_get_brightness() which does all
> this and insulates this from future changes.
>
> Signed-off-by: Stephen Kitt <steve@sk2.org>

For the tools:
Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


D.
