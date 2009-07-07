From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH v5] Frame Buffer driver for TI
	DA8xx/OMAP-L1xx
Date: Tue, 7 Jul 2009 22:09:43 +0200
Message-ID: <20090707220943.479940d7.krzysztof.h1@poczta.fm>
References: <1246858151-16995-1-git-send-email-sudhakar.raj@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <krzysztof.h1@poczta.fm>) id 1MOGpk-0000oS-N5
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 20:00:09 +0000
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOGpe-0005pt-T1 for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 07 Jul 2009 20:00:08 +0000
In-Reply-To: <1246858151-16995-1-git-send-email-sudhakar.raj@ti.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: "Rajashekhara, Sudhakar" <sudhakar.raj@ti.com>
Cc: Steve Chen <schen@mvista.com>, davinci-linux-open-source@linux.davincidsp.com, linux-fbdev-devel@lists.sourceforge.net, Pavel Kiryukhin <pkiryukhin@ru.mvista.com>

On Mon,  6 Jul 2009 01:29:11 -0400
"Rajashekhara, Sudhakar" <sudhakar.raj@ti.com> wrote:

> Adds LCD controller (LCDC) driver for TI's DA8xx/OMAP-L1xx architecture.
> LCDC specifications can be found at http://www.ti.com/litv/pdf/sprufm0a.
> 
> LCDC on DA8xx consists of two independent controllers, the Raster Controller
> and the LCD Interface Display Driver (LIDD) controller. LIDD further supports
> character and graphic displays.
> 
> This patch adds support for the graphic display (Sharp LQ035Q3DG01) found on
> the DA830 based EVM. The EVM details can be found at:
> http://support.spectrumdigital.com/boards/dskda830/revc/.
> 
> Signed-off-by: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
> Signed-off-by: Pavel Kiryukhin <pkiryukhin@ru.mvista.com>
> Signed-off-by: Steve Chen <schen@mvista.com>
> ---
>  This patch applies to Linus's Kernel tree.
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

----------------------------------------------------------------------
Zaufalo nam ponad 700 000 Polakow. Dolacz do AXA OFE.
http://link.interia.pl/f2257


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
