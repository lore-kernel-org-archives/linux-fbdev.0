From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4218] New: Radeon fb doesn't have correct
 resolution for lcd screen
Date: Tue, 15 Feb 2005 13:39:33 -0800
Message-ID: <20050215133933.61769fd0.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D1AKz-0007rv-9P
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 13:34:29 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D1AKv-00054F-NJ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 15 Feb 2005 13:34:29 -0800
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
Cc: bart@verwilst.be



Begin forwarded message:

Date: Tue, 15 Feb 2005 13:28:36 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4218] New: Radeon fb doesn't have correct resolution for lcd screen


http://bugme.osdl.org/show_bug.cgi?id=4218

           Summary: Radeon fb doesn't have correct resolution for lcd screen
    Kernel Version: 2.6.x
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: bart@verwilst.be


Distribution: Mandrake Linux 10.1 
Hardware Environment: HP Pavilion ze4455ea 
Software Environment:  
Problem Description:  
When in framebuffer mode, the screen is always 800*600, while it should be 
1024*768 to fit the screen nicely.. The mandrake installer itself starts up at 
800*600 too.. Maybe my laptop gives the wrong information back to the driver? 
Could this have a workaround inside the driver pretty please? 
 
Thanks a lot!  
 
Steps to reproduce:  
  
Use Pavilion laptop with radeon card i guess.. :$

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
