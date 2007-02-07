From: Luca Tettamanti <kronos@people.it>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Thu, 8 Feb 2007 00:48:37 +0100
Message-ID: <20070207234837.GA27822@dreamland.darkstar.lan>
References: <21d7e9970701281612q56b694edp6efd1a5556dea3fe@mail.gmail.com>
	<20070128162907.370f5476.akpm@osdl.org>
	<21d7e9970701281639w57edc2efw4ba620d4c1bdcee7@mail.gmail.com>
	<cb7bb73a0701290637q2ce0ff16t28f82d0c0339a2ba@mail.gmail.com>
	<20070130203301.GA15067@dreamland.darkstar.lan>
	<20070204201713.GA12867@dreamland.darkstar.lan>
	<cb7bb73a0702041317u4ca2fbabp45cf56526e57c982@mail.gmail.com>
	<20070205201824.GA13431@dreamland.darkstar.lan>
	<cb7bb73a0702051328n50c889d9o461ac2bb9f9ea75e@mail.gmail.com>
	<Pine.LNX.4.64.0702062118450.9224@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HEwWv-00033v-Uj for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 15:48:50 -0800
Received: from averell.tiscali.it ([213.205.33.55])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEwWu-0004ii-AV
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 15:48:49 -0800
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702062118450.9224@pentafluge.infradead.org>
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
To: James Simmons <jsimmons@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net, Dave Airlie <airlied@gmail.com>, Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, linux-kernel@vger.kernel.org

Il Tue, Feb 06, 2007 at 09:22:00PM +0000, James Simmons ha scritto: 
> 
> > On 2/5/07, Luca Tettamanti <kronos@people.it> wrote:
> > > get-edid uses the BIOS, while the other two talk directly over the I2C
> > > bus.
> > > 
> > > Try loading i2c-dev (I2C_CHARDEV); With i2cdump[1] you can read the EDID
> > > block, which resides at address 0x50:
> > > 
> > > i2cdump N 0x50 (where N is the bus number)
> > > 
> > > If you are unshure about bus number try with all the available
> > > /dev/i2c-* devices (you may want to unload HW monitor drivers first, so
> > > you don't poke at random stuff).
> > 
> > No luck. i2c-dev and dependencies are loaded
> > """ lsmod | grep i2c reports """
> > i2c_i801                7404  0
> > i2c_isa                 5152  0
> > i2c_piix4               8140  0
> > i2c_algo_pcf            6180  0
> > i2c_algo_pca            5380  0
> > i2c_algo_bit            8424  0
> > i2c_dev                 8548  0
> > i2c_core               19680  7
> > i2c_i801,i2c_isa,i2c_piix4,i2c_algo_pcf,i2c_algo_pca,i2c_algo_bit,i2c_dev
> > """"
> > 
> > There is no such thing as /dev/i2c* UNLESS I load nvidiafb. When I
> > load that, I get three busses (i2c-0, -1, and -2), but i2cdump N 0x50
> > gives me a nice tableau of X's all around, for all values of N. This
> > is using kernel 2.6.18-3 stock Debian kernel. I'll keep trying with
> > some variations, to see if I can get more sensible information.
> 
> There is no stand alone nvidia card i2c driver. Its the issue of sharing 
> device interfaces with the same hardware problem again!!! 

Nah, nvidiafb registers the I2C busses, you can drive them with whatever
you want through the devices exported by I2C core.
The fact the none of them work makes me think that the EDID is coming
from the BIOS, we do VBE calls in real mode during early kernel setup.

Luca
-- 
Se non sei parte della soluzione, allora sei parte del problema.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
