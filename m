From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Framebuffer mode required for PowerBook Titanium
Date: Sun, 06 Nov 2005 11:17:44 +1100
Message-ID: <1131236265.5229.49.camel@gaston>
References: <20051105234938.GA18608@hansmi.ch>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S932235AbVKFATX@vger.kernel.org>
In-Reply-To: <20051105234938.GA18608@hansmi.ch>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

On Sun, 2005-11-06 at 00:49 +0100, Michael Hanselmann wrote:
> This patch adds the framebuffer mode required for an Apple PowerBook G4
> Titanium.
> 
> Signed-off-by: Michael Hanselmann <linux-kernel@hansmi.ch>
> 
> ---
> --- linux-2.6.14/drivers/video/modedb.c.orig	2005-11-05 22:29:02.000000000 +0100
> +++ linux-2.6.14/drivers/video/modedb.c	2005-11-05 22:31:15.000000000 +0100
> @@ -251,6 +251,10 @@ static const struct fb_videomode modedb[
>  	NULL, 60, 1920, 1200, 5177, 128, 336, 1, 38, 208, 3,
>  	FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
>  	FB_VMODE_NONINTERLACED
> +    }, {
> +	/* 1152x768, 60 Hz, PowerBook G4 Titanium I and II */
> +	"mac21", 60, 1152, 768, 15386, 158, 26, 29, 3, 136, 6,
> +	FB_SYNC_HOR_HIGH_ACT|FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED
>      },
>  };

Please, re-do it without the "mac21" name, just leave NULL there.

Ben.
