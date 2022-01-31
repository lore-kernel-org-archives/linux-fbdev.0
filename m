Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 674DCC433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 31 Jan 2022 23:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiAaX03 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 31 Jan 2022 18:26:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:20067 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229519AbiAaX03 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 31 Jan 2022 18:26:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643671588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YoObquMC1Y099gjHiKrPd1NW4/MPXx5uArpEcPqAfgo=;
        b=SPVXVCFRbu3o/BAfrB9eB/IIHLwWnrBtM8ghgKXoWRx2qWbax/mDf4einrW/uWbzAzZTVD
        BaYC7XtxARL1BCviJFXzaDcm3xAALKODHhKN4P0xkgXhVT9ihtHTUW0YE58qb2/HT0vwo4
        jX7dvSrTmpnLl9fHi/74lJ4HpJsBxZ0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-qhEv1soPNyGVIOrbQ8vTyA-1; Mon, 31 Jan 2022 18:26:24 -0500
X-MC-Unique: qhEv1soPNyGVIOrbQ8vTyA-1
Received: by mail-wm1-f70.google.com with SMTP id f7-20020a1cc907000000b0034b63f314ccso278217wmb.6
        for <linux-fbdev@vger.kernel.org>; Mon, 31 Jan 2022 15:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YoObquMC1Y099gjHiKrPd1NW4/MPXx5uArpEcPqAfgo=;
        b=i/7ypt+XfA91ZIHlcda1PN1Sp8tRpbH0GBy6GbaeWhNmTuPvKg68AG3eR+8ayNyto1
         HrPczD/nXIf3eikZ9Rg2N/LdDp+C53NWfGBBEIX+Fmp619ABoFb5FKfIlHz9kF9jlI+C
         9IPEkykLTx9q1CCOdC8ZpW20zyXHtCWfIbLAIoxV6FBL2UvVB0J4FEDiR7JK0FKYHiFc
         H7Y7syxiOdgQ6HRrk3po/y2rE3iMCtGNkP1ELNVNs9apOvrJ1jxwtw2YY69f0DOKvxEq
         qz59xlaEr9x3AISl+isyEuKaWJoid7KR8dDM6005J/COLyXZ/1CrUGtYPrG5/waqbv8P
         PsAQ==
X-Gm-Message-State: AOAM530AsxBtoR45HuiR6o4XNJyqFFcNRzJ68IdGPBc6bt7YpE1YJ3fD
        rC8OH9txqeXI/5zigtPT0GtUiCMQxpNqxt26wyeuD3zC/1WpT/rgZikfVOGBWi8TXIeXrCMqiF0
        NIVtJ6apHb8aSmBl5o6/fQj0=
X-Received: by 2002:a1c:440a:: with SMTP id r10mr20863800wma.142.1643671583666;
        Mon, 31 Jan 2022 15:26:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvDyBUYLTU/L1b51CS4uxvaGJqLeLCo2c7D1CjSfutkqldhTLTiY2yHFXAdgxPYSuz6ErDnQ==
X-Received: by 2002:a1c:440a:: with SMTP id r10mr20863790wma.142.1643671583508;
        Mon, 31 Jan 2022 15:26:23 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id h4sm15500586wre.0.2022.01.31.15.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 31 Jan 2022 15:26:23 -0800 (PST)
Message-ID: <03ffaaa6-1a8c-68fa-dd17-1e6d0e1e4868@redhat.com>
Date:   Tue, 1 Feb 2022 00:26:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/4] drm: Add I2C connector type
Content-Language: en-US
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20220131201225.2324984-1-javierm@redhat.com>
 <20220131201225.2324984-2-javierm@redhat.com> <YfhMESTylI1NTKDg@ravnborg.org>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <YfhMESTylI1NTKDg@ravnborg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/31/22 21:52, Sam Ravnborg wrote:
> On Mon, Jan 31, 2022 at 09:12:21PM +0100, Javier Martinez Canillas wrote:
>> There isn't a connector type for display controllers accesed through I2C,
>> most drivers use DRM_MODE_CONNECTOR_Unknown or DRM_MODE_CONNECTOR_VIRTUAL.
>>
>> Add an I2C connector type to match the actual connector.
>>
>> As Noralf Trønnes mentions in commit fc06bf1d76d6 ("drm: Add SPI connector
>> type"), user-space should be able to cope with a connector type that does
>> not yet understand.
>>
>> Tested with `modetest -M ssd1307 -c` and shows the connector as unknown-1.
> I had expected unknown-21??
>

As you pointed out in patch 3/4, I forgot to change DRM_MODE_CONNECTOR_Unknown
to DRM_MODE_CONNECTOR_I2C after adding this patch...
 
>>
>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
>> ---

Thanks!

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

