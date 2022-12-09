Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 444B9C4167B
	for <linux-fbdev@archiver.kernel.org>; Fri,  9 Dec 2022 12:51:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbiLIMvi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 9 Dec 2022 07:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiLIMvh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 9 Dec 2022 07:51:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A5B5C0EE
        for <linux-fbdev@vger.kernel.org>; Fri,  9 Dec 2022 04:51:32 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id co23so5112771wrb.4
        for <linux-fbdev@vger.kernel.org>; Fri, 09 Dec 2022 04:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OtnZ1kdjAPZRqPqQ9rwdeEDxyI3IJgipy4lZ3Z6DHOU=;
        b=mzhiuYzLh5MXO4d2/CaGSLQRvmAHHQmyihleIadBSeVx0urmsuaZmDMUhlN6s6G8Up
         KGqJ2YNpR9+iZiOaO1gzAodX6jigmaayrqo/LY5geqBf0KGwQiN28ak0hr+qKVhp41/h
         lwiBFZuTLTdW/6SDBpJfuU28ZTjfX0BYytaoyOD4VdJvI5R6qLbslN8pJoYKU/RUfBxc
         yqvA/kxuhhz9o5Y6B2qx95QtRTxAjXm4uEfj31X4efvNKWuxnGeFyjDP1kIh0Lgasnb7
         uO+8X9prY1dZNpqTfVJp2HvUy4jyN7/6zqEDrct7rMKKm1K8MijdUSHqH3O6ArIOH3Pl
         9/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OtnZ1kdjAPZRqPqQ9rwdeEDxyI3IJgipy4lZ3Z6DHOU=;
        b=zPtxypaim18lbh4TVNiqW4L613k/VRNKLT3ejrm3W3SxpdwtrPCb3Zt5lZjb/0hedL
         AxKIgi3+BvF7lrrYv3RWoWFGWrA+aQgBNHSDNZeXj99XRd3vIqgPvlHXGXg1FHrKbDGD
         NSEEmB3x1IU0djYyB9lydosFfu/TmO3CKH8op3KOKCL102llGH2pomQgzSK5v+FFp2LT
         kKHxlri/+B74gEFj3hZ/zSuh+lDKcu3PNJb769zcMMM+Fy+WykRXNr7DYXUQsMkeyz0+
         KlH+pg4PE0CYd1g/hjg21+HyhvkQJHiBQHef8NvmIU57zt+TDFQvbzm8XR40xz1b9cJk
         ctBQ==
X-Gm-Message-State: ANoB5pnHaDY5vCW34yh0cQPkZ4YecgllwydlJ8cUg4LWHQfLVHRfpZQY
        QfY8xYhlY3tndCkTStPdRiMfVA==
X-Google-Smtp-Source: AA0mqf44qDADYcbcErOKO4f1THlbbJ0Qbkf2oOidypUvsQ4ltBNeY7SL3mw7aTGkms7BkKrITifFxA==
X-Received: by 2002:a5d:5111:0:b0:232:be5b:44db with SMTP id s17-20020a5d5111000000b00232be5b44dbmr3931759wrt.67.1670590290559;
        Fri, 09 Dec 2022 04:51:30 -0800 (PST)
Received: from aspen.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d5004000000b0022e57e66824sm1538868wrt.99.2022.12.09.04.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 04:51:30 -0800 (PST)
Date:   Fri, 9 Dec 2022 12:51:28 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     ye.xingchen@zte.com.cn
Cc:     lee@kernel.org, jingoohan1@gmail.com, deller@gmx.de,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next] backlight: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y5MvULWEnqp7pzft@aspen.lan>
References: <202212051556478226726@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212051556478226726@zte.com.cn>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Mon, Dec 05, 2022 at 03:56:47PM +0800, ye.xingchen@zte.com.cn wrote:
> Subject: [PATCH linux-next] backlight: use sysfs_emit() to instead of
> scnprintf()

Isn't this a v2?

(this isn't just a "nice to have"... I ended up delaying review for
several days until I had time to look up where I had seen these changes
before)


> From: ye xingchen <ye.xingchen@zte.com.cn>
>
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
>
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
