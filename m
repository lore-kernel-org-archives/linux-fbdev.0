From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 5178] New: bug in drivers/video/vesafb-tng.c
Date: Sat, 3 Sep 2005 12:37:17 -0700
Message-ID: <20050903123717.107943f9.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EBdqv-0003l3-Rb
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Sep 2005 12:39:01 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EBdqu-0005Gm-72
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 03 Sep 2005 12:39:01 -0700
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
To: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@pol.net>



Begin forwarded message:

Date: Sat, 3 Sep 2005 07:28:43 -0700
From: bugme-daemon@kernel-bugs.osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 5178] New: bug in drivers/video/vesafb-tng.c


http://bugzilla.kernel.org/show_bug.cgi?id=5178

           Summary: bug in drivers/video/vesafb-tng.c
    Kernel Version: 2.6.13
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: guillaume.baudot@caramail.com


Most recent kernel where this bug did not occur:2.6.12-r9
Distribution:gentoo
Hardware Environment:x86
Software Environment:linux
Problem Description:
kernel 2.6.13 does not compile with vesafb_tng because of a miss in
drivers/video/vesafb-tng.c.
compilation fails at drivers/video/vesafb-tng.c, line 1180.
"                iounmap(info->screen_base);"

It should be
"                iounmap(vesafb_info->screen_base);"

Steps to reproduce:
cd /path/to/2.6.13kernel
make config # and enable vesafb_tng
make

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
