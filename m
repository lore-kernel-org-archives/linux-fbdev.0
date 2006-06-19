From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6720] New: mga framebuffer
 flickers after upgrading to 2.6.17
Date: Mon, 19 Jun 2006 16:09:34 -0700
Message-ID: <20060619160934.488944da.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsSox-0005aW-35 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 16:06:15 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FsSov-0002Om-L4
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 16:06:15 -0700
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
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>



Begin forwarded message:

Date: Mon, 19 Jun 2006 13:42:51 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6720] New: mga framebuffer flickers after upgrading to 2.6.17


http://bugzilla.kernel.org/show_bug.cgi?id=6720

           Summary: mga framebuffer flickers after upgrading to 2.6.17
    Kernel Version: 2.6.17
            Status: NEW
          Severity: normal
             Owner: ak@suse.de
         Submitter: markus.gapp@ktv-one.at


Most recent kernel where this bug did not occur: 2.6.16.20
Distribution: gentoo -- vanilla sources
Hardware Environment: dual opteron, mga g550, lcd connected via dvi
Software Environment: framebuffer console
Problem Description: after upgrading to 2.6.17 on an opteron smp machine 
(x86_64 kernel) with a mga g550 vga several dots around letters on a 
framebuffer console are flickering. matroxfb is compiled as a module. 
this also happens to an X server using mga and fbhw submodule.

Steps to reproduce:

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
