From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: [Bugme-new] [Bug 9822] New: mdacon messing
 up console on hw w/o MDA adapter
Date: Sat, 26 Jan 2008 22:24:33 -0800
Message-ID: <20080126222433.e1c662d5.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JJ0x4-0002Ek-Jp for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:25:10 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JJ0x3-0002l5-66
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 26 Jan 2008 22:25:10 -0800
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[207.189.120.55]) by smtp2.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	m0R6OVe3001022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 26 Jan 2008 22:24:32 -0800
Received: from sony (localhost [127.0.0.1]) by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id
	m0R6OUHT000931 for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 26 Jan 2008 22:24:31 -0800
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net



Begin forwarded message:

Date: Sat, 26 Jan 2008 06:00:42 -0800 (PST)
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 9822] New: mdacon messing up console on hw w/o MDA adapter


http://bugzilla.kernel.org/show_bug.cgi?id=9822

           Summary: mdacon messing up console on hw w/o MDA adapter
           Product: Drivers
           Version: 2.5
     KernelVersion: 2.6.24 and before
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: low
          Priority: P1
         Component: Console/Framebuffers
        AssignedTo: jsimmons@infradead.org
        ReportedBy: devzero@web.de


Latest working kernel version: didn`t try before 
Earliest failing kernel version: don`t know, but may exist for a long time
Distribution: openSuSE
Hardware Environment: various (e.g. FSC Scenic T 1Ghz i815 PC, FSC Lifebook,
VMware Workstation)
Software Environment: -

Problem Description:
loading mdacon on a system without MDA adapter screws up the console window. i
cannot use it afterwards. i would have expected some "no mda adapter found" and
a clean exit afterwards.

Steps to reproduce:
modprobe mdacon

also see:
http://marc.info/?l=linux-kernel&m=120082731013963&w=2
http://uwsg.indiana.edu/hypermail/linux/kernel/0203.3/0524.html


same issue with cfag12864bfb. behaviour is a little bit different, but console
is also unusable afterwards.


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
