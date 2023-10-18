Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8B7CDB482
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 Oct 2023 09:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjJRJet (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 Oct 2023 05:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjJRJen (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 Oct 2023 05:34:43 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF39114
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 02:34:41 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-31c5cac3ae2so5709946f8f.3
        for <linux-fbdev@vger.kernel.org>; Wed, 18 Oct 2023 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697621679; x=1698226479; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2sv0FCDZpFwcd+OomNX8xlBQ0tLiUtxgv2CzVm71AOM=;
        b=P2Sa+JPxtt9/d4lV9U0Ml4S8z4OIH6TxLXid5B1elUI2nW4LBi9/zuhyyEIleg704+
         ozb5+2TCnA0b7bxa+WD6t/705GL3Q7Q/utlAB0K0QctcI4TWstm7Vih3/nRMio4QwcPt
         9x4vjmrG6xHGKsRwaoWuPcjNKqIjnEvCjwAgKEng96zXjx8Ieuvz9wuzwAXq/BHZwp/K
         EHNFv3ozEMWK5APRQaKHpow/iw2RGokMD1YjhU5d2Mxo+5kUFyJ60W4wFpVs3KnDOd01
         PsjNJacEL6N8QFDdE0pdS6+E9Kzeh/13RNwp22RPACKCqd7PIkynBhW+FtBxCV9HYXga
         f9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697621679; x=1698226479;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sv0FCDZpFwcd+OomNX8xlBQ0tLiUtxgv2CzVm71AOM=;
        b=RzpaeZBotdAKGVvgDf9pqpeRKbLxDkjsqKfohUIHnXoaPog033ViH8A9JUupOWwK5V
         8a5Jj1xQnpNOu9kjmV8SuBFtX4wLVJ3+jgLJEEo/cLWIz7l5or/CktecDvORhNF0g2Az
         lbtxi62JHasVUwGpxBqZvLS0PYxyq6B786b00tnYFzBHTOLDagES4L3zQfDyUDshhMo6
         qyJPTk7LdFwsI1HOX6467Z0B6Z6QG56wOD/Iw7P76v5KXw/OP1GygRPsDjNook6Ddvxo
         0WNpyti5DyqPlFNUQilcAy7C9JTCnnJIgXGJAA8USgtN67WHBy3jxNbWzFQ32xg/jw0U
         8ngQ==
X-Gm-Message-State: AOJu0YyBEsXoJRHil0m/b/6gOU1ZLVqK/e8YRq+qAchXYNKuGCXiotSi
        2ScCAecH6NRFlDS4nzDaW6W5wA==
X-Google-Smtp-Source: AGHT+IGIAS/j+uj93RmHmX/KEbmsiZXmJCczP64fq3Xd7hK0t1HHw4THzR0C0AbDNLPG9A9j4rAoxw==
X-Received: by 2002:a5d:4f02:0:b0:32d:a28b:da08 with SMTP id c2-20020a5d4f02000000b0032da28bda08mr3721637wru.62.1697621679570;
        Wed, 18 Oct 2023 02:34:39 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id h13-20020a056000000d00b0031fd849e797sm1681945wrx.105.2023.10.18.02.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 02:34:39 -0700 (PDT)
Date:   Wed, 18 Oct 2023 12:34:36 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        andi.shyti@linux.intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: sm750fb: Remove unused return value in
 program_mode_registers()
Message-ID: <41a6ac1b-d21e-41ab-b193-623d2f5f2d2c@kadam.mountain>
References: <cover.1697619623.git.anonolitunya@gmail.com>
 <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <492e63bbc58147fb534930ef9e1fb5d844ae8769.1697619623.git.anonolitunya@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 18, 2023 at 12:07:38PM +0300, Dorcas AnonoLitunya wrote:
> -static int program_mode_registers(struct mode_parameter *mode_param,
> -				  struct pll_value *pll)
> +static void program_mode_registers(struct mode_parameter *mode_param,
> +				   struct pll_value *pll)
>  {
>  	int ret = 0;
>  	int cnt = 0;
> @@ -202,7 +202,6 @@ static int program_mode_registers(struct mode_parameter *mode_param,
>  	} else {
>  		ret = -1;

No need to set ret here.

>  	}
> -	return ret;
>  }

regards,
dan carpenter

