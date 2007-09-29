From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH 06/17] platinumfb: Fix resource
 management
Date: Sat, 29 Sep 2007 11:16:18 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0709291115300.10965@anakin>
References: <46FDAA91.4080205@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IbYR0-0003CP-Dl for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 02:16:27 -0700
Received: from astra.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IbYQy-0006aq-P5
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 29 Sep 2007 02:16:26 -0700
In-Reply-To: <46FDAA91.4080205@gmail.com>
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
To: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andy Whitcroft <apw@uk.ibm.com>

On Sat, 29 Sep 2007, Antonino A. Daplas wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Current kernels have a non-working platinumfb due to some resource
> management issues. This fixes it.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Antonino Daplas <adaplas@gmail.com>
> ---
> 
>  drivers/video/platinumfb.c |   48 ++++++++++++++++++++++++--------------------
>  1 files changed, 26 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/video/platinumfb.c b/drivers/video/platinumfb.c
> index 8503e73..cbe71a5 100644
> --- a/drivers/video/platinumfb.c
> +++ b/drivers/video/platinumfb.c
> @@ -17,6 +17,8 @@
>   *  more details.
>   */
>  
> +#undef DEBUG
> +
>  #include <linux/module.h>
>  #include <linux/kernel.h>
>  #include <linux/errno.h>

Probably scripts/checkpatch.pl should be taught to complain about
`#undef DEBUG'.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
