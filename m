From: Thomas Pfaff <tpfaff@pcs.com>
Subject: Re: [PATCH] [Resend] fbcon : fix color
 generation for monochrome framebuffer
Date: Fri, 1 Feb 2008 14:01:07 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0802011353430.5628@lxtpfaff.pcs.ditec.de>
References: <Pine.LNX.4.64.0801281052480.4385@lxtpfaff.pcs.ditec.de>
	<20080131140701.b584430e.akpm@linux-foundation.org>
	<Pine.LNX.4.64.0802011128210.5425@lxtpfaff.pcs.ditec.de>
	<Pine.LNX.4.64.0802011322450.18111@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JKviB-0007Ac-RG for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 05:13:44 -0800
Received: from mail.pcs.de ([145.253.69.50] helo=mail.pcs.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JKvW9-0006RL-RF
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 01 Feb 2008 05:01:19 -0800
In-Reply-To: <Pine.LNX.4.64.0802011322450.18111@anakin>
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
> > On Thu, 31 Jan 2008, Andrew Morton wrote:
> > > On Mon, 28 Jan 2008 11:03:38 +0100 (CET)
> > If the functions should be deinlined someone should decide where to put them. 
> > Since they must be exported i would avoid to put them into fbcon.c, this would 
> > lead to cross dependencies.
> > I would suggest to put the prototype into <linux/fb.h> and the definition into 
> > fbcmap.c instead, but i am unsure whether they really belong there.
> 
> General note: functions in header files must be inline, else you get
> multiple definitions of the same symbol.
> 

Of course you are right but this does not answer my question:
Where should i put a mono_col / attr_col_ec if they must be deinlined ?

My suggestion is a fb_mono_col / fb_attr_col_ec in fbcmap.c.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
