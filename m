Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C26C433F5
	for <linux-fbdev@archiver.kernel.org>; Mon, 24 Jan 2022 14:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbiAXOZ4 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 24 Jan 2022 09:25:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:32746 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234478AbiAXOZz (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 24 Jan 2022 09:25:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643034354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7lR4CEZmUA7KU2EEtClbGSv2hJzPsx0avoRxay7giE0=;
        b=TDDR+5FFmTPEA0WmZ6+iRsbBcYKyTlQqN8eJi8LEy0unw4D3MI24SHEJuzeSCSZgANulEy
        uOmKwQLkiZGYy3WQBqtEYGFgpCRFdaNu7cAYHVD+60/hJ7Sccy5bdf5vomgVfPK+Yw0z32
        jlKjyXo7bhH2TJ3na2df2gcOWCYiLss=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-341-GnVLtp6OPDykZ2omVoDY-g-1; Mon, 24 Jan 2022 09:25:53 -0500
X-MC-Unique: GnVLtp6OPDykZ2omVoDY-g-1
Received: by mail-wr1-f69.google.com with SMTP id m18-20020adfa3d2000000b001d926bdf34aso1708996wrb.11
        for <linux-fbdev@vger.kernel.org>; Mon, 24 Jan 2022 06:25:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7lR4CEZmUA7KU2EEtClbGSv2hJzPsx0avoRxay7giE0=;
        b=u382o7EtJi5qZdjOflO/v5w45OTeQVpNwWzrNrWjQ09NmuEopEUKXAMpi3BotgN9Jy
         9bvSRDZujWAz0dkbyHQ78979rqlWzDmxMBiPyABD3s+jrw7IMvWlbxE43HGUI3v3VZ7X
         QGJhxtJAKpZZRM5Ql6tUhFJuCHOuT6zeXDq2/7jj4sZAXP7Dppw+DG0my7qZn4g3Py8k
         ZdslZHwcjYb1iON/LB6UihoIjmRyQnKQvFZwi6biE9+5VDFZs/bFwYoiu7SqlIqjJcqA
         kpzsTvouWEGwQACq0ek+N1p4iaI/Pv0IPjwV6Kpr48/oe70aR7TnDEjbObI7OMeb5iMH
         8WKA==
X-Gm-Message-State: AOAM531okkGhGwf7mHV8dzu00jbT41LtOdDjhDiGmErqExyagA2hqhnS
        o1m3y6Eg/P+Dv4iiyj5ZH2n/w1t6pYyGyecdRKN60wxBp0VoCBxAuhWVCne6xR4O+GYmeG9BGBf
        aH8dDpcxOHdJRQ+IyYZNwXW4=
X-Received: by 2002:a05:600c:1d21:: with SMTP id l33mr2085586wms.134.1643034352134;
        Mon, 24 Jan 2022 06:25:52 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIp5WYmpvxAnkgICIFMWJqVkRpKEZirVZ1OoWVlrqMrxGRvVgHs08iWCn81KmI17eLy1xm9Q==
X-Received: by 2002:a05:600c:1d21:: with SMTP id l33mr2085569wms.134.1643034351912;
        Mon, 24 Jan 2022 06:25:51 -0800 (PST)
Received: from [192.168.1.102] ([92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u15sm1881620wrs.17.2022.01.24.06.25.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jan 2022 06:25:51 -0800 (PST)
Message-ID: <811fa19c-5bce-4752-2fc9-720a6e34f484@redhat.com>
Date:   Mon, 24 Jan 2022 15:25:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 5/5] drm: Add TODO item for requesting memory regions
Content-Language: en-US
To:     Thomas Zimmermann <tzimmermann@suse.de>, zackr@vmware.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, deller@gmx.de,
        hdegoede@redhat.com
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
References: <20220124123659.4692-1-tzimmermann@suse.de>
 <20220124123659.4692-6-tzimmermann@suse.de>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <20220124123659.4692-6-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 1/24/22 13:36, Thomas Zimmermann wrote:
> Add a TODO item about requesting  memory regions for each driver. The
> current DRM drivers don't do this consistently.
> 
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Best regards,
-- 
Javier Martinez Canillas
Linux Engineering
Red Hat

