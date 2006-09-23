From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 7189] New: Inconsistent
	/proc/fb behavior
Date: Fri, 22 Sep 2006 19:47:00 -0700
Message-ID: <20060922194700.c581fa72.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GQxXs-0000GD-NA for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Sep 2006 19:47:12 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1GQxXq-0002Dg-VQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 22 Sep 2006 19:47:12 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8N2l2nW020480
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 22 Sep 2006 19:47:03 -0700
Received: from box (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k8N2l0WY002863
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Fri, 22 Sep 2006 19:47:01 -0700
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

Date: Fri, 22 Sep 2006 19:27:02 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 7189] New: Inconsistent /proc/fb behavior


http://bugzilla.kernel.org/show_bug.cgi?id=7189

           Summary: Inconsistent /proc/fb behavior
    Kernel Version: 2.6.17.13
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: jurij@wooyd.org


Distribution: Debian unstable
Hardware environment: Sparc Ultra60 workstation

Problem Description:
It appears that the function fbmem_read_proc, which serves as a backend for the
/proc/fb file, has a problem. When constructing the list of available frame
buffers to return to the user, it uses the following for-cycle;

for (fi = registered_fb; fi < &registered_fb[FB_MAX] && len < 4000; fi++)

Here len is the parameter passed to the function, that it the amount of data the
user is requesting from the file. So if the user requests a chunk larger than
4000 bytes, nothing is returned, leading to the peculiar behaviour described below.

Steps to reproduce:

$ cat /proc/fb
0 Creator 3D

This works fine, because strace shows that cat is reading data in 1024-byte chunks:
[..]
read(3, "0 Creator 3D\n", 1024)         = 13

OTOH, grep is reading data in 32kB chunks:
[..]
read(3, "", 32768)                      = 0

so the command 'grep Creator /proc/fb' returns nothing (quite unexpectingly). I
suspect that for-loop should have 'clen' rather than 'len', the local variable
which tracks the size of the buffer (even though I am not sure why one would
want to impose a 4000 byte limit here).

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
