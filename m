From: krzysztof.h1@poczta.fm
Subject: Re: 
	=?utf-8?q?=5BPATCH_v5=5D_Frame_Buffer_driver_?=
	=?utf-8?q?for_TI_DA8xx/OMAP-L1xx?=
Date: 08 Jul 2009 12:07:40 +0200
Message-ID: <20090708100740.960513D1821@f53.poczta.interia.pl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MOU46-0003Xv-Ri
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Jul 2009 10:07:50 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOU42-0001c5-Jj for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Jul 2009 10:07:50 +0000
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: =?UTF-8?q?Rajashekhara=2C_Sudhakar?= <sudhakar.raj@ti.com>, =?UTF-8?q?=27Krzysztof_Helt=27?= <krzysztof.h1@poczta.fm>, linux-fbdev-devel@lists.sourceforge.net, davinci-linux-open-sour

Rajashekhara, Sudhakar napisa=B3(a):
> On Wed, Jul 08, 2009 at 01:39:43, Krzysztof Helt wrote:
> > On Mon,  6 Jul 2009 01:29:11 -0400
> > "Rajashekhara, Sudhakar" >sudhakar.raj@ti.com> wrote:
> > =

> > > Adds LCD controller (LCDC) driver for TI&#039;s DA8xx/OMAP-L1xx
> architecture.
> > > LCDC specifications can be found at
> http://www.ti.com/litv/pdf/sprufm0a.
> > > =

> > > LCDC on DA8xx consists of two independent controllers, the Raster =

> > > Controller and the LCD Interface Display Driver (LIDD) controller. =

> > > LIDD further supports character and graphic displays.
> > > =

> > > This patch adds support for the graphic display (Sharp LQ035Q3DG01) =

> > > found on the DA830 based EVM. The EVM details can be found at:
> > > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > > =

> > > Signed-off-by: Sudhakar Rajashekhara >sudhakar.raj@ti.com>
> > > Signed-off-by: Pavel Kiryukhin >pkiryukhin@ru.mvista.com>
> > > Signed-off-by: Steve Chen >schen@mvista.com>
> > > ---
> > >  This patch applies to Linus&#039;s Kernel tree.
> > > =

> > =

> > Acked-by: Krzysztof Helt >krzysztof.h1@wp.pl>
> > =

> =

> Thanks. What I should do to get this patch to Linus&#039;s tree?
> =


Send it to Andrew Morton <akpm@linux-foundation.org>

Regards,
Krzysztof

----------------------------------------------------------------------
Twoja pensja x 3? Otworz Konto Direct!
Sprawdz >>  	 http://link.interia.pl/f2209


---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
