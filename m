From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4869] New: Screen stays blank upon resume
Date: Sun, 10 Jul 2005 22:22:03 -0700
Message-ID: <20050710222203.7e21d5f6.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Drqkh-0005eD-H8
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Jul 2005 22:22:47 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.44)
	id 1Drqkg-00064b-4p
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 10 Jul 2005 22:22:47 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6B5MhjA017360
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 10 Jul 2005 22:22:43 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j6B5Mgxe020104
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 10 Jul 2005 22:22:43 -0700
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

Date: Sun, 10 Jul 2005 22:08:39 -0700
From: bugme-daemon@kernel-bugs.osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4869] New: Screen stays blank upon resume


http://bugzilla.kernel.org/show_bug.cgi?id=4869

           Summary: Screen stays blank upon resume
    Kernel Version: 2.6.12
            Status: NEW
          Severity: low
             Owner: other_modules@kernel-bugs.osdl.org
         Submitter: russell@rickstewart.com


Distribution:slackware
Hardware Environment:  ibm thinkpad 390x
Software Environment: just the kernel, apm, and the neomagic fb driver
Problem Description:  upon resume the screen flashes on for a fraction of a 
second, then blanks and won't unblank.
Steps to reproduce:  suspend (Fn-F4), then resume.  This did not happen with
kernel 2.6.11.  I have commented out the blanking routines in apm.c, neofb.c,
and vt.c, and it still happens.  I booted in 2.6.11 and it does not happen.
I have inspected the patch file and can't find anything likely I have not tried
to roll back.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP,
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
