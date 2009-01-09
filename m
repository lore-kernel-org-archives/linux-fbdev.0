From: Alessio Sangalli <alesan@manoweb.com>
Subject: PostProcessing API
Date: Fri, 09 Jan 2009 00:04:26 -0800
Message-ID: <4967050A.1020808@manoweb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <alesan@manoweb.com>) id 1LLCjJ-0000fN-Vj
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Jan 2009 08:28:33 +0000
Received: from moutng.kundenserver.de ([212.227.126.171])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LLCjD-0001oL-9z for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 09 Jan 2009 08:28:32 +0000
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

Hi, I have a framebuffer device that we are writing a kernel driver for.
This device has an hardware "overlay" with colorspace conversion
(YCbCr->RGB) and scaler.

Is there an API to manage things like this and implement a driver
accordingly?

bye
Alessio



------------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It is the best place to buy or sell services for
just about anything Open Source.
http://p.sf.net/sfu/Xq1LFB
