From: Edgar Hucek <hostmaster@ed-soft.at>
Subject: Re: [PATCH 1/1] New Framebuffer for Intel based
 Macs [try #2] (fwd)
Date: Fri, 23 Jun 2006 06:01:44 +0200
Message-ID: <449B67A8.70500@ed-soft.at>
References: <Pine.LNX.4.62.0606221038280.23155@pademelon.sonytel.be>
	<9D874D8E-7EF1-4C29-98F2-AEDFD78C6676@cecropia.com>
	<449A7FDC.2030304@gmail.com>
	<269AA200-402D-4D9B-93AC-773C44F1AF50@cecropia.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ftcrg-0001LV-3u for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 21:01:52 -0700
Received: from 83-64-96-243.bad-voeslau.xdsl-line.inode.at ([83.64.96.243]
	helo=mognix.dark-green.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ftcre-0001jt-IG
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 22 Jun 2006 21:01:52 -0700
In-Reply-To: <269AA200-402D-4D9B-93AC-773C44F1AF50@cecropia.com>
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
To: Dennis Munsie <dmunsie@cecropia.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>

The driver is needed when making a native EFI boot, it does not work
with BootCamp.

cu

Edgar Hucek

Dennis Munsie schrieb:
> fair enough -- i had thought about it a little more on the way to work,
> and that makes sense.  But, once the native drivers work, it would
> probably be a good idea to make note someplace that the other drivers
> would provide better performance than this one.
> 
> btw -- the intelfb driver in it's current state might not work on the
> intel macs anyway.  The intelfb driver doesn't do well with anything but
> the analog output, and the MacBook and mini both have DVI ports.
> 
> another quick question regarding this driver -- is it only needed when a
> native EFI boot is done?  or does it also get used when Boot Camp is
> used?  I would think that Boot Camp would allow the VESA driver to work,
> since it's purpose is to make it look like the machine has a true x86
> BIOS...
> 
> dennis
> 
> On Jun 22, 2006, at 7:32 AM, Antonino A. Daplas wrote:
> 
>> Dennis Munsie wrote:
>>> Why is a new framebuffer driver required in this case?
>>
>> It is a platform driver, much like vga16fb and vesafb are for
>> x86. They are backup drivers.
>>
>>> Why not use
>>> the intelfb driver for the mini and the MacBook and an ati driver for
>>> the iMac and the MacBook Pro?
>>
>> The same reason that people use vesafb because the chipset-specific
>> driver either conflicts with X or does not work.
>>
>> Tony
>>
> 
> 


Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
