From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [Sm5xx-devel]  SM501 framebuffer driver
Date: Fri, 13 Oct 2006 22:35:27 +0900
Message-ID: <20061013133527.GA4452@linux-sh.org>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
	<20061013121138.GA21744@linux-sh.org>
	<452F90A4.3040603@varma-el.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYNDU-0002EY-3Y for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 06:36:48 -0700
Received: from smtp.ocgnet.org ([64.20.243.3])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GYNDP-00070b-Gc
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 06:36:48 -0700
Content-Disposition: inline
In-Reply-To: <452F90A4.3040603@varma-el.com>
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
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Robert Whaley <rwhaley@applieddata.net>, sm5xx-devel@lists.berlios.de, linux-fbdev-devel@lists.sourceforge.net

On Fri, Oct 13, 2006 at 05:12:04PM +0400, Andrey Volkov wrote:
> Paul Mundt wrote:
> > There's at least half a dozen of these floating around, with some
> > disagreement on the actual implementation. We had one in the old SH tree
> > that specifically registered a different framebuffer device for each
> > plane, which we had some code in DirectFB and mplayer for making use of
> > for overlays and so on.
> IMHO, its very awkward implementation for real world application,
> especially since, as ex, alpha/video planes is coupled with panel plane
> but not with CRT plane. We currently try use sm501 as two fb (crt/panel)
> devices.
> 
Awkward as it may be, there are plenty of users going with this
approach, and DirectFB has been using it for quite some time. If you
don't care for this approach, do you have a better idea for exposing
individual planes to userspace and fine-grained overlay control?
Multiple device nodes are a lot more pleasant to look at than an ioctl
abortion.

> PCI and MMIO modes of SM501 is mutually exclusive, so it should be
> selected at configure time (as I already does, check my implementation
> in svn).
> 
The driver still requires visibility of these two things. Looking at the
fb driver, it's clear you have no transparent means for gauging the
aperture size. With PCI this comes down to sizing the membar, and in the
platform case it can be statically defined at registration time too.

This will never work on a system where you have a platform bus SM501
with an SM501 on a PCI add-in board, you simply can not gaurantee that
they are exclusive.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
