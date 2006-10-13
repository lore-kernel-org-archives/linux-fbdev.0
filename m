From: Clemens Koller <clemens.koller@anagramm.de>
Subject: Re: SM501 framebuffer driver
Date: Fri, 13 Oct 2006 15:12:11 +0200
Message-ID: <452F90AB.709@anagramm.de>
References: <45268042.8050207@billgatliff.com> <452691A2.2020209@anagramm.de>
	<20061013121138.GA21744@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GYMpo-0008Lv-55 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 06:12:20 -0700
Received: from moutng.kundenserver.de ([212.227.126.188])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GYMpk-0004Tb-H1
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Oct 2006 06:12:20 -0700
In-Reply-To: <20061013121138.GA21744@linux-sh.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: sm5xx-devel@lists.berlios.de

Hello, Paul!

Thank you for your comments! I'll have to dig through the code to
see of what we can use there.
Since I don't want to re-invent the wheel, I am curious how we get the
driver cross-platform'ish. Hmm... no big ideas yet.

> It should be fairly trivial to rework this for the mfd approach and work
> from there, which I'll look at doing if no one beats me to it and I
> finish some more pressing matters first.

The MultiFunctionDevice (mfd) approach looks good to me.
I'll be glad to have you onboard! :-)

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
