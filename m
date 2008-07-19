From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: No console on Riva TNT since 2.6.26-0.rc4
Date: Sat, 19 Jul 2008 18:06:59 +0200
Message-ID: <20080719180659.da7efbcd.krzysztof.h1@poczta.fm>
References: <062620082004.6012.4863F668000CEA0D0000177C2200751090CE05040A05@comcast.net>
	<20080709194108.f18226e8.akpm@linux-foundation.org>
	<20080710025149.GA4817@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KKEt5-0005yi-Hy for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Jul 2008 09:02:23 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KKEt2-0007uy-V5
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 Jul 2008 09:02:23 -0700
In-Reply-To: <20080710025149.GA4817@martell.zuzino.mipt.ru>
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
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Quel Qun <kelk1@comcast.net>, Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, LKML <linux-kernel@vger.kernel.org>

On Thu, 10 Jul 2008 06:51:49 +0400
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> On Wed, Jul 09, 2008 at 07:41:08PM -0700, Andrew Morton wrote:
> > On Thu, 26 Jun 2008 20:04:56 +0000 kelk1@comcast.net (Quel Qun) wrote:
> > 
> > > Hi,
> > > 
> > > The system boots fine with 2.6.26-0.rc3.1mnb (Mandriva Cooker), but since rc4, I see a few squares of color, then a black screen and the console never comes back. This is independent of the resolution chosen when using vga=ask. The machine does boot and I can start X if I log in blindly. Only the F1 to F6 consoles are gone.
> > > 

Please try the patch below if it helps:

--- linux-2.6.26/drivers/video/vesafb.c	2008-07-13 23:51:29.000000000 +0200
+++ linux-mm/drivers/video/vesafb.c	2008-07-19 17:56:51.774318414 +0200
@@ -247,7 +247,8 @@ static int __init vesafb_probe(struct pl
 	/*   size_total -- all video memory we have. Used for mtrr
 	 *                 entries, ressource allocation and bounds
 	 *                 checking. */
-	size_total = screen_info.lfb_size * 65536;
+	size_total = screen_info.lfb_linelength * screen_info.lfb_height *
+		     screen_info.pages;
 	if (vram_total)
 		size_total = vram_total * 1024 * 1024;
 	if (size_total < size_vmode)

Regards,
Krzysztof

----------------------------------------------------------------------
Zobacz cala prawde o Lukaszu Podolskim!
kliknij >>> http://link.interia.pl/f1e57


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
