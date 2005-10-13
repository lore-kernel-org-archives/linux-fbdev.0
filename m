From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 5430] New: ProSavage8 doesn't work correctly
 with FB_SAVAGE
Date: Wed, 12 Oct 2005 23:37:15 -0700
Message-ID: <20051012233715.52471214.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EPwin-0003fB-OS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Oct 2005 23:37:45 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1EPwin-00042k-FS
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 12 Oct 2005 23:37:45 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9D6bh4s017612
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Oct 2005 23:37:43 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j9D6bhRS004736
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 12 Oct 2005 23:37:43 -0700
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

Date: Wed, 12 Oct 2005 23:32:44 -0700
From: bugme-daemon@kernel-bugs.osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 5430] New: ProSavage8 doesn't work correctly with FB_SAVAGE


http://bugzilla.kernel.org/show_bug.cgi?id=5430

           Summary: ProSavage8 doesn't work correctly with FB_SAVAGE
    Kernel Version: 2.6.14-rc2
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: rich@hq.vsaa.lv


Hardware Environment:
fujitsu siemens lifebook c-1020
VGA compatible controller: S3 Inc. VT8375 [ProSavage8 KM266/KL266]

Problem Description:
this videocard works ok in framebuffer console with vesa drivers. if i try to 
use s3 savage driver (FB_SVAGE), setting framebuffer to 1024x768 results in 
800x600, area around the text is either black, either red, either blue
(i'm not exactly sure what this colour depends on)

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
