From: "Sunil Kumar T" <t.sunilkumar@bplmail.com>
Subject: Display driver.
Date: Sun, 13 Oct 2002 14:32:41 -0700
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <00ec01c27300$0f31a060$990d0a0a@bpldj7ls7op535>
References: <Pine.GSO.4.21.0210141020550.9580-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from [203.200.31.3] (helo=btlmail.bplmail.com)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1811EG-0007Vj-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Oct 2002 02:09:37 -0700
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>, Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi,
I am planning to write a display  driver for the chip(MD2406)  which is
having ARM7TDMI core.
This chip is having a display interface and JPEG engine.

The purpose is to take JPEG file from user space decode the JPEG file using
hardware decoder in the chip. Display the the jpeg file.

I would like to know from you experts, Should I go for Frame Buffer driver
for this function.

Its able to do the display of jpeg file only from the processor without
using linux.
I am new to display driver. Can I by pass frame buffer method and do the
SDRAM (Display ram) memory acesses directly and acomplish the task. I mean
can I do this driver by using ioctl, and write statement alone. As a normal
charactor driver.
Is there any problem in doing so.
Regards


SunilKumar.T
Sr. Design Engineer
Software and Embedded Systems Group,
BPL TELECOM LTD.
11th K. M., Bannerghatta Road,
Bangalore 560076.
Ph. No.91-80- 6589080 etx.2058







-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
