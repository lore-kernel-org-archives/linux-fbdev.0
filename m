Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC932C433FE
	for <linux-fbdev@archiver.kernel.org>; Thu, 10 Feb 2022 17:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240735AbiBJRzx (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 10 Feb 2022 12:55:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiBJRzw (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 10 Feb 2022 12:55:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 577FF1A8
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Feb 2022 09:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644515752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pgYKgbH/aywvATf7zLUXZmomBX6TKWirDhHOAVvfKM=;
        b=OgSgGqQlmfjf0OsfqDfVNKDiQQ4QRY1uTIo+QtIiKQGRs4GNxj65fDGuWe2D0rGbpogqet
        AlnqMtcgs0Lf2v9PXbliRzit0tRhxfhXmfX2FthgH0yNYpiGWsNtOqQFaGA8669VIWwhGV
        vAXP24Y2J2rIDA1xjJO6hEsDWopfpeM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-551-3xAMCYfLNNO-h71kKkRW_w-1; Thu, 10 Feb 2022 12:55:51 -0500
X-MC-Unique: 3xAMCYfLNNO-h71kKkRW_w-1
Received: by mail-wm1-f70.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so4655412wmb.7
        for <linux-fbdev@vger.kernel.org>; Thu, 10 Feb 2022 09:55:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=2pgYKgbH/aywvATf7zLUXZmomBX6TKWirDhHOAVvfKM=;
        b=bCYiurHotaZhnGuFWP0S/BalKnJtJ/oSeXvYnJR7ghqQ9SY9WQGOvtvMz1gUx0e4F3
         Ddo93/lv2BeK12OKllMtm44p+U9f8EEJ3+fn/DHQFPZXoz2SwnFPwEcrNPmPGqRcO2pM
         0WIqhJG5vWLk/hZ5E3oJFzbfeurUyf9QkaM1b1ehst0YAgCpZd4FydjibrZvjaIix+bP
         gr/zk9Aa69SDRWAKImn1MXndiDlK0m5kW2ZKlzl1rebnuH+Qa45BpZsrkJEmZLIDzl0F
         Medx9poc1u9gnG8IA8nP4SbZNWF5HJx+aq76v+SHjQ9tmoRGYVoyCSha9j+28u6C2IV+
         O4ag==
X-Gm-Message-State: AOAM533OAhrHG7PyYgRiVGby7XyCu3DppvjbWL01XfPKjYrqAwEPnNgR
        KD/P9NqZbcdj1HoIyUmG1a/52836ZjcfnvDcHvBQAYJH6/SOORT8D4q9jKK2B+aTyXAzK+3UBcF
        HbySo98PfcVMc0cjy2kuVzqA=
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr3110906wmr.141.1644515750096;
        Thu, 10 Feb 2022 09:55:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzztOtP2nPNM37UZbRdKgmrkAzYQV0Pr1R7MI99JcWycnjK/AG6TWJyvSRPiuS1u8x26j6AYA==
X-Received: by 2002:a05:600c:501f:: with SMTP id n31mr3110886wmr.141.1644515749879;
        Thu, 10 Feb 2022 09:55:49 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p8sm21716128wrr.16.2022.02.10.09.55.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Feb 2022 09:55:49 -0800 (PST)
Message-ID: <e910fc2f-2acb-b81d-4b8c-532562952aeb@redhat.com>
Date:   Thu, 10 Feb 2022 18:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/7] drm: Add driver for Solomon SSD130X OLED displays
Content-Language: en-US
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Sam Ravnborg <sam@ravnborg.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux PWM List <linux-pwm@vger.kernel.org>
References: <20220209090314.2511959-1-javierm@redhat.com>
 <CAMuHMdVs750iE=kP1vabwgsGOb8sHc8aC5k=HwCU32CURnYktw@mail.gmail.com>
 <CAMuHMdVKmfOAdTG70KF+eAw3noXHSGCPyGjw3cSVyQOvzUafhQ@mail.gmail.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <CAMuHMdVKmfOAdTG70KF+eAw3noXHSGCPyGjw3cSVyQOvzUafhQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Geert,

On 2/10/22 18:06, Geert Uytterhoeven wrote:
> On Wed, Feb 9, 2022 at 1:19 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> On Wed, Feb 9, 2022 at 10:03 AM Javier Martinez Canillas
>> <javierm@redhat.com> wrote:
>>> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
>>> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
>>
>> [...]
> 
>> The logo is not shown, even when I create a 16-color or 224-color
>> version of the small monochrome logo I'm using.
> 
> My mistake, I messed up the hook-up, causing it to pick a different
> logo that was too large to be displayed.
>

Great, thanks for all the testing.
 
> Of course it's using the 224-color logo reduced to monochrome instead
> of the real monochrome logo, as fbcon thinks it's running on XRGB8888.
>

Right. Once the patch lands, I'll look at wiring up the needed support in
DRM for the drivers to be able to advertise 8-bit grayscale and monochrome
to avoid the unnecessary conversions and to have feature parity with fbdev.

But I just wanted to do it incrementally and first port to DRM as first step.
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

