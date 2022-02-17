Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A881C433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Feb 2022 10:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239095AbiBQKS7 (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:18:59 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbiBQKS7 (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Feb 2022 05:18:59 -0500
X-Greylist: delayed 427 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Feb 2022 02:18:43 PST
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31591256ED0
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 02:18:43 -0800 (PST)
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        by mail-4321.protonmail.ch (Postfix) with ESMTPS id 4JzrG762N8z4x4GW
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 10:11:43 +0000 (UTC)
Authentication-Results: mail-4321.protonmail.ch;
        dkim=pass (2048-bit key) header.d=emersion.fr header.i=@emersion.fr header.b="X+i20R5g"
Date:   Thu, 17 Feb 2022 10:11:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1645092693;
        bh=T6IpIe0qlak/CRlarOD0jKHaYw0xSiHQu/HYNWx/KyM=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=X+i20R5g6ti2hqmOoTzHcZag2oMG6wacA4IM9NAmsxM5gAbqBGJ0BrYEbJph2fNVv
         IP8F8DcPWOwL7kEgFlhn+Kd+zeXnREUhjPdBVoUn5j/9atEZSyStWGvQSY8HNGduWK
         zfTEw9aL7rd4112wrmpdNluANJjyHnbYKXP88qLlmsY2DUq2UQzQsZgPO4Zg61RbNe
         4cAOJFyW8sSm/47UyeQJ0qvFIlWqIwSIWzPP7cSukV9lAuQybM65SOFY8U+PR71Cq/
         tBuXy/ouPvAS2QntjYR6DKM8ciJEMErzpOV25DhhZEPD9cor+Pg+TJUzLjmIW8bXlZ
         ZNQ1fXHRqlaYQ==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        linux-fbdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 8/8] drm/fourcc: Add DRM_FORMAT_D1
Message-ID: <DcHC6EkcAbkIdUGwoi3NJ9dU_zOwtndgZvp6ynoG05hPKPphZNEBAGWo25xgkxjjfmqzn2vBJcc3xGaFEMfWqY0jXNus1sWjmZSr9yzkcZE=@emersion.fr>
In-Reply-To: <20220215165226.2738568-9-geert@linux-m68k.org>
References: <20220215165226.2738568-1-geert@linux-m68k.org> <20220215165226.2738568-9-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi,

On Tuesday, February 15th, 2022 at 17:52, Geert Uytterhoeven <geert@linux-m=
68k.org> wrote:

> Introduce a fourcc code for a single-channel frame buffer format with two
> darkness levels. This can be used for two-level dark-on-light displays.

The previous patches introduce C1 and R1. Do we really need D1? Can't
we just use R1 instead?

Simon
