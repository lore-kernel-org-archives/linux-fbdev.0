Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBC8C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 13 Jan 2022 15:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233677AbiAMPCk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 13 Jan 2022 10:02:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbiAMPCj (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 13 Jan 2022 10:02:39 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0B1C06161C
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jan 2022 07:02:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id o3so10596126wrh.10
        for <linux-fbdev@vger.kernel.org>; Thu, 13 Jan 2022 07:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NjQ5CckMH/FqJHfWgmyb7DQKMb+OQO1cEac1mm0zNp0=;
        b=yt160kvam3HJdDmZb3vsgy1B/f68cJyCqRxHQGpeUER/bpnSaBG7Qh/n9igDWSpKlW
         lMQHT+qDXxcH3Ji+D24uEeHoEGgFn9vwppBCwpbmCI00TJsAxYE/zuzhspFjriUt3zIO
         xO1kYIHSoT7TdChA2VswjVnPZ7zaQG20FDT4WB+SdrPYYjW7k+3dbRvf+geNvagAYkpq
         AMr5RBx28EPYCSqhT8++9pqwwsSMEFhlsEOhqs2BGtwAJqEMVFDO3V26YtGLQ8Pu/OqL
         ga6ApEUefApiDfHc9WqxWYwCOHyKMnDIWJPL/5ETrgBEebfweJNEM0UEZko1ivBtaQjx
         zw3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NjQ5CckMH/FqJHfWgmyb7DQKMb+OQO1cEac1mm0zNp0=;
        b=OmLc0CgrGpCIXMBsekbp/2ZyMqGzf9Gx3c2hBnxuzy4hzu4dnJya0LqjHNPoUNuoaD
         nk0gVScc71pfazGB5Vo035BRTIT4yei+58DM5H4RuEYFXQDMKjghk6Y4RW0wxLaoF5Y4
         +s8b1JjdvXL+JxjX05QQLxqn7W17oXDfu+lPTva8qB8gLxZ2TFmYzftimaqa9vwe3QEW
         vNW6OAabOyDZhUWL3ImBI7hfqljYPKl3JfKBijT6cgD6jpRQ99zxaPG0e6uWrRcEqz50
         ktl9K8bzMvInmwkpQV+wyBmEz516vD4T4bg0IzB7h5Sivz5FePNSKMt8s1YFBv7meg3R
         S3mQ==
X-Gm-Message-State: AOAM530e7p0L1jr7a/TFa3KDDftQe0AgTcx0qm2DA0PdAjL4cuiNPUf+
        d/Sx8pHWw8TVC+z0gZ5+6yMMbg==
X-Google-Smtp-Source: ABdhPJxel8Y0oxv14BbumdD74ugMJ5nF6Wawn+vNlK5AtA4I45AJGBMjljCF4xkTlJ3wYfJ8vpqPrQ==
X-Received: by 2002:a05:6000:1563:: with SMTP id 3mr1836447wrz.395.1642086157839;
        Thu, 13 Jan 2022 07:02:37 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id h14sm2682335wrz.31.2022.01.13.07.02.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 07:02:37 -0800 (PST)
Date:   Thu, 13 Jan 2022 15:02:35 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Xu Wang <vulab@iscas.ac.cn>
Cc:     lee.jones@linaro.org, jingoohan1@gmail.com,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backlight: lm3630a_bl: Remove redundant
 'flush_workqueue()' calls
Message-ID: <20220113150235.fyzee7bhx7uceiwk@maple.lan>
References: <20220113084806.13822-1-vulab@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113084806.13822-1-vulab@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Jan 13, 2022 at 08:48:06AM +0000, Xu Wang wrote:
> 'destroy_workqueue()' already drains the queue before destroying it, so
> there is no need to flush it explicitly.
> 
> Remove the redundant 'flush_workqueue()' calls.
> 
> Signed-off-by: Xu Wang <vulab@iscas.ac.cn>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
