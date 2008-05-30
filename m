From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver
Date: Fri, 30 May 2008 07:15:54 +0200
Message-ID: <20080530051554.GA21499@roarinelk.homelinux.net>
References: <20080529092451.19666.91541.sendpatchset@rx1.opensource.se>
	<20080530135928.9a555aca.iwamatsu@nigauri.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K1wy9-0001cw-HE for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 22:16:01 -0700
Received: from fnoeppeil48.netpark.at ([217.175.205.176]
	helo=roarinelk.homelinux.net)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K1wy7-0003Xo-Og
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 29 May 2008 22:16:01 -0700
Content-Disposition: inline
In-Reply-To: <20080530135928.9a555aca.iwamatsu@nigauri.org>
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
To: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, akpm@linux-foundation.org, lethal@linux-sh.org, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org

Hi Folks,

On Fri, May 30, 2008 at 01:59:28PM +0900, Nobuhiro Iwamatsu wrote:
> Hi, Magnus.
> 
> On Thu, 29 May 2008 18:24:51 +0900
> Magnus Damm <magnus.damm@gmail.com> wrote:
> 
> > This patch adds frame buffer support for the LCDC block found in
> > SuperH Mobile processors. The hardware supports up to two LCD panels
> > per LCDC block, and both RGB and SYS interfaces can be used to hook
> > up LCD panels/modules.
> > 
> > The device driver is a regular platform driver, so LCD configuration
> > and board specific hooks are passed to the driver using platform data.
> > LCD modules using SYS interface often require special configuration
> > using the SYS bus, and to solve this cleanly the driver provides SYS
> > interface operations to the board code.
> > 
> > Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
> > WVGA panels using RGB16 and RGB18 interfaces.
> > 
> > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > ---
> > 
> >  drivers/video/Kconfig            |   10 
> >  drivers/video/Makefile           |    2 
> >  drivers/video/sh_mobile_lcdcfb.c |  742 ++++++++++++++++++++++++++++++++++++++
> >  include/asm-sh/sh_mobile_lcdc.h  |   66 +++
> 
> This is a proposal. 
> I am coding sh7763's frame buffer driver.

 I wrote a driver for the SH7760 LCDC 2 years ago. From a quick glance at
the respective datasheets it seems both 7760 and 7763 have identical
register layout.  Looking at Magnus' driver, the 7722/7723 LCDC seems to
be an extended version of the 7760/63 LCDC. Maybe we can unify them somehow?


	Manuel Lauss

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
