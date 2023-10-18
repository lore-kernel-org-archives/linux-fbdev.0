Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DA55CDB47E
	for <linux-fbdev@archiver.kernel.org>; Wed, 18 Oct 2023 08:26:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235131AbjJRI0r (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Wed, 18 Oct 2023 04:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbjJRI0o (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Wed, 18 Oct 2023 04:26:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4502E109;
        Wed, 18 Oct 2023 01:26:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B330C433C8;
        Wed, 18 Oct 2023 08:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697617602;
        bh=FYY5Pw0Y+SetLQv/94Izx/Ga9lYCUK/a+v2DG8+qr3U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K8ihN9k42Q+zy47NN7jjfBSBCf75PLtqJUOxonlKVPQ7Uc2VVf9w/cCYWm8Idmpye
         j1pMGnF15msUWEOw1DstX5nhc7LJc34NrUSGx2TGp84nCRjMmICfmtM9HRNk4tKoLK
         EpUawOspUieZOKkL8SZdod8Hi1pvuJ6V9ri3vdd0=
Date:   Wed, 18 Oct 2023 10:26:33 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc:     outreachy@lists.linux.dev, julia.lawall@inria.fr,
        dan.carpenter@linaro.org, andi.shyti@linux.intel.com,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Staging: sm750fb: Rename
 display_control_adjust_sm750LE
Message-ID: <2023101817-cleat-attendee-8884@gregkh>
References: <20231018080416.25931-2-anonolitunya@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018080416.25931-2-anonolitunya@gmail.com>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, Oct 18, 2023 at 11:04:08AM +0300, Dorcas AnonoLitunya wrote:
> Rename function display_control_adjust_sm750LE to
> display_control_adjust_sm750le. This further enforces snakecase naming
> convention for consistent naming style throughout entire file.
> 
> This change was suggested by Andi Shyti <andi.shyti@linux.intel.com>

Please use the "Suggested-by:" tag for this.

thanks,

greg k-h
