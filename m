From: Russell King <rmk@arm.linux.org.uk>
Subject: Type confusion in fbcon
Date: Thu, 19 Dec 2002 23:14:15 +0000
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021219231415.A25145@flint.arm.linux.org.uk>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from caramon.arm.linux.org.uk ([212.18.232.186])
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 18P9sV-0008Pt-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 19 Dec 2002 15:14:55 -0800
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

I'm in the midst of porting sa1100fb over to the new fb API, and I stumbled
across an apparant confusion over the type of fb_info->pseudo_palette.

Some code appears to think its an unsigned long, others think its u32.
This doesn't make much difference when sizeof(unsigned long) == sizeof(u32)
but this isn't always the case (eg, 64-bit architectures).

I'll get back to bashing the sa1100fb driver to work out why fbcon is
producing a _completely_ blank display, despite characters being written
to it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html



-------------------------------------------------------
This SF.NET email is sponsored by: Geek Gift Procrastinating?
Get the perfect geek gift now!  Before the Holidays pass you by.
T H I N K G E E K . C O M      http://www.thinkgeek.com/sf/
