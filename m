From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and LCD
 "burn"
Date: Tue, 15 Feb 2005 12:15:55 -0800
Message-ID: <20050215121555.54c63ed2.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D192A-0003Fr-KF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 12:10:58 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D1926-00068t-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 12:10:58 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: marc.poulhies@epfl.ch



Begin forwarded message:

Date: Tue, 15 Feb 2005 12:03:52 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4217] New: radeonfb makes system hang and LCD "burn"


http://bugme.osdl.org/show_bug.cgi?id=4217

           Summary: radeonfb makes system hang and LCD "burn"
    Kernel Version: 2.6.11-rc3
            Status: NEW
          Severity: high
             Owner: jsimmons@infradead.org
         Submitter: marc.poulhies@epfl.ch


Distribution: debian sid
Hardware Environment:i686, Radeon Mobility M7 LW [Radeon Mobility 7500]
Software Environment:
Problem Description:
When radeonfb gets loaded, system hangs and LCD display (this is a laptop)
"burns" (seems classic when noone handles the display).

Steps to reproduce:
Starts in single user, then "modprobe radeonfb"

I tried to get some debug information by compiling the debug support, but I
can't get kernel message to another computer (I tried with netcat).
This seems to cause some problem with DRI also. I boot without radeonfb, X
starts, then a switch to console has the same effect (freeze + "burn")

(same with -rc4)

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
