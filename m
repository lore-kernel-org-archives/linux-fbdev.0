From: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Subject: Screen Refresh
Date: Wed, 5 May 2004 10:47:00 -0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405051047.00127.lucasvr@gobolinux.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLMjY-0006Qc-Vc
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 May 2004 06:46:48 -0700
Received: from ibague.terra.com.br ([200.154.55.225])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BLMjY-0000dF-MQ
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 05 May 2004 06:46:48 -0700
Received: from sucre.terra.com.br (sucre.terra.com.br [200.154.55.134])
	by ibague.terra.com.br (Postfix) with ESMTP id E644AEC5AE
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  5 May 2004 10:46:46 -0300 (BRT)
Received: from ummagumma.ozzmosis.net (200-203-051-117.nhoce7002.dsl.brasiltelecom.net.br [200.203.51.117])
	(authenticated user lucasvr)
	by sucre.terra.com.br (Postfix) with ESMTP id C44563C0B3
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed,  5 May 2004 10:46:46 -0300 (BRT)
Content-Disposition: inline
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

Hi,

I'm writing a device driver for a monochrome LCD display managed by a 
controller that will be plugged into the CPU through a SPI, that is, I cannot 
directly memory-map it's address, since the communication will be done via 
a serial interface.

I've seen good chunks of code tonight (fbcon.c, fbmem.c and fbcon_mfb.c), but 
an unique question still remains: I didn't see anywhere *how* the buffer is 
updated to the video card. As far I could see on others drivers that I've 
read, they are doing that by memory mapping the video card's memory, and 
hence any write done into the buffer will be automagically reflected on the 
screen.

On my case I probably won't be able to memory map it's video memory. So, is 
there a way to get notified (at driver level) when some write is going to 
happen? Or should I just install a timer and use some kind of 
double-buffering scheme to verify if changes happened?

Many thanks in advance,
Lucas


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE. 
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
