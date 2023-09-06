Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9702EB8FAD
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Sep 2023 09:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjIFJrW (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Sep 2023 05:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbjIFJrV (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Sep 2023 05:47:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D16A1BD2
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Sep 2023 02:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693993535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UlEOBu/VE6tjdzL9UJOCpexRbWh3hX2rULyWpu7l158=;
        b=cilXly8NEdvxAyKzLGZlv06W8dA75Ea6BSaoIp2ClcIdR5an/I8fCSJoEbRih1+pk13eqb
        VeT318nob5fuZf3Hy81u0V2nDBrUL2dssxdzqAVPrsd365jMIX5sBbiVVvp7xDzHbqqcxn
        gtWEbMcVYBvv7NuHVujOh4y0mS6p/pU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-UQT7IoDrNKGyRgDtE7xkew-1; Wed, 06 Sep 2023 05:45:34 -0400
X-MC-Unique: UQT7IoDrNKGyRgDtE7xkew-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-401ea9bf934so21390915e9.2
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Sep 2023 02:45:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693993533; x=1694598333;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UlEOBu/VE6tjdzL9UJOCpexRbWh3hX2rULyWpu7l158=;
        b=ktXGEWhQy0pXeV2yb6IUJEzoGytuNBEBf+qWnw1fc3pBos+3fC9h90EtvWe6U9hmnk
         slsnHreALkMS4gE34XKClSTd1JFqLxojA8lvwHErRANmCuDRVg2qq/xHlMkn3GziBJA7
         uKXDESjj0JRUtRW+vSDELHSqQCweND3gF9IskkOeGxYIc7mPA37hyRM8Aavf9MpyibTz
         9vzqOwDyn83wdCKAnSK8Kt7w8LCfndJneqkvlKVddj91GdHaXzVlSRZG5xS4bRZJZvQt
         3Ldhxho1sGhjJ6ddnHYylO4hGOdSTJ8x6ozTTV/JQ4fBilMI98c6L78HGSaHl/eudIZ1
         fpIA==
X-Gm-Message-State: AOJu0YwczB6jOhjGvbV3jCPOw1SiiX108yLWUsMxpgd+ri/dHqnN8Izc
        EAAaT+uO65bjBHfQ42pdhL0S+4ul1ZIDDni1iSnDvpNjcyR0ImJPq8/QRlFjDFSAW2efZIwzzbs
        OqVCrmcHQSv0hFQRXdE7iebc=
X-Received: by 2002:a7b:c01a:0:b0:400:419c:bbde with SMTP id c26-20020a7bc01a000000b00400419cbbdemr2083804wmb.18.1693993533251;
        Wed, 06 Sep 2023 02:45:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvzjMv9fXcOqlGgHExO0/Bky5TAsfqUJ4gFKWD/812OOB2n+3Ka+NKF8N9/cFpNJ2b058T6g==
X-Received: by 2002:a7b:c01a:0:b0:400:419c:bbde with SMTP id c26-20020a7bc01a000000b00400419cbbdemr2083793wmb.18.1693993532950;
        Wed, 06 Sep 2023 02:45:32 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id w17-20020a05600c015100b00401d6c0505csm19255994wmm.47.2023.09.06.02.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 02:45:32 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 1/7] fbdev/au1200fb: Do not display boot-up logo
In-Reply-To: <20230829142109.4521-2-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-2-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 11:45:31 +0200
Message-ID: <87o7if4ouc.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> The fbcon module takes care of displaying the logo, if any. Remove
> the code form au1200fb. If we want to display the logo without fbcon,
> we should implement this in the fbdev core code.
>

Agreed. I see that this code has been since the driver was added in 2006,
I wonder if was ever used. Enabling a fbdev driver without fbcon doesn't
seem to be a common configuration.

> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

