From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4767] New: RFE: console_blank_hook that can
 call userspace program
Date: Mon, 20 Jun 2005 12:15:21 -0700
Message-ID: <20050620121521.6144b88f.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DkRkF-00031b-V3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Jun 2005 12:15:43 -0700
Received: from smtp.osdl.org ([65.172.181.4])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DkRkE-0002gW-Du
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 20 Jun 2005 12:15:43 -0700
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5KJFdjA029279
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jun 2005 12:15:39 -0700
Received: from bix (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with SMTP id j5KJFctk014086
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 20 Jun 2005 12:15:39 -0700
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

Date: Mon, 20 Jun 2005 03:37:22 -0700
From: bugme-daemon@kernel-bugs.osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4767] New: RFE: console_blank_hook that can call userspace program


http://bugzilla.kernel.org/show_bug.cgi?id=4767

           Summary: RFE: console_blank_hook that can call userspace program
    Kernel Version: 2.6.12
            Status: NEW
          Severity: normal
             Owner: jsimmons@infradead.org
         Submitter: heilong@bluebottle.com


I think it'd be very good to have a console_blank_hook handler that would call a
userspace program/script/generate hotplug event whatever. Currently, the console
can only be blanked using APM, so no options exist for people using ACPI. I've
got a Radeon graphics chip on my laptop, and the LCD backlight can be controlled
(on/off) using radeontool. If there was a userspace callback interface to
console blanking, I would just make a callback script that calls "radeontool
light off" on blank and "radeontool light on" on unblank - really easy. I think
this userspace console_blank_hook handler is very simple to put into kernel, but
I'm not a kernel developer myself, so wouldn't risk sending any patches (that
call system("some_script")), because I probably won't make things as they should
be in the kernel.

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
