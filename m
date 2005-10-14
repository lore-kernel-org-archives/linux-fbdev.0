From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 5441] New: SVGATextMode problem on 2.6.14-rc4
Date: Fri, 14 Oct 2005 10:31:44 -0700
Message-ID: <20051014103144.16a7bb65.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EQTQ1-0004Xt-3p
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 10:32:33 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EQTPy-0006gU-PD
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 14 Oct 2005 10:32:33 -0700
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
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, walt <wa1ter@myrealbox.com>, "bugme-daemon@kernel-bugs.osdl.org" <bugme-daemon@kernel-bugs.osdl.org>



Begin forwarded message:

Date: Fri, 14 Oct 2005 05:08:31 -0700
From: bugme-daemon@kernel-bugs.osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 5441] New: SVGATextMode problem on 2.6.14-rc4


http://bugzilla.kernel.org/show_bug.cgi?id=5441

           Summary: SVGATextMode problem on 2.6.14-rc4
    Kernel Version: 2.6.14-rc4
            Status: NEW
          Severity: blocking
             Owner: jsimmons@infradead.org
         Submitter: olel@ans.pl


Most recent kernel where this bug did not occur: 2.6.13.4

Distribution: Slackware

Problem Description:

After upgrding my kernel to 2.6.14-rc4 I noticed that SVGATextMode, instead of
changing screen resolution to 100x40, messed my console completely. 

Reverting those two patches helps:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=6d36ba629e0ef47a03d3703ee1d38143c25532a8;hp=7b6a186d65589901a73d460070504a5e02703c45
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=28254d439b8c65f93cb331f5aa741efa6a8ec62f;hp=ff55fe2075e3901db4dbdc00e0b44a71bef97afd

Steps to reproduce:
Use SVGATextMode to change screen resolution.

Tested on:
 - Matrox Graphics, Inc. MGA G200 AGP

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
