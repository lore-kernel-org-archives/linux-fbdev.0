From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3645] New: 2.6.9: no logo displayed with
 vga16fb
Date: Tue, 26 Oct 2004 12:58:46 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041026125846.28ebc184.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CMXUu-0002sN-8Z
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 13:00:48 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CMXUr-0007xE-IW
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 26 Oct 2004 13:00:48 -0700
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i9QK0i904894
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 26 Oct 2004 13:00:44 -0700
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

Date: Tue, 26 Oct 2004 07:38:22 -0700
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3645] New: 2.6.9: no logo displayed with vga16fb


http://bugme.osdl.org/show_bug.cgi?id=3645

           Summary: 2.6.9: no logo displayed with vga16fb
    Kernel Version: 2.6.9
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: ldrolez@linbox.com


Distribution: LFS
Hardware Environment: Any i386
Software Environment: 
Problem Description:

I used to have a nice vga boot logo with my 2.6.7 kernel, but with the 2.6.9, my
boot logo has disappeared (same .config)...
It seems to switch to VGA, and some space is reserved for the logo, but it is 
not displayed. I've tried with the standard logo, and with bigger ones with no
success.

The logo appears with vesafb.


Steps to reproduce: 
1- Activate the linux logo and the vga16fb
2- compile, boot => No logo displayed
3- Activate vesafb
4- compile, boot => logo displayed

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
