Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879DC2BA4C
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 11:18:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbiAZLSg (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 06:18:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233442AbiAZLSf (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 06:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643195915;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=srD1l04gPQ84q1XF/RWjCuwwGgitsqKSn4fv06ciBhg=;
        b=BOq1JhOQ6S5CBzLMafGtyDPZsi8Ip66bN/ZQDczOdtou3QFz8vfAU11O/uvZAnsl88tyn9
        Ag42FArFJKYuGyZuX70P6b9Ab/o+uOchbFdPmeNwH6msPuJ+Kn4/Jd5ehWfnxDEPKMlIPe
        aunQR60Au1OiUBAx5idNc5eDjDW2gCU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-572-0_5RF-ZnNJK5mifVa12KVA-1; Wed, 26 Jan 2022 06:18:33 -0500
X-MC-Unique: 0_5RF-ZnNJK5mifVa12KVA-1
Received: by mail-wr1-f71.google.com with SMTP id v28-20020adfa1dc000000b001dd1cb24081so1731920wrv.10
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 03:18:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=srD1l04gPQ84q1XF/RWjCuwwGgitsqKSn4fv06ciBhg=;
        b=eAizsHakhe3hUclyNB+OqMGQGUIIo0NJBIerT6FoCOR9bJyFiJFeJ01ezTBEVI3w4c
         PGj2dhz2zX8ZQ4G5tkda10e6woQtq2ptyQZVeVowZ//6eHM997GJM4EjToruAi1DTYcx
         wES7icU+9FpRrypiHK/5yZP4xQiZaoOyvVHNJB4JQ4VihcUC3vdyqWowdvIoN6O14XdQ
         PcGKql8plBxi1LPT2/RLPwsR3Wb7VwwPouHMsSF0EnbO6SPJELIzDjeYjrV3iHxy/3TO
         c8Lr+rykcfREIll1Wn+1dLZGLG4G9dRYlgMml75yKHf8lm1MaWtQ9s/AstDiN7i/HIYM
         tTWA==
X-Gm-Message-State: AOAM533x/ctYDU2Pg8hACDGgcu08GC+vLOBAFDDmfp0DIdo2O6dNea8S
        lgkQiQM9M5CMRfH9wGPYBhSOZD+SQxhePzL1WttprfEGjwb0JdcxBE4XWZICjC8bA5CgohMqFPx
        xO+DQ8pfXgfjURJJS6Ckp2UE=
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr1586795wrz.66.1643195912647;
        Wed, 26 Jan 2022 03:18:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyvCzW4Jn73KJItw350M3F/f6JTN+7T8OA7kDxsaF2hqvwBivMpTbBXPxCTm3unY1Mql6OAYg==
X-Received: by 2002:a05:6000:156d:: with SMTP id 13mr1586760wrz.66.1643195912374;
        Wed, 26 Jan 2022 03:18:32 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id i17sm19005103wru.107.2022.01.26.03.18.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 03:18:32 -0800 (PST)
Message-ID: <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
Date:   Wed, 26 Jan 2022 12:18:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>
Cc:     Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/26/22 11:59, Helge Deller wrote:
> On 1/26/22 11:02, Andy Shevchenko wrote:

[snip]

>> P.S. For the record, I will personally NAK any attempts to remove that
>> driver from the kernel. And this is another point why it's better not
>> to be under the staging.
> 
> I agree. Same as for me to NAK the disabling of fbcon's acceleration
> features or even attempting to remove fbdev altogether (unless all
> relevant drivers are ported to DRM).
> 

But that will never happen if we keep moving the goal post.

At some point new fbdev drivers should not be added anymore, otherwise
the number of existing drivers that need conversion will keep growing.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

