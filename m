Return-Path: <linux-fbdev-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C4B0C433EF
	for <linux-fbdev@archiver.kernel.org>; Sat,  5 Feb 2022 05:42:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239041AbiBEFmR (ORCPT <rfc822;linux-fbdev@archiver.kernel.org>);
        Sat, 5 Feb 2022 00:42:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbiBEFmL (ORCPT
        <rfc822;linux-fbdev@vger.kernel.org>); Sat, 5 Feb 2022 00:42:11 -0500
X-Greylist: delayed 620 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 04 Feb 2022 21:42:08 PST
Received: from mx1.smtp.larsendata.com (mx1.smtp.larsendata.com [91.221.196.215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBE1C061347
        for <linux-fbdev@vger.kernel.org>; Fri,  4 Feb 2022 21:42:08 -0800 (PST)
Received: from mail01.mxhotel.dk (mail01.mxhotel.dk [91.221.196.236])
        by mx1.smtp.larsendata.com (Halon) with ESMTPS
        id a1e59090-852f-11ec-b20b-0050568c148b;
        Thu, 03 Feb 2022 20:26:56 +0000 (UTC)
Received: from ravnborg.org (80-162-45-141-cable.dk.customer.tdc.net [80.162.45.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sam@ravnborg.org)
        by mail01.mxhotel.dk (Postfix) with ESMTPSA id 8B539194BAD;
        Thu,  3 Feb 2022 21:25:55 +0100 (CET)
Date:   Thu, 3 Feb 2022 21:25:53 +0100
X-Report-Abuse-To: abuse@mxhotel.dk
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     DRI Development <dri-devel@lists.freedesktop.org>,
        linux-fbdev@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Claudio Suarez <cssk@net-c.es>,
        Gerd Hoffmann <kraxel@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Sven Schnelle <svens@stackframe.org>
Subject: Re: [PATCH 01/21] MAINTAINERS: Add entry for fbdev core
Message-ID: <Yfw6UVCdmDyxKpDa@ravnborg.org>
References: <20220131210552.482606-1-daniel.vetter@ffwll.ch>
 <20220131210552.482606-2-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131210552.482606-2-daniel.vetter@ffwll.ch>
Precedence: bulk
List-ID: <linux-fbdev.vger.kernel.org>
X-Mailing-List: linux-fbdev@vger.kernel.org

Hi Daniel,

On Mon, Jan 31, 2022 at 10:05:32PM +0100, Daniel Vetter wrote:
> Ever since Tomi extracted the core code in 2014 it's been defacto me
> maintaining this, with help from others from dri-devel and sometimes
> Linus (but those are mostly merge conflicts):
> 
> $ git shortlog -ns  drivers/video/fbdev/core/ | head -n5
>     35  Daniel Vetter
>     23  Linus Torvalds
>     10  Hans de Goede
>      9  Dave Airlie
>      6  Peter Rosin
> 
> I think ideally we'd also record that the various firmware fb drivers
> (efifb, vesafb, ...) are also maintained in drm-misc because for the
> past few years the patches have either been to fix handover issues
> with drm drivers, or caused handover issues with drm drivers. So any
> other tree just doesn't make sense. But also, there's plenty of
> outdated MAINTAINER entries for these with people and git trees that
> haven't been active in years, so maybe let's just leave them alone.
> And furthermore distros are now adopting simpledrm as the firmware fb
> driver, so hopefully the need to care about the fbdev firmware drivers
> will go down going forward.
> 
> Note that drm-misc is group maintained, I expect that to continue like
> we've done before, so no new expectations that patches all go through
> my hands. That would be silly. This also means I'm happy to put any
> other volunteer's name in the M: line, but otherwise git log says I'm
> the one who's stuck with this.
> 
> Cc: Dave Airlie <airlied@gmail.com>
> Cc: Jani Nikula <jani.nikula@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Javier Martinez Canillas <javierm@redhat.com>
> Cc: DRI Development <dri-devel@lists.freedesktop.org>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Cc: Claudio Suarez <cssk@net-c.es>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Daniel Vetter <daniel.vetter@intel.com>
> Cc: Sven Schnelle <svens@stackframe.org>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ea3e6c914384..49809eaa3096 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7573,6 +7573,12 @@ S:	Maintained
>  W:	http://floatingpoint.sourceforge.net/emulator/index.html
>  F:	arch/x86/math-emu/
>  
> +FRAMEBUFFER CORE
> +M:	Daniel Vetter <daniel@ffwll.ch>
> +F:	drivers/video/fbdev/core/

Maybe add:
include/linux/fb.h
include/uapi/linux/fb.h

Both edited within some months - so they see a little changes.

With or without this:
Acked-by: Sam Ravnborg <sam@ravnborg.org>
