From: kelk1@comcast.net (Quel Qun)
Subject: Re: [Linux-fbdev-devel] No console on Riva TNT since 2.6.26-0.rc4
Date: Mon, 21 Jul 2008 15:39:12 +0000
Message-ID: <072120081539.21192.4884ADA00005A241000052C82200760180CE05040A05@comcast.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752110AbYGUPjY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Helt <krzysztof.h1@poczta.fm>, Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

Thanks for looking at that.

It takes a while to compile a kernel on this machine, but I will try this patch and report.
--
Eric
 -------------- Original message ----------------------
From: Krzysztof Helt <krzysztof.h1@poczta.fm>
> On Thu, 10 Jul 2008 06:51:49 +0400
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> 
> > On Wed, Jul 09, 2008 at 07:41:08PM -0700, Andrew Morton wrote:
> > > On Thu, 26 Jun 2008 20:04:56 +0000 kelk1@comcast.net (Quel Qun) wrote:
> > > 
> > > > Hi,
> > > > 
> > > > The system boots fine with 2.6.26-0.rc3.1mnb (Mandriva Cooker), but since 
> rc4, I see a few squares of color, then a black screen and the console never 
> comes back. This is independent of the resolution chosen when using vga=ask. The 
> machine does boot and I can start X if I log in blindly. Only the F1 to F6 
> consoles are gone.
> > > > 
> 
> Please try the patch below if it helps:
> 
> --- linux-2.6.26/drivers/video/vesafb.c	2008-07-13 23:51:29.000000000 +0200
> +++ linux-mm/drivers/video/vesafb.c	2008-07-19 17:56:51.774318414 +0200
> @@ -247,7 +247,8 @@ static int __init vesafb_probe(struct pl
>  	/*   size_total -- all video memory we have. Used for mtrr
>  	 *                 entries, ressource allocation and bounds
>  	 *                 checking. */
> -	size_total = screen_info.lfb_size * 65536;
> +	size_total = screen_info.lfb_linelength * screen_info.lfb_height *
> +		     screen_info.pages;
>  	if (vram_total)
>  		size_total = vram_total * 1024 * 1024;
>  	if (size_total < size_vmode)
> 
> Regards,
> Krzysztof
> 
> ----------------------------------------------------------------------
> Zobacz cala prawde o Lukaszu Podolskim!
> kliknij >>> http://link.interia.pl/f1e57
> 
