Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A668C61DA4
	for <linux-fbdev@archiver.kernel.org>; Mon, 13 Mar 2023 09:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjCMJrT (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 13 Mar 2023 05:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjCMJrS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 13 Mar 2023 05:47:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516E423C6A
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Mar 2023 02:47:14 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5-20020a05600c510500b003ec0e4ec6deso4367925wms.3
        for <linux-fbdev@vger.kernel.org>; Mon, 13 Mar 2023 02:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678700833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iYmD5MsF3oIPjX0k1aZdNm+DBHk9Xc24//Dz7MF2Y9A=;
        b=wkmGW7wc2pdyPdIU+Nm357li92G76oKI9w/bmdVrHlXV/QG2Ez37OEMxc7dIJPLvMf
         Cu666skGNPCFLE5/XrAVnWCBWpeATwrtPxtYqPkwZ7qSYZU2rhOji0tKhTgkHycLKEuL
         v7QjibKtqqBPtrLnEj1UQxGdp0l2PXSStc1kJxIybIvQu/2WHL6Xn+SpM/UKVfKtSkpl
         V5XeMo7e470oKaYKCkS4XCIBlq7lddvBH2YR5DjE4bwVe+wpNAxWB1Vekz1n6u4cdYUd
         I/4RlJ2Uet6JsF8lP4cgafvyKliIrIk64Jkw1JYwRR2xMR0s+Urzuo/WrtGNSVdhgxju
         Dbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678700833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYmD5MsF3oIPjX0k1aZdNm+DBHk9Xc24//Dz7MF2Y9A=;
        b=njb48Ctz7lUTKwJQwl0IxYi3DUlobxQdF3WJ3EBYhUCHpr+WaDOIS4M7zEnnOQ5yQg
         B9r5fOkz3X3RLKKr03DqrrxUhRFtRzDMm6HnIJnxOXVfi5dkFTFj054IMbobI7KZhouy
         2wjYLbVWrnU/KuNcFXbOWghVMXIJcal6B5ht60Qi/E9C+Ke1vCQA02bUTba1Tpup5tlz
         geojSL+Nr1H3+l2PduheXqc1h2jHjje6ZPpzSFDf/XcrZ+Ja54PqwrtdoAccngQ0QIlQ
         hb5kNy3SbrZ9aPeRZ2oe1erC+UFZ/BDhIZu52PJ1hR3rtYxfp1dWVD+Z9P0Bwuw/PET5
         Fm8A==
X-Gm-Message-State: AO0yUKVI8b73d0WGH/ess0kXTwb7c7gaSSsQDrD7qBhV6Ht0WirOWXg5
        40vhwnDoODAr8iUeS0wjS3RoUg==
X-Google-Smtp-Source: AK7set9Sg80xuB9cO8VB2x2eShv9xTBr9GnHLZPdvslFpUZbRRXOJJT3ZkwrYl/Y1o84knGB9MDhow==
X-Received: by 2002:a05:600c:4fcb:b0:3eb:2e32:72c3 with SMTP id o11-20020a05600c4fcb00b003eb2e3272c3mr10209094wmq.22.1678700832758;
        Mon, 13 Mar 2023 02:47:12 -0700 (PDT)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id z10-20020a05600c220a00b003ed25c0e124sm1907853wml.35.2023.03.13.02.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Mar 2023 02:47:12 -0700 (PDT)
Date:   Mon, 13 Mar 2023 09:47:10 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: hx8357: Use of_property_present() for testing
 DT property presence
Message-ID: <20230313094710.GA55049@aspen.lan>
References: <20230310144730.1546101-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230310144730.1546101-1-robh@kernel.org>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Fri, Mar 10, 2023 at 08:47:30AM -0600, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
