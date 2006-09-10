From: thunder7@xs4all.nl
Subject: Re: 2.6.18-rc6-mm1
Date: Sun, 10 Sep 2006 08:30:58 +0200
Message-ID: <20060910063058.GA9516@amd64.of.nowhere>
References: <20060908011317.6cb0495a.akpm@osdl.org>
	<20060908193041.GA18966@amd64.of.nowhere>
	<20060908124411.aa96fb7b.akpm@osdl.org>
	<20060909090449.GA16579@amd64.of.nowhere>
	<20060909083140.adfa878e.akpm@osdl.org>
	<20060910000245.e9df3fea.khali@linux-fr.org>
Reply-To: Jurriaan <thunder7@xs4all.nl>,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GMIqp-0002PB-2K for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 23:31:31 -0700
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1GMIqn-0004cj-Gf
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 09 Sep 2006 23:31:31 -0700
Received: from rivierenland.xs4all.nl (zeeotter.xs4all.nl [80.126.31.149])
	by smtp-vbr14.xs4all.nl (8.13.6/8.13.6) with ESMTP id k8A6VBju066311
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 10 Sep 2006 08:31:22 +0200 (CEST)
	(envelope-from jurriaan@rivierenland.xs4all.nl)
Content-Disposition: inline
In-Reply-To: <20060910000245.e9df3fea.khali@linux-fr.org>
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
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@pol.net>, linux-fbdev-devel@lists.sourceforge.net, Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, Sep 10, 2006 at 12:02:45AM +0200
> Hi Andrew, Jurriaan, Antonino,
> 
> So my guess is that Jurriaan's graphics adapter is supported by the
> savagefb driver, but the driver doesn't create an i2c bus for it
> (either because the hardware doesn't have it, or we simply have no
> support.) Jurriaan, please confirm that your adapter is not one of
> Savage4, Savage2000, ProSavagePM, ProSavage8.

lspci calls it 'S3 Inc. SuperSavage IX/C SDR (rev 05)' 

> 
> If my analysis is correct, the following patch should fix the problem.
> It can probably be optimized/cleaned up, but I'll leave that to
> Antonino. Jurriaan, can you please apply this patch on top of
> 2.6.18-rc6-mm1 and report success or failure?

This patch fixes my problems, rc6-mm1 boots without problems even with
the savagefb driver builtin.

Thanks,
Jurriaan
-- 
Genius untempered by ethics is a deadly commodity.
	Iain Irvine - A Shadow on the Glass
Debian (Unstable) GNU/Linux 2.6.18-rc4-mm3 4423 bogomips load 0.04

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
