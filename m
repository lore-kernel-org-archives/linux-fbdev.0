From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4000] New: Laptop Panel gets black on switch
 to frame buffer device 175x65
Date: Thu, 6 Jan 2005 08:19:43 -0800
Message-ID: <20050106081943.530018e4.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CmaMf-0003Dz-BW
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Jan 2005 08:19:57 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CmaMc-00060M-OM
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 06 Jan 2005 08:19:57 -0800
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



Begin forwarded message:

Date: Thu, 6 Jan 2005 04:14:39 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4000] New: Laptop Panel gets black on switch to frame buffer device 175x65


http://bugme.osdl.org/show_bug.cgi?id=4000

           Summary: Laptop Panel gets black on switch to frame buffer device
                    175x65
    Kernel Version: 2.6.10
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: mborgelt@compuserve.de


Distribution: Debian unstable
Hardware Environment: 
Acer extensa 2902LMi Laptop
ATI mobility Radeon 9700
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350 [Mobility
Radeon 9600 M10]
Software Environment:
Problem Description:
Laptop Panel gets black on switch to frame buffer device 175x65.
Even starting Xfree won't give me a Signal on the Panel.

With Kernel 2.6.9 it works. Only 1 out of 10 reboots fail.

Steps to reproduce:
Panel will work after a few reboots.

There are no differences in logfiles from a faild boot and a succesfull boot.
I will compile a Kernel with radeonfb debuging turnd on this evening and see if
I get any clou's from the debug output.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
