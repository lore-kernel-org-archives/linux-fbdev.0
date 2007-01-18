From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Subject: i2c adapter on i852/855
Date: Thu, 18 Jan 2007 15:35:53 +0100
Message-ID: <200701181535.53546.hjk@linutronix.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H7YMx-0002V9-Be for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jan 2007 06:35:59 -0800
Received: from www.osadl.org ([213.239.205.134] helo=mail.tglx.de)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1H7YMv-000863-UL
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 18 Jan 2007 06:35:59 -0800
Content-Disposition: inline
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
Cc: Benedikt Spranger <b.spranger@linutronix.de>

I'm using intelfb from 2.6.20-rc3 on an embedded board with an i852/855 and an 
i801. My .config contains

CONFIG_FB_INTEL=y
CONFIG_FB_INTEL_I2C=y
CONFIG_I2C=y
CONFIG_I2C_ALGOBIT=y

Problem is that no i2c adapter from this driver shows up 
in /sys/class/i2c-adapter, while the adapter registered by i2c_i801 is there.

I can make the i2c adapter of the i852/855 work with a modified version of 
i2c-i810, but this module is deprecated, so I'd like to use intelfb only.

Can somebody confirm that it actually works? What could be wrong?

Hans
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
