Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E49DC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 23:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiAaXZD (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:25:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23547 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229493AbiAaXZD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 18:25:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643671502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOB8RYRPIuXt9XuC1duDz579Ebb678cvofpXB4sR8RI=;
        b=Rn23NxkCQunRrrSeTd7hGJhkH7SXnGY7iwt7V0xNmey1Kv1ixB9n6z7ALW1ifSMQkz2dYB
        +P35ftGTE1L2Uu9bO7Yq9Z5QyCgAxlsZhrbavxod2JOyclu64ZvhSB5stg8exvLYCc/EjT
        UM4MKZW64+wja7opxherNr8cI1p5p9k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-548-LNavVV3HPf6hcV1iSX66hg-1; Mon, 31 Jan 2022 18:25:00 -0500
X-MC-Unique: LNavVV3HPf6hcV1iSX66hg-1
Received: by mail-wr1-f72.google.com with SMTP id z1-20020adfbbc1000000b001df54394cebso4490481wrg.20
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 15:25:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sOB8RYRPIuXt9XuC1duDz579Ebb678cvofpXB4sR8RI=;
        b=yRhOCW5lBkZ5zgqTdBLJrQ1nlmpVxG6BIBJQSB/o28qIWNUS+yXXDEFJqDFviUMyHc
         ATL+vSg08PkrMxlnOvWWr0V80tvcjoBLvLud3ijlUpP8Oi/9ScnWJQfokJ//EELdAf7B
         FeOdjCYZVLHWwB24EbgDIayPeuoDg0CtytzWvxWGmdHptYn9k/zZawr9Yck3pJvNssVb
         pxrE+VrY9wT/gfw0XHnNMXpM3KNNhgxOoFBm5yOl7193d8o3iRDU6MSibEzH2/2mG3GO
         SQ28BuJcfgK/GG5R2bGIKkWZ9gqUyi+un0tWQHF06whk+Kzaf3X5x6D/VjePwkfrAtZ6
         AKpg==
X-Gm-Message-State: AOAM531r39t+lI5QBpINA5bigJAIV0k8DfNytLsDsRyHWhEkdDuIQNaJ
        l1ewINve+CMsy1cRV2HddyiJ0mivGRlL6xZ+EoNDgyztZzmT0kcpmhofy84mff0ggQmVKSI9oe9
        urGDJYEpI0qkBDyyjcb69+zc=
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr20585930wmh.169.1643671499289;
        Mon, 31 Jan 2022 15:24:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXct5Vi006IAsnWX7pGg6l9TgY49Hkt7Zu/EEEoWSUyfvrEDOXAziQ+K8kEvGmrE5W4zQmHQ==
X-Received: by 2002:a7b:c0d0:: with SMTP id s16mr20585920wmh.169.1643671499121;
        Mon, 31 Jan 2022 15:24:59 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id f13sm577284wmq.29.2022.01.31.15.24.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:24:58 -0800 (PST)
Message-ID: <9e9808c0-5a92-b2c3-c1c5-158608f49e6b@redhat.com>
Date:   Tue, 1 Feb 2022 00:24:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 4/4] MAINTAINERS: Add entry for Solomon SSD1307 OLED
 displays DRM driver
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201537.2325487-1-javierm@redhat.com>
 <YfhKrznFzRmDcZa6@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfhKrznFzRmDcZa6@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hello Sam,

Thanks a lot for your feedback.

On 1/31/22 21:46, Sam Ravnborg wrote:
> Hi Javier,
> 
> On Mon, Jan 31, 2022 at 09:15:37PM +0100, Javier Martinez Canillas wrote:
>> To make sure that tools like the get_maintainer.pl script will suggest
>> to Cc me if patches are posted for this driver.
>>
>> Also include the Device Tree binding for the old ssd1307fb fbdev driver
>> since the new DRM driver was made compatible with the existing binding.
> 
> To avoid any confusion add yourself as Maintainer in the
> solomon,ssd1307fb.yaml file too.
>

Agreed. You mentioned in another email though to diverge from the existing
DT binding for ssd1307fb. If we decide to keep the backward compatibility
then I'll add another patch to the set to list myself as a co-maintainer.
 
> With that done:
> Acked-by: Sam Ravnborg <sam@ravnborg.org>
>

Thanks!
 
Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

