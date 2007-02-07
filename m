From: Luca Tettamanti <kronos@people.it>
Subject: Re: [PATCH] nvidiafb: allow ignoring EDID info
Date: Thu, 8 Feb 2007 00:57:28 +0100
Message-ID: <20070207235728.GA28695@dreamland.darkstar.lan>
References: <20070128160831.fb51347f.akpm@osdl.org>
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
	id 1HEwfE-0003vI-UZ for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 15:57:25 -0800
Received: from jack.tiscali.it ([213.205.33.53])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HEwfE-00049p-Cn
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 07 Feb 2007 15:57:24 -0800
Content-Disposition: inline
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

Il Mon, Feb 05, 2007 at 10:28:36PM +0100, Giuseppe Bilotta ha scritto: 
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
[...]
> There is no such thing as /dev/i2c* UNLESS I load nvidiafb.

Of course :)

> When I
> load that, I get three busses (i2c-0, -1, and -2), but i2cdump N 0x50
> gives me a nice tableau of X's all around, for all values of N.

There may be a bug in the serial clock line control, at least the code
looks strange. I'll check and come back with a patch ASAP.

Luca
-- 
"Sei l'unica donna della mia vita".
(Adamo)

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
