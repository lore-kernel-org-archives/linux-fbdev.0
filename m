Return-Path: <linux-fbdev-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4C0C77B7F
	for <linux-fbdev@archiver.kernel.org>; Fri, 18 Aug 2023 15:39:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378217AbjHRPie (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Fri, 18 Aug 2023 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378298AbjHRPiR (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Fri, 18 Aug 2023 11:38:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606802D56;
        Fri, 18 Aug 2023 08:38:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA22962205;
        Fri, 18 Aug 2023 15:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5696C433C8;
        Fri, 18 Aug 2023 15:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692373094;
        bh=0WCy5tN3iMXrAbP8cnUWqtSxEBdiZXqtQG83w2YAGdQ=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=DToQViPWWNU1n2KH92eufMO1C1X5GRpl2uJdQ3JOewhdYsS2AFdTTp2y0O5vuBeMe
         Auu0UMeUopW0hJlTlkArHcBieAtfxVY9TJ8vArIkWlgwdnmTEpzNuK1BloLhcqIrJq
         EreHl3+z3/UIgr9XDuxlw0xzbcMSijWRKIlBuyUlVDGlmCYDAY4eFqIL1cGsejwcpN
         tbd4kyYwtWLdnZYHy/8+TRVsFDLbNbQ7rgvXGranu1f5rPnvSu8gg8uM+BuWPd3gzk
         XMf4SnUu78MtymPJEJAyrxYT002O/0nifL+P4CGUXTd5NWv1UXmLzvjwJD3PQBHi8H
         lcDxhE1kOJr+A==
From:   Lee Jones <lee@kernel.org>
To:     Lee Jones <lee@kernel.org>, Artur Weber <aweber.kernel@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
In-Reply-To: <20230809114216.4078-1-aweber.kernel@gmail.com>
References: <20230809114216.4078-1-aweber.kernel@gmail.com>
Subject: Re: (subset) [PATCH] backlight: lp855x: Drop ret variable in
 brightness change function
Message-Id: <169237309246.1277603.10412077461610988447.b4-ty@kernel.org>
Date:   Fri, 18 Aug 2023 16:38:12 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.2
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

On Wed, 09 Aug 2023 13:42:16 +0200, Artur Weber wrote:
> Fixes the following warning:
> 
> drivers/video/backlight/lp855x_bl.c:252:7: warning: variable 'ret' is used
> uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
> 
> 

Applied, thanks!

[1/1] backlight: lp855x: Drop ret variable in brightness change function
      commit: dfd122fe8591d513b5e51313601217b67ae98d13

--
Lee Jones [李琼斯]

