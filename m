From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH] video: SuperH Mobile LCDC Driver V2
Date: Mon, 2 Jun 2008 15:09:12 +0900
Message-ID: <20080602060912.GA24978@linux-sh.org>
References: <20080530110239.21680.46731.sendpatchset@rx1.opensource.se> <20080530182803.5d599d21.krzysztof.h1@poczta.fm> <20080530120606.9ff1b384.akpm@linux-foundation.org>
Mime-Version: 1.0
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20080530120606.9ff1b384.akpm@linux-foundation.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, iwamatsu@nigauri.org, linux-sh@vger.kernel.org, mano@roarinelk.homelinux.net

On Fri, May 30, 2008 at 12:06:06PM -0700, Andrew Morton wrote:
> On Fri, 30 May 2008 18:28:03 +0200 Krzysztof Helt <krzysztof.h1@poczta.fm> wrote:
> 
> > On Fri, 30 May 2008 20:02:39 +0900
> > Magnus Damm <magnus.damm@gmail.com> wrote:
> > 
> > > This is the SuperH Mobile LCDC frame buffer driver V2, adding
> > > support for the LCDC block found in SuperH Mobile processors. The
> > > hardware supports up to two LCD panels per LCDC block, and both RGB
> > > and SYS interfaces can be used to hook up LCD panels/modules.
> > > 
> > > The device driver is a regular platform driver, so LCD configuration
> > > and board specific hooks are passed to the driver using platform data.
> > > LCD modules using SYS interface often require special configuration
> > > using the SYS bus, and to solve this cleanly the driver provides SYS
> > > interface operations to the board code.
> > > 
> > > Tested on sh7723 and sh7722 processors with a SYS16A QVGA panel and
> > > WVGA panels using RGB16 and RGB18 interfaces.
> > > 
> > > Signed-off-by: Magnus Damm <damm@igel.co.jp>
> > > ---
> > 
> > Acked-by: Krzysztof Helt<krzysztof.h1@wp.pl>
> > 
> > Does anybody know which tag is better for a reviewed patch:
> > "Acked-by" or "Reviewed-by" ?
> > 
> 
> I consider Reviewed-by: to be much stronger that Acked-by:
> 
> You wouldn't believe some of the crap which has had cheerful Acked-by:s :(

In that case:

Acked-by: Paul Mundt <lethal@linux-sh.org>

:-)
