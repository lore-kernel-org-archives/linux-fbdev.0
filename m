From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3698] New: vesafb doesn't work anymore
Date: Thu, 4 Nov 2004 10:34:47 -0800
Message-ID: <20041104103447.526c0587.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CPmRg-0004ie-Mc
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 10:34:52 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CPmRf-0003ow-1Y
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 04 Nov 2004 10:34:52 -0800
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id iA4IYn929011
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 4 Nov 2004 10:34:50 -0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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

Date: Thu, 4 Nov 2004 05:55:57 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3698] New: vesafb doesn't work anymore


http://bugme.osdl.org/show_bug.cgi?id=3698

           Summary: vesafb doesn't work anymore
    Kernel Version: 2.6.9
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: dilorenzo@kmfms.com


Distribution:
 Debian Sarge

Hardware Environment: 
 Dell Inspiron 8600 notebook / nvidia geforce graphic

Problem Description:
 I used vesafb with mode 0x314 (in lilo vga=788) until kernel 2.6.7.
 Now I decided to upgrade to 2.6.9, I did it as always: 
 make oldconfig and so on...
 But when I restart, the screen blanks, I tried it with vga=ask, but
 it didn't work with the 3xx modes, the normal modes work, but
 as I work a lot with the console I need a 'nice' one, like mode 314.
 I compared the bootlogs in /var/log/kern.log and found that with the
 2.6.7 kernel there were some lines with 'vesafb: ...' and after that
 there was a line :
 'Console: switching to colour frame buffer device 100x37'.
 But with the 2.6.9 kernel these lines don't appear.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
