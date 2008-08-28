From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 2/2] tdfxfb: fix frame buffer name
 overrun
Date: Thu, 28 Aug 2008 09:01:54 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0808280854220.11935@anakin>
References: <20080827210739.21936b36.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KYbW6-00053h-Js for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 00:02:02 -0700
Received: from wilson.telenet-ops.be ([195.130.132.42])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KYbW4-0001iA-SE
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 28 Aug 2008 00:02:02 -0700
In-Reply-To: <20080827210739.21936b36.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>

On Wed, 27 Aug 2008, Krzysztof Helt wrote:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> If there are more then one graphics card handled 
> by the tdfxfb driver the name of the frame buffer 
> overruns reserved name size.

Nice spot! Multiple strcat() will start overwriting other fields in
fb_fix_screeninfo.

> ---
> This also is good candidate for 2.6.27 fix.
> 
>  drivers/video/tdfxfb.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
> index fa7cbec..ed86ef3 100644
> --- a/drivers/video/tdfxfb.c
> +++ b/drivers/video/tdfxfb.c
> @@ -95,7 +95,6 @@ static inline int mtrr_del(int reg, unsigned long base,
>  #define VOODOO5_MAX_PIXCLOCK 350000
>  
>  static struct fb_fix_screeninfo tdfx_fix __devinitdata = {
> -	.id =		"3Dfx",
>  	.type =		FB_TYPE_PACKED_PIXELS,
>  	.visual =	FB_VISUAL_PSEUDOCOLOR,
>  	.ypanstep =	1,
> @@ -1196,6 +1195,7 @@ static int __devinit tdfxfb_probe(struct pci_dev *pdev,
>  		return -ENOMEM;
>  
>  	default_par = info->par;
> +	strcpy(tdfx_fix.id, "3Dfx");
>  
>  	/* Configure the default fb_fix_screeninfo first */
>  	switch (pdev->device) {

At first I thought: but this doesn't fix all problems with multiple
cards, as tdfx_fix is still shared among all of them? But that's not
true (tdfx_fix is copied to info->fix later), so it is correct.

IMHO, as tdfx_fix is used as some `temporary' variable in tdfxfb_probe() only,
a better fix would be to change the operation mode from:

    info = framebuffer_alloc(...);
    tdfx_fix.foo = ...; /* depends on probe value */
    tdfx_fix.bar = ...; /* depends on probe value */
    info->fix = tdfx_fix;

to

    info = framebuffer_alloc(...);
    info->fix = tdfx_fix;
    info->fix.foo = ...; /* depends on probe value */
    info->fix.bar = ...; /* depends on probe value */

and make tdfx_fix const. Then you don't have to initialize tdfx_fix.id
for every card, and make it clear that tdfx_fix is just used as a template.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
