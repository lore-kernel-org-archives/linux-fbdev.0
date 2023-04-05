Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1FAC76188
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Apr 2023 11:31:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbjDELbn (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Apr 2023 07:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237538AbjDELbm (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Apr 2023 07:31:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5BC59D5
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Apr 2023 04:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680694247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RNLFmKiaJhCbpMv6NNLJ01MSUH3fUGQXMqewzc3mLvQ=;
        b=I+RpAs5mCS5Th1EimrRqM/Q4mOP/7YIffKUy39fJA9hUVMo9yoh0v+znhOu8ryrCoxhh3b
        Lo/70+OqmNBPQNSkiOvgFHaUTGaHGiF5QN6Tx2xcKz8SqYTdbR1zaw0f4VU0glSdxPU5WS
        ysPHUYyvAAPfcoBGS+uYOk3lcIshONk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-bYV9sx2ROkecJ8hsr3ApHg-1; Wed, 05 Apr 2023 07:30:38 -0400
X-MC-Unique: bYV9sx2ROkecJ8hsr3ApHg-1
Received: by mail-wm1-f69.google.com with SMTP id j14-20020a05600c1c0e00b003f066d2638aso298065wms.8
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Apr 2023 04:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680694237;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNLFmKiaJhCbpMv6NNLJ01MSUH3fUGQXMqewzc3mLvQ=;
        b=3bYR92iGK9YFe5Su04AdErxnik7YFGmbGhkc+/JUDSvDmma76SOfb0ideqjzxPVXoq
         a5gGdpIMMwXgMAnFIX18EFRqGJvL2HNKWtW1WjI7uwF8idOUlw6dOu0KfUZw4UVILHZK
         CmUjqVHEZsqh4LrIoXex938qsRzrNFWzv/SjGUTV9p97siDXAVUNozcNoMEX9Q+0OBRf
         1R5cfDAqfPncRmveAS1Msc35ZKaBCTUKr19z0FOTKCIqghB13w/HNwxqOvWlqub9E6Ab
         F2x2H7jkDTpV5/MfiGT2o5UIOZt3QyXcQgLZ2aPro0eAhMQNAaCOmU8bquCqYDAQoh8a
         C3FA==
X-Gm-Message-State: AAQBX9efuM1qZWCpqqD6QNbAhna845hR5YlVtnSN0+oTkKKnr0Rpx1Hp
        rSFA0kYBprAwp7Mp6oFxH/vfdL4wbw7hMXVmh/TckZ4xosEDN68gE5MnKgbSmNGdKUuMF0m+iYl
        V392vUMayw/wlv2k44B0y0ZM=
X-Received: by 2002:adf:e409:0:b0:2ce:a0c1:bcaa with SMTP id g9-20020adfe409000000b002cea0c1bcaamr1759122wrm.9.1680694237463;
        Wed, 05 Apr 2023 04:30:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z+rEnxummXTXBERQ/WiQlDGMhXDsQ6asLHd92imjUbjJ+WG229BKVrkkBNa50e3N/32xHrgg==
X-Received: by 2002:adf:e409:0:b0:2ce:a0c1:bcaa with SMTP id g9-20020adfe409000000b002cea0c1bcaamr1759090wrm.9.1680694237126;
        Wed, 05 Apr 2023 04:30:37 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w3-20020adfcd03000000b002d45575643esm14727267wrm.43.2023.04.05.04.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 04:30:36 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Deepak Rawat <drawat.floss@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Emma Anholt <emma@anholt.net>, Helge Deller <deller@gmx.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-hyperv@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
Subject: Re: [PATCH 3/8] drm/aperture: Remove primary argument
In-Reply-To: <20230404201842.567344-3-daniel.vetter@ffwll.ch>
References: <20230404201842.567344-1-daniel.vetter@ffwll.ch>
 <20230404201842.567344-3-daniel.vetter@ffwll.ch>
Date:   Wed, 05 Apr 2023 13:30:36 +0200
Message-ID: <871qkyd0rn.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Daniel Vetter <daniel.vetter@ffwll.ch> writes:

> Only really pci devices have a business setting this - it's for
> figuring out whether the legacy vga stuff should be nuked too. And
> with the preceeding two patches those are all using the pci version of
> this.
>
> Which means for all other callers primary == false and we can remove
> it now.
>
> v2:
> - Reorder to avoid compile fail (Thomas)
> - Include gma500, which retained it's called to the non-pci version.
>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

