From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: radeonfb on pegasos powerpc motherboard
	and X endianess problem
Date: 05 Jun 2003 10:01:16 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1054800076.700.23.camel@gaston>
References: <20030604145423.GA22876@iliana>
	 <1054740419.27389.332.camel@thor.holligenstrasse29.lan>
	 <20030604153916.GA23620@iliana>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from amarseille-201-1-3-25.w193-253.abo.wanadoo.fr ([193.253.250.25] helo=gaston)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19Nph9-0002pL-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 05 Jun 2003 01:02:00 -0700
In-Reply-To: <20030604153916.GA23620@iliana>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Sven Luther <sven.luther@wanadoo.fr>
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>


> A, ok, but then, i think i will not worry about this, and simply port
> the pegasos changes to the latest benh kernel (or maybe i can simply
> replace the radeonfb.c file ? Mmm, i will try it). By recent benh
> kernel, you mean the one from the linuxppc_2_4_devel tree or the one from the
> linuxppc_2_4 tree ? Or maybe both are the same.

From the linuxppc_2_4_benh tree :)

> > >   3) When running X without the UseFBDev option, the colors are good,
> > >   but i get garbage when i return to the console. Not exactly garbage,
> > >   at first it is ok, but when i enter a line or somehow pan the screen,
> > >   the corruption start. Doing a vt switch and back redraws a clean
> > >   screen.
> > 
> > Sounds like the radeon driver doesn't restore the framebuffer aperture
> > byte swapping correctly.
> 
> Yep. same solution as above i guess.

The "fuzzyness" on scroll (basically clear operation not behaving
correctly) is an engine setup problem, not an endian problem.

> Sound is also messed up, i guess it is also an endianess issue, but most
> probably due to endianess issue in the VT82Cxx driver, and no other
> powerpc box should use this, i think.

Probably ;)



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
