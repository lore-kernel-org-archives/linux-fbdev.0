Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC094C433B4
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 05:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85085613A3
	for <linux-fbdev@archiver.kernel.org>; Wed,  7 Apr 2021 05:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbhDGF5M (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 7 Apr 2021 01:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243610AbhDGF5M (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 7 Apr 2021 01:57:12 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254E2C06174A;
        Tue,  6 Apr 2021 22:57:02 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id bg21so6140976pjb.0;
        Tue, 06 Apr 2021 22:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U21rJoH55u/lTd+3NoSn40fthcLZb2sfVCKDVMCxIlA=;
        b=EsQDoXHTu4nbl9VuF2kCmFKrM2UFX9vXu5ZGIcU1q4/K1Xf20K6ol6qFxKFpetJ/iI
         Aj9hohCIyHTvQbwNnfSzNexF9dBOHn3lzgX9mFSTRUBhm+zoYP4+c29RCTZuEbLURI50
         lm1enCq73Ue8tVcdQrKKo6yrlvzAQcEJWiU8Wl9iRRUmSFrHvdgiU6z/1t/1h1h3ghR/
         xJR2RiWXLhyC6mFXshfzhnRYA7+3G5H4u8YqBA5VtB80O60xrJ13EQd3xWZ8KJ/HPW0U
         hFsdvRWSKEK6qEqIYDQZLGHoHTpUOZet6vMd7PYktcZfXjmFBz75RLIc2eNUkWxrth0K
         VowQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U21rJoH55u/lTd+3NoSn40fthcLZb2sfVCKDVMCxIlA=;
        b=PqsaDkbYB6LW17myJlmUk/krOFc3qWmR9v6nL1srp9RdEV+EFFo9wIdcLBWnbVmFTx
         ihyGzz5ibbFPWI3hDv7bMCuKrB+iTXFoGIc7Lyz7pDrZRFGl3/FkfZjCbsrT5H5om0zm
         H46Qg1ZF4b1MPqJd8sjB7cFgB5XWN8CA4tqV7P2ojrpNz3LdPkGaw/VDrn1cFm+McgUS
         6nLMwMgbhZFG9rpI5VxSrI3Hapq9D3E26Xqp7YRxOVjcXYEIecAFhkY82LVZYk/e96DO
         bwd8fKAvdoLJLmz7/lY9jmMY9ycwi071iZS7fafbJoHF6Ktt5Zq7x2sovMiu3ZIt1yQK
         zEiA==
X-Gm-Message-State: AOAM531jUk44cs+Cwuce4JFqFeNkrYco2KH4EiH+eQ99i+jLnjSwYp2D
        J5baz7XmlppmjaiaogWTlQPksTGubCnp4g==
X-Google-Smtp-Source: ABdhPJxPbp03UpzLhfR/J68iRJ//WncNagogrPhYEy5gMNCnxvAchd6XMunHL1adZEczDlW5zxEEMw==
X-Received: by 2002:a17:90a:80c9:: with SMTP id k9mr1694475pjw.58.1617775021214;
        Tue, 06 Apr 2021 22:57:01 -0700 (PDT)
Received: from localhost.localdomain ([134.173.248.5])
        by smtp.gmail.com with ESMTPSA id o3sm4271353pjm.30.2021.04.06.22.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Apr 2021 22:57:00 -0700 (PDT)
Date:   Tue, 6 Apr 2021 22:56:58 -0700
From:   Pavle Rohalj <pavle.rohalj@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: sm750fb: Convert camel case to snake case
Message-ID: <YG1JqvTMu7pmHASQ@localhost.localdomain>
References: <YGwncT6RGvYlL9yj@localhost.localdomain>
 <YGwrqUkAUWzccKA2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YGwrqUkAUWzccKA2@kroah.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Tue, Apr 06, 2021 at 11:36:41AM +0200, Greg KH wrote:
> On Tue, Apr 06, 2021 at 02:18:41AM -0700, Pavle Rohalj wrote:
> > -	struct dvi_ctrl_device *pCurrentDviCtrl;
> > +	struct dvi_ctrl_device *p_current_dvi_ctrl;
> 
> Does this change make sense?  Why keep the "p_" here?  We do not need or
> use, this type of variable naming in the kernel.
> 
> Also, please break this up into a patch series where you do one
> structure change at a time.
> 
> thanks,
> 
> greg k-h

Thank you for the input. Makes sense why we would not want to include
type information in variable names. I will send a patchset with changes
broken up into smaller chunks soon.

-Pavle
