From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4386] New: tridentfb with ACCEL leaves
 artefacts when scrolling
Date: Tue, 22 Mar 2005 12:45:01 -0800
Message-ID: <20050322124501.6c4573a1.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDqG6-0005dm-Mm
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 12:45:50 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DDqFm-0005KJ-RU
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 12:45:50 -0800
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
Cc: jochen@jochen.org


Jochen, it would be useful if you could test 2.6.12-rc1-mm1.

Also, did this driver work OK in earlier kernels?  If so, which versions?



Begin forwarded message:

Date: Tue, 22 Mar 2005 08:15:18 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4386] New: tridentfb with ACCEL leaves artefacts when scrolling


http://bugme.osdl.org/show_bug.cgi?id=4386

           Summary: tridentfb with ACCEL leaves artefacts when scrolling
    Kernel Version: 2.6.11.5
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: jochen@jochen.org


Distribution: Debian/sarge
Hardware Environment: Mini-ITX with trident on board, C3 CPU
Problem Description:
When compiling tridentfb with
CONFIG_FB_TRIDENT=y
CONFIG_FB_TRIDENT_ACCEL=y
booting leaves the end of long lines in the last line on screen when scrolling.
When X is running, scrolling puts garbage on the screen (looks like X data)
Console switch fixes the screen.
Behaviour seems to be identical with noaccel and without on the video=tridentfb
parameter in lilo.conf.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
