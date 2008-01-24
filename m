From: Andrew Morton <akpm@linux-foundation.org>
Subject: Fw: [Bugme-new] [Bug 9803] New: intel fb
	switches off monitor
Date: Wed, 23 Jan 2008 23:50:21 -0800
Message-ID: <20080123235021.209c5df0.akpm@linux-foundation.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JHwqt-000450-Sm for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 23:50:23 -0800
Received: from smtp2.linux-foundation.org ([207.189.120.14])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JHwqs-0005y9-GD
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 23:50:23 -0800
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org
	[207.189.120.55]) by smtp2.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id
	m0O7oFFM029342
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Jan 2008 23:50:16 -0800
Received: from sony (localhost [127.0.0.1]) by imap1.linux-foundation.org
	(8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with SMTP id
	m0O7oEF8016617 for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 23 Jan 2008 23:50:15 -0800
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


argh.

Begin forwarded message:

Date: Wed, 23 Jan 2008 01:56:14 -0800 (PST)
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 9803] New: intel fb switches off monitor


http://bugzilla.kernel.org/show_bug.cgi?id=9803

           Summary: intel fb switches off monitor
           Product: Drivers
           Version: 2.5
     KernelVersion: [REGRESSION] 2.6.23.0 and higher currently tested
                    2.6.24-rc8
          Platform: All
        OS/Version: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: Video(Other)
        AssignedTo: drivers_video-other@kernel-bugs.osdl.org
        ReportedBy: cijoml@volny.cz


Latest working kernel version: config-2.6.22.5
Earliest failing kernel version: 
Distribution:Debian stable
Hardware Environment: Dell Optiplex GX620, BIOS A11 (latest)
Software Environment: Debian stable, Intel FB compiled into kernel
Problem Description:

When kernel boots I see normal letters on the screen until
in-kernel-compiled-intelfb is inicialited. From that time my LCD's LED says "No
signal" and I see nothink until Xorg starts. Then I can jump from Xorg to
intelfb screen with ctrl+alt+f1 and nice fb is there. With my previous 2.6.22.5
this works.

Steps to reproduce:

boot kernel and look

Boot


-- 
Configure bugmail: http://bugzilla.kernel.org/userprefs.cgi?tab=email
------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
