From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: [PATCH v3] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Tue, 30 Jun 2009 11:54:44 +0530
Message-ID: <48408.9027195752$1246343455@news.gmane.org>
References: <1245841101-3095-1-git-send-email-sudhakar.raj@ti.com>
	<20090626071855.22518d52.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MLWnc-0007G2-K1
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jun 2009 06:26:36 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MLWme-0003Vt-8z for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 30 Jun 2009 06:26:36 +0000
In-Reply-To: <20090626071855.22518d52.krzysztof.h1@poczta.fm>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: 'Krzysztof Helt' <krzysztof.h1@poczta.fm>
Cc: 'Steve Chen' <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net, 'Pavel Kiryukhin' <pkiryukhin@ru.mvista.com>

Hi,

On Fri, Jun 26, 2009 at 10:48:55, Krzysztof Helt wrote:
> On Wed, 24 Jun 2009 06:58:21 -0400
> "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> wrote:
> 
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> > LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> > 
> > LCDC on DA8xx consists of two independent controllers, the Raster Controller
> > and the LCD Interface Display Driver (LIDD) controller. LIDD further supports
> > character and graphic displays.
> > 
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01) found on
> > the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > 
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > ---

[...]

> 
> The true color modes do not use the palette entry. I assume
> that the value below forces controller to use true color mode.
> 
> > +		palette[0] = 0x4000;
> > +	}
> > +

You are right. The above line enables the true color mode.

I tested the driver with the changes suggested by you. I'll
be submitting the v4 version of the patch soon.

Regards,
Sudhakar



------------------------------------------------------------------------------
