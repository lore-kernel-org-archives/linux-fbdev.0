From: James Simmons <jsimmons@infradead.org>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Tue, 6 Feb 2007 21:22:00 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0702062118450.9224@pentafluge.infradead.org>
References: <ephv35$4i3$1@sea.gmane.org>
	<20070128160831.fb51347f.akpm@osdl.org>
	<21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com> 
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com> 
	<20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com> 
	<20070205201824.GA13431@dreamland.darkstar.lan>
	<cb7bb73a0702051328n50c889d9o461ac2bb9f9ea75e@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEXlM-0008UG-V1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 13:22:06 -0800
Received: from pentafluge.infradead.org ([213.146.154.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEXlL-0004Gm-Dl
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 06 Feb 2007 13:22:04 -0800
In-Reply-To: <cb7bb73a0702051328n50c889d9o461ac2bb9f9ea75e@mail.gmail.com>
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
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: Luca Tettamanti <kronos@people.it>, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org


> On 2/5/07, Luca Tettamanti <kronos@people.it> wrote:
> > get-edid uses the BIOS, while the other two talk directly over the I2C
> > bus.
> > 
> > Try loading i2c-dev (I2C_CHARDEV); With i2cdump[1] you can read the EDID
> > block, which resides at address 0x50:
> > 
> > i2cdump N 0x50 (where N is the bus number)
> > 
> > If you are unshure about bus number try with all the available
> > /dev/i2c-* devices (you may want to unload HW monitor drivers first, so
> > you don't poke at random stuff).
> 
> No luck. i2c-dev and dependencies are loaded
> """ lsmod | grep i2c reports """
> i2c_i801                7404  0
> i2c_isa                 5152  0
> i2c_piix4               8140  0
> i2c_algo_pcf            6180  0
> i2c_algo_pca            5380  0
> i2c_algo_bit            8424  0
> i2c_dev                 8548  0
> i2c_core               19680  7
> i2c_i801,i2c_isa,i2c_piix4,i2c_algo_pcf,i2c_algo_pca,i2c_algo_bit,i2c_dev
> """"
> 
> There is no such thing as /dev/i2c* UNLESS I load nvidiafb. When I
> load that, I get three busses (i2c-0, -1, and -2), but i2cdump N 0x50
> gives me a nice tableau of X's all around, for all values of N. This
> is using kernel 2.6.18-3 stock Debian kernel. I'll keep trying with
> some variations, to see if I can get more sensible information.

There is no stand alone nvidia card i2c driver. Its the issue of sharing 
device interfaces with the same hardware problem again!!! There is a patch 
for DRI and fbdev but it really looks like we need a generic solution.
 

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
