Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43A1C61DA4
	for <linux-fbdev@archiver.kernel.org>; Mon,  6 Feb 2023 11:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBFLmr (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 6 Feb 2023 06:42:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbjBFLmo (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 6 Feb 2023 06:42:44 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39021EBC9
        for <linux-fbdev@vger.kernel.org>; Mon,  6 Feb 2023 03:42:42 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id l37-20020a05600c1d2500b003dfe46a9801so7047035wms.0
        for <linux-fbdev@vger.kernel.org>; Mon, 06 Feb 2023 03:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5mcLZp+bwHljE1RPuf6xDhCdiFhlDxm+3HKZwHetgGw=;
        b=S1/cNS9JWmRCZjJP0bvEApYHgfPv/5Mq/zmU04VMCzjhe03zfE/kTViHbevV8VeLFR
         VVZOmmsX8Vj+MgINVGGJ5zj1Xo/DQKz2nWCWBoMT0t1iiwlchcu4Aw8A2Y9YTE6o/FH2
         wL2NXNHmCI9o/ISJc8HzhjPHGlauMuGSNVUZN3ZrQLw/8cLzLL97c1R72iH+jaoxkJLV
         dzf96GbhIS+qtyumbaTEEvVjuhLwHUgQPwFwtD02wG59fmo7DHGzAJPwTbCCvkAmQniN
         RmQ3W3VoE3Z37TcraP0c5v4olmO01gXh3ukNu80/tDe/eg1VVi6VKhQjvs+tInOAAK/R
         5Yig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mcLZp+bwHljE1RPuf6xDhCdiFhlDxm+3HKZwHetgGw=;
        b=fwhSJ/NJ7SL/cz+ehO2Pnl9En7p+W75yWlzwCiyFfbGNhCfbNO3tGg4j+HNTz3/xKD
         nhh1ZklI1jXFEgjyLJ4iwSJ02i4xfpdptzfinpRKas0pNruij9rg5gs0a9lTFCAMCUmB
         UwNAwvGqU2w4W/HNzq3Z5dPgn1/koARC7zFBj94sOX/9Fv9XOyDlwmkS5v2j6+fz+ow4
         j6izO0IOBmzCumRHB+b2BI26O7XTBKG68/egOiw7b9IjSNnzvTut67p6PkjxYbhCLqHU
         jbZ+LP9p/32p37hsX8GtAyozAsTzd5ER0wliFqwYETMMen6+CBe1/F6WfOjWhKD5ZSN4
         Dc+A==
X-Gm-Message-State: AO0yUKUK54mdviVqXznU7qmZyvFvhm9h9tBmU3Vk3NwM1MIQhApO+jlj
        rhc+LJ6I+EFJEtfn/bExeBxWag==
X-Google-Smtp-Source: AK7set/0e8rb0pkCcbZULGmSmISHb9E98R7iG5wsZXc2LS2PbucXN5Ox8X2GEu4jmltN0YSmz+C+0g==
X-Received: by 2002:a05:600c:1d99:b0:3dc:d5c:76d9 with SMTP id p25-20020a05600c1d9900b003dc0d5c76d9mr20747824wms.0.1675683761383;
        Mon, 06 Feb 2023 03:42:41 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z17-20020a7bc7d1000000b003dc3f07c876sm16116888wmk.46.2023.02.06.03.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 03:42:40 -0800 (PST)
Date:   Mon, 6 Feb 2023 11:42:39 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: hx8357: stop using of-specific APIs
Message-ID: <Y+Dnr7bzJ7XDdXH1@aspen.lan>
References: <20230131225707.3599889-1-dmitry.torokhov@gmail.com>
 <20230131225707.3599889-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131225707.3599889-2-dmitry.torokhov@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Jan 31, 2023 at 02:57:07PM -0800, Dmitry Torokhov wrote:
> There is no need for this driver to be OF-specific, so switch it to
> use device_get_match_data() and stop including various of-related
> headers.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
