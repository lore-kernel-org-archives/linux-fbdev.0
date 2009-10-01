From: Alessio Sangalli <alesan@manoweb.com>
Subject: probing the supported resolution list
Date: Thu, 01 Oct 2009 00:41:41 -0700
Message-ID: <4AC45D35.3020600@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alesan@manoweb.com>) id 1MtGIX-0002eN-6j
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Oct 2009 07:41:57 +0000
Received: from moutng.kundenserver.de ([212.227.126.177])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MtGIS-0001YY-3z for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Oct 2009 07:41:57 +0000
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

Hi, is there a standard way for a userspace program to "probe" the 
supported display sizes/refresh rates/bit depths? The display I'm 
writing a driver for only supports a few specific resolutions, and I'm 
wondering how a userspace program can discover those.

Thank you
Alessio



------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
