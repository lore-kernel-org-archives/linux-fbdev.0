From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3316] New: radeonfb Ati 9700 mobility
 powerbook
Date: Tue, 31 Aug 2004 08:17:01 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040831081701.52969518.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C2APN-0004lC-KP
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Aug 2004 08:18:53 -0700
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C2APM-0005Ww-Ea
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Aug 2004 08:18:53 -0700
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id i7VFIn121499
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 Aug 2004 08:18:49 -0700
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

Date: Tue, 31 Aug 2004 04:47:34 -0700
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3316] New: radeonfb Ati 9700 mobility powerbook


http://bugme.osdl.org/show_bug.cgi?id=3316

           Summary: radeonfb Ati 9700 mobility powerbook
    Kernel Version: 2.6.9.1-rc1
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: francesco.fiduccia@libero.it


Distribution: Debian
Hardware Environment: Powerbook ati 9700 mobility LCD 1440x900
Software Environment: bash,fbset,fbi
Problem Description: the Framebuffer shows every lines correctly but at the same time every line is 
reproduced some pixel on the left. the reproduced text lines continue to flash.
I have tried to use fbi to show an image in the framebuffer and the same problem occured.
http://tng.homelinux.net/gallery/hardware/DSCN1739?full=1
http://tng.homelinux.net/gallery/hardware/DSCN1738?full=1
http://tng.homelinux.net/gallery/hardware/DSCN1737?full=1
I have ver_linux .config,dmesg and fbset -i logs, but don't know how to add to this premade form
Steps to reproduce:
patched the 2.6.8.1 withe 2.6.9-rc1 compiled with framebuffer radeon  (new) builtin. installed rebooted 
with 1440x900 and 1024x768.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
