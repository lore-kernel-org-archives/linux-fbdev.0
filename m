From: Martin Michlmayr <tbm@cyrius.com>
Subject: Re: vga16fb: blank screen with Intel
	GM965/GL960 on HP 2510p	notebook
Date: Sun, 23 Mar 2008 00:27:08 +0100
Message-ID: <20080322232708.GA32209@deprecation.cyrius.com>
References: <20080321163944.GA22068@deprecation.cyrius.com>
	<1206204017.26934.554.camel@koto.keithp.com>
	<20080322165817.GD13703@deprecation.cyrius.com>
	<200803222035.08897.elendil@planet.nl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JdD6p-0003Ri-Pv for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 16:26:43 -0700
Received: from sorrow.cyrius.com ([65.19.161.204])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JdD6o-00089r-Hd
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 22 Mar 2008 16:26:43 -0700
Content-Disposition: inline
In-Reply-To: <200803222035.08897.elendil@planet.nl>
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
To: Frans Pop <elendil@planet.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, Keith Packard <keith.packard@intel.com>

* Frans Pop <elendil@planet.nl> [2008-03-22 20:35]:
> > > Can you use vesafb instead of vga16fb? That should be far more
> > > reliable.
> > vesafb is built into the Debian kernel, so presumably that works.
> > I've no idea why debian-installer loads vga16fb.  Frans, any idea?
> 
> For the graphical installer we force the use of vesafb by directfb, but we 
> don't do anything like that for the regular installer. So you could try 
> booting installgui and see if that does work.

installgui works, but that also passes vga=788 and when I pass that to
the normal installer it also works.

Anyway, you didn't answer my original question which was why the
text-based d-i loads vga16fb.

> Other option could be to boot with 'install video=vga16fb:off', but
> I'm not sure if that's supported.

That doesn't seem to work.
-- 
Martin Michlmayr
http://www.cyrius.com/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
