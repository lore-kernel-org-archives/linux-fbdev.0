From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] fb: add support
	for	foreign	endianness
Date: Tue, 19 Feb 2008 11:35:53 +1100
Message-ID: <1203381353.6740.59.camel@pasglop>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
	<47BA162C.5000807@anagramm.de>
Reply-To: benh@kernel.crashing.org,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JRGTT-0007EY-PW for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 16:36:43 -0800
Received: from gate.crashing.org ([63.228.1.57]
	ident=[U2FsdGVkX1+xLU/FxLkccV544kWkfSX4wP+SgjBR2Ug=])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JRGTS-0001aO-AK
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 16:36:43 -0800
In-Reply-To: <47BA162C.5000807@anagramm.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Clemens Koller <clemens.koller@anagramm.de>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>


On Tue, 2008-02-19 at 00:35 +0100, Clemens Koller wrote:
> Valdis.Kletnieks@vt.edu schrieb:
> > On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
> >> I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
> >> Both resolve endianess at driver level. Actually, both handle it by setting special
> >> bits so the graphics chip itself reorder bytes to transform foreign endianess. 
> >> I understand that this patch is for chips which cannot reorder bytes by themselves.
> > 
> > Does anybody know of such a chip that's actually available in the wild?  Or are
> > we writing drivers for speculative possible chips?
> > 
> 
> I had troubles with the Silicon Motion SM501/SM502 endianess on PowerPC PCI vs. LocalBus.
> The chip also has a register to swap endianess, but that seems to only affect some
> LocalBus modes.
> The current fb and X drivers are working, but when it comes to font
> aliasing and hw-acceleration, the problems start to rise again...

Most "sane" gfx chips nowadays provide configurable surfaces that allow
to perform the swap when writing/reading from regions of the
framebuffer, with the ability to set a different swapper setting (based
on bit depth) per region.

Then there is also the risk that your PCI<->Localbus has been wired
improperly :-)

Ben.



-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
