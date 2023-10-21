Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F96CC001E0
	for <linux-fbdev@archiver.kernel.org>; Sat, 21 Oct 2023 10:01:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230340AbjJUKBk (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 21 Oct 2023 06:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjJUKBh (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Sat, 21 Oct 2023 06:01:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609E11A4;
        Sat, 21 Oct 2023 03:01:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2094C433C8;
        Sat, 21 Oct 2023 10:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697882492;
        bh=3zCgKmJdi98hP9QQIfd4H55ELJbSnTf8HD6FTfiv8Gc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=h8ILdv1xC+/c1UTQ76hervPgmqNVMKWX4Y1SckCY0sU+yPerY622eXEh5sr/07KxP
         7KTjkMSqtlB3+cs0GxDuUvRGi2frDN7BX0cwCHzIRPuLcpd5dGv+Pd7ydJvPDhLVBP
         xBF2rFo/2wXRDSmEp+/vLY0Kp5D0YzDzcmfQk+Jo=
Date:   Sat, 21 Oct 2023 12:01:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: sm750fb: Remove unused return value in
 display_control_adjust_sm750le()
Message-ID: <2023102113-barbell-amazingly-cef6@gregkh>
References: <20231019101348.22076-1-anonolitunya@gmail.com>
 <20231019101348.22076-2-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231019101348.22076-2-anonolitunya@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Thu, Oct 19, 2023 at 01:13:36PM +0300, Dorcas AnonoLitunya wrote:
> Modifies the return type of display_control_adjust_sm750le()
> to void from unsigned long as the return value is being ignored in
> all subsequent function calls.
> 
> This improves code readability and maintainability.
> 
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Dorcas AnonoLitunya <anonolitunya@gmail.com>
> ---
>  drivers/staging/sm750fb/ddk750_mode.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

This patch doesn't apply against my latest branch.  Please rebase it and
resend.

thanks,

greg k-h
