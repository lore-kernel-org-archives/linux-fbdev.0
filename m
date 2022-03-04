Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23B8C433F5
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Mar 2022 20:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiCDUsw (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Mar 2022 15:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiCDUsv (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Fri, 4 Mar 2022 15:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AD9122EDC6
        for <linux-fbdev@vger.kernel.org>; Fri,  4 Mar 2022 12:48:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646426881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIKaFpflRd9hwR16NlF6OnU9QoRFMeWutPRp1q0p0c0=;
        b=Kymd+0nor5iFAX8KXPTdCHiaaTy2tUT7Xwzn6cz/MyzOeXekeb/BZ8WUJiWuO8agipjEpn
        U5r6XoDRVoI8QCyDxBiy9eSIJMeAyMPw23qWxWSjlyX6GrJ2512/0s/Bgxh+pyL2Hto/CX
        rKp5yJlOTlnwr/9NWSL0jRfGypW2K0w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-519-8KuYjqMdNQKNtkFQ6M50Ew-1; Fri, 04 Mar 2022 15:48:00 -0500
X-MC-Unique: 8KuYjqMdNQKNtkFQ6M50Ew-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1c21d7000000b003552c13626cso4588566wmh.3
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Mar 2022 12:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fIKaFpflRd9hwR16NlF6OnU9QoRFMeWutPRp1q0p0c0=;
        b=gn72bCpyPjuWiQrz/+HM9FCwOlSjvBZt0Tno+04L+hJFGnKtkqYgGD/gF3wL4h+W+h
         0kQTlEapdFJnq2A9ZoOWIFGYf6V6k/K6nHCK5kCCPJcPoZ/5s8o62AAdIcB51KSeC+ZM
         ffTBgTyvnn7qfv1AjVGjK8aBjwCVN/ZKh7xc05nS353u4e2DVzQZl2p65VNKH2kKqlcj
         I5rY9ozx5I0p3GfuG6kWemPZjGb9BvT9SoEJlQDsYCENJ9Oo6xW8RwKr36zv/fAuzrmO
         5pbPFeXSCv4M8MDoeKxroOyVr6RuF+Lj9r3LZTSx3n8Ce2Dr2OnjKPoLgkRjdJCUhgXl
         2LTA==
X-Gm-Message-State: AOAM531cbImHT7O+WI74mK1O/0W8lw8EkSEfAwmNY0MkQnYTySDwfvmc
        v0s2uWy1P9OtSSeTAca4XqzlsoSzaR3XdoaaFKzrOt85LIOlhk7w6Jx7zzKf6NN8RBdcMT0ZBqB
        9i+kbpSZggzfUWDi+BXXW/dY=
X-Received: by 2002:a5d:6c66:0:b0:1f0:5fd5:697 with SMTP id r6-20020a5d6c66000000b001f05fd50697mr365415wrz.65.1646426878900;
        Fri, 04 Mar 2022 12:47:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzltMdM718VwuVL5pcJNjWElXTGeJCCvXaeW2MlBTYMP981ds1+0SMQ7OOkDx5SiXxjBKq6wA==
X-Received: by 2002:a5d:6c66:0:b0:1f0:5fd5:697 with SMTP id r6-20020a5d6c66000000b001f05fd50697mr365399wrz.65.1646426878644;
        Fri, 04 Mar 2022 12:47:58 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm5110984wrw.57.2022.03.04.12.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 12:47:58 -0800 (PST)
Message-ID: <8d1c3caf-96ad-ae4c-021e-ac38f179dfcb@redhat.com>
Date:   Fri, 4 Mar 2022 21:47:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] simpldrm: Enable boot time VESA graphic mode selection.
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc:     linux-fbdev@vger.kernel.org, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>, David Airlie <airlied@linux.ie>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Helge Deller <deller@gmx.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-video@atrey.karlin.mff.cuni.cz,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Maxime Ripard <maxime@cerno.tech>,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Daniel Mack <daniel@zonque.org>
References: <20220218093334.24830-1-msuchanek@suse.de>
 <354f3cfd-bfa0-3ebe-3d67-705423d9294e@suse.de>
 <20220302193846.GT3113@kunlun.suse.cz>
 <2ba8497f-ba6d-558b-d782-bb3ee67d23ec@redhat.com>
 <81f87874-4aa8-265d-a0ed-c8a67708a92a@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <81f87874-4aa8-265d-a0ed-c8a67708a92a@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Thomas,

On 3/4/22 21:00, Thomas Zimmermann wrote:
> Hi,
> 
> I've merged the patches into drm-misc-fixes. Thanks a lot to both of you.
> 

Ard already picked these through the efi tree:

https://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git/log/

> Best regards
> Thomas
> 
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

