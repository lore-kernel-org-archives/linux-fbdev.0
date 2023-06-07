Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AB6C7EE23
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Jun 2023 09:03:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjFGJDj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Jun 2023 05:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235007AbjFGJDK (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Jun 2023 05:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157711FFB
        for <linux-fbdev@vger.kernel.org>; Wed,  7 Jun 2023 02:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686128451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVTR4IxyLBLXJW/X4J1N4pKhPGAjKCq/t5JfKIVV29U=;
        b=IDJpD5gQeZiVhhfAYknJ+UrCFMA9z/Bm07Oy9OEyKLXQc77SaCVrm/yxVW6idrlHgIjn3C
        PgoUXFAxHm2UVNhSMLAol/62sf2PMzTIKXE0Nysq5CzKgtq3o6l3l3jkvh+f8u59XzrI30
        9mjLBHpmpOpeLx7S8Jr6KkHrOUBN+IM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-ZwSYnfCeOySzgz9soHLvBw-1; Wed, 07 Jun 2023 05:00:50 -0400
X-MC-Unique: ZwSYnfCeOySzgz9soHLvBw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-3f60911a417so35423155e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 07 Jun 2023 02:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686128449; x=1688720449;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rVTR4IxyLBLXJW/X4J1N4pKhPGAjKCq/t5JfKIVV29U=;
        b=F0MVeEBLMSBKZOpH2vXUEWAYpl0IueaE744R+P/Vf8paBuRIb1bj/CJlZssXYpm5Dy
         3rp6rU7NTvpO/uxO6AcN2eLgPidNP80l96JMKQJVZhcgBvRglUhp9c/ScuDjOXC2oDkT
         Df/19/9Z3cr/wq33GB1FxAec3E8TLWNWQyQJrwCc5guCKdnns9gDYlOKdITfZpSkb8yb
         YjYp1gYixD1m8VJS6IVOcadLdLVGp1ItBp6MW8VB/uzdz0RtM00m77YKA9OwkXfSnL6G
         aZqFQ+KCtcPtV/wvYycnbD3JzP13VXxLspdl6HXK7JsNDyqPuwikitTnGjcgMz/kVvpx
         HiIA==
X-Gm-Message-State: AC+VfDyytItdhrgH2AV/t0aSpcICJa2jdCKdTfBH6SrmwxyEb7ZVnbV7
        OLGmg9ojzSsZzqCm/GHmxzov82TlCOEaU/Ky+KG3qj1c1ihtfi3BBPfH/d7xgkWzJStf/qyuiEq
        27Ydtp0QfdJYU5jabe6hJonSTV7hmOXM=
X-Received: by 2002:a05:600c:202:b0:3f7:3575:9e28 with SMTP id 2-20020a05600c020200b003f735759e28mr4341998wmi.41.1686128448792;
        Wed, 07 Jun 2023 02:00:48 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6DpfZRaNzsiu/uAACD5Q0ndg8v93wxyuv2x48c658BhjUxR/uhCQIbScZ6GMWBCIsDezZdiQ==
X-Received: by 2002:a05:600c:202:b0:3f7:3575:9e28 with SMTP id 2-20020a05600c020200b003f735759e28mr4341976wmi.41.1686128448503;
        Wed, 07 Jun 2023 02:00:48 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c294200b003f7ba52eeccsm1449794wmd.7.2023.06.07.02.00.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 02:00:48 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
        sam@ravnborg.org, deller@gmx.de, geert+renesas@glider.be,
        lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-sh@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-staging@lists.linux.dev,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 12/30] fbdev/mb862xxfb: Output messages with fb_dbg()
 and fb_err()
In-Reply-To: <20230605144812.15241-13-tzimmermann@suse.de>
References: <20230605144812.15241-1-tzimmermann@suse.de>
 <20230605144812.15241-13-tzimmermann@suse.de>
Date:   Wed, 07 Jun 2023 11:00:47 +0200
Message-ID: <87fs73fxz4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Fix cases were output helpers are called with struct fb_info.dev.
> Use fb_dbg() and fb_err() instead. Prepares fbdev for making struct
> fb_info.dev optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

