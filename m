From: Marc Blumentritt <marc.blumentritt@arcor.de>
Subject: where does viafb go?
Date: Sun, 04 Jan 2009 13:24:22 +0100
Message-ID: <gjq9pm$p5u$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <glfd-linux-fbdev-devel@m.gmane.org>)
	id 1LK69f-0002yQ-DW for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Jan 2009 07:15:11 +0000
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1LK69e-00028G-H4
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Jan 2009 07:15:10 +0000
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1LK69X-0001g9-KX for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Jan 2009 07:15:04 +0000
Received: from dslb-088-070-011-246.pools.arcor-ip.net ([88.70.11.246])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 06 Jan 2009 07:15:03 +0000
Received: from marc.blumentritt by dslb-088-070-011-246.pools.arcor-ip.net
	with local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 06 Jan 2009 07:15:03 +0000
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

Hi,

recently viafb was added to linux 2.6.28. While it allows to use VIA's
graphic cards directly via framebuffer, it does not support all hardware
features (e.g. the mpeg-2 decoder or mpeg-4 accelerator). As far as I
know VIA will not publish any code about this, because of possibly
License problems [1]. On the other hand, there is a X driver [2], which
does support at least part of these features (mpeg-2 decoder) and VIA is
working together with this project.

My question is: does anyone here now about future development of the
viafb driver to support these features?

Thanks for any info in advance.
Marc


[1]
http://laforge.gnumonks.org/weblog/2008/09/01#20080901-via-xorg-opensource-faq
[2] http://www.openchrome.org/


------------------------------------------------------------------------------
