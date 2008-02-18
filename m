From: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/2] fb: add support for foreign
	endianness
Date: Mon, 18 Feb 2008 20:37:45 +0300
Message-ID: <20080218173745.GA25628@localhost.localdomain>
References: <20080205154432.GA8749@localhost.localdomain>
	<20080214224942.a0cb6218.akpm@linux-foundation.org>
	<20080215164542.GB16810@localhost.localdomain>
	<Pine.LNX.4.64.0802171030330.6848@anakin>
	<20080218081847.e9e65f2f.krzysztof.h1@poczta.fm>
	<19805.1203355811@turing-police.cc.vt.edu>
Reply-To: avorontsov@ru.mvista.com,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JR9w5-0007b5-OQ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 09:37:50 -0800
Received: from [85.21.88.6] (helo=buildserver.ru.mvista.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JR9w4-0004kw-B8
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 Feb 2008 09:37:49 -0800
Content-Disposition: inline
In-Reply-To: <19805.1203355811@turing-police.cc.vt.edu>
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
To: Valdis.Kletnieks@vt.edu
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, Geert Uytterhoeven <geert@linux-m68k.org>, Andrew Morton <akpm@linux-foundation.org>

On Mon, Feb 18, 2008 at 12:30:11PM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 18 Feb 2008 08:18:47 +0100, Krzysztof Helt said:
> > I know two fb drivers which use endianess information (pm2fb and s3c2410fb).
> > Both resolve endianess at driver level. Actually, both handle it by setting special
> > bits so the graphics chip itself reorder bytes to transform foreign endianess. 
> > I understand that this patch is for chips which cannot reorder bytes by themselves.
> 
> Does anybody know of such a chip that's actually available in the wild?

LE Fujitsu mb86277 (MINT) on the BE MPC8360E.

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
