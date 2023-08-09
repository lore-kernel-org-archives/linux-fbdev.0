Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56202C001B0
	for <linux-fbdev@archiver.kernel.org>; Wed,  9 Aug 2023 16:38:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229537AbjHIQia (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 9 Aug 2023 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjHIQia (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Wed, 9 Aug 2023 12:38:30 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCA91982
        for <linux-fbdev@vger.kernel.org>; Wed,  9 Aug 2023 09:38:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so40884465e9.0
        for <linux-fbdev@vger.kernel.org>; Wed, 09 Aug 2023 09:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691599108; x=1692203908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P8nX0pI7rFcPckDGFTH0fbolEOZLnYl6aVYECM4juis=;
        b=FxqHIVo7uVYddWJpN82jeeBQLa2SewY2J5gQJly6P2rQgUBkAGNnZ+bgQtmpNDgw4v
         4mN7u5x/LaW6AoYJ+9d0e4LSthWqV17J1YvpHBXPsZZKsDsmd2Zh9HRdhzBRkiL9tE6E
         5f30eiRt4G59OUhlJM1AhxuL3tX7GgVE2HJMYGN3npJ2PmWIiOwxiHgRcuFTRmSEzuE/
         KCg6LJi+hxRAzI9fD9V9XoIViD32ndaMe5/QjonBZNhTcPMPvIb2GQvxmAePgKIZBHbN
         tEIQuTRbltrMWPYaBeS4LecHgQJ6idS15vgVFzZcSokRMVg36JuO5A/AtTawG83t5vMk
         eNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691599108; x=1692203908;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P8nX0pI7rFcPckDGFTH0fbolEOZLnYl6aVYECM4juis=;
        b=V/HMZ5tgjrLdOugFpcbVZN4rUA62f4HHnFPLl3XbYcGdzpKaLVsXJBAtqe3Ke2/LO2
         t3gnBmJd85aCnoRoiiE6bk0oF73mE+LJ1bTM7baLct5D4dT+yrRKuPUsy+dgNqBuy7H7
         5q9LdJ3ZFGu7Kge1v7v3eB9ZixPLZnLheXwBu28JGu6P1KB+drqIVXun8uv1uf8i6U/J
         zNc9JJRzQgLI+TQlnk/9vztP6lgXk3bxfOgDhdDaxnb2BdZGHHgrBRIeS7DB/lmNv8AZ
         BQdBGCdPTf1jhPoQj5rAxlexVM1ft0LhiNCOnIXYiXJLrh4ufAL01cucZvew2S5UTiWV
         wWCw==
X-Gm-Message-State: AOJu0Yx0Uz+nispmV5x97rlbIVUG95dG6ijkLq+2FFCQR5Luv4egVc4O
        AmNFm+xXEiy+0RzzAT63gQiIv3d4DX9XxtFpsQXAFw==
X-Google-Smtp-Source: AGHT+IEXw5QpPfHSLyKGkNqtuPh+9Tq+iYFSsWhkI2sxKn6VlTHqXOSJRg51iI6lS3t0Y0bELSUsAA==
X-Received: by 2002:adf:d0c2:0:b0:313:f98a:1fd3 with SMTP id z2-20020adfd0c2000000b00313f98a1fd3mr2533598wrh.27.1691599107792;
        Wed, 09 Aug 2023 09:38:27 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id m9-20020a5d4a09000000b0031801aa34e2sm3250114wrq.9.2023.08.09.09.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 09:38:27 -0700 (PDT)
Date:   Wed, 9 Aug 2023 17:38:25 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Artur Weber <aweber.kernel@gmail.com>
Cc:     Lee Jones <lee@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] backlight: lp855x: Drop ret variable in brightness
 change function
Message-ID: <20230809163825.GA5056@aspen.lan>
References: <20230809114216.4078-1-aweber.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809114216.4078-1-aweber.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Aug 09, 2023 at 01:42:16PM +0200, Artur Weber wrote:
> Fixes the following warning:
>
> drivers/video/backlight/lp855x_bl.c:252:7: warning: variable 'ret' is used
> uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
>
> Signed-off-by: Artur Weber <aweber.kernel@gmail.com>
> Fixes: 5145531be5fb ("backlight: lp855x: Catch errors when changing brightness")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202308091728.NEJhgUPP-lkp@intel.com/

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
