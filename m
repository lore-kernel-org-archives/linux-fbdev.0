Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D45BC433F5
	for <linux-fbdev@archiver.kernel.org>; Tue, 11 Oct 2022 15:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbiJKPpj (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiJKPpM (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 11 Oct 2022 11:45:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F29288A26
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Oct 2022 08:35:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id s206so13122147pgs.3
        for <linux-fbdev@vger.kernel.org>; Tue, 11 Oct 2022 08:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E4TT5+XgfF+fVIz+vKOOCmhNChiCny6uMsCa8RIlVyY=;
        b=Pgenw8jmi7PqQSftPG+9DPKuF12f9wmISSReQ4ohtRCWKJ565YBXodNHYUzhltct3W
         3nFrgJsGXEWLfTAkIBvRUf/O3nna48ZcSh3YAz+Ajc0fpNS5T0XaT6lfn8kYkZWn6O/Z
         nzjnZvupeuF/QGn9Zolmw5a9m0d+EUzYbC15+NNNXBFszh4sdFoL0IQ+99iMly/6rcBb
         9YcDkjWuty+iTUidy773H0PVF9iQVSk/IMEtsLlqvntuEQvxGLAlHl58/iu/Fdmy6Kh1
         5slho+4PGXI4iPHB6/OyRaINtF9swY4KQqyqbNMFtxOYnYgDZfsZ97NNuH+ps8c7wV9m
         hlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4TT5+XgfF+fVIz+vKOOCmhNChiCny6uMsCa8RIlVyY=;
        b=TGW6+VxuYiMf9QPD4fvkS0NRd+VMeNRxW4NB5zAa1CqMbzNnumg6BG12aDr/Z15ie7
         QgWHsEw4w8S5wEIU20WHSTdS1nMd16TG6voX80CHI/gvIYa+Ut8I2J2ymrHQd+gUIA4O
         grP9KBC0L/VVcYtVZwrkEMT9fouwiBpeIPyvO1iAZdc+p7qKMqNWj6Vi8NJhC1LqR7Mi
         1Yy2kRESnLD1jJadRBEgfxmHpM3OwK8iIOeu3YZ4o1nsaoIHXI88rCzz1hoxZhdXdsF5
         J39oeY+qL02MUVZkjX9FoJXPY/u5MzKAXWn6sdsTcv+bdII2qVkwqAK34WV8cjn/6t93
         oZvw==
X-Gm-Message-State: ACrzQf2kZVdOhMpNzaj1apipRzZjiyPsoA8QIzVRClnOU+PJGOhFWVB9
        ZVkSpSuH53Y44sjzi1Ls+5s=
X-Google-Smtp-Source: AMsMyM4nTQJFjN5qA0FQqZDYin3Y7HzdWXMAoAJ3QezkkZYNF6NziPpjcC42tZ3Bldu2o3VdJwVJNQ==
X-Received: by 2002:aa7:9212:0:b0:562:b5f6:f7d7 with SMTP id 18-20020aa79212000000b00562b5f6f7d7mr25048626pfo.70.1665502481594;
        Tue, 11 Oct 2022 08:34:41 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902f60500b0017b5e1f486asm8737424plg.211.2022.10.11.08.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:34:41 -0700 (PDT)
Date:   Tue, 11 Oct 2022 08:34:36 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     ChenXiaoSong <chenxiaosong2@huawei.com>
Cc:     steve.glendinning@shawell.net, deller@gmx.de,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        "zhangxiaoxu (A)" <zhangxiaoxu5@huawei.com>, yangerkun@huawei.com,
        imv4bel@gmail.com
Subject: Re: Question about patch "fbdev: smscufx: Fix use-after-free in
 ufx_ops_open()"
Message-ID: <20221011153436.GA4446@ubuntu>
References: <363cdfe4-f54d-0ce4-2f03-bcfe998deeef@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <363cdfe4-f54d-0ce4-2f03-bcfe998deeef@huawei.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Oct 11, 2022 at 10:13:02PM +0800, ChenXiaoSong wrote:
> Hi Hyunwoo:
> 
> [patch "fbdev: smscufx: Fix use-after-free in ufx_ops_open()"](https://lore.kernel.org/all/20220925133243.GA383897@ubuntu/T/)
> fix [CVE-2022-41849](https://nvd.nist.gov/vuln/detail/CVE-2022-41849).
> 
> If the UAF scenarios is as follows, it seems that [fix path
> v3](https://lore.kernel.org/all/20220925133243.GA383897@ubuntu/T/) will not
> avoid race contidion of krefs:
> 
> ```
>           cpu0                       |        cpu1
> -------------------------------------|---------------------------------------------------
>  1. open()                           |
>     ufx_ops_open()                   |
> -------------------------------------|---------------------------------------------------
>                                      | 2. ufx_usb_disconnect()
>                                      |    dev->virtualized = true;
>                                      |    atomic_set()
>                                      |    usb_set_intfdata()
>                                      |
>                                      | 3. if (dev->fb_count == 0)
>                                      |    schedule_delayed_work()
>                                      |    kref_put()   <- kref count : 1
>                                      |    kref_put()   <- kref count : 0
>                                      |    ufx_free()
>                                      |    kfree(dev);
> -------------------------------------|---------------------------------------------------
>  4. if (dev->virtualized) <==== UAF  |
> ```

You are right. This v3 fix patch may prevent the UAF scenario I first suggested,
but not the one you suggested.

Any good ideas for this?
Could it be solved by adding a global flag variable indicating disconnected?


Regards,
Hyunwoo Kim.
