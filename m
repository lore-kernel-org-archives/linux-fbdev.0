Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D177EB8FB6
	for <linux-fbdev@archiver.kernel.org>; Wed,  6 Sep 2023 10:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbjIFKOY (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 6 Sep 2023 06:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238819AbjIFKOY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 6 Sep 2023 06:14:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB05171D
        for <linux-fbdev@vger.kernel.org>; Wed,  6 Sep 2023 03:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1693995220;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7P8kh6CIVjrAvpwiqFyzHCIsBPa3I3p11VQyjXy+3Zk=;
        b=QxEAdR37iI40fhyNEu1CCodL3H/R7qsMZq9Fbbbt4HZRYtOc3EBVHydHxBKeGpeU1p4tHY
        rGCtGT1/rvVX2CdjDbDtfGLGKeq/dYrEf92bCZ6m7o1MNwSTok9M9A0dNwscKgGGUmln1H
        Plu4NTRzCh6FTtwRsgcJN6YrzFJc5+E=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-_XKrcCeOM_au2hxw0WPiww-1; Wed, 06 Sep 2023 06:13:39 -0400
X-MC-Unique: _XKrcCeOM_au2hxw0WPiww-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401bdff6bc5so19954995e9.1
        for <linux-fbdev@vger.kernel.org>; Wed, 06 Sep 2023 03:13:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693995218; x=1694600018;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7P8kh6CIVjrAvpwiqFyzHCIsBPa3I3p11VQyjXy+3Zk=;
        b=dmq/QanH76vzCUfgBzNF2phJ1x5QRh6/YVQdYL7petmu7t57IqOBHxRXnlQWn/E6/w
         wrup/WaSBvYzusEY9UrCnDFUD63g14IaOLCaKapmCAO2eLBprdsCutJ2/MJDR6mkn3Yb
         X3424qdNyUKQb5CsMwt0J6qIcEsR30MQ86aYpBf9BoxUFaKabE+lZHHk3tqbq76shhS4
         +lnQBn/jRze6ctCMej5azRq7P00jYLEVkkl63PnUKqVExT86/ZErIPGZG9mm/9J7SnS+
         9FQQD8CC+ZRzmBnG45elJpAJqWzW3GQYPlrZOnrtuMgE+XYmkm2JmEyW95FMMpIaMacY
         j4/Q==
X-Gm-Message-State: AOJu0YwGvFqcVrJ9isLNj8oJr6rrnPwpQd/4K+6De4YWQ1QtT0pQgxEC
        a/+zEvRkzRDQbpjNM7lQo108Ohc15pZqyFHfUz7GaYPWK7PhTUInTziH9BzEgU9oTymXC2JvxIN
        ZZvZq7NAnp6llPflAHe0x5vU=
X-Received: by 2002:a7b:cc8f:0:b0:401:7d3b:ccaf with SMTP id p15-20020a7bcc8f000000b004017d3bccafmr1731096wma.4.1693995218314;
        Wed, 06 Sep 2023 03:13:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFGa0rqlpwHCD3ArX4qRxa6wt4EmB6m2UPyb4S2zhNfk6B8JHfjyXVCJwwpoBZ8fsicra3CMQ==
X-Received: by 2002:a7b:cc8f:0:b0:401:7d3b:ccaf with SMTP id p15-20020a7bcc8f000000b004017d3bccafmr1731087wma.4.1693995218007;
        Wed, 06 Sep 2023 03:13:38 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c021100b003fefca26c72sm19443756wmi.23.2023.09.06.03.13.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 03:13:37 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        daniel@ffwll.ch, sam@ravnborg.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     linux-kernel@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 7/7] fbdev/core: Clean up include statements in fbmem.c
In-Reply-To: <20230829142109.4521-8-tzimmermann@suse.de>
References: <20230829142109.4521-1-tzimmermann@suse.de>
 <20230829142109.4521-8-tzimmermann@suse.de>
Date:   Wed, 06 Sep 2023 12:13:37 +0200
Message-ID: <877cp34nji.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Remove all unnecessary include statements from fbmem.c. Most of
> them were for functionality that has meanwhile been moved into
> other files.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

Acked-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

