From: Jurriaan <thunder7@xs4all.nl>
Subject: Anyone got vm86d working? I've got some questions
Date: Wed, 9 Apr 2003 13:03:38 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20030409110338.GA1760@middle.of.nowhere>
Reply-To: thunder7@xs4all.nl
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from smtpzilla5.xs4all.nl ([194.109.127.141])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 193Idp-0000Lg-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Apr 2003 09:41:41 -0700
Received: from zeeotter.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtpzilla5.xs4all.nl (8.12.9/8.12.9) with ESMTP id h39GfcfF043371
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 9 Apr 2003 18:41:38 +0200 (CEST)
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
To: linux-fbdev-devel@lists.sourceforge.net

The vm86d package from Antonino Daplas should allow me to change the
parameters of my VESA framebuffer after booting.

Unfortunately, I can't get it working. vm86d won't run unless I have a
/dev/vm86 entry. The auther mentioned the correct major/minor numbers
for this entry would be in linux/Documentation/devices.txt and
linux/include/linux/misc.h. Since vm86 is a patch against 2.5.66, I
tried looking for this information, but 'vm86' doesn't appear in
devices.txt and 2.5.66 has no include/linux/misc.h file.

Then I searched 2.5.66 and 2.4.21pre7 for any mention of vm86. No luck.
touch /dev/vm86 works in so far as vm86d starts without error messages,
but neither fbset nor stty change anything about the resolution. strace
on vm86d shows endless select() calls without anything else.
Googling didn't help, alas.

Antonino also mentioned going away for a while, and not having a linux
box at his disposal; so now I'm asking here.

If you have a /dev/vm86, could you tell me the output of 

ls -l /dev/vm86

please?

Thanks,
Jurriaan
-- 
"Windows?", said Pooh. "I want a computer, not a house."
	Pooh buys himself a 'Puter.
Debian (Unstable) GNU/Linux 2.5.66 3940 bogomips load av: 1.15 0.88 0.36


-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
