Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C8CC433F5
	for <linux-fbdev@archiver.kernel.org>; Thu, 17 Feb 2022 11:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239785AbiBQLGK (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:06:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237687AbiBQLFr (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>);
        Thu, 17 Feb 2022 06:05:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AE88D4C8F
        for <linux-fbdev@vger.kernel.org>; Thu, 17 Feb 2022 03:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645095932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6YSZbwBi3c0InCkDrYByE4b4NApn0BejRZUJ5ijAPEA=;
        b=hdPTmift3fKLoVG/YV2MSnHLspV1BBUKmCeQPhdbbgvmZDoNLnpJtATVDg9OpaOkiIm2OZ
        31V13IUEYlUsnCdPwvaoCCWg/VbGf5P7JgoWHxyleQCSPHS9+JwV6ukoFSwDXnufKSEK/8
        oFtEKeJzEoQw3u30eXFd6PBLWpL4CFs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-tz6_fUFfOR60RApTJwRpVQ-1; Thu, 17 Feb 2022 06:05:29 -0500
X-MC-Unique: tz6_fUFfOR60RApTJwRpVQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9B3381424B;
        Thu, 17 Feb 2022 11:05:27 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.34])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id EC03256A8A;
        Thu, 17 Feb 2022 11:05:20 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
        id 267F618000AA; Thu, 17 Feb 2022 12:05:19 +0100 (CET)
Date:   Thu, 17 Feb 2022 12:05:19 +0100
From:   Gerd Hoffmann <kraxel@redhat.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>
Cc:     daniel@ffwll.ch, deller@gmx.de, javierm@redhat.com,
        geert@linux-m68k.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/2] fbdev: Improve performance of sys_imageblit()
Message-ID: <20220217110519.ql5baa46sbsfb5cy@sirius.home.kraxel.org>
References: <20220217103405.26492-1-tzimmermann@suse.de>
 <20220217103405.26492-3-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217103405.26492-3-tzimmermann@suse.de>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

> -		for (j = k; j--; ) {
> -			shift -= ppw;
> -			end_mask = tab[(*src >> shift) & bit_mask];
> -			*dst++ = (end_mask & eorx) ^ bgx;
> -			if (!shift) {
> -				shift = 8;
> -				src++;
> +		for (j = k; j; j -= jdecr, ++src) {
> +			switch (ppw) {
> +			case 4: /* 8 bpp */
> +				*dst++ = colortab[(*src >> 4) & bit_mask];
> +				*dst++ = colortab[(*src >> 0) & bit_mask];
> +				break;
> +			case 2: /* 16 bpp */
> +				*dst++ = colortab[(*src >> 6) & bit_mask];
> +				*dst++ = colortab[(*src >> 4) & bit_mask];
> +				*dst++ = colortab[(*src >> 2) & bit_mask];
> +				*dst++ = colortab[(*src >> 0) & bit_mask];
> +				break;
> +			case 1: /* 32 bpp */
> +				*dst++ = colortab[(*src >> 7) & bit_mask];
> +				*dst++ = colortab[(*src >> 6) & bit_mask];
> +				*dst++ = colortab[(*src >> 5) & bit_mask];
> +				*dst++ = colortab[(*src >> 4) & bit_mask];
> +				*dst++ = colortab[(*src >> 3) & bit_mask];
> +				*dst++ = colortab[(*src >> 2) & bit_mask];
> +				*dst++ = colortab[(*src >> 1) & bit_mask];
> +				*dst++ = colortab[(*src >> 0) & bit_mask];
> +				break;
>  			}

How about moving the switch out of the loop, i.e.

switch (ppw) {
case 4:
    for (j = ...) {
        *dst++ = colortab[(*src >> 4) & bit_mask];
        *dst++ = colortab[(*src >> 0) & bit_mask];
    }
[ ... ]
}

?

take care,
  Gerd

