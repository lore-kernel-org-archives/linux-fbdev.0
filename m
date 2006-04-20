From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6417] New: savagefb conflicts with x.org
 savage driver
Date: Thu, 20 Apr 2006 12:27:38 -0700
Message-ID: <20060420122738.5bd5b588.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [10.3.1.93] (helo=sc8-sf-list1-new.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FWepf-0007SF-Mv
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Apr 2006 12:28:51 -0700
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FWepf-0005s4-Nt
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Apr 2006 12:28:51 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FWepc-0003NZ-5Z
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 20 Apr 2006 12:28:51 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k3KJSYtH028024
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Apr 2006 12:28:36 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k3KJSUJh005257
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 20 Apr 2006 12:28:32 -0700
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

Date: Thu, 20 Apr 2006 07:44:34 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6417] New: savagefb conflicts with x.org savage driver


http://bugzilla.kernel.org/show_bug.cgi?id=6417

           Summary: savagefb conflicts with x.org savage driver
    Kernel Version: 2.6.16.9
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: rich@hq.vsaa.lv


this is a companion bug to
https://bugs.freedesktop.org/show_bug.cgi?id=5878
short description : if savage driver is used in x.org together with savagefb, 
it results in seriously garbled and distorted screen - coupled with severe 
slowdowns.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
