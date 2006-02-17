From: Miernik <miernik@ffii.org>
Subject: Bug#353310: linux-image-2.6.15-1-686: CONFIG_FB_ATY_XL_INIT should be set to n because it is broken
Date: Fri, 17 Feb 2006 14:36:17 +0100
Message-ID: <20060217133617.4550.32757.reportbug__37662.7399506562$1140201835$gmane$org@localhost.localdomain>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FA5xx-0006sA-Hz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Feb 2006 05:48:09 -0800
Received: from spohr.debian.org ([140.211.166.43] ident=Debian-exim)
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1FA5xw-0006UQ-0y
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 17 Feb 2006 05:48:09 -0800
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.353310.B.114018338210040@bugs.debian.org>
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
To: Debian Bug Tracking System <submit@bugs.debian.org>

Package: linux-image-2.6.15-1-686
Version: 2.6.15-6
Severity: normal

Please set CONFIG_FB_ATY_XL_INIT=n in the Debian kernel build, because
this option is broken, and for example on ATI Rage XL / Mach64GM makes
the system hang. For details please read this thread:
http://thread.gmane.org/gmane.linux.fbdev.user/518

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (500, 'unstable'), (1, 'experimental')
Architecture: i386 (i686)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.15-1-686
Locale: LANG=en_US.UTF-8, LC_CTYPE=en_US.UTF-8 (charmap=UTF-8)

Versions of packages linux-image-2.6.15-1-686 depends on:
ii  module-init-tools             3.2.2-2    tools for managing Linux kernel mo
ii  yaird [linux-initramfs-tool]  0.0.12-3   Yet Another mkInitRD

Versions of packages linux-image-2.6.15-1-686 recommends:
ii  libc6-i686                    2.3.6-1    GNU C Library: Shared libraries [i

-- debconf information excluded



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
