Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FF5DC25B4E
	for <linux-fbdev@archiver.kernel.org>; Sun, 22 Jan 2023 15:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbjAVPhH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sun, 22 Jan 2023 10:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjAVPhG (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sun, 22 Jan 2023 10:37:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48AE22788;
        Sun, 22 Jan 2023 07:37:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B157160C67;
        Sun, 22 Jan 2023 15:36:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17420C433A4;
        Sun, 22 Jan 2023 15:36:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674401819;
        bh=RtN6VM53/AyRL0T6lTHmeEBHv7Z+IjaXe/djZ6ectng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D1qkKG4kb8gHNmXGAgMJ0NKzf1Jrt9kuF7IvFG41zjxEB07D6uK7E6qvHoEf3yAez
         DL5zQsO9NNfp22miYOfawlS1pdkD1yU7+9Wdh+nZUNtDJdIIR5CP2WhwZNwoS09juN
         mbrNTpp6kuhhwzXy3v4Z0Qys2YuVcojAZOdEwnUKmrk2Q7VKdpx+scIO7HbKT9bG2R
         vi39XHLEPJY2xSPVyUQ+AzrUE6+ZA47tJArOW0tEg3jR5R9FpqPFmP86v3tC54ScCW
         9Z7TUau7l5XMjxwyo1J+uTLvhCTQFsAPXGXJe9KkKUXGwu6Le9eZs1H3c6GvuBphSf
         LX1519gywNuIQ==
Received: by mail-ua1-f42.google.com with SMTP id a40so2323697uad.12;
        Sun, 22 Jan 2023 07:36:59 -0800 (PST)
X-Gm-Message-State: AFqh2kpy0I04yNUCBYvdh/fGu33+pHmvWXnhM9BdTCqKhxx4QWIlEOHY
        sk2J65adtujZ7AhIqH9uJfcUn0Ng9PbqEdL0RA==
X-Google-Smtp-Source: AMrXdXtaJGGPuSDntjhTa9IstN9+kYwGqE/HL9t8ofms18yBJ45Rqak284KVOWnfaIo98tIhMeiIZzEB2j+M3JIs2KM=
X-Received: by 2002:ab0:1512:0:b0:5fc:a2ef:4b70 with SMTP id
 o18-20020ab01512000000b005fca2ef4b70mr2269079uae.36.1674401817944; Sun, 22
 Jan 2023 07:36:57 -0800 (PST)
MIME-Version: 1.0
References: <20230121153544.467126-1-rayyan@ansari.sh> <20230121153544.467126-3-rayyan@ansari.sh>
In-Reply-To: <20230121153544.467126-3-rayyan@ansari.sh>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Sun, 22 Jan 2023 09:36:46 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
Message-ID: <CAL_JsqL+G=Cxkc2j_NowznpqNAnixrU+-6SdccFbpMaP6OYSqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: display: simple-framebuffer: Document
 physical width and height properties
To:     Rayyan Ansari <rayyan@ansari.sh>
Cc:     dri-devel@lists.freedesktop.org,
        ~postmarketos/upstreaming@lists.sr.ht, asahi@lists.linux.dev,
        janne@jannau.net, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Sat, Jan 21, 2023 at 9:36 AM Rayyan Ansari <rayyan@ansari.sh> wrote:
>

Why do you need this change?

The 'simple-framebuffer' contains data on how the bootloader
configured the display. The bootloader doesn't configure the display
size, so this information doesn't belong here. The information should
already be in the panel node, so also no point in duplicating it here.

> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  .../devicetree/bindings/display/simple-framebuffer.yaml   | 8 ++++++++
>  1 file changed, 8 insertions(+)
