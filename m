Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B10C0015E
	for <linux-fbdev@archiver.kernel.org>; Wed,  5 Jul 2023 09:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjGEJIG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 5 Jul 2023 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232194AbjGEJH4 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 5 Jul 2023 05:07:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B9E10FB
        for <linux-fbdev@vger.kernel.org>; Wed,  5 Jul 2023 02:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688548036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a06dM4DVhOWie+29y5OH6RTZsrC7pthC/bnsJb9dU4k=;
        b=TkctYdfkaG7vg82cKjocujjyNN5f97SGBL0O8qElhImGEztSuHPnXfne6t5x5MRb0EwqZp
        bX+PYReIO2No8v9pat+IOLaqHDow16jV/JVa0mEsQbq7YQIC/4jcGvumAG/r4yGdfqjIMi
        vNcelHt24pWiqCavtCB1LAIZSBf5pZg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-BsxMvkaDMqSWqY9N1yswMw-1; Wed, 05 Jul 2023 05:07:15 -0400
X-MC-Unique: BsxMvkaDMqSWqY9N1yswMw-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3143b999f6eso1327041f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 05 Jul 2023 02:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688548034; x=1691140034;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a06dM4DVhOWie+29y5OH6RTZsrC7pthC/bnsJb9dU4k=;
        b=MZq3Qv/g3NtbRfgfBcK1Z9FGMIwUSHjQ9iouUqxIFo9xX6IFLMzbMZHQsavYQnlnaw
         JeGU6PEhK5rl2Hd7U7209wIbAE/vhG1CdRSRQLKwrEbzemT/kAXgg90HCBd1p+hAdSrY
         F8BTu+vrRE+5wmwUmplOS0Le3a3E2s0jGfqjycavosGPg/cEwVJK2i9v+RCRJBg7Ugpq
         xHaqBByQz3jSZyS8qt3G+lbDteEzF7YKwQHNcCK8oOwm84JTjaGed/cdvYMnjZwl0qhp
         ja4oZiLSlT/4CS5TSys2+GcDkkYrCxFIomjjbOl3JoV9WyfQIdLmcV+CJqoGukEeHNj9
         +jGQ==
X-Gm-Message-State: ABy/qLbqxB9X4K4oESGF/5MWPE5RAq3RXhp0Q+8AmZh8k7DVk34RRt8N
        yVEdkvcstJ+fXsZkGhIboyOxzBEE+K9dgTwGhHE0sG+V64B8aORZfQWt12INeCh3CB9MehjK378
        G7+BbifR/pa4zVkFOhwux0OA=
X-Received: by 2002:adf:f3c4:0:b0:313:ebf3:850e with SMTP id g4-20020adff3c4000000b00313ebf3850emr13765067wrp.37.1688548033939;
        Wed, 05 Jul 2023 02:07:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHGcT0p8hhCDRF3h+9mFlbkiFbzXDC8/ZzlCbbtfV1aXJy0eKEzcQDMciMIa3WCioCrYV9vdg==
X-Received: by 2002:adf:f3c4:0:b0:313:ebf3:850e with SMTP id g4-20020adff3c4000000b00313ebf3850emr13765052wrp.37.1688548033678;
        Wed, 05 Jul 2023 02:07:13 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id m3-20020adff383000000b0031417b0d338sm16044699wro.87.2023.07.05.02.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jul 2023 02:07:13 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH 09/10] drm/omapdrm: Set fbdev flags
In-Reply-To: <20230704160133.20261-10-tzimmermann@suse.de>
References: <20230704160133.20261-1-tzimmermann@suse.de>
 <20230704160133.20261-10-tzimmermann@suse.de>
Date:   Wed, 05 Jul 2023 11:07:12 +0200
Message-ID: <87ilayrakf.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Set fbdev default flags FBNFO_DEFAULT and mark the framebuffer with

FBINFO_DEFAULT. I noticed that the same typo is in patch 04/10 as well.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

