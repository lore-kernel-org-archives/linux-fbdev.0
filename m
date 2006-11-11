From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005	with radeonfb enabled
Date: Sun, 12 Nov 2006 09:49:39 +1100
Message-ID: <1163285379.4982.233.camel@localhost.localdomain>
References: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gj1fa-0000Sn-D4 for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 14:49:50 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+C8zjzqwcSO6fx8YUHIGbVmLCjVw8MJzQ=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Gj1fY-00030q-US
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 14:49:50 -0800
In-Reply-To: <D0233BCDB5857443B48E64A79E24B8CE6B5438@labex2.corp.trema.com>
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
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian@ogre.sisk.pl, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Solomon Peachy <pizza@shaftnet.org>, Hoffmann@albercik.sisk.pl


> Then the radeonfb doesn't kick in at all (guess some pci ids are added
> in that patch).
> 
> BTW: resume/suspend works ok if I have the vesa fb enabled.

In that case (vesafb), when does the screen come back precisely ? Do you
get console mode back and then X ? Or it only comes back when going back
to X ? Do you have some userland-type vbetool thingy that bring it
back ?

Ben.



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
