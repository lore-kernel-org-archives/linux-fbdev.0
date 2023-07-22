Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E35EB64DA
	for <linux-fbdev@archiver.kernel.org>; Sat, 22 Jul 2023 10:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjGVKaR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 22 Jul 2023 06:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGVKaQ (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 22 Jul 2023 06:30:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E8FA270F
        for <linux-fbdev@vger.kernel.org>; Sat, 22 Jul 2023 03:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690021772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZLRLDZZbasI3kPxd2PCiFXEwaPIuFeJBoo7oz3+UCU=;
        b=cetov833HA282mK96GhekqGFH9OdLnUrxR4VX+BPOdk6ycw0q59nllxX0kH7gpkIPfC18i
        Hiir2X8vr03KxRC6nuVievT59D70i2pd47spVAMZ8T+0del9cZJAzao4H6aD0N6Hcx8Zjc
        TggaJE0lt/Qtw4nTyhnnELjUdRrZ4pE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-0NkElijXOLi8ByBl4X4mDQ-1; Sat, 22 Jul 2023 06:29:28 -0400
X-MC-Unique: 0NkElijXOLi8ByBl4X4mDQ-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31443e13f9dso1445452f8f.0
        for <linux-fbdev@vger.kernel.org>; Sat, 22 Jul 2023 03:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690021766; x=1690626566;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qZLRLDZZbasI3kPxd2PCiFXEwaPIuFeJBoo7oz3+UCU=;
        b=D47fsNF8glv38gVn5h1UY9QgiXDfMiQdFysWfjiDXxNVGSku6mh5EUECARIY2Ck3Z0
         +GvK73AgStn0NHmZS7dgOKGR4NbV6CI6E1mdlltcfG8kBD8WaaLQEF0o4nN2iG9QgETF
         LIFlR0QYRXztrDZ5tOYnhG6n+gO1JywTuJ9yAHkciEz4eWkZPChHLhruZTGH3vBtsYn4
         Jl8BdbSpSwyciwK+EkLg6uo2yKs8uV77jzc3tLSk2fkGspydzUnXXeSSiPRMMiDRL53Q
         0NjZtgnesQ8Q7yebo5GRfsL9BjY0dpnOdc8Ysy5y+MTTsl2/NPa64U7bJrxnJTNfOwAv
         bk1w==
X-Gm-Message-State: ABy/qLZnUSs3GzdQEZeXhrr40OutSve1i9N/chknlqaGg/HIa+AhNYSg
        6p2MKC9fxIkIO3u7akDWG1aK+yIALPC3gb0bn1zK3CFvI8sglPex5s9QrUXMALV0nn7eQoomNc1
        I1+AV+RKpdYOUoKfnI1njysE=
X-Received: by 2002:a5d:594c:0:b0:317:49a2:1f89 with SMTP id e12-20020a5d594c000000b0031749a21f89mr442339wri.1.1690021765925;
        Sat, 22 Jul 2023 03:29:25 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG0CW3cuTzgVY3orLwkAx2H5NfB4jIEo8bf4kpoNIbZm8TlKtXSwhP5qmSJP+CHTVpIhD+K5A==
X-Received: by 2002:a5d:594c:0:b0:317:49a2:1f89 with SMTP id e12-20020a5d594c000000b0031749a21f89mr442306wri.1.1690021765546;
        Sat, 22 Jul 2023 03:29:25 -0700 (PDT)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t10-20020a5d690a000000b00316fc844be7sm6553821wru.36.2023.07.22.03.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Jul 2023 03:29:25 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Helge Deller <deller@gmx.de>,
        Ingo Molnar <mingo@redhat.com>,
        Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee@kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Nipun Gupta <nipun.gupta@amd.com>,
        Oded Gabbay <ogabbay@kernel.org>,
        Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v6 0/4] Allow disabling all native fbdev drivers and
 only keeping DRM emulation
In-Reply-To: <20230719081544.741051-1-javierm@redhat.com>
References: <20230719081544.741051-1-javierm@redhat.com>
Date:   Sat, 22 Jul 2023 12:29:24 +0200
Message-ID: <87h6pwtf23.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Javier Martinez Canillas <javierm@redhat.com> writes:

> This patch series splits the fbdev core support in two different Kconfig
> symbols: FB and FB_CORE. The motivation for this is to allow CONFIG_FB to
> be disabled, while still having the the core fbdev support needed for the
> CONFIG_DRM_FBDEV_EMULATION to be enabled. The motivation is automatically
> disabling all fbdev drivers instead of having to be disabled individually.
>

Pushed to drm-misc (drm-misc-next). Thanks all!

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

