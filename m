From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4738] New: intel865: Cannot remap FB region.
Date: Fri, 17 Jun 2005 00:56:06 -0700
Message-ID: <20050617005606.61078fa8.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DjBiD-0006Xh-G4
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Jun 2005 00:56:25 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DjBiA-0003BY-Vb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Jun 2005 00:56:25 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5H7uLjA024408
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Jun 2005 00:56:21 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j5H7uLfH023657
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 17 Jun 2005 00:56:21 -0700
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

Date: Sun, 12 Jun 2005 05:27:13 -0700
From: bugme-daemon@kernel-bugs.osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4738] New: intel865: Cannot remap FB region.


http://bugzilla.kernel.org/show_bug.cgi?id=4738

           Summary: intel865: Cannot remap FB region.
    Kernel Version: 2.6.12-rc6
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: goldenfish@bsys.cz


Distribution: Debian Sarge
Hardware Environment: P4,1GB RAM,Intel D865GBF Desktop Board, only integrated
graphics card
Software Environment: X-server4.3.0
Problem Description: 
i can't load intelfb module
Steps to reproduce:
rmmod intelfb - if module loaded
modprobe intelfb
// module i830 is loaded

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
