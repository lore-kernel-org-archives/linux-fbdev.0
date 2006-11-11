From: "Christian Hoffmann" <Christian.Hoffmann@wallstreetsystems.com>
Subject: Re: Fwd: [Suspend-devel] resume not working on
	acer ferrari 4005	with radeonfb enabled
Date: Sun, 12 Nov 2006 00:02:00 +0100
Message-ID: <D0233BCDB5857443B48E64A79E24B8CE043CB5@labex2.corp.trema.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gj1zD-0002FW-Ql for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 15:10:07 -0800
Received: from wshld2.trema.com ([194.103.215.196]
	helo=webshieldout.corp.trema.com)
	by mail.sourceforge.net with smtp (Exim 4.44) id 1Gj1zA-0007So-V7
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 11 Nov 2006 15:10:07 -0800
content-class: urn:content-classes:message
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
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Christian@ogre.sisk.pl, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Solomon Peachy <pizza@shaftnet.org>, Hoffmann@albercik.sisk.pl


-----Original Message-----
From:	linux-fbdev-devel-bounces@lists.sourceforge.net on behalf of Benjamin Herrenschmidt
Sent:	Sat 11/11/2006 11:49 PM
To:	Christian Hoffmann
Cc:	Andrew Morton; linux-fbdev-devel@lists.sourceforge.net; Christian@ogre.sisk.pl; LKML; Rafael J. Wysocki; Solomon Peachy; Hoffmann@albercik.sisk.pl
Subject:	Re: [Linux-fbdev-devel] Fwd: [Suspend-devel] resume not working on acer ferrari 4005	with radeonfb enabled


> Then the radeonfb doesn't kick in at all (guess some pci ids are added
> in that patch).
> 
> BTW: resume/suspend works ok if I have the vesa fb enabled.

In that case (vesafb), when does the screen come back precisely ? Do you
get console mode back and then X ? Or it only comes back when going back
to X ? Do you have some userland-type vbetool thingy that bring it
back ?

Ben.

---
With vesafb X comes back even without vbetool. The console has to be reactivated by switching back and forth between X and console or by using vbetool. But it never completely freezes the machine.

Chris




Privileged or confidential information may be contained in this message.  If you are not the addressee of this message please notify the sender by return and thereafter delete the message, and you may not use, copy, disclose or rely on the information contained in it. Internet e-mail may be susceptible to data corruption, interception and unauthorised amendment for which Wall Street Systems does not accept liability. Whilst we have taken reasonable precautions to ensure that this e-mail and any attachments have been swept for viruses, Wall Street Systems does not accept liability for any damage sustained as a result of viruses.  Statements in this message or attachments that do not relate to the business of  Wall Street Systems are neither given nor endorsed by the company or its Directors.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
