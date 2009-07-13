From: Ali Gholami Rudi <ali@rudi.ir>
Subject: [PATCH 0/2] fbdev: add fillrect and copyarea
	ioctls
Date: Mon, 13 Jul 2009 19:47:09 +0430
Message-ID: <20090713151709.GA1297@lilem.mirepesht>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <aligrudi@gmail.com>) id 1MQNJB-0002ev-BL
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Jul 2009 15:19:13 +0000
Received: from fg-out-1718.google.com ([72.14.220.157])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQNJ3-0003D0-9G for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 13 Jul 2009 15:19:13 +0000
Received: by fg-out-1718.google.com with SMTP id e12so424699fga.9
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 13 Jul 2009 08:19:03 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>
Cc: Krzysztof Helt <krzysztof.h1@wp.pl>, Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org, Philippe De Muyter <phdm@macqel.be>, Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, Andrew Morton <akpm@linux-foundation.org>, Andrea Righi <righi.andrea@gmail.com>

Hi,

Is there any reason for not adding these ioctls to fbdev?  I searched
the net and couldn't any.  Anyway, these patches simply implement those
ioctls.

Ali Gholami Rudi (2):
  fbdev: add FBIOFILLRECT ioctl
  fbdev: add FBIOCOPYAREA ioctl

 drivers/video/fbmem.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/fb.h    |    2 +
 2 files changed, 52 insertions(+), 0 deletions(-)

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
