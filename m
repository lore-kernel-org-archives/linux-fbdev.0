From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3849] New: tridentfb console at 16 bpp appears
 in funny colours
Date: Thu, 2 Dec 2004 07:53:47 -0800
Message-ID: <20041202075347.455bbbb2.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CZtHZ-0005OL-8U
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Dec 2004 07:54:13 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CZtHY-0000VM-01
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 02 Dec 2004 07:54:12 -0800
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id iB2Fs9916726
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 2 Dec 2004 07:54:09 -0800
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

Date: Thu, 2 Dec 2004 02:00:38 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3849] New: tridentfb console at 16 bpp appears in funny colours


http://bugme.osdl.org/show_bug.cgi?id=3849

           Summary: tridentfb console at 16 bpp appears in funny colours
    Kernel Version: 2.6.9
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: timothy.lee@siriushk.com


Hardware: CyberBlade/i1 on VIA Epia-800

Problem Description:  When the framebuffer is set to 16 bpp, console's text
colours are incorrect.  For example, white becomes yellow, black becomes blue, etc.

Steps to reproduce:
1. Load tridentfb
2. Use "setterm -n -depth 16" to request 16 bpp framebuffer

The problem arose from the fact that each psuedo palette entry should be 32-bit
in size, even under 16-bit display mode.

I will attach a patch.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
