From: "Laurent Lagrange" <lagrange@fr.oleane.com>
Subject: Endian issue
Date: Mon, 27 Nov 2006 15:59:00 +0100
Message-ID: <000001c71234$95079550$5201a8c0@GEG2400>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Gohss-0003zd-Hf for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 06:55:02 -0800
Received: from smtp19.msg.oleane.net ([62.161.4.19])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Gohsq-0006qL-DE
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 27 Nov 2006 06:55:02 -0800
Received: from GEG2400 ([194.3.133.184]) (authenticated)
	by smtp19.msg.oleane.net (MTA) with ESMTP id kAREstlZ002100
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 27 Nov 2006 15:54:57 +0100
In-Reply-To: 
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


Hi
 
I'm writing a framebuffer driver and I have some endian problems. 
My board is big endian (powerpc inside) and I use a little endian 
graphic card. I try to get a 16 bpp RGBA (5/5/5/1) true color mode 
working. Nevertheless, I have troubles with the framebuffer layer.
 
For example, in the color_imageblit function of cfbimgblt.c, if I 
want to draw two 16bpp rgba pixels P0 (0xFFFE) and P1 (0x0001), 
they are packed together like this 0xFFFE_0001. 
In memory, 0xFF is LSB, 0x01 is MSB (big endian). Then this 32bit 
value is "__raw_writel" to the memory of the video card. 

As my videocard works in little endian, I get 0x0100_FEFF. So the 
pixels are at the correct place, but don't have the correct color. 
It would be OK if it was 0x0001_FFFE.
 
My question is :
- is it possible to use generic drawing function (blit, fillrect...) 
on a big endian board with a little endian graphics card ?
- if yes, how can I describe the colors bitfields, without 
patching the kernel code, to get the correct color ?
 
Thanks
Laurent
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
