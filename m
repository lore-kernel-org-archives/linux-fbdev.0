From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3624] New: radeon drivers don't handle unclean
 X.org exits properly, screwing up resolution settings
Date: Sat, 23 Oct 2004 12:34:15 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041023123415.43f2a136.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLRgW-0005K2-77
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 23 Oct 2004 12:36:16 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CLRgV-0006mR-Lv
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 23 Oct 2004 12:36:16 -0700
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-fbdev-devel@lists.sourceforge.net



Begin forwarded message:

Date: Sat, 23 Oct 2004 09:32:08 -0700
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3624] New: radeon drivers don't handle unclean X.org exits properly, screwing up resolution settings


http://bugme.osdl.org/show_bug.cgi?id=3624

           Summary: radeon drivers don't handle unclean X.org exits
                    properly, screwing up resolution settings
    Kernel Version: 2.6.9
            Status: NEW
          Severity: normal
             Owner: davej@codemonkey.org.uk
         Submitter: luke-jr+linuxbugs@utopios.org


Distribution: Gentoo 
Hardware Environment: 
  CPU: Athlon64 3200+ 
  Motherboard: Asus K8V SE 
  Video Card: ATi Radeon 9200 SE 
Software Environment: 
  Linux 2.6.9 
  X.org 6.8.1 
Problem Description: radeon drivers don't handle unclean X.org exits properly, 
screwing up resolution settings 
 
Steps to reproduce (a): 
  1. Take a working X.org configuration 
  2. Change the pointer device to some non-existant /dev item 
  3. Attempt to start X 
  4. Your display is gone 
 
Steps to reproduce (b): 
  1. Take a working X.org configuration 
  2. Start X 
  3. Crash X 
  4. Your console VTs are the wrong resolution and thus do not display 
properly

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
