Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BFFC433EF
	for <linux-fbdev@archiver.kernel.org>; Wed,  2 Mar 2022 19:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiCBTsi (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 2 Mar 2022 14:48:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241759AbiCBTsg (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 2 Mar 2022 14:48:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 613A039170
        for <linux-fbdev@vger.kernel.org>; Wed,  2 Mar 2022 11:47:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646250468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9ndR+qkKf8IiCmXwP6/0TLhJyNK+iAc9DAT0Oa/pgpY=;
        b=Se8jp0NCtqyftC3zslnmgnyFSoxnIokS7NuWydbb0NCHnVKnWT6w/sqRorq2nUYJXvdhgo
        WPSoowWM49uN1mcveTdUAtz29i1xCjfR2dtq2/FAjeEzoeKvbq16yYZzDkK1KzyDy/wBBa
        iI8EkNSsISWZsWO2IUUAxpZlNyFJ1+k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-T5acyuLeOJCfm6inoVtTJg-1; Wed, 02 Mar 2022 14:47:44 -0500
X-MC-Unique: T5acyuLeOJCfm6inoVtTJg-1
Received: by mail-wm1-f71.google.com with SMTP id r133-20020a1c448b000000b00385c3f3defaso386922wma.3
        for <linux-fbdev@vger.kernel.org>; Wed, 02 Mar 2022 11:47:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9ndR+qkKf8IiCmXwP6/0TLhJyNK+iAc9DAT0Oa/pgpY=;
        b=aDTNsV+s1xsR+RRwn3RHPmfSDwQzwB/et2wA49Zc88m61wzCcjPnxnwohF3IUqvXj8
         6M6zq1EDhMrN7lfIsmFWPHQPAONVYWHgWQB/WjdWfCreQgeZ602bXZ/XUGKlYgSlT4/3
         K9XMkA24zrvBRt9YGRCrO5gn5H8HoUeAmA8KAfXOuqYOu3kWWKKZ1jd7fZslnTzP6FcZ
         PtOmJDevEfc8ynnuDQrmTaQRO4tkRLjgZi3Ejilx8lnqLlYt70mZAP1VciUZkbn3VCmJ
         juRLbA4dneYURx8IXQ60CKDa7BEbP0d3RmJDD1GddT62bgwAPZFsncT5LkyGeGEKefBV
         bx/A==
X-Gm-Message-State: AOAM530NOPNyrJ2pTZFX3pDz2MfKfOIzBx07VnTITpCuokp5z54Tftb6
        4kRQGhJPJBm/m4jygwEQ4psxm/fzFnBtmlPQ3pVyKpzbWratmhXUZiKAOWsU6frOZm5Qo3Sa9R5
        a1fU+hm57kF7rO8pItKQ/kPc=
X-Received: by 2002:adf:a749:0:b0:1ef:7d81:f4cd with SMTP id e9-20020adfa749000000b001ef7d81f4cdmr17935822wrd.133.1646250463115;
        Wed, 02 Mar 2022 11:47:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytQkVIbt3RjmxG7srv9p6KdE7ADQdJ/WVQfRQmhaoGILBPTLLpENUyF/E4HqcmI+2MYZN+gw==
X-Received: by 2002:adf:a749:0:b0:1ef:7d81:f4cd with SMTP id e9-20020adfa749000000b001ef7d81f4cdmr17935812wrd.133.1646250462893;
        Wed, 02 Mar 2022 11:47:42 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037fa93193a8sm8935824wmp.44.2022.03.02.11.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 11:47:42 -0800 (PST)
Message-ID: <2ba8497f-ba6d-558b-d782-bb3ee67d23ec@redhat.com>
Date:   Wed, 2 Mar 2022 20:47:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] simpldrm: Enable boot time VESA graphic mode selection.
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        Thomas Zimmermann <tzimmermann@suse.de>
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
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220302193846.GT3113@kunlun.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello,

On 3/2/22 20:38, Michal Suchánek wrote:
> Hello,
> 
> On Wed, Mar 02, 2022 at 08:31:25PM +0100, Thomas Zimmermann wrote:
>> Hi,
>>
>> is this ready to be merged?
> 
> The objections raised so far have been addressed in v4.
>
> I think this is good to merge.
>

The v4 patches looks good to me and have provided my Reviewed-by to all of them.
 
> Thanks
> 
> Michal
> 
>>
-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

