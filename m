Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41739EB64DC
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Jun 2023 12:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjFZM3D (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Jun 2023 08:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFZM2s (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Jun 2023 08:28:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90CF2950
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Jun 2023 05:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687782433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Q7A4QtIPQ46OJKI9lflLzm3DTzPmnZrWIQG2/OeQ3hc=;
        b=ZOlgo35hKGBCoOJze6GQ03Sgcxnp+jGHJbd5I9qDAsLaqxfpy6bdNRK3pxW0NNQxywDccT
        l7flhFZsLdQunVs1C23F7OtKG05J/6S71Kbbw6TWw/pBDndhwWOCh/9m8G2Lca3ZY9G+0P
        EzuNUqUQyxQUU41/uc+0k0RvBmu8FCU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61--JbMxioTMOOiHE9a_8ly5w-1; Mon, 26 Jun 2023 08:27:12 -0400
X-MC-Unique: -JbMxioTMOOiHE9a_8ly5w-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30932d15a30so2456540f8f.1
        for <linux-fbdev@vger.kernel.org>; Mon, 26 Jun 2023 05:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687782431; x=1690374431;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7A4QtIPQ46OJKI9lflLzm3DTzPmnZrWIQG2/OeQ3hc=;
        b=P9yshxH+md/HnYeRmVKpZus8QqR0yPhNYvdJN6F4k9Y2US6GqHGnofpv2elOyPqp7r
         A8lTCzaw14yciDKjYXv3goJQzEqRTlzbyNnJTfUrXaqJXGPGZfAQo84VgvjSXUWIU5Sq
         3p6gqYcSkOQg3IDmlr0kqyOt/6sipYn/B5Hp++385MrFtj0koINI00WUVMDuDDUPAECf
         xOQzjj+Nhj9/gVeDdtwm5yJsn2cGMNynGKQTZriQmslxFctbXw9M4faWmpL0M07xnPzU
         JdDZeoq9JhNZtA3BmE74WYbWNOXsYSA5WKNhHEjDSLDpTEI6DIpk3mZw5h6iZ7sf1JBG
         wFbA==
X-Gm-Message-State: AC+VfDxjN87JtcM+niYoJZPkuMIQgSblxZjZxMuzMiswjsnfW3ItNbdL
        M1EV5A59WnCCzH4sxgdAYZSt0w9LXp4KQx3masOk+iDYEqDWz8NhVk4r5CSpMHacgcf7ZcWC55Y
        toe4jzxjpo4M7WBXxQ0g2q+U=
X-Received: by 2002:adf:e98b:0:b0:30f:befc:d864 with SMTP id h11-20020adfe98b000000b0030fbefcd864mr25143864wrm.62.1687782431247;
        Mon, 26 Jun 2023 05:27:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5s+xo+3GocfRAN2ddT936OL6TbSjlftKvOe/WQg4sXaYYvHxhA/vC/T+Q/4yNgIvb7WBFVgw==
X-Received: by 2002:adf:e98b:0:b0:30f:befc:d864 with SMTP id h11-20020adfe98b000000b0030fbefcd864mr25143851wrm.62.1687782430944;
        Mon, 26 Jun 2023 05:27:10 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d69cb000000b00313f07ccca4sm3108010wrw.117.2023.06.26.05.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 05:27:10 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        dan.carpenter@linaro.org, michael.j.ruhl@intel.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH v3 27/38] fbdev/sh7760fb: Alloc DMA memory from hardware
 device
In-Reply-To: <20230613110953.24176-28-tzimmermann@suse.de>
References: <20230613110953.24176-1-tzimmermann@suse.de>
 <20230613110953.24176-28-tzimmermann@suse.de>
Date:   Mon, 26 Jun 2023 14:27:09 +0200
Message-ID: <87sfaeh0iq.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Pass the hardware device to the DMA helpers dma_alloc_coherent() and
> dma_free_coherent(). The fbdev device that is currently being used is
> a software device and does not provide DMA memory. Also update the
> related dev_*() output statements similarly.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

