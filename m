From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Mon, 14 Oct 2002 14:54:40 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021014125440.GA2171@vana.vc.cvut.cz>
References: <20021012153641.GA13798@casa.fluido.as> <20021013001324.GF4267@ppc.vc.cvut.cz> <20021013141516.GA9973@casa.fluido.as> <20021013145604.GC20348@ppc.vc.cvut.cz> <20021013160746.GA17618@casa.fluido.as> <20021013223507.GA5348@ppc.vc.cvut.cz> <20021014055053.GA1953@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from vana.vc.cvut.cz ([147.32.240.58])
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1814kA-000307-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Oct 2002 05:54:47 -0700
Content-Disposition: inline
In-Reply-To: <20021014055053.GA1953@casa.fluido.as>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Mon, Oct 14, 2002 at 07:50:53AM +0200, Carlo E. Prelz wrote:
> --- lspciold	Mon Oct 14 07:30:53 2002
> +++ lspcinew	Mon Oct 14 07:35:09 2002
> @@ -17,7 +17,7 @@
>  10: 08 00 00 e8 00 00 00 e4 00 00 00 e5 00 00 00 00
>  20: 00 00 00 00 00 00 00 00 00 00 00 00 2b 10 7d 21
>  30: 00 00 00 00 dc 00 00 00 00 00 00 00 0b 01 10 20
> -40: 20 00 04 00 00 3c 00 00 2b ff ff 2b 00 00 00 00
> +40: 20 08 04 00 00 3c 00 00 2b ff ff 2b 00 00 00 00

Oops.

>   OPTION flags:                  0xC2

Small mistake. Please apply patch below, it should fix your
problem.
						Best regards,
							Petr Vandrovec
							vandrove@vc.cvut.cz


--- linux-2.5.41-c748/drivers/video/matrox/matroxfb_misc.c.orig	2002-10-10 18:11:14.000000000 +0200
+++ linux-2.5.41-c748/drivers/video/matrox/matroxfb_misc.c	2002-10-14 14:50:29.000000000 +0200
@@ -849,7 +849,7 @@
 					  ( bd->pins[86]        & 0x0000000F);
 	MINFO->values.reg.opt		= ((bd->pins[53] << 15) & 0x00400000) |
 					  ((bd->pins[53] << 22) & 0x10000000) |
-					  ((bd->pins[53] << 10) & 0x00001C00);
+					  ((bd->pins[53] <<  7) & 0x00001C00);
 	MINFO->values.reg.opt3		= get_u32(bd->pins + 67);
 	MINFO->values.pll.system	= (bd->pins[ 65] == 0xFF) ? 200000 			: bd->pins[ 65] * 4000;
 	MINFO->features.pll.ref_freq	= (bd->pins[ 92] & 0x01) ? 14318 : 27000;


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
