Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F16C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri, 25 Feb 2022 22:09:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiBYWKH (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233730AbiBYWKF (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 25 Feb 2022 17:10:05 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12369527FE
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Feb 2022 14:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645826972;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5PA9hg/jjTKbd4y1qX7Ux68wjGwVszX5ra4xkbOOiek=;
        b=KpTDrC50ds5O2oENtuvyrNdaqV8FSPj96JxgH7QV/gcpkcjTkNELJnPj+y0P3JNnsPbRGK
        yMY7k97BN6RjAGAON/c0w8SMlAXeKzxpkoZju+7J1/4vs3yL/uL8ntFfhKddKe3UQbL3Cd
        x5wPeunei1ZXzQqPwtEIQZy+L3RZWL8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-114-L9vygpzgNjyzICrrqGdejg-1; Fri, 25 Feb 2022 17:09:30 -0500
X-MC-Unique: L9vygpzgNjyzICrrqGdejg-1
Received: by mail-wm1-f72.google.com with SMTP id l31-20020a05600c1d1f00b00380e3425ba7so1988036wms.9
        for <linux-fbdev@vger.kernel.org>; Fri, 25 Feb 2022 14:09:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5PA9hg/jjTKbd4y1qX7Ux68wjGwVszX5ra4xkbOOiek=;
        b=0H7Dj+JGaduF7n+2QugRKt5DPazDwGbQ7RzVJ+ONoNFRrfc/BHjSZGYF7ZsHmsB5kN
         W2Hs9faoqtz6AuGobfaWIhJ2yQkNhTeSPtal+RCxtcqLyDr7d2UlzEPAd5VOIGQD1/B1
         uB3pZTbs6AYu87YYIBHAa99eIa7BHac8WeRVI5ZZ429oaEDY276kOMdb1SyHW0Oo2ByT
         lk0xSJfD4+t6g61WvW1G91J4efLxy93wx35odjH5Kq5ajG6bHfZDl509CrI4cTy5d2tW
         ezI4sDCdaKA8WGgYQjl1bGkeuFJ5dPelxwldmv1aql604WAgChAoUywDTr2YdQR71rkL
         V/Jg==
X-Gm-Message-State: AOAM530h3eH9e33JZJQBBqSAxpYv/jvgOkW6eIBE5fP+fgao+x2s8xtq
        zX1NtFJz/0j4920wlZQK2niSKHSFtKdwW0xkwxXB+C702usIec91pfTQTcQyY3PfJVTttsHIVW5
        DT/CGQ0ycMwUBTOoVvgYPP+0=
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr4329864wmq.20.1645826969212;
        Fri, 25 Feb 2022 14:09:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRz8kqXC26lmDuZDgPn8lbcKVBuJ71tDPuJGSpWOnTZ7pH1GMfhj1Tg6aY60ZvqiZQtVKhzw==
X-Received: by 2002:a05:600c:3483:b0:380:edaf:d479 with SMTP id a3-20020a05600c348300b00380edafd479mr4329851wmq.20.1645826969002;
        Fri, 25 Feb 2022 14:09:29 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b0037df2e5d8c9sm4311870wmg.27.2022.02.25.14.09.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 14:09:28 -0800 (PST)
Message-ID: <b87cf8eb-a27f-5060-7941-3b374c2792dd@redhat.com>
Date:   Fri, 25 Feb 2022 23:09:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 1/3] sysfb: Make config option dependencies explicit
Content-Language: en-US
To:     Michal Suchanek <msuchanek@suse.de>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Martin Mares <mj@ucw.cz>,
        Helge Deller <deller@gmx.de>, Ard Biesheuvel <ardb@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        linux-kernel@vger.kernel.org, linux-video@atrey.karlin.mff.cuni.cz,
        linux-efi@vger.kernel.org
References: <1f13e6f2-a87c-83ac-7119-8632c8c8ac8e@redhat.com>
 <a0fa41e9186653e4c41ad0a28259e5cdc71b1f66.1645822213.git.msuchanek@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <a0fa41e9186653e4c41ad0a28259e5cdc71b1f66.1645822213.git.msuchanek@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Michal,

On 2/25/22 21:51, Michal Suchanek wrote:
> efifb and vesafb requires sysfb implicitly but this is not stated in
> Kconfig. Add the dependency.
> 
> With that all drivers that require sysfb depend on it so it can default
> to disabled.
> 
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---

Thanks for the patch. This makes much more sense to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

