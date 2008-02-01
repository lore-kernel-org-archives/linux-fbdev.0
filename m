From: Thomas Pfaff <tpfaff@pcs.com>
Subject: Re: [PATCH] [Resend] fbcon : fix color
 generation for monochrome framebuffer
Date: Fri, 1 Feb 2008 14:55:41 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802011443290.5695@lxtpfaff.pcs.ditec.de>
References: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
	<20080131140701.b584430e.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0802011128210.5425@lxtpfaff.pcs.ditec.de>
	<Pine.LNX.4.64.0802011322450.18111@anakin>
	<Pine.LNX.4.64.0802011353430.5628@lxtpfaff.pcs.ditec.de>
	<Pine.LNX.4.64.0802011426140.18111@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKwMv-0003Gc-AM for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 05:55:49 -0800
Received: from mail.pcs.de ([145.253.69.50] helo=mail.pcs.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKwMt-0007Fd-To
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 05:55:49 -0800
In-Reply-To: <Pine.LNX.4.64.0802011426140.18111@anakin>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com

On Fri, 1 Feb 2008, Geert Uytterhoeven wrote:
> On Fri, 1 Feb 2008, Thomas Pfaff wrote:
> > On Fri, 1 Feb 2008, Geert Uytterhoeven wrote:
> > > On Fri, 1 Feb 2008, Thomas Pfaff wrote:
> > > > On Thu, 31 Jan 2008, Andrew Morton wrote:
> > > > > On Mon, 28 Jan 2008 11:03:38 +0100 (CET)
> > > > If the functions should be deinlined someone should decide where to put them. 
> > > > Since they must be exported i would avoid to put them into fbcon.c, this would 
> > > > lead to cross dependencies.
> > > > I would suggest to put the prototype into <linux/fb.h> and the definition into 
> > > > fbcmap.c instead, but i am unsure whether they really belong there.
> > > 
> > > General note: functions in header files must be inline, else you get
> > > multiple definitions of the same symbol.
> > 
> > Of course you are right but this does not answer my question:
> > Where should i put a mono_col / attr_col_ec if they must be deinlined ?
> 
> Sorry, I misunderstood. I thought you meant the macros that Andrew
> wanted to be turned into functions.
> 
> > My suggestion is a fb_mono_col / fb_attr_col_ec in fbcmap.c.
> 
> As they're used by fbcon only, not by fbdev, I'd suggest fbcon.c.
> 

IMHO putting them in fbcon.c does not work because the functions are called in 
tileblit / bitblit . Both modules are used by fbcon (bitblit directly, tileblit 
when CONFIG_FB_TILEBLITTING is defined).

When the functions are defined in fbcon.c you would get a
bitblit depends on fbcon depends on bitblit
situation.

> pmag-aa-fb.c is the only other user, but it's broken anyway because it
> still uses the 2.4.x fbdev API.
> 


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
