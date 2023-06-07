Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11887C7EE29
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbjFGJOe (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239886AbjFGJOO (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:14:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36EC2D57
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x1ensWxwtR1H9WH8H1jKCiwbKVNzMfKW0b7Yi6bDGCs=;
        b=RDQGGqGCwANX1vvi05EMyvg/+nmQUrKMDBJQm3k0BrBbTtri8g8xHgJNt7MLwxExd/RxFJ
        3TNNLCqqqtxG12tYqMrWpjrhKFCoJWCjbCUGofvzymtezbLD7HXGW/NcD/Bj5Na/jaX2NK
        ed3b4qI3+dw0lWKxqnsUzj7SDNQSnQI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-T_0RvutVMa2hSOV5utphyA-1; Wed, 07 Jun 2023 05:12:01 -0400
X-MC-Unique: T_0RvutVMa2hSOV5utphyA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-30c2e9541b9so3888759f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:12:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129120; x=1688721120;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x1ensWxwtR1H9WH8H1jKCiwbKVNzMfKW0b7Yi6bDGCs=;
        b=IZcrktlJ1iBUvtwgO0pN9NPwfA7rkAIDziFmQ5Sn/N3cyE1oMeBwo0ByycUhaX5UUI
         SvRePgJaoTbWh9EFmL6P7Ocl5h9Q8HoiVN4JJB/04FuKDdmzNLco3Zsp1EWtvkARZHkR
         8kdHDAUf/FnZ5ljNg40q6glBlMwzYCPvGnpFIV3c7SDYIOfu/h3M04BxR32pJdiT6pAK
         uXxipW3VGMVo4HJaV/WHc3fZ20Ujobyw5jBcpH+/CTbrwVoUjj/mu8egcdLF5BaCwVl6
         89hJ3p0UP8gcSnsxNaJ8YrMSz29nbyR50YaKHmJACOicjpnYNG0KyjwdIUzQodoo9ktZ
         bfGg==
X-Gm-Message-State: AC+VfDy16VUMJonqM/XGTvtc2ZgK5m4EeU2Ud2UDJC5mjrFV6DytGZ9L
        FlJlaK2ylEuN8gFwE7SmxQpfBxVNdZYV/ssjqibrVcJOb4xWkeGMlRlRKAgFSe0JhKy0c4abzjV
        Y4XmNhTUJbsar/TsG6PfsjN8=
X-Received: by 2002:adf:efc7:0:b0:30a:eada:8b9b with SMTP id i7-20020adfefc7000000b0030aeada8b9bmr4008351wrp.41.1686129120262;
        Wed, 07 Jun 2023 02:12:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6pKDNydRWrc71fW3bUFKqJDv/PfRpGWQYSkEIZ2IoZqLYQ3oH2ibQ9gh3nWmNRpad6J8Zxng==
X-Received: by 2002:adf:efc7:0:b0:30a:eada:8b9b with SMTP id i7-20020adfefc7000000b0030aeada8b9bmr4008341wrp.41.1686129120078;
        Wed, 07 Jun 2023 02:12:00 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w3-20020a5d6083000000b0030abe7c36b1sm14722806wrt.93.2023.06.07.02.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:11:59 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Antonino Daplas <adaplas@gmail.com>
Subject: Re: [PATCH 20/30] fbdev/rivafb: Use hardware device as backlight
 parent
In-Reply-To: <20230605144812.15241-21-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-21-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:11:59 +0200
Message-ID: <87r0qneiw0.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Use the hardware device in struct fb_info.device as parent of the
> backlight device. Aligns the driver with the rest of the codebase
> and prepares fbdev for making struct fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Antonino Daplas <adaplas@gmail.com>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

