From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: tdfx & multiple voodoo cards : supposed to
 work ? + Mach64Gx question.
Date: Thu, 30 Oct 2003 21:31:56 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0310302131070.16880-100000@waterleaf.sonytel.be>
References: <20031030183125.GA12087@iliana>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AFJSd-0005H2-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 30 Oct 2003 12:32:03 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AFJSc-00031l-TC
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 30 Oct 2003 12:32:03 -0800
In-Reply-To: <20031030183125.GA12087@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 30 Oct 2003, Sven Luther wrote:
> On Thu, Oct 30, 2003 at 06:27:01PM +0000, James Simmons wrote:
> > > 00:0f.0 VGA comppatible controller: ATI Technolgies Inc 210888GX [Mach64 GX] (rev 02)
> > > 
> > > Any idea on what is going on here (the kernel works, but there is no
> > > video output).
> > 
> > I have this card as well and never got it to work.
> 
> On x86 ? But Chris is telling that it used to work well with his 2.2.20
> or thereabout kernel.

Interesting... With atyfb? There shouldn't be any changes between atyfb in
2.2.20 and 2.4.x/2.6.0 w.r.t. Mach64 GX.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
