From: Andrew Morton <akpm@osdl.org>
Subject: Fw: [Bugme-new] [Bug 4047] New: kerenl failt to kompile
Date: Sun, 16 Jan 2005 03:38:07 -0800
Message-ID: <20050116033807.668d5676.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cq8jl-00043e-Oy
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 Jan 2005 03:38:29 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cq8jl-0007Ni-6v
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 16 Jan 2005 03:38:29 -0800
Received: from bix (build.pdx.osdl.net [172.20.1.2])
	by mail.osdl.org (8.11.6/8.11.6) with SMTP id j0GBcQl15843
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 16 Jan 2005 03:38:26 -0800
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

Date: Sun, 16 Jan 2005 03:14:57 -0800
From: bugme-daemon@osdl.org
To: bugme-new@lists.osdl.org
Subject: [Bugme-new] [Bug 4047] New: kerenl failt to kompile


http://bugme.osdl.org/show_bug.cgi?id=4047

           Summary: kerenl failt to kompile
    Kernel Version: 2.6.11-rc1-mm1
            Status: NEW
          Severity: blocking
             Owner: jsimmons@infradead.org
         Submitter: bug-track@fisher-privat.net


Distribution:Debian Sarge 
 
Problem Description: 
 LD      init/built-in.o 
  LD      .tmp_vmlinux1 
drivers/built-in.o(.text+0x9bfa): In function `lcd_device_register': 
: undefined reference to `fb_register_client' 
drivers/built-in.o(.text+0x9ce3): In function `lcd_device_unregister': 
: undefined reference to `fb_unregister_client' 
drivers/built-in.o(.text+0xa16a): In function `backlight_device_register': 
: undefined reference to `fb_register_client' 
drivers/built-in.o(.text+0xa253): In function `backlight_device_unregister': 
: undefined reference to `fb_unregister_client' 
make: *** [.tmp_vmlinux1] Error 1 
 
 
Steps to reproduce: 
lcd backliting depends on fb

------- You are receiving this mail because: -------
You are on the CC list for the bug, or are watching someone who is.


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
