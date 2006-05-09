From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6523] New: savagefb console is 1 px off
Date: Tue, 9 May 2006 07:23:07 -0700
Message-ID: <20060509072307.0e51170c.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FdT9p-0004q1-Q7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 07:25:49 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FdT9p-00068m-QT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 07:25:49 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FdT9o-00022i-Dr
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 09 May 2006 07:25:49 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k49EPitH006354
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 9 May 2006 07:25:45 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k49EPi1o010747
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 9 May 2006 07:25:44 -0700
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

Date: Tue, 9 May 2006 05:40:20 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6523] New: savagefb console is 1 px off


http://bugzilla.kernel.org/show_bug.cgi?id=6523

           Summary: savagefb console is 1 px off
    Kernel Version: 2.6.16.9
            Status: NEW
          Severity: low
             Owner: jsimmons@infradead.org
         Submitter: rich@hq.vsaa.lv


S3 VT8375 ProSavage8
during boot video=savagefb:1024x768@60 is passed to the kernel.
this is fujitsu-siemens lifebook c-1020, native resolution for the lcd is 1024x
768.

in console, screen is shifted one pixel to the left, so that left side is 
missing one px, at the rioght side a line is drawn (it's colour seems to depend 
on some other location on the screen)

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
