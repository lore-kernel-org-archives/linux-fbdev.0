Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F36C433EF
	for <linux-fbdev@archiver.kernel.org>; Fri,  4 Feb 2022 14:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359332AbiBDOde (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:33:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38478 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343911AbiBDOde (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 4 Feb 2022 09:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643985213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YE+7dcKVrnsXlJFwi4qc611YF3e/nMZjJd0WuHXGT7w=;
        b=DQxhyBGsZrIDFqF5CisQw36xF7ZViW78rfpUJHMQ4Z/lePoteFg8E1BYyHrPI+s/BSCZYx
        Qr8zFmKYyfS2+TcDTBeGAMfp7yG+kd7cKKQIYTh9zmiNJfLk6AejdYMlSfiQhavCo1SMgy
        oJH/DKyl5zr2j8KKnv9VKk6kVc64ZEk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-445-g5KJijbEP1-B3Tutzh32JA-1; Fri, 04 Feb 2022 09:33:32 -0500
X-MC-Unique: g5KJijbEP1-B3Tutzh32JA-1
Received: by mail-wm1-f71.google.com with SMTP id c7-20020a1c3507000000b0034a0dfc86aaso7648394wma.6
        for <linux-fbdev@vger.kernel.org>; Fri, 04 Feb 2022 06:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YE+7dcKVrnsXlJFwi4qc611YF3e/nMZjJd0WuHXGT7w=;
        b=WiL75qit9cfnRHvgivbaNN6GY4GGx9jbhuUGhqB+iVLBiPAJMsQKxfQy/axXLr8HDl
         zgx6rUzemsC35Nyw8Hpb82eS0CaH8Kyce9LbO3Yui/Zab39O2Qfd1BDuUVLA1Q3DS+AS
         iSZYp2LwiHbiqYsPIt1zxhTORySdmo6j07n9dcs7mT0jVbZhBFYbBOLJbdAi9fLGeuNr
         iSsSOoXJNLxKj/5/99b6edD5ujQpooAYyJN3VV74fcITDRi3T7V9FqoFKtb4jC3JfmSF
         r8LqaZvMGE8RLYwK7socrEr4jbScniBUjeEQjczO5DwIWgZfiXw7bSBdxrUe34SBZsWP
         CBvA==
X-Gm-Message-State: AOAM530voxDSNQDPAEvJhLQNiGrTL7qLlQ8dwZL2uleDzqUF1BJV5Ule
        gmatNx7xQosbWGvI0sTtwed0OcDNNj0UYmRTsIZUdEKrAtalUTmjGqnRF2N4HpXTOwEIezvqVDI
        CI12VE9BORDF7aqcu+nq8LcA=
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr2506722wmf.42.1643985211619;
        Fri, 04 Feb 2022 06:33:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy8Sf3LjiYWLzwA9+5siU+yJFBE/sxFNsjVMYQtNMWsluGofgOGAh6oxxtKiSCC9coLkWjFOA==
X-Received: by 2002:a1c:4c08:: with SMTP id z8mr2506694wmf.42.1643985211382;
        Fri, 04 Feb 2022 06:33:31 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id a9sm1992289wmm.32.2022.02.04.06.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Feb 2022 06:33:31 -0800 (PST)
Message-ID: <f7a5d15f-3a02-5698-01f9-e79970180d99@redhat.com>
Date:   Fri, 4 Feb 2022 15:33:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/4] MAINTAINERS: Add entry for Solomon SSD130X OLED
 displays DRM driver
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-fbdev@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <maxime@cerno.tech>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>
References: <20220204134347.1187749-1-javierm@redhat.com>
 <20220204134347.1187749-4-javierm@redhat.com>
 <Yf0wzOP/kaubDAhP@smile.fi.intel.com>
 <5892749f-0bb0-68f5-c3d2-8ceedfc6b162@redhat.com>
 <Yf03+MsbqRp+uQff@smile.fi.intel.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <Yf03+MsbqRp+uQff@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/4/22 15:28, Andy Shevchenko wrote:
> On Fri, Feb 04, 2022 at 03:12:17PM +0100, Javier Martinez Canillas wrote:
>> On 2/4/22 14:57, Andy Shevchenko wrote:
>>> On Fri, Feb 04, 2022 at 02:43:46PM +0100, Javier Martinez Canillas wrote:
> 
> ...
> 
>>> Stray change?
>>
>> Sigh, I'm not sure how added that change. Just ignore it, I'll fix it
>> on v3 or when applying if there isn't another revision of this series.
> 
> I believe v3 is warranted due to the other patch review.
> 

Agreed. Thanks a lot for your feedback and comments.

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

