From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 6685] New: Permedia2
	framebuffer on E250
Date: Mon, 19 Jun 2006 15:33:20 -0700
Message-ID: <20060619153320.49a7c736.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FsSFt-0002Ot-Bg for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 15:30:01 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by mail.sourceforge.net with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.44) id 1FsSFq-0005pV-Uv
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 19 Jun 2006 15:30:01 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5JMTvgt014522
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jun 2006 15:29:58 -0700
Received: from akpm.pao.digeo.com (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id k5JMTvkV015739
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 19 Jun 2006 15:29:57 -0700
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

Date: Tue, 13 Jun 2006 13:48:20 -0700
From: bugme-daemon@bugzilla.kernel.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 6685] New: Permedia2 framebuffer on E250


http://bugzilla.kernel.org/show_bug.cgi?id=6685

           Summary: Permedia2 framebuffer on E250
    Kernel Version: 2.6.17-rc6
            Status: NEW
          Severity: normal
             Owner: platform_sparc64@kernel-bugs.osdl.org
         Submitter: marvin@mydatex.cz


Most recent kernel where this bug did not occur: 2.4.27
Distribution: Debian Sid
Hardware Environment: Sun E250
Software Environment:  Permedia2 FB
Problem Description:
I have E250 with Raptor GFX framebuffer. On 2.4.27 works fine but with any
kernel which I tested > 2.6.12 frame buffer console looks very ugly and is
unreadable fonts is defocusing.

Steps to reproduce:
Compile kernel with Permedia2 framebuffer enabled on E250

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.
