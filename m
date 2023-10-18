Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99260CDB47E
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 Oct 2023 09:32:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjJRJcl (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 Oct 2023 05:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbjJRJcY (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 Oct 2023 05:32:24 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF181A6
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 02:31:23 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c16757987fso86466161fa.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 02:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697621482; x=1698226282; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5QjheaEjRfKcRJsWNr6c0V1v0c9oT2H9QVa83EftNSs=;
        b=PjYHVL2AFOut/224ptF8VtNEhfpwRNPub38kA2MBq82iokhJNwgbjxKQavrGzm3Kbl
         3TbF2YuoJd3z9nA9e+rbcVQkYasWjyasLgMGeFcAohD88eII9Dn2m+wVnMpucIa8wYKG
         TqiwrGqS6LID234R8f85HJH7fSE9K9ljkfj8UcNSilhFADfLfBrT3ai9pWef8EOQTgg7
         qWaoqF77zTZ3obd5SWs5SRDcTfX19wDmQODQ1nmNYpyUXoU/dKdGPmXh4TMKCWwLMM86
         wwetkyQG3ONW47iNfq5KRYUQtx9vJNd4e/3IA6WIvbaDLdFuki5XLp530LLeIy8FeyHF
         zyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621482; x=1698226282;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QjheaEjRfKcRJsWNr6c0V1v0c9oT2H9QVa83EftNSs=;
        b=VZqes2VIVLYQ2E1f1m0qC6z0tavscbMVNfvfZDjsV6sdo0S3p4jOglE/huqrVIFu6Z
         1trJEEtAtCs0vUqnGBUulDbmdcVaFYnKZp/CU6QFbbEp52eH/1mi2xpOY7BlGz7jN3K2
         q6AgrQIMk9kAt96p4DlC+ZcOWthwyaXl+X6v7YkQXuh+BbqmNswTFI2S0ODAp2itrAqu
         bsuuVcmTxjoPXNfIEk+krEacuvEfNiHi20s3y2yR0Y70wl8GAskuaS9QZCdWOPHS3tlu
         Ji1X0rxVEXpfO75DFDkrOG0oIFVFM4kBcYcOjPVfSB5hasj+gZDg080NbVpTt/JKbN/J
         f0PA==
X-Gm-Message-State: AOJu0YwA+zakIuIjGGnInkhKZcN/0/Pe1AXD08TX//jlvp97qS2NG9hV
        PeOoMD1jfGaJsRRhXzqzX9mnZg==
X-Google-Smtp-Source: AGHT+IFHc/k/rIU+sAYuQvOHqwFIxrnmxpoL8ylYokPeKwjOidRYHM5IwFIWSNd3wG8Wr8cIoMs15Q==
X-Received: by 2002:a2e:9c51:0:b0:2c0:d06:9e65 with SMTP id t17-20020a2e9c51000000b002c00d069e65mr3332079ljj.8.1697621482061;
        Wed, 18 Oct 2023 02:31:22 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c358c00b00401b242e2e6sm1171689wmq.47.2023.10.18.02.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:31:21 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:31:18 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Karolina Stolarek <karolina.stolarek@intel.com>
Cc:     Dorcas AnonoLitunya <anonolitunya@gmail.com>,
        outreachy@lists.linux.dev, julia.lawall@inria.fr,
        andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: sm750fb: Rename
 display_control_adjust_sm750LE
Message-ID: <d219a6b7-0b59-4894-a0c3-01e286f6a132@kadam.mountain>
References: <20231018080416.25931-2-anonolitunya@gmail.com>
 <870b9b74-75bc-2a0d-7138-ae8df237f980@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <870b9b74-75bc-2a0d-7138-ae8df237f980@intel.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 18, 2023 at 10:12:19AM +0200, Karolina Stolarek wrote:
> On 18.10.2023 10:04, Dorcas AnonoLitunya wrote:
> > Rename function display_control_adjust_sm750LE to
> > display_control_adjust_sm750le. This further enforces snakecase naming
> > convention for consistent naming style throughout entire file.
> > 
> > This change was suggested by Andi Shyti <andi.shyti@linux.intel.com>
> 
> You can use Suggested-by tag here, if you wish (as per [1]) before
> Signed-off-by line.

Yeah

> 
> In the first line of the commit, "Staging" should be lowercase.

There isn't really a rule on this.  People do it either way.  But, sure,
in this directory it's a 404 lower case vs 51 upper case so better to
follow the majority opinion.

In outreachy people are way more strict about some process issues than
we would be in real life.  And that's fine, because it's an educational
process.  I just worry that there is a certain amount of bleed over
where people start "correcting" people who haven't signed up to be in
outreachy.

regards,
dan carpenter

