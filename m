From: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Subject: Re: [PATCH v5] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Wed, 8 Jul 2009 15:06:13 +0530
Message-ID: <8729.35753218389$1247045990@news.gmane.org>
References: <1246858151-16995-1-git-send-email-sudhakar.raj@ti.com>
	<20090707220943.479940d7.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sudhakar.raj@ti.com>) id 1MOTaj-00070N-I5
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Jul 2009 09:37:29 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOTad-0004Ln-BP
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Jul 2009 09:37:29 +0000
In-Reply-To: <20090707220943.479940d7.krzysztof.h1@poczta.fm>
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

On Wed, Jul 08, 2009 at 01:39:43, Krzysztof Helt wrote:
> On Mon,  6 Jul 2009 01:29:11 -0400
> "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> wrote:
> 
> > Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> > LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> > 
> > LCDC on DA8xx consists of two independent controllers, the Raster 
> > Controller and the LCD Interface Display Driver (LIDD) controller. 
> > LIDD further supports character and graphic displays.
> > 
> > This patch adds support for the graphic display (Sharp LQ035Q3DG01) 
> > found on the DA830 based EVM. The EVM details can be found at:
> > http://support.spectrumdigital.com/boards/dskda830/revc/.
> > 
> > Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> > Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> > Signed-off-by: Steve Chen <schen@mvista.com>
> > ---
> >  This patch applies to Linus's Kernel tree.
> > 
> 
> Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>
> 

Thanks. What I should do to get this patch to Linus's tree?

Regards,
Sudhakar



------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
