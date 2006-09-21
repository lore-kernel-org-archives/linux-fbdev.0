From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 7176] New: Mach64
 framebuffer console hangs when compiled with gcc 4.1
Date: Thu, 21 Sep 2006 10:09:36 -0700
Message-ID: <20060921100936.6bfad4ba.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GQS3R-0005bU-4h for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Sep 2006 10:09:41 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GQS3P-00067F-NA
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 21 Sep 2006 10:09:41 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8LH9bnW004677
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 21 Sep 2006 10:09:37 -0700
Received: from akpm.corp.google.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k8LH9aUH015586
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 21 Sep 2006 10:09:37 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net



Begin forwarded message:

Date: Thu, 21 Sep 2006 05:51:41 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7176] New: Mach64 framebuffer console hangs when compiled with gcc 4.1


http://bugzilla.kernel.org/show_bug.cgi?id=7176

           Summary: Mach64 framebuffer console hangs when compiled with gcc
                    4.1
    Kernel Version: 2.6.18
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: jernej-bugzilla.kernel@ena.si


Most recent kernel where this bug did not occur: ?
Distribution: Gentoo
Hardware Environment: 1) Compaq ProLiant ML330 G2 server [Pentium III 1066MHz] 
2) HP ML350G4 [Xeon 3GHz EM64T]
Software Environment:
Problem Description: I first noticed the problem with Gentoo's 2.6.16-r8 kernel 
on ML330 server (running Debian Etch, but with Gentoo kernel) - kernel compiled 
with GCC 4.0, worked fine, but when I recompiled the same kernel with gcc 
4.1.2, the kernel locks up at bootup, when it's supposed to switch to graphic 
console. I confirmed the same lockup with vanilla 2.6.18 kernel (which is why 
I'm reporting here).
The same thing also happens on ML350G4 server with kernel 2.6.17-gentoo-r8 
[running in 64bit mode] (previous kernel, compiled with gcc 3.4.6 works, but 
when recompiled with gcc 4.1.1, it too locks up in apparently the same way; 
unfortunately I'm not able to test with a vanilla kernel there).

Steps to reproduce: Enable Device Drivers -> Graphics support -> <*> Support 
for frame buffer devices -> <*> ATI Mach64 display support, [*]   Mach64 CT/VT/
GT/LT (incl. 3D RAGE) support, [*]   Mach64 GX support; compile with gcc 4.1.1 
or 4.1.2, boot.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
