Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FB5C07E9D
	for <linux-fbdev@archiver.kernel.org>; Mon, 26 Sep 2022 04:50:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiIZEul (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Mon, 26 Sep 2022 00:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiIZEul (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Mon, 26 Sep 2022 00:50:41 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA92654B
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 21:50:39 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso5556361pjm.5
        for <linux-fbdev@vger.kernel.org>; Sun, 25 Sep 2022 21:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=8PxZH0BmsyJu9+ITF6qQvrU+JnlICuP2MjpJbjhQ5y0=;
        b=qbqNGQfPQ6R0PH/uT+gONTWuOvI2r6XIk+/azya6UxU0kaTqdj1TeHfauyc0VUxp38
         Nn4EjGYs4BSgxrnLzx3D6+mw2aMjfcJ6jERcsyKkRqcD+vqN9ykKfqLw3pi46HkRyWi7
         hla2nbx8EZEFsTHssLouke52bR7gmv170RxLy0axkORVAr5Gep3mnOA1/wpmfAwUEwRU
         X+HEDZ9boS8/I2Y1c5U1X85KNSMD+/u7EDOLMXN1SwH3y1iu5eXhyyjp6dqxlacQXMdw
         bBUA5719DnSlCldxvvn9eFVNVmHhoARFlnstKOUaEWZyGIXuioEnES4s4zoOiIqerkdb
         AcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=8PxZH0BmsyJu9+ITF6qQvrU+JnlICuP2MjpJbjhQ5y0=;
        b=iXqD04bBp4wpzktjcKKDYURYbi9wh8u6EPGZIcAv4hQ74PN2aljF2+hUqDr7T3AYO+
         VaBjPN+QKa0NtVNfVdC5dxViEieMVVDauMRjxumtO9KnfKJdkfDe0wDp1jIz2TBLnw/d
         6XFefzIvaYxxWakCmYemzbyrBeIajVgU1bnWWBo/AMdMJealfz971rnz5u78XJ4v9v8j
         5vcd0RqE5nOK+cBCa3Zplx1G6WcICi7GcIEPXIPenBfo68ZEMbkrYmEWS96iGMpaRXc4
         V1k9eHzCXTxXaPDL/8SgGJeNCd3wvlmFxV8Or4xQCR2fYS7pf3+ajmG/+DZKiJAtGMnD
         DF1g==
X-Gm-Message-State: ACrzQf0mhHib08vwQFucNoL2BKHLQqxiOp+71q62R5diz0KwsakLBANj
        tjJz8mlfpWZtJ+46FTXwID/bZhgfMcE=
X-Google-Smtp-Source: AMsMyM5jidO7BxUcy2yILHGXx/VYbFmwekvVE4ZTO0Z8QXVqKQ2/5c22vSg3uhBvBz+bHdfRG2HEGw==
X-Received: by 2002:a17:902:ea11:b0:176:b283:9596 with SMTP id s17-20020a170902ea1100b00176b2839596mr19752292plg.69.1664167839026;
        Sun, 25 Sep 2022 21:50:39 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id e9-20020a17090a280900b00203059fc75bsm5493653pjd.5.2022.09.25.21.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 21:50:38 -0700 (PDT)
Date:   Sun, 25 Sep 2022 21:50:34 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Helge Deller <deller@gmx.de>
Cc:     steve.glendinning@shawell.net, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v3] video: fbdev: smscufx: Fix use-after-free in
 ufx_ops_open()
Message-ID: <20220926045034.GA389532@ubuntu>
References: <20220925133243.GA383897@ubuntu>
 <37915429-7b4d-6e64-8ef7-a28bf8015fd5@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37915429-7b4d-6e64-8ef7-a28bf8015fd5@gmx.de>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Thank you for your review.


Best Regards,
Hyunwoo Kim.
