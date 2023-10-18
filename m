Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F490CDB47E
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 Oct 2023 08:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjJRIRG (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 Oct 2023 04:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjJRIRD (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 Oct 2023 04:17:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC054F7
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 01:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697616977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jmZc6Q4WePRTx40QodA4tT/WlA97DXcd06bFoFktVdU=;
        b=UpbjL+tu7uuTBDnzF4yW7PMHnNzFKl9rIUPnj9dWutLliE6XNARhsnxFcuL6xpufA3s3jq
        MNY8SFASKelm/atPNXKnKYnYodtOt0b0iFNO4BHbrkzqHDLf2TZ99dYV27t0Jl+Hytjnzs
        3j4ezGowrTg133DdonFYu60sOYPULfM=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-CxTXWXuKMRqkDVRLb5w7Yw-1; Wed, 18 Oct 2023 04:16:05 -0400
X-MC-Unique: CxTXWXuKMRqkDVRLb5w7Yw-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-5079a66711eso4829066e87.1
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 01:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697616964; x=1698221764;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmZc6Q4WePRTx40QodA4tT/WlA97DXcd06bFoFktVdU=;
        b=MhDiSKguCLU2/dHLo7Q81LPD5IA20gXuyGOAWDne5btZd/Z6vJvh+fKdZIehtTau/G
         QVX68u87VE8O0OK/L+oWtQQyOlabEnpK4bsGE2Ktj+toms1Lr96ljE8LnjpsgPIUiwrB
         gxXgiYSdHwCFcXKc9yYxyU3kubHU9c/MfTMUzTiiqc+X9bqD6eAheyTJdZXat1KjZDe8
         D+lItipSOvzsFeTYz4D8FBuy1S1Le56VKPlQ6G8D7HR0vPgYbp1NbTw+obSKWx7DEBoe
         vXCFbADvH13eH1zwjBMRkU5xmQYRRn/iHvuAcAQ8CpYQ+vb2PvZ3TeMIcttpx178tN2/
         oPkQ==
X-Gm-Message-State: AOJu0YzveX60tC5u6OsirEJsnkfij+CHiFk977PpD+BAi2T20Ihoo9HU
        pM+pTB39mdQyqJaJt3104Ro4bCHVG7v+vPkAToaaKLZF/mbQ1rrsX8duhjJ2ZI/bQ/WWUEwuqYT
        VwrAhj9X9diSOPIH0JzKWmiM=
X-Received: by 2002:a05:6512:1589:b0:503:28cb:c087 with SMTP id bp9-20020a056512158900b0050328cbc087mr4387861lfb.29.1697616964197;
        Wed, 18 Oct 2023 01:16:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEYatw1+GQZsrovTtK4AIM0GHdCZTQtrZMNluODtTEfilpBoqjDMDouescfpJJZYj44ekzDvA==
X-Received: by 2002:a05:6512:1589:b0:503:28cb:c087 with SMTP id bp9-20020a056512158900b0050328cbc087mr4387842lfb.29.1697616963899;
        Wed, 18 Oct 2023 01:16:03 -0700 (PDT)
Received: from localhost (210.red-80-36-22.staticip.rima-tde.net. [80.36.22.210])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c310e00b0040813e14b49sm988670wmo.30.2023.10.18.01.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 01:16:03 -0700 (PDT)
From:   Javier Martinez Canillas <javierm@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>, deller@gmx.de,
        sam@ravnborg.org, arnd@arndb.de, daniel@ffwll.ch
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-nvidia@lists.surfsouth.com, linux-omap@vger.kernel.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 01/46] fbdev: Provide I/O-memory helpers as module
In-Reply-To: <20230927074722.6197-2-tzimmermann@suse.de>
References: <20230927074722.6197-1-tzimmermann@suse.de>
 <20230927074722.6197-2-tzimmermann@suse.de>
Date:   Wed, 18 Oct 2023 10:16:02 +0200
Message-ID: <87a5sgqrb1.fsf@minerva.mail-host-address-is-not-set>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org


Hello Thomas,

Thomas Zimmermann <tzimmermann@suse.de> writes:

> Provide helpers for accessing I/O memory in a helper module. The fbdev
> core uses these helpers, so select the module unconditionally for fbdev.
> Drivers will later be able to select the module individually and the
> helpers will become optional.
>
> Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> ---

The patch looks good to me.

Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

