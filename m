From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH]: frame buffer driver for 2700G LCD
 controller
Date: Sun, 9 Jul 2006 21:38:32 +0200 (CEST)
Message-ID: <Pine.LNX.4.62.0607092137490.25239@pademelon.sonytel.be>
References: <44AD2B75.6050302@compulab.co.il> <44ADC4AE.2040903@gmail.com>
	<44B11542.7010402@compulab.co.il>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fzf71-00034e-SC for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 12:38:40 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fzf70-0000Yl-8r
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 09 Jul 2006 12:38:39 -0700
In-Reply-To: <44B11542.7010402@compulab.co.il>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

On Sun, 9 Jul 2006, Mike Rapoport wrote:
> Antonino A. Daplas wrote:
> > Mike Rapoport wrote:
> > > +#include "mbxsysfs.c"
> > > +
> > > +#define res_size(_r) (((_r)->end - (_r)->start) + 1)
> > >    
> > 
> > No arch-specific function/macro's to determine the resource length?
> >  
> I searched for one but in vain.

`grep resource_len include/linux/*.h' indeed doesn't show one for generic use,
only for the PCI, Zorro, and DIO busses.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
