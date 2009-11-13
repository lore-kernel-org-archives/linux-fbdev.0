From: =?iso-8859-2?Q?Ren=E9=20Kola=F8=EDk?= <rene.kolarik@seznam.cz>
Subject: framebuffer general questions
Date: Fri, 13 Nov 2009 15:11:48 +0100 (CET)
Message-ID: <1023.2945-18821-2123977998-1258121508@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <rene.kolarik@seznam.cz>) id 1N8wse-0007Lx-BX
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Nov 2009 14:12:04 +0000
Received: from mxh.seznam.cz ([77.75.72.26])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N8wsX-0006d3-Vc for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 13 Nov 2009 14:12:04 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi

i am trying to customize framebuffer drivers and i have some questions...

Please can you give me an advice? 

1) If I define my own imageblit function, how do I call it? Or is it called automatically?

2) I have gpu connected via pci to cpu. I did mmap and have framebuffer mapped in for example "uchar * data". I have loop and iterating through some pixel data and do data[i] = pixel[i]. Does this lead to transmitting via PCI in style - transmit byte ... end ... transmit byte ... end ... etc?

3)what is the difference bethween mmap framebuffer and write to mapped pointer and calling write() to descriptor previously obtained by open()?

these are the main questions in my mind. Thank you for your time i would be glad for any informations.

Rene

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
