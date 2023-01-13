Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9756EC54EBE
	for <linux-fbdev@archiver.kernel.org>; Fri, 13 Jan 2023 16:27:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjAMQ1S (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 13 Jan 2023 11:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjAMQ0z (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 13 Jan 2023 11:26:55 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C5814D25
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Jan 2023 08:20:38 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id c4-20020a1c3504000000b003d9e2f72093so14309965wma.1
        for <linux-fbdev@vger.kernel.org>; Fri, 13 Jan 2023 08:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=06yrgHLtubzlVTv8ZMuuqpVVcPSwyPWQD3kou2AtPjE=;
        b=zrFZvqQmSdfN3TP96rg+qCC38kwG2a2tGbIWZCtwPBWu8b5rqlJQvUvwbz0absrUWq
         f2+HygAJ12mlVvFSqx5TBpNtotqYmdNXLnWPsyUwqDE4juqk6dOAqUAhRGf5GL0e94KH
         uzEZ3POXerO0a+xZDIfgQWArn/AsWjsYAtu1sIIUgH6/kNROx4bjNPrfb7N+hpQoyKlD
         SERj4Nc4CMz1D2EZoS9m/34CnijnEtcMHAuuqvQJSu3FKT7sfu7K7pWtby2Jr1l+P2Aa
         zq1w9VM80VOnZ2aN+htvT+5myf2YfzmqW1g4jKu7mfbIMZlsNXgN9wv2uplydNx6tZ8S
         jbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=06yrgHLtubzlVTv8ZMuuqpVVcPSwyPWQD3kou2AtPjE=;
        b=UTa3oBmv1DIhR1zsmEn21eQj/4uvUrVUwVFkqSFDYxqOQEBVcFCyAYDF3vktF3QubH
         IFdD1lj4a6Xx6b3aA0CooEfPrRnBuMXQr/UhmtRXniFL6cpnY/VjuLnQZauD6Ag75uex
         FmLbnursVYusnrxywWKTQ+lAXhpVNDa0hdqD6ECAI+gM+fX89p2u/UkRDz9TyT09A/0K
         OBZD4bZ4QAlSXWhGrK9qUswUM585WSHga8iVkAFfoGSXCCn8t/KuDpvqqLCbh3mn+RjX
         uh6hoZ508iliZkyDhXcA/r/6OU2XfsNa+XsW8AbY/IgzqMNk+KLAL2aGn6izBt/oxIkT
         rC/Q==
X-Gm-Message-State: AFqh2kpmfzvOQA1ImSi2/Cms66qn5sbAvNqQUk+BJxip3gHzeeTp3Het
        6YKkxVvfcwAiU2KuT5647BRIew==
X-Google-Smtp-Source: AMrXdXv/fkkqVwAy0FAec0vYcCM6E9mSl/Oq7DvCSvQ2RbgiZMu2Av6NkgVtbj85zzZkDZtaY/excg==
X-Received: by 2002:a05:600c:1d10:b0:3d9:ef75:ea6e with SMTP id l16-20020a05600c1d1000b003d9ef75ea6emr188418wms.38.1673626836588;
        Fri, 13 Jan 2023 08:20:36 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c444a00b003d998412db6sm32412208wmn.28.2023.01.13.08.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 08:20:36 -0800 (PST)
Date:   Fri, 13 Jan 2023 16:20:34 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee@kernel.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH] backlight: sky81452: fix sky81452_bl_platform_data
 kernel-doc
Message-ID: <Y8GE0kEJdQpM9M4L@aspen.lan>
References: <20230113064118.30169-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113064118.30169-1-rdunlap@infradead.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 12, 2023 at 10:41:18PM -0800, Randy Dunlap wrote:
> Correct the struct name and add a short struct description to fix the
> kernel-doc notation.
>
> Prevents this kernel-doc warning:
> drivers/video/backlight/sky81452-backlight.c:64: warning: expecting prototype for struct sky81452_platform_data. Prototype was for struct sky81452_bl_platform_data instead
>
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Lee Jones <lee@kernel.org>
> Cc: Daniel Thompson <daniel.thompson@linaro.org>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Helge Deller <deller@gmx.de>
> Cc: dri-devel@lists.freedesktop.org
> Cc: linux-fbdev@vger.kernel.org

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
