Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB05C0015E
	for <linux-fbdev@archiver.kernel.org>; Mon,  3 Jul 2023 10:36:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjGCKg1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 3 Jul 2023 06:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbjGCKgZ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Mon, 3 Jul 2023 06:36:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53487CC
        for <linux-fbdev@vger.kernel.org>; Mon,  3 Jul 2023 03:36:24 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3141c3a7547so4422784f8f.2
        for <linux-fbdev@vger.kernel.org>; Mon, 03 Jul 2023 03:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688380582; x=1690972582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ixKZPqjMUtYmaa1DZf59STOffMkhoGUDgvvQ1w9gmxU=;
        b=pz0dwk4ABASU/bsaehINWP2hrWKMVGOli4cj08a0jsh3za/q/rasrg6XpxZRlZ/cc5
         n1eawc3Rp+oltxx6Y/8NogISdO2UbMJ0JzROiR6FMN9/mmrXb27Ad+F3ch5UZ1lFS2oR
         BTuyqyz80hrUkr1a578tKS+0vAOAEq//koWS6aZIVyaeE21CAOlo8pqxWHuaduD0FojJ
         OM2HWmX0P0SFSgnlx+FVEX+P3tyni1cNBO06taAKgbzCK+fpjKyjhtQQnr9JjcVOSYTx
         +UW69hVXfDMnYDDkhi9OnDsQHBq3yfR8YpiXGwBCO4iSs1KvayYKZGz1FXjuKSQhaKmq
         2Wkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688380582; x=1690972582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ixKZPqjMUtYmaa1DZf59STOffMkhoGUDgvvQ1w9gmxU=;
        b=WFrho/i5c3n+CNHM4Tl/a77cuRjpoExF+uN0iR3FVof2fK2qB+TMAmiuiYon80/kZH
         2ow4uZ1bjx9XHEjEd2sFwuB0KmdSNTagU8z/Kc1NDOYWXRRpy1LSNwkbJWmyzPAUQ8Vk
         v8doyVQmpDvbSCyluoMs5g0YC/ABlcPuoz9pvlyNR3VjFTyQPb4x6Ep8yVRmkBZnAmVH
         iuIeYuYPt0ncq4qMz7ncIsFVbczqkQ4GGXoxraTPhHc0X+BB5/pzG9TPEcKm2l30qCcU
         v01LrkQcZx/tPz5t4JIY3KSzCAM0AAA5MDP9mCm19UqIanqWZN4UGsK/acQkmeoYHDnM
         ZnRQ==
X-Gm-Message-State: ABy/qLY/APJh5AkB+y2tpOQ7dNbvYK/nJDrs/VsmZzh9xpvmpHYAxYzy
        6JdxDEqeVQQzK9upPmHP8TU+YQ==
X-Google-Smtp-Source: APBJJlFCtn/MbjA2G8ZvLuBmC6KdcueKpt+ZPYpnE6pacAyeUCSM0gU2+5700Tz56JqYf+INB/Q1GQ==
X-Received: by 2002:adf:cd87:0:b0:313:edaa:24fd with SMTP id q7-20020adfcd87000000b00313edaa24fdmr7691744wrj.21.1688380582578;
        Mon, 03 Jul 2023 03:36:22 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id fa12-20020a05600c518c00b003fbb1ce274fsm10250195wmb.0.2023.07.03.03.36.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 03:36:21 -0700 (PDT)
Date:   Mon, 3 Jul 2023 11:36:20 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Julius Zint <julius@zint.sh>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 0/1] Backlight driver for the Apple Studio Display
Message-ID: <20230703103620.GB4328@aspen.lan>
References: <20230701120806.11812-1-julius@zint.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230701120806.11812-1-julius@zint.sh>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jul 01, 2023 at 02:08:02PM +0200, Julius Zint wrote:
> I have been using and testing this as a DKMS for 6 months now without
> any known issues. It bothers me, that it needs to be part of the
> initramfs instead of just working out of the box. Maybe someone else
> here knows, how to tell the USB HID driver, that this is not a HID device
> and it should keep its fingers from it.

If is says it is a HID device and is uses HID reports for control then
it *is* a HID device!

In other words you need your driver to register as a HID driver instead
of sending raw HID frames using the USB stack. If you do that then the
HID core infrastructure will ensure the right driver gets loaded (it
has special logic to automatically unregister hid-generic and load the
better driver as soon as one becomes available).


Daniel.
