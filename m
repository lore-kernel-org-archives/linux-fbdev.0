From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [PATCH] remove pointless <0 comparisons in drivers/video/fbmem.c
Date: Mon, 22 Nov 2004 08:11:43 +0800
Message-ID: <200411220811.43517.adaplas@hotpop.com>
References: <Pine.LNX.4.61.0411220034040.3423@dragon.hygekrogen.localhost>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261879AbUKVAM2@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411220034040.3423@dragon.hygekrogen.localhost>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Jesper Juhl <juhl-lkml@dif.dk>, linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel <linux-kernel@vger.kernel.org>

On Monday 22 November 2004 07:45, Jesper Juhl wrote:
> The "console" and "framebuffer" members of struct fb_con2fbmap are both
> unsigned, so it makes no sense to compare them for being <0. Patch to
> remove the pointless comparisons below.

Thanks.

Tony
