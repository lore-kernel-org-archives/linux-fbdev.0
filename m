From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3078] New: radeonfb, switching from X to
 console locks up system.
Date: Thu, 15 Jul 2004 10:55:38 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040715105538.168da136.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BlBdF-00028N-SM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 12:11:01 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1BlBdF-0007n7-BI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 15 Jul 2004 12:11:01 -0700
Received: from akpm-1 (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i6FJAwk27593
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 15 Jul 2004 12:10:58 -0700
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



Begin forwarded message:

Date: Thu, 15 Jul 2004 11:35:17 -0700
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3078] New: radeonfb, switching from X to console locks up system.


http://bugme.osdl.org/show_bug.cgi?id=3078

           Summary: radeonfb, switching from X to console locks up system.
    Kernel Version: 2.6.8-rc1
            Status: NEW
          Severity: high
             Owner: jsimmons@infradead.org
         Submitter: jose.l.cordova@seagate.com


Distribution: FC2
Hardware Environment: Intel D865GLX, 3.2 GHz hyperthreaded P4, ATI Radeon 9600SE
Software Environment: fb consoles, gnome

Problem Description:
I have upgraded to 2.6.7 with patch-2.6.8-rc1.bz2 (earlier versions seem to have
other radeonfb problems). After fixing the kernel oops reported in
https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=125841
using patch
https://bugzilla.redhat.com/bugzilla/attachment.cgi?id=101570&action=view,
I could  install the new kernel with built-in radeonfb support. But now, the
system crashes when exiting from an X-session.

Steps to reproduce:
The system boots up and looks perfect, with two cute penguins and all. The
following happens regardless of whether I start at init 3 and run startx from a
console or go directly into init5. My Gnome session starts flawlessly, and if I
cat /proc/fb I get the 9600 information. The problem is when I either log out
from gnome, or try to access a console via ctrl-alt-f#. The consoles are pure
garbage, and the system is hard-locked, requiring the reset button.

For the x drivers I am running with module support for agp, agp_intel, and dri,
but I am using the proprietary ATI driver fglrx to get 3D acceleration (this, by
the way, also works well using both the kernel of the internal agp support).

I don't know how to get logs for this, since the system dies completely.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
