From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6229] New: modprobe atyfb before fbcon ->
 black screen
Date: Tue, 14 Mar 2006 16:23:47 -0800
Message-ID: <20060314162347.6bb72b1f.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1FJJld-0003ug-0q
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Mar 2006 16:21:33 -0800
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44)
	id 1FJJlb-0002bJ-NS
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 14 Mar 2006 16:21:33 -0800
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k2F0LTDZ012971
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Mar 2006 16:21:29 -0800
Received: from akpm.pao.digeo.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k2F0LTMa019748
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 14 Mar 2006 16:21:29 -0800
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

Date: Tue, 14 Mar 2006 16:14:32 -0800
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6229] New: modprobe atyfb before fbcon -> black screen


http://bugzilla.kernel.org/show_bug.cgi?id=6229

           Summary: modprobe atyfb before fbcon -> black screen
    Kernel Version: 2.6.15
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: samuel.thibault@ens-lyon.org


Most recent kernel where this bug did not occur: Never tested it before
Distribution: debian
Hardware Environment: 0000:01:00.0 VGA compatible controller: ATI Technologies Inc Rage Mobility P/M AGP 2x (rev 64) and 0000:01:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)

Hi,

When trying to use framebuffer, I first inserted atyfb (before inserting fbcon) and got a black screen. As soon as fbcon is inserted, the console shows up right, but in the middle the screen is just black.

Steps to reproduce:
- get sure fbcon is compiled as module and not inserted
- modprobe atyfb

Regards,
Samuel

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
