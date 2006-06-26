From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: radeonfb: DDC read wrong?
Date: Tue, 27 Jun 2006 04:55:49 +0800
Message-ID: <44A049D5.5030702@gmail.com>
References: <20060620140152.GB5414@polar.elf12.net>	<449D2C02.8010101@gmail.com>	<20060624174731.GA6091@polar.elf12.net>	<449DD21E.9070906@gmail.com>
	<20060626170158.GA2331@polar.elf12.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Fuy7p-0000wC-1M for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 13:56:05 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Fuy7o-0005Zs-D7
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Jun 2006 13:56:05 -0700
Received: by py-out-1112.google.com with SMTP id m51so1498227pye
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 26 Jun 2006 13:56:02 -0700 (PDT)
In-Reply-To: <20060626170158.GA2331@polar.elf12.net>
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
Cc: Robert Siemer <Robert.Siemer@backsla.sh>

Robert Siemer wrote:
> On Sun, Jun 25, 2006 at 08:00:30AM +0800, Antonino A. Daplas wrote:
>> Robert Siemer wrote:
>>> On Sat, Jun 24, 2006 at 08:11:46PM +0800, Antonino A. Daplas wrote:
>>>> Robert Siemer wrote:
>> Disregard the previous patch, I forgot to adjust the checksum.
>> Try this instead...
> 
> The patch works in the way that I see a console without a video= param.
> 
> Please answer my questions:
> -Does the EDID block that reads the kernel get somehow exported or
>  used somewhere else (in kernel maybe)?

For drivers that use the EDID, it gets converted into struct fb_monspecs.
Part of this structure is a private mode database
(cat /sys/class/graphics/fb0/modes).

> -How get the capabilities of the monitor joined with the capabilities
>  of the graphic adapter?

The driver has to watch out for that.

> -Are there some (high) minimum capabilities of the radeon cards (so,
>  is it possible to assume all can handle h: ...kHz, v: ...Hz or pxck:
>  ...MHz)

VGA cards will always have an upper limit to the pixelclock, and the
horizontal and vertical sync limits are derived from the pixelclock and
the resolution of the display.

> -Which mode gets choosen from the resulting set of resolutions? I mean,
>  based on what?

Depends on the driver. A combination of the 'first detailed timing
is preferred' flag and a detailed timing is the initial startup mode.
As for radeonfb, I think it just grabs the first detailed timing for
the initial mode.

Tony

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
