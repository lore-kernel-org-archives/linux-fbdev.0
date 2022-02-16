Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB6B1C4332F
	for <linux-fbdev@archiver.kernel.org>; Wed, 16 Feb 2022 12:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiBPMe7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 16 Feb 2022 07:34:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232850AbiBPMe6 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 16 Feb 2022 07:34:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 907B41F79EC
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Feb 2022 04:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645014885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fu6TzmgbMlYQuSDAMHkyuQBli3G2K2SmS218sexp9ic=;
        b=VNukAEq4tQjN3l1MSMgWGQT4DaRVFuTyk+0kKOikl1ZXpcrFVFg8oGAItoFP85T2g8meWA
        orEeFlLaalfvUU9wmjtgFAjsEiGcgLuQJ1rruaxr3M8RWWFqZSwfPD+bA/+Kv6yjeqkmKc
        WiEeR2Ykj3PBFSrcQXhAI6muhONHVP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-2jW9D6oPO_6J_OoY0Irehg-1; Wed, 16 Feb 2022 07:34:42 -0500
X-MC-Unique: 2jW9D6oPO_6J_OoY0Irehg-1
Received: by mail-wm1-f69.google.com with SMTP id o24-20020a05600c379800b0037c3222c0faso1615100wmr.1
        for <linux-fbdev@vger.kernel.org>; Wed, 16 Feb 2022 04:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fu6TzmgbMlYQuSDAMHkyuQBli3G2K2SmS218sexp9ic=;
        b=CI6e8QlsUPsA5k0M0Z/UdLjYrbA3C4Z6JdzovectiPwoEeGcdSgHPqvtvV3mwFD5IK
         Ko78yuhKShMh/D2vlUiDJ+kB8H9Oj2rpqFwGPrPOwCyJrGXrP8iVZvWeGE74Yj271i1e
         2G3hC1iJM7FU4x2i+Um2IjVLkqECd3c8SKR/TQf+AwTZ1P98CK/31M3Uey9iNy3brbDT
         vWZb3MfIPpQcVi5u/G2mTYqDMS4cAM2g8cfHE45qfVU6vsr7W2QaOXo9tntoVhvWPua+
         wv4c1/7AByYQd4EotNyVRUsi39nouzR146H/qBLmuiuDKCMFQl9j+/kAo8q5gSWhFdNC
         BnbA==
X-Gm-Message-State: AOAM533LrsBYHgTU1l4u0zq4XjwA2JsuO3fMlA68/VDa9z4NsEIRPP/d
        fVhD8/7fGrbMHBWQVZQNVGMW1UI/94QFwJ+zC6fGlmGgsiOzxBr7uHQoMN40YkEoI4AnAg7OQHH
        0gF2cVkMkbmFojVrqz0GFgz0=
X-Received: by 2002:adf:f005:0:b0:1e3:1957:af07 with SMTP id j5-20020adff005000000b001e31957af07mr2203687wro.311.1645014881497;
        Wed, 16 Feb 2022 04:34:41 -0800 (PST)
X-Google-Smtp-Source: ABdhPJww2pEBjWX6+qG9snaBEnYCCDQh6YGaz6Dcc7r7r2Rqwhne1V8moyLnyuF2IvLxEM9om9CJGQ==
X-Received: by 2002:adf:f005:0:b0:1e3:1957:af07 with SMTP id j5-20020adff005000000b001e31957af07mr2203675wro.311.1645014881239;
        Wed, 16 Feb 2022 04:34:41 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id l12sm32213684wrs.11.2022.02.16.04.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Feb 2022 04:34:40 -0800 (PST)
Message-ID: <2d0e88a3-8fa2-6b21-93da-1c9e6f8e3e84@redhat.com>
Date:   Wed, 16 Feb 2022 13:34:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 0/6] drm: Add driver for Solomon SSD130x OLED displays
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org, Maxime Ripard <maxime@cerno.tech>,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org
References: <20220214133710.3278506-1-javierm@redhat.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220214133710.3278506-1-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/14/22 14:37, Javier Martinez Canillas wrote:
> This patch series adds a DRM driver for the Solomon OLED SSD1305, SSD1306,
> SSD1307 and SSD1309 displays. It is a port of the ssd1307fb fbdev driver.
> 
> Using the DRM fbdev emulation, all the tests from Geert Uytterhoeven repo
> (https://git.kernel.org/pub/scm/linux/kernel/git/geert/fbtest.git) passes.
> 
> I've also tested it using the display as a VT output and even though fbcon
> seems to work, it is mostly unusable on a 128x64 SSD1306 display.
> 
> This is a v6 that addresses the issues pointed in v5. Thanks a lot to all
> reviewers that gave me feedback and comments.
> 

Pushed this series to drm-misc (drm-misc-next). Thanks all!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

