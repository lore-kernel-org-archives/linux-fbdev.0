From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4570] New: vesafb, Console goes black after
 some time of inactivity, but does not put monitor in standby
Date: Sun, 1 May 2005 14:21:20 -0700
Message-ID: <20050501142120.0978d2f9.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DSLst-00058u-ED
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 14:21:51 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DSLsr-0003l5-SC
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 01 May 2005 14:21:51 -0700
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
Cc: bonbons67@internet.lu



Begin forwarded message:

Date: Sun, 1 May 2005 13:16:17 -0700
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4570] New: vesafb, Console goes black after some time of inactivity, but does not put monitor in standby


http://bugme.osdl.org/show_bug.cgi?id=4570

           Summary: vesafb, Console goes black after some time of
                    inactivity, but does not put monitor in standby
    Kernel Version: 2.6.*
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: bonbons67@internet.lu


Distribution: Gentoo 
Hardware Environment: 
    Does not matter, all my computers have same problem 
Software Environment: 
Problem Description: 
After some time of inactivity the console goes black, but does not put monitor   
into standby mode (this works in X with driver for the card, have not tried  
with vesa driver in X) 
What I would expect is that the monitor is put in stand-by when the console  
goes blank. (Tweaking with fbset does not help) 
 
Steps to reproduce: 
Work on linux console (not under X ;-)), then keep away from keyboard/mouse 
for some time.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
