From: Antonino Daplas <adaplas@pol.net>
Subject: Re: rivafb "Badness" using fbdev.diff.gz and
	2.5.5[45]
Date: 19 Jan 2003 23:41:25 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042990791.1058.12.camel@localhost.localdomain>
References: <1042975785.1296.31.camel@h9n1fls20o980.telia.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from willow.compass.com.ph ([202.70.96.38])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18aHjU-0002nv-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 19 Jan 2003 07:51:36 -0800
In-Reply-To: <1042975785.1296.31.camel@h9n1fls20o980.telia.com>
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
To: Fredrik Noring <noring@nocrew.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 2003-01-19 at 19:29, Fredrik Noring wrote:
> Hi,
> 
> > To summarise:
> >  insmod rivafb causes "Badness in kobject_register" every time 
> >    ( after pci_register_driver() in rivafb_init(),see below )
> >  after insmod rivafb, I have a green screen, which can be cleared by fbset
> >   ( fbset now changes resolution of all VTs, this is different from 2.4.x )
> >  after clearing green screen using fbset, text colours are wrong
> 
> I get similar results, but I have to run and stop XFree86 4.2 before 
> "insmod rivafb". Otherwise the screen will not be cleared by fbset.
> 
> >  now ( 2.5.59 ), I can insmod fbcon, and screen looks OK again ( apart from
> >   the left-hand-most column of screen appears at right-hand side of screen )
> 
> With 2.5.59 with and without the patch Antonino Daplas sent to the
> kernel list (17 Jan), loading fbcon only displays garbage on the screen.
> The graphics card is TNT AGP.
> 

Unfortunately, the first patch I submitted will only fix wrong colors
with user applications.  If you already have garbage with the unmodified
driver, the patch will not fix it.  The other patch (in reply to Jak)
should hopefully fix the initial screen corruption on insmod and the
kobject trace message.

Can you try running an fbdev-based application, such as X, at 8bpp, just
to find out if the hardware is incorrectly initialized from the very
start or if this is more fbcon-related?

Tony  




-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
