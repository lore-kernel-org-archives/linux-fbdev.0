From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH] [Resend] fbcon : fix color
 generation for monochrome framebuffer
Date: Fri, 1 Feb 2008 09:02:17 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802010859230.22762@anakin>
References: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
	<20080131140701.b584430e.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKqqw-0000vW-G9 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 00:02:26 -0800
Received: from edna.telenet-ops.be ([195.130.132.58])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKqqu-0004Jm-Mx
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 00:02:26 -0800
In-Reply-To: <20080131140701.b584430e.akpm@linux-foundation.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Thomas Pfaff <tpfaff@pcs.com>, adaplas@gmail.com

On Thu, 31 Jan 2008, Andrew Morton wrote:
> On Mon, 28 Jan 2008 11:03:38 +0100 (CET) Thomas Pfaff <tpfaff@pcs.com> wrote:
> > +#define attr_bgcol_ec(bgshift,vc,info)		\
> > +	attr_col_ec(bgshift,vc,info,0);
> > +#define attr_fgcol_ec(fgshift,vc,info)		\
> > +	attr_col_ec(fgshift,vc,info,1);
> > +
> 
> Could be implemented as C functions.

I don't see a real advantage in using a function instead. It will just
become longer. There won't be any additional type checking.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
