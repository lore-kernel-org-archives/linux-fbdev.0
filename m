From: Andrew Walrond <andrew@walrond.org>
Subject: Dual screen framebuffer development advice
Date: Sat, 19 Jun 2004 14:55:56 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200406191455.56574.andrew@walrond.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BbgWc-0008A5-Sx
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 07:08:54 -0700
Received: from host213-160-108-25.dsl.vispa.com ([213.160.108.25] helo=cenedra.walrond.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1BbgWc-0003hU-GB
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 07:08:54 -0700
Received: from [192.168.0.2] (helo=bob.mobile)
	by cenedra.walrond.org with esmtp (Exim 4.34)
	id 1BbgWX-0003JG-ME
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Jun 2004 15:08:49 +0100
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: linux-fbdev-devel@lists.sourceforge.net

I need to setup a machine to develop a framebuffer based application. I'd like 
to use two graphics devices; The first an ati agp chipset on the motherboard 
which will run X11 with X11's ati driver, the second a PCI card running a fb 
driver and displaying my framebuffer application.

Is this possible/sensible?

Andrew Walrond


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
