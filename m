From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 5/9] ps3: Preallocate bootmem memory
	for ps3fb
Date: Tue, 30 Jan 2007 09:16:03 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0701300914580.4728@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>
	<Pine.LNX.4.62.0701251849550.24610@pademelon.sonytel.be>
	<1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HBo9z-0001PE-6H for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 00:16:11 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HBo9y-0005SK-O3
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jan 2007 00:16:11 -0800
In-Reply-To: <1170124157.19887.116.camel@concordia.ozlabs.ibm.com>
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
To: Michael Ellerman <michael@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

On Tue, 30 Jan 2007, Michael Ellerman wrote:
> On Thu, 2007-01-25 at 18:50 +0100, Geert Uytterhoeven wrote:
> > Preallocate bootmem memory for the PS3 frame buffer device, which needs a
> > large block of physically-contiguous memory. The size of this memory block is
> > configurable:
> >   - The config option CONFIG_FB_PS3_DEFAULT_SIZE_M allows to specify the
> >     default amount of memory (in MiB) allocated to the virtual frame buffer.
> >   - The early boot parameter `ps3fb=xxx' allows to override the default value.
> >     It will be rounded up to a multiple of 1 MiB, if needed.
> > 
> > Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> Rather than doing the alloc in setup.c, defining a structure to the hold
> the params, and then exporting the structure - why don't you just do the
> alloc in the ps3 fb driver code, and have it all private in there?

Because at that time it's no longer possible to allocate such a big block of
memory.

We have a similar problem with the storage driver, which needs a block of 256
KiB of contiguous memory.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
