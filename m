From: Andrey Volkov <avolkov@varma-el.com>
Subject: Re: [F]Framebuffer driver using SM501 hardware.
Date: Wed, 17 Aug 2005 16:15:50 +0400
Message-ID: <43032A76.6080104@varma-el.com>
References: <20050816194825.A62AC353AB5@atlas.denx.de> <43030D41.3000508@varma-el.com> <Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E5Mpr-0005Gs-Fz
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 05:15:59 -0700
Received: from [195.144.244.147] (helo=amanaus.varma-el.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)
	id 1E5Mpp-0006Fr-RO
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 17 Aug 2005 05:15:59 -0700
In-Reply-To: <Pine.LNX.4.62.0508171317540.6073@numbat.sonytel.be>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: Geert Uytterhoeven <geert@linux-m68k.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: Wolfgang Denk <wd@denx.de>, Linux/PPC Development <linuxppc-dev@ozlabs.org>, surendra.yadav@softdel.com



Geert Uytterhoeven wrote:
> On Wed, 17 Aug 2005, Andrey Volkov wrote:
> 
>>Todo:
>>- 16 bpp colormap (needed reverse endian support in fbcon/fbmem)
> 
> 
> Can you please elaborate? For 2.6, there should be no such problems (for 2.4,
> there are).

Sorry for inexactitude, problem (as usually :)) in next (for case of
MPC5200 connected through PCI to SM501): PCI on PPC (and hence SM501) is
a little endian, PPC - big endian.
Currently (up to 2.6.13-rc6) frame buffer routines use
__raw_writeXX for write to fb memory. Result - garbage with colors in
RGB565/RGB888 modes (but pixels, meanwhile, are in place). If using
write[lw] - colors are diplayed correctly, but all image pixels are
shifted for (RGB565). This is not bug of frame buffer, this is lack of
some define in .config which tell fb/device driver how palette must be
generated (more precisely it is unknown when must be RGB565, but when
must be BGR565).

Problem redouble when hw accel, as bus muster, entered in the game:
for accelerated imageblit pixels must be in RGB565 mode :((

-- 
Regards
Andrey Volkov


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
