From: Markus Rudolf <rudolf@mpch-mainz.mpg.de>
Subject: Implementing FB driver for serial attached TFT
Date: Tue, 31 Jan 2006 11:35:29 +0100
Message-ID: <1093982103.20060131113529@mpch-mainz.mpg.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F3srh-0006VC-Pb
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Jan 2006 02:36:01 -0800
Received: from mpch01.mpch-mainz.mpg.de ([192.67.218.34])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1F3sre-0001al-W7
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Jan 2006 02:36:01 -0800
Received: (from root@localhost)
	by mpch01.mpch-mainz.mpg.de (8.12.9/8.12.9) id k0VAZu6W496366
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 31 Jan 2006 11:35:56 +0100 (MET)
Received: from gemini.mpch-mainz.mpg.de (terra.mpch-mainz.mpg.de [141.5.0.17])
	by mpch01.mpch-mainz.mpg.de (8.12.9/8.12.9) with SMTP id k0VAZU88497106
	for <Linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 Jan 2006 11:35:35 +0100 (MET)
Received: from callisto (Administrator@[141.5.1.229])
        by gemini.mpch-mainz.mpg.de (8.12.11/) with ESMTP id k0VAZUio745512
        for <Linux-fbdev-devel@lists.sourceforge.net>; Tue, 31 Jan 2006 11:35:30 +0100 (MET)
Resent-Message-Id: <200601311035.k0VAZUio745512@gemini.mpch-mainz.mpg.de>
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
To: Linux-fbdev-devel@lists.sourceforge.net

I'm currently using an embedded ARM920 board running kernel 2.6.5.

I designed a custom hardware using my onboard FPGA to attach a serial controlled
small TFT (actually it's a display from a mobile phone which uses some sort of
SPI to communicate) to my CPU.

The display supports 132 pixel horizontal and 176 pixel vertical resolution, and
uses a 16bit 565RGB color encoding per pixel.

I want to code a framebuffer driver for it to keep the application software as
portable as possible (thought about using directFB or something like that
later).

I guess the vfb.c code is a good base to start from.

As the display does not have memory mappable RAM I need to use some kernel
memory as framebuffer and copy this memory via the serial link to the display
(thought about usig a kernel thread and / or interrupt handler, as the transfer
logic in the FPGA has a 512 word FIFO with interrupt signaling if the FIFO runs
empty. Did that to free some CPU time).

What kind of changes do I have to do to the vfb.c regarding the setup of the
capabilities (resolution / color scheme)? I didn't got that stuff with those
different color coding schemes. If someone could point out what mode would be
best for my display I would really appreciate.

If I use the framebuffer console, will the console automatically adjust its size
to the small display or how can I set a correct mode here ?

I also read that it's impossible to mmap() the kernel memory, but that most FB
applications will try to do so. How can I fix this issue ?

Many questions, I know, but I'm really a bit lost.

Thanks for any comments !

Markus



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
