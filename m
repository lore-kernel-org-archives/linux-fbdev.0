Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94437C87FDE
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 07:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbjFGHp7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 03:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239643AbjFGHp3 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 03:45:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE15F1FFC
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 00:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686123741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=NI41Fwdn9Za8jS35kaey85WnHOxBqCqZualB4J4AkW4EIZDPV7+jXhnbjUS3h/ptJOoMge
        Kn56mlZkOJv3dCkcE9GYe1CKFdRxE2pm/8fUe5yxWBbf0FDy+mCrEP3tI7vfy6p+dmuh/Z
        o4WUHBXGmK6aiJqdLB9qj6muafJT2Cs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-RzbiqkNfOYusJO_LeClHeQ-1; Wed, 07 Jun 2023 03:42:19 -0400
X-MC-Unique: RzbiqkNfOYusJO_LeClHeQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-30ae4ed92eeso3067066f8f.1
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 00:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686123738; x=1688715738;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VCpM3n9uxiNBqWYphesbEdJfBdCBdNVjlNpr9KooViE=;
        b=c0PglDBj2VYN7bvvorF+o0Z3lbcQjWr46jQTnxJ1aGaQH7/D1vALnUc8bTFzw3pyEP
         jUxRLGAJSBm8fDqWIKq4nMvTcN+LWP836le3q/bmKo0wA9GEMGIcl3H86EX88qYcSHvW
         a+6ES5KhJIC1cK4ZrhgihI+Yyn78n1iww8epb1aUrOzJtdw2+d50c+1ViMQgfrQFXlzZ
         hm6uvaRXoiCmbHPdVaYzlhjSydzDgqu/jh1tD57Piff7HA5Cu6x5P6/M5zRJchB+I+aM
         5LXL+FfZLZh3y1rhD6wqqiPXZHn3vLc8Zz61VbSYh6SK7RCjtNUSJuXRDYvoimSVl+PO
         I24w==
X-Gm-Message-State: AC+VfDyJVCNof4cQTm/FeJkt06P9p++OXEPFa7fI9sF/5XZ2rTICm7/D
        KpXZBYIj3G80QxcYnMkrwH4XTcwmwwNyrH51ium9Z9qkoDa8OjAIs/YJL7Zl0tWEiGsO6ebr6G2
        IhMoRVk4juTJkxLRIPICRuZA=
X-Received: by 2002:adf:eb88:0:b0:30e:45ac:810e with SMTP id t8-20020adfeb88000000b0030e45ac810emr3734959wrn.36.1686123738653;
        Wed, 07 Jun 2023 00:42:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KZwfGmENtFpHBv/PbHt1rJPnSSY7XTJGSBoIFHGMz6zbW+M0/3e5qcpQ+OgRWGlPIuGCuTA==
X-Received: by 2002:adf:eb88:0:b0:30e:45ac:810e with SMTP id t8-20020adfeb88000000b0030e45ac810emr3734950wrn.36.1686123738508;
        Wed, 07 Jun 2023 00:42:18 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z13-20020a056000110d00b003047dc162f7sm14752394wrw.67.2023.06.07.00.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 00:42:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 06/30] fbdev/aty128fb: Reorder backlight and framebuffer
 init/cleanup
In-Reply-To: <20230605144812.15241-7-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-7-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 09:42:17 +0200
Message-ID: <87wn0fg1ly.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The driver's backlight code requires the framebuffer to be
> registered. Therefore reorder the init and cleanup calls for
> both data structures.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

