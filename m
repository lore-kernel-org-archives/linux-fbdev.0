Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51006C001E0
	for <linux-fbdev@archiver.kernel.org>; Fri, 28 Jul 2023 15:41:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbjG1Pld (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbjG1Plc (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 28 Jul 2023 11:41:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF0CE4F
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 08:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690558847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iOF0PHPrH3dJgyFOQfSRoJXhdPgnnuEOgE1WVBQPBqw=;
        b=g6SiqprC/HTF+uop2gLFvJmEVIwer4MmIZNxFPg59ZFMwr9dMxRwW156WAOAyg2uZkq7hC
        jpclbC4nEputF5XVjV7u0u5iT/fU/yTzvFwBcusKW7A2nty9nMCZvFBBVsDBco8pQvHFq5
        7+u/gVb+ZZnBbIq0yXKkTXQZY5PLvy0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-dqaLrtUoOTK_2DMkjwTIkw-1; Fri, 28 Jul 2023 11:40:45 -0400
X-MC-Unique: dqaLrtUoOTK_2DMkjwTIkw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3fbdd5d09b8so13657145e9.1
        for <linux-fbdev@vger.kernel.org>; Fri, 28 Jul 2023 08:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690558844; x=1691163644;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iOF0PHPrH3dJgyFOQfSRoJXhdPgnnuEOgE1WVBQPBqw=;
        b=k+qZ6mDHgw+W6HEYNCFnZytxDv+KPLXLXfsMZepqTZaBDZ0XH0iVmueivhkadPmn89
         FxmnEgVnKobK9q9Y7OTwMGG/8dCpytDdMi4LG264Fa9in3EeHFcTAj+ETVJaLSzFvIIT
         mDUSkEiz9E6iWQgeF5z9QTnGmT40XjO2E5EddJdeDYReQ/AWj5a+oYCEreya7dkmpmmO
         B6mJ3ou5owA4QUYzLJ+gCl8FAZf0JUWy1QfxhDEjwXn7/KwNji5BLNvh2s/hzX9BTAdB
         vEUSv2tygCzPqnR1v+pYJwDiCZDnEZgbzV97zkTCKSKzHfkKJaM6FoGaCq1tqq4YWheV
         3uSw==
X-Gm-Message-State: ABy/qLbUMwYb1efDm/KEgiKCl1YWMfoAQgRh3b8+t9ms3pHBrbXbbqx4
        lOd+tS1x8JRGDjyowlh26nF7cTkEnEF1315Yz07A+QVffmrRtZ1MNM2+cgpnF80ciW/wkS+dai3
        F8W3gXaO5EFbb2fBHp4hgIMtT0nyop1I=
X-Received: by 2002:a1c:4c12:0:b0:3fd:ad65:ea8b with SMTP id z18-20020a1c4c12000000b003fdad65ea8bmr2051219wmf.12.1690558844484;
        Fri, 28 Jul 2023 08:40:44 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFZkd39vTN4wXd7ZoLniUUkcL0ILftF1YPIm9kU2cl+nZOmsPjF4oBpTaV9XyaQD/ZF8TL9rA==
X-Received: by 2002:a1c:4c12:0:b0:3fd:ad65:ea8b with SMTP id z18-20020a1c4c12000000b003fdad65ea8bmr2051199wmf.12.1690558844162;
        Fri, 28 Jul 2023 08:40:44 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l10-20020a05600c1d0a00b003fd2d3462fcsm9244050wms.1.2023.07.28.08.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 08:40:43 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/3] video: fbdev: ssd1307fb: Print the PWM's label
 instead of its number
In-Reply-To: <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
References: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
 <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
Date:   Fri, 28 Jul 2023 17:40:43 +0200
Message-ID: <87lef0xcw4.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> struct pwm_device::pwm is a write-only variable in the pwm core and used
> nowhere apart from this and another dev_dbg. So it isn't useful to
> identify the used PWM. Emit the PWM's label instead in the debug
> message.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

