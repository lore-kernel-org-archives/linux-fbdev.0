From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 3778] New: neofb: screen corruption
Date: Fri, 19 Nov 2004 16:08:27 -0800
Message-ID: <20041119160827.64201d6f.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CVIje-0004vz-Ep
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 16:04:14 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CVIjd-0006Yn-E1
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 19 Nov 2004 16:04:14 -0800
Received: from akpm.pao.digeo.com (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id iAK04C914683
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 19 Nov 2004 16:04:12 -0800
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

Date: Fri, 19 Nov 2004 15:36:37 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 3778] New: neofb: screen corruption


http://bugme.osdl.org/show_bug.cgi?id=3778

           Summary: neofb: screen corruption
    Kernel Version: 2.6.10-rc2
            Status: NEW
          Severity: blocking
             Owner: aridtech@gmail.com
         Submitter: aridtech@gmail.com


Distribution: Gentoo
Hardware Environment: IBM ThinkPad 570
Neomagic Corporation NM2200 [MagicGraph256AV] (rev 20)
440BX Motherboard
Software Environment:
It happens during kernel loading

Problem Description: It happens when kernal begin to load. All characters on the
screen are unreadable and contsist of lines and pixels. i can't attach dmesg
because i can't see what i type when this bug occurs.
As i discovered this bug was born after convertion MODULE_PARM to module_param
in neofb module because if copy unconverted neofb from 2.6.10-rc1 to rc2 and
compile it everything works ok.

Steps to reproduce:
Recompile kernel with neofb.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
