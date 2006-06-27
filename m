From: Luca <kronos@people.it>
Subject: Re: radeonfb: DDC read wrong?
Date: Tue, 27 Jun 2006 21:11:24 +0200
Message-ID: <20060627191124.GC14392@dreamland.darkstar.lan>
References: <20060620140152.GB5414@polar.elf12.net>
	<449D2C02.8010101@gmail.com>
	<20060624174731.GA6091@polar.elf12.net>
	<449DD21E.9070906@gmail.com>
	<20060626170158.GA2331@polar.elf12.net>
	<44A049D5.5030702@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1FvIxs-0003Gp-CR for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 12:11:12 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1FvIxp-0004gw-6Y
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 27 Jun 2006 12:11:12 -0700
Content-Disposition: inline
In-Reply-To: <44A049D5.5030702@gmail.com>
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

Il Tue, Jun 27, 2006 at 04:55:49AM +0800, Antonino A. Daplas ha scritto: 
> Robert Siemer wrote:
> > On Sun, Jun 25, 2006 at 08:00:30AM +0800, Antonino A. Daplas wrote:
> >> Robert Siemer wrote:
> >>> On Sat, Jun 24, 2006 at 08:11:46PM +0800, Antonino A. Daplas wrote:
> >>>> Robert Siemer wrote:
> >> Disregard the previous patch, I forgot to adjust the checksum.
> >> Try this instead...
> > 
> > The patch works in the way that I see a console without a video= param.
> > 
> > Please answer my questions:
> > -Does the EDID block that reads the kernel get somehow exported or
> >  used somewhere else (in kernel maybe)?
> 
> For drivers that use the EDID, it gets converted into struct fb_monspecs.
> Part of this structure is a private mode database
> (cat /sys/class/graphics/fb0/modes).

With radeonfb you can also access the raw edid block(s):
/sys/class/graphics/fb0/device/edid1
/sys/class/graphics/fb0/device/edid2 (for second monitor, if any).

> > -Which mode gets choosen from the resulting set of resolutions? I mean,
> >  based on what?
> 
> Depends on the driver. A combination of the 'first detailed timing
> is preferred' flag and a detailed timing is the initial startup mode.
> As for radeonfb, I think it just grabs the first detailed timing for
> the initial mode.

Yes, the selection goes like this:

- mode option
- 1st detailed block
- 1st mode in the db


Luca
-- 
Home: http://kronoz.cjb.net
Se alla sera, dopo una strepitosa vittoria, guardandoti allo
specchio dovessi notare un secondo paio di palle, che il tuo 
cuore non si riempia d'orgoglio, perche` vuol dire che ti 
stanno inculando -- Saggio Cinese

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
