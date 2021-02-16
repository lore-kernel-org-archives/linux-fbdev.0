Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05326C433E6
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CEA614A5
	for <linux-fbdev@archiver.kernel.org>; Tue, 16 Feb 2021 15:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhBPPuS (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Tue, 16 Feb 2021 10:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbhBPPuR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Tue, 16 Feb 2021 10:50:17 -0500
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB96C0613D6
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Feb 2021 07:49:37 -0800 (PST)
Received: by mail-io1-xd29.google.com with SMTP id e133so10590984iof.8
        for <linux-fbdev@vger.kernel.org>; Tue, 16 Feb 2021 07:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y7FAAueIFMAXFTE9aqqwaVuxVLzWJ41n1RibstBf/uw=;
        b=SHCf+Lr8Fai0+JIKF6loXEw9yJRu+EiA1D8AdZuiQpbpVYhDAoGb5wb0MZdfDrE+I8
         wqw5SVPw5Haw+RsZQ25HkOw81kkwDgzLKgQWVChvG9y2l/EYO5gmn0d3nglSTU5XWHoA
         xosoQ8MpYSKhzMu6bczvWbOudi2SHjqAjmSZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y7FAAueIFMAXFTE9aqqwaVuxVLzWJ41n1RibstBf/uw=;
        b=HnUtcTzTXYaAWLUZIDarjV7lgZgFBAA4kw0PMPp3sD66zTHV76kcNnrJfkM/Oltk0Z
         eO7tTLMpzeQRDHdh8nfdIA4SWtqoqhD9Y7orsqDQjANuDIbSVu5744hLk7pjoDPNBwjt
         qnTidZ4t9P2OAIbzjlmOsuE6uTj5p/vErImGuI2bjlOLVE2lyYbmFNWmSaguZ/g0p7+T
         flH7Wf/l6pGqOX4k1NZGQG6xAlKKJDAHk5fsM/5YFVRAc6kTPYdBgO7+Nu6onI2c7M7F
         /FyuqazdZVvWwwqRXDgwZ5nFx8arjKky32CXW/DMk/YUBsfkzKtJ5M1aWPac+DlI4ju6
         RyWw==
X-Gm-Message-State: AOAM531/SuDJEEiduxc7D8ibRnmxmjVfzbSje0y3tkCSr6sB54sH/IQY
        3gFW8wUu0Egav6//iFEEEXkgJihUKlX6U3vv
X-Google-Smtp-Source: ABdhPJwUZNvwU49wt0M7ae6klwO05ufg/idd6YcypAKodnZIVmawBJoecT36s9t00oRUiMz2HIYfrw==
X-Received: by 2002:a5e:a911:: with SMTP id c17mr17526518iod.20.1613490575345;
        Tue, 16 Feb 2021 07:49:35 -0800 (PST)
Received: from [172.22.22.4] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id i20sm10877449ila.82.2021.02.16.07.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Feb 2021 07:49:34 -0800 (PST)
Subject: Re: [PATCH 02/13] staging: greybus: Switch from strlcpy to strscpy
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     devel@driverdev.osuosl.org, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Ioana Radulescu <ruxandra.radulescu@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Rui Miguel Silva <rmfrfs@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Marc Dietrich <marvin24@gmx.de>,
        Jens Frederich <jfrederich@gmail.com>,
        Daniel Drake <dsd@laptop.org>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        William Cohen <wcohen@redhat.com>,
        Mike Rapoport <rppt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Robert Richter <rric@kernel.org>, greybus-dev@lists.linaro.org,
        ac100@lists.launchpad.net, linux-tegra@vger.kernel.org,
        linux-fbdev@vger.kernel.org
References: <20210131172838.146706-1-memxor@gmail.com>
 <20210131172838.146706-3-memxor@gmail.com>
 <b565bdae-10a9-9b6c-ae60-dcee88f7dedd@ieee.org>
 <20210216154800.jg24ahfj52t6qgbd@apollo>
From:   Alex Elder <elder@ieee.org>
Message-ID: <8b51d270-5d25-919d-2034-8452513e3eaf@ieee.org>
Date:   Tue, 16 Feb 2021 09:49:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <20210216154800.jg24ahfj52t6qgbd@apollo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On 2/16/21 9:48 AM, Kumar Kartikeya Dwivedi wrote:
> On Tue, Feb 16, 2021 at 08:24:59PM IST, Alex Elder wrote:
>> This is a good change.  But while you're at it, I would
>> appreciate if you would convert a few spots to use
>> sizeof(dest) rather than a fixed constant.  I will
>> point them out below.
>>
>> If this is the *only* request for a change on your
>> series, please tell me that and I can sign off on
> 
> So far, this has been the only request.
> 
>> this without you implementing my suggestion.  But
>> if you post a version 2, please do what I describe.
>>
> 
> I will incorporate these if I end up sending a v2.
> 
> Alternatively, would a separate patch with your suggestions applied on top of
> this be acceptable, if I don't?

Yes.  Assuming you do that, for this patch (as-is):

Reviewed-by: Alex Elder <elder@linaro.org>

