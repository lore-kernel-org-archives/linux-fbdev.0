Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A029EE801F
	for <linux-fbdev@archiver.kernel.org>; Sat,  9 Sep 2023 16:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjIIQZ1 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 9 Sep 2023 12:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346464AbjIIOjS (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 9 Sep 2023 10:39:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1844188
        for <linux-fbdev@vger.kernel.org>; Sat,  9 Sep 2023 07:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694270312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+4HcA1k/8qF1IXNw0Bg9+Q9i2TWOoU8T7hDCYKbYZ0=;
        b=G14NTEOIVYciUIIIDstqiysVj4XiQr+7voS9d7sscsNa/hX8czG0fQTbU35NKVBLWmNSfY
        0PkM6jMZNp4oObshsDJxXMRqAMjurT/yd6wUSqB6SDxEh166RIxAMZJLKqQHbCMfTc/P8C
        tQEu7+h2McPo4TRYExNYBxgJ8UVBP5Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-UjF59EsUNcmUQEQvaqHkpA-1; Sat, 09 Sep 2023 10:38:30 -0400
X-MC-Unique: UjF59EsUNcmUQEQvaqHkpA-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401c4f03b00so23297155e9.1
        for <linux-fbdev@vger.kernel.org>; Sat, 09 Sep 2023 07:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694270309; x=1694875109;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+4HcA1k/8qF1IXNw0Bg9+Q9i2TWOoU8T7hDCYKbYZ0=;
        b=r3rnxrg61iOFxlh3neolhr0CGxinbxg7pv60jT2GQ0ZQrT+xFpTqJbSGZJpxP6PfhB
         BulnT4yBRQaCQ+Ec8iBpM10d/Xu1oMHB5RCzkUZVddYO/LYgk1UxpZz3NPC4vI0bKN4e
         RtLEB157S6HIi/vSTvMLohDMSsQz+mtxjTRFq3Mgs8Ph2cOOy44ufkMNeVKs3tidYkVd
         5X6DDlbCB7dhNCFgQts4ZrVe67YIjTF/ahMFu16ntwziyW7aM/S98C1zDu9jiUNuE48N
         4osd8lwn5REcdjOl0YEGuzBjTmiokNDzPymjLuO32PvaUPI3j662iVPn7Om6DZEPIS1l
         gr/A==
X-Gm-Message-State: AOJu0YxBnO3eKm8IMBFTFnS2VNr4npqOBz6RS5jTj8glW/z0DKNxV/M9
        36P9ZbwEwSFJlHzcccWH5b6r3Kj7FqP3uqCS+ixVRVeAj8TiOyT9JF7SyWV3ydMC/YF0wYrANtH
        W18cvSwBXty8OdEpaJ+Fp0EU=
X-Received: by 2002:a1c:ed08:0:b0:401:d803:6242 with SMTP id l8-20020a1ced08000000b00401d8036242mr4639447wmh.27.1694270309542;
        Sat, 09 Sep 2023 07:38:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOej/d14sWmLizTh2i9esPauTJp58e7fPOscywQN9ddxhYmMXBFm9Ht5FE7LNRjGS+PLhdRQ==
X-Received: by 2002:a1c:ed08:0:b0:401:d803:6242 with SMTP id l8-20020a1ced08000000b00401d8036242mr4639434wmh.27.1694270309221;
        Sat, 09 Sep 2023 07:38:29 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c315300b00402bda974ddsm4869260wmo.6.2023.09.09.07.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Sep 2023 07:38:28 -0700 (PDT)
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
In-Reply-To: <87lef0xcw4.fsf@minerva.mail-host-address-is-not-set>
References: <20230728145824.616687-1-u.kleine-koenig@pengutronix.de>
 <20230728145824.616687-3-u.kleine-koenig@pengutronix.de>
 <87lef0xcw4.fsf@minerva.mail-host-address-is-not-set>
Date:   Sat, 09 Sep 2023 16:38:28 +0200
Message-ID: <87zg1vif8b.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:
>
>> struct pwm_device::pwm is a write-only variable in the pwm core and used
>> nowhere apart from this and another dev_dbg. So it isn't useful to
>> identify the used PWM. Emit the PWM's label instead in the debug
>> message.
>>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
>> ---
>
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
>

Pushed to drm-misc (drm-misc-next). Thanks!

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

