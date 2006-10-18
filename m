From: Bill Gatliff <bgat@billgatliff.com>
Subject: Framebuffer "hangs" at startup
Date: Tue, 17 Oct 2006 21:43:49 -0500
Message-ID: <453594E5.4060606@billgatliff.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ga1OX-0005Hi-3N for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 19:43:01 -0700
Received: from smtp2.mtco.com ([207.179.226.205])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ga1OV-0000k8-OD
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 17 Oct 2006 19:43:01 -0700
Received: from [192.168.2.10] (ghillsrb1-pool1-32.mtco.com [207.179.227.32])
	by smtp2.mtco.com (Spam Firewall) with ESMTP id A734A12393B
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 17 Oct 2006 21:42:56 -0500 (CDT)
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

Guys:


Bear with me, this one is a bit tricky to describe...  :)

I'm testing a 2.6.12 kernel and a 2.6.18.1 kernel, and a few in between, 
and they all do it.  All on ARM targets: PXA255 with onboard LCD 
framebuffer, and AT91RM9200 with an S1D13xxx framebuffer.  Duplicated 
with Qt 4.x and SDL 1.2-debian.

The first time I start up a framebuffer-based application, say Qt or 
Antigrain/SDL, things appear to go fine.  But if I abort said program 
with a CTRL-C and restart it, then the application appears to start up 
fine but there's no screen output.  I don't see any output until I do a 
CTRL-Z and then restore the program to the foreground with "fg".  Then 
the screen clears and things start drawing as usual.  The screen also 
draws if I do a CTRL-C instead of -Z, but then the program aborts as you 
would expect.

If I'm running the program under strace then the screen never recovers 
whether I do a CTRL-Z or not.  I see the code hanging in an 
ioctl(KGDKBENT) on /dev/tty8.

Honestly, I'm totally stumped.  Anyone have any suggestions?


b.g.

-- 
Bill Gatliff
bgat@billgatliff.com


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
