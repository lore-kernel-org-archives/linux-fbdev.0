From: Robert Siemer <Robert.Siemer@backsla.sh>
Subject: Re: radeonfb: DDC read wrong?
Date: Sat, 24 Jun 2006 23:56:59 +0200
Message-ID: <20060624215659.GD6091@polar.elf12.net>
References: <20060620140152.GB5414@polar.elf12.net>
	<449D2C02.8010101@gmail.com>
	<20060624174731.GA6091@polar.elf12.net>
	<449DAFA1.4060405@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+pHx0qQiF2pBVqBT"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FuG7t-0005BC-Po for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 14:57:13 -0700
Received: from backsla.sh ([217.160.178.134])
	by mail.sourceforge.net with smtp (Exim 4.44) id 1FuG7t-0007Bb-9x
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 24 Jun 2006 14:57:13 -0700
Content-Disposition: inline
In-Reply-To: <449DAFA1.4060405@gmail.com>
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


--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 25, 2006 at 05:33:21AM +0800, Antonino A. Daplas wrote:
> Robert Siemer wrote:
> > On Sat, Jun 24, 2006 at 08:11:46PM +0800, Antonino A. Daplas wrote:
> >> Robert Siemer wrote:
> 
> > [4294669.980000]       Analog Display Input: Input Voltage - 0.700V/0.300V
> > [4294669.980000]       Sync: Separate Composite Sync on Green 
> > [4294669.981000]       Max H-size in cm: 31
> > [4294669.981000]       Max V-size in cm: 23
> > [4294669.981000]       Gamma: 1.80
> > [4294669.981000]       DPMS: Active yes, Suspend yes, Standby yes
> > [4294669.981000]       RGB Color Display
> > [4294669.981000]       Chroma
> > [4294669.981000]          RedX:     0.625 RedY:     0.340
> > [4294669.981000]          GreenX:   0.275 GreenY:   0.605
> > [4294669.981000]          BlueX:    0.150 BlueY:    0.065
> > [4294669.981000]          WhiteX:   0.283 WhiteY:   0.298
> > [4294669.981000]    Detailed Timings
> > [4294669.982000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
> > [4294669.982000] 
> > [4294669.982000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
> > [4294669.982000] 
> > [4294669.982000]       2 MHz 1 2 3 258 1 1 18 258 -HSync -VSync
> > [4294669.982000] 
> 
> Yes, your monitor has a broken EDID block.  It basically violated the
> VESA detailed timing descriptor specs.

I noticed already.

> Can you send me a dump of the EDID?  You can use read-edid for that.

What will the corrected behaviour look like. The edid is attached
(get-edid), but tell me what the changes to the kernel will cause!


Robert

--+pHx0qQiF2pBVqBT
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="eizo.edid"
Content-Transfer-Encoding: base64

AP///////wAVOgICAAAAAAIGAQEOHxdQ6Ai5oFdGmyYQSEyAIYAAAAAAAAAAAAAAAAAAAAAA
AAAA/gA3oB5WAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEB
AQEBAQEBAQEBAQEBAQEBAQEBACE=

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--+pHx0qQiF2pBVqBT
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--+pHx0qQiF2pBVqBT--
