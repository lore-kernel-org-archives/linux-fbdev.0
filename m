Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A8FC28CF5
	for <linux-fbdev@archiver.kernel.org>; Wed, 26 Jan 2022 13:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241533AbiAZNrj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 26 Jan 2022 08:47:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241628AbiAZNri (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 26 Jan 2022 08:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643204857;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xq9qXfs6mYq/UfTYZlfXKoJk7bb8Idtqn7KKr27tJeY=;
        b=bONizZyyC0bqldXQ+kQWfVadWSdBtWVCsGeCwthShSsmCqf8yDxPQwrnUdKRhSpRp7IwED
        SZhUzDu7E8ved0F/j6YK1Ec4ljsEAxhc/qiFroHjkTmKzJg6kvvToaZRBsIH4Kca2VXfnm
        dN4pmZqTgF798E9FCndcEbn+kXclC/g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-oz5wO9e3OQ2HpdqwAAw1bg-1; Wed, 26 Jan 2022 08:47:36 -0500
X-MC-Unique: oz5wO9e3OQ2HpdqwAAw1bg-1
Received: by mail-wr1-f70.google.com with SMTP id b3-20020a5d4b83000000b001d676462248so4351995wrt.17
        for <linux-fbdev@vger.kernel.org>; Wed, 26 Jan 2022 05:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xq9qXfs6mYq/UfTYZlfXKoJk7bb8Idtqn7KKr27tJeY=;
        b=xnO+RTvi0SGFwERohjd1kGZzKKbZnhtRpVjUGHJ0kq252Ylw0mtSij/OEo1ylI6hCl
         RS2HD3wXJMmlU9vNqOF7xtK/mKG4Qqyiiad5edFLgr6A7LDuGyU6sQ/YVvZiiDgHyaw7
         nDA+zWI+2fWCMYfDbxwPRIAKH3aQno9Adr3g81hU2gN6kud6LNfp8qohvpyxHaVDkWgi
         tLe9OuAs/nKJAQCqlyNNVOAX6niax/Fcyos7fA6YqBurW+rIs7eytI5ToNjkARrVVtXO
         0unaCUOvH1GPxJpTTqHCyEA9Qc5M3/tNsrqPYyIoA94RlhXOBoIalq7oThiBzZPXGm/a
         BfeA==
X-Gm-Message-State: AOAM530ErLtRzHRTjLMysVAhzpMjrkVcDCPenv3/C54RMwrx4cTpjuFS
        Pf9eNCoK3Aw0nEaxSStI1uVPalXSalSpMohlky6ap1HlZnaJYiuvq5gNkOfhxtLc2SrVC7wnjh7
        2ZX75mmJlnPo56xFnWycSprU=
X-Received: by 2002:a1c:f404:: with SMTP id z4mr7537089wma.165.1643204854941;
        Wed, 26 Jan 2022 05:47:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxs81KYxiPF/pMoFmGo74Ky9xgWpfukUAN7+fK2cyeIPPH1/2P88Q/Z9OzeoSa7tZySgGcZpA==
X-Received: by 2002:a1c:f404:: with SMTP id z4mr7537069wma.165.1643204854684;
        Wed, 26 Jan 2022 05:47:34 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id n2sm22869132wrw.63.2022.01.26.05.47.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jan 2022 05:47:34 -0800 (PST)
Message-ID: <f6ffe9bb-8683-4061-c876-1d559267ebae@redhat.com>
Date:   Wed, 26 Jan 2022 14:47:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v1 0/4] fbtft: Unorphan the driver for maintenance
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Helge Deller <deller@gmx.de>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Andy Shevchenko <andy@kernel.org>, linux-fbdev@vger.kernel.org,
        Michael Hennerich <michael.hennerich@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Phillip Potter <phil@philpotter.co.uk>,
        Carlis <zhangxuezhi1@yulong.com>,
        Lee Jones <lee.jones@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
References: <20220125202118.63362-1-andriy.shevchenko@linux.intel.com>
 <991e988b-7225-881b-a59a-33c3eae044be@suse.de>
 <CAHp75Vc2cjHkJwNSiJ-HSWBG=DYy68uvD7QQzNdRp3mQxoY1nw@mail.gmail.com>
 <3877516e-3db3-f732-b44f-7fe12b175226@gmx.de>
 <b13c0634-e766-74db-ab1f-672f5d0c04d6@redhat.com>
 <YfFMSkhbvHaR0YNE@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfFMSkhbvHaR0YNE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/26/22 14:27, Andy Shevchenko wrote:
> On Wed, Jan 26, 2022 at 12:18:30PM +0100, Javier Martinez Canillas wrote:
>> On 1/26/22 11:59, Helge Deller wrote:
>>> On 1/26/22 11:02, Andy Shevchenko wrote:
>>
>> [snip]
>>
>>>> P.S. For the record, I will personally NAK any attempts to remove that
>>>> driver from the kernel. And this is another point why it's better not
>>>> to be under the staging.
>>>
>>> I agree. Same as for me to NAK the disabling of fbcon's acceleration
>>> features or even attempting to remove fbdev altogether (unless all
>>> relevant drivers are ported to DRM).
>>>
>>
>> But that will never happen if we keep moving the goal post.
>>
>> At some point new fbdev drivers should not be added anymore, otherwise
>> the number of existing drivers that need conversion will keep growing.
> 
> This thread is not about adding a new driver.
> 

It was about adding a new drivers to drivers/video/ (taken from staging).

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

