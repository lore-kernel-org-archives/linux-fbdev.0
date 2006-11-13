From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005 with radeonfb enabled
Date: Mon, 13 Nov 2006 18:07:08 +0100
Message-ID: <20061113170708.GC23917@atrey.karlin.mff.cuni.cz>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GjfH9-0007lh-Rq for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 09:07:16 -0800
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GjfH9-0004Kn-CP
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Nov 2006 09:07:15 -0800
Content-Disposition: inline
In-Reply-To: <D0233BCDB5857443B48E64A79E24B8CE6B5441@labex2.corp.trema.com>
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
To: Christian Hoffmann <Christian.Hoffmann@wallstreetsystems.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian@ogre.sisk.pl, Benjamin Herrenschmidt <benh@kernel.crashing.org>, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Solomon Peachy <pizza@shaftnet.org>, Hoffmann@albercik.sisk.pl

Hi!

> > > > Then the radeonfb doesn't kick in at all (guess some pci ids are 
> > > > added in that patch).
> > > > 
> > > > BTW: resume/suspend works ok if I have the vesa fb enabled.
> > > 
> > > In that case (vesafb), when does the screen come back 
> > precisely ? Do 
> > > you get console mode back and then X ? Or it only comes back when 
> > > going back to X ? Do you have some userland-type vbetool 
> > thingy that 
> > > bring it back ?
> > 
> > He's using s3_bios+s3_mode, so kernel does some BIOS calls to 
> > reinit the video. It should come out in text mode, too.
> > 
> > Christian, can you unload radeonfb before suspend/reload it 
> > after resume?
> 
> Will it work if radeonfb is compiled as module? I think I had problems
> with that, but I'll try again.

I think it could. Be sure to compile vga text-mode support into
kernel.

-- 
Thanks, Sharp!

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
