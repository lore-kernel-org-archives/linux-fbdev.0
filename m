From: Robert Siemer <Robert.Siemer@backsla.sh>
Subject: Re: radeonfb: DDC read wrong?
Date: Mon, 26 Jun 2006 19:01:58 +0200
Message-ID: <20060626170158.GA2331@polar.elf12.net>
References: <20060620140152.GB5414@polar.elf12.net>
	<449D2C02.8010101@gmail.com>
	<20060624174731.GA6091@polar.elf12.net>
	<449DD21E.9070906@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuuTX-00047v-5K for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 10:02:15 -0700
Received: from backsla.sh ([217.160.178.134])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FuuTV-0006HM-H1
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 10:02:15 -0700
Content-Disposition: inline
In-Reply-To: <449DD21E.9070906@gmail.com>
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

On Sun, Jun 25, 2006 at 08:00:30AM +0800, Antonino A. Daplas wrote:
> Robert Siemer wrote:
> > On Sat, Jun 24, 2006 at 08:11:46PM +0800, Antonino A. Daplas wrote:
> >> Robert Siemer wrote:
> 
> Disregard the previous patch, I forgot to adjust the checksum.
> Try this instead...

The patch works in the way that I see a console without a video= param.

Please answer my questions:
-Does the EDID block that reads the kernel get somehow exported or
 used somewhere else (in kernel maybe)?
-How get the capabilities of the monitor joined with the capabilities
 of the graphic adapter?
-Are there some (high) minimum capabilities of the radeon cards (so,
 is it possible to assume all can handle h: ...kHz, v: ...Hz or pxck:
 ...MHz)
-Which mode gets choosen from the resulting set of resolutions? I mean,
 based on what?


Thanks,
	Robert

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
