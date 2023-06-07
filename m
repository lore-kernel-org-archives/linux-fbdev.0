Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A73DC7EE2E
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239906AbjFGJOi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239425AbjFGJOT (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:14:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B4C1FD4
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686129144;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B3BIYD3PXMtQvTPGQV01/1k0Hmx/7PJYivm+5X8kP8U=;
        b=YTHDPJYkDyJupCJc9mv28KqqFLz9JWkoxFEn3qYCIf+1HnJk9BguHGSo1raI0DbMfGBBHr
        ozmHKje7yWuvVVg/YCgK3BGT89RkZZJECu2qEN8eVx9Ts04TFytsi6pk8xvWAhuipvAX/J
        Y1NRk2sBOqFiJZDkS6gndCMVrpBYUTc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-sbjHfws0P-uLamwaLw8LMg-1; Wed, 07 Jun 2023 05:12:20 -0400
X-MC-Unique: sbjHfws0P-uLamwaLw8LMg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-30aeef6f601so3229284f8f.0
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:12:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686129139; x=1688721139;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B3BIYD3PXMtQvTPGQV01/1k0Hmx/7PJYivm+5X8kP8U=;
        b=H9GRjnLceYqtHNyWfOlNIzIawvdD9ht4Pz3RantlIuLPFb73jETY7rBf86QypMkb/Q
         Nmoh3PVpg7FZvOQFzdbOE/oIBA3swMo8ZWk2Q9eluvuESF1x8nMr/rHNVcjf2FBOHr6x
         Ir2FCBFS46m/pc5DhlffqU106f6LdfZxytwEndKx/WjuIYQ6LO1aJ/WzeziQznj4LxHB
         am1TZDDXp0pk8lexh3EqojAe7vUW/Cxmg7lvP6gWAqKLpQvIdp3kamC/2Ruj68iYJqqW
         PwUuKW/v2dWteDDkjqABY7qM7qqgDnPqnw5TFVESGs8rC51sXBL1sjxnh3hy6NbYfTVN
         V3pw==
X-Gm-Message-State: AC+VfDx2G5EAmAtq8fdJsANHnPXPiexn4zS/330yuVVW23WvOo3OnTWg
        VlbE6jFbtPu8tEYVpzU8oHGoKAxp3Q4P+FFVOrzzKyfgWh2mGKMXr9CJui8f4ueGt86KvlURAnM
        8taMMqYRGcIKpBI490p8lnos=
X-Received: by 2002:a5d:55c6:0:b0:30e:38d3:cc4f with SMTP id i6-20020a5d55c6000000b0030e38d3cc4fmr3742544wrw.36.1686129139399;
        Wed, 07 Jun 2023 02:12:19 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5wzUZfsA9VSizf9bxaqukgTVAwDp5W+57tfKmlffItPyQVvcHhSQ5E8wYACr5/gCv7xQF2rA==
X-Received: by 2002:a5d:55c6:0:b0:30e:38d3:cc4f with SMTP id i6-20020a5d55c6000000b0030e38d3cc4fmr3742525wrw.36.1686129139085;
        Wed, 07 Jun 2023 02:12:19 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003f60101074dsm1447712wmc.33.2023.06.07.02.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:12:18 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-staging@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH 21/30] fbdev/sm501fb: Output message with fb_err()
In-Reply-To: <20230605144812.15241-22-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-22-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:12:18 +0200
Message-ID: <87o7lreivh.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix case were dev_err() is being called with struct fb_info.dev.
> Use fb_err() instead.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

