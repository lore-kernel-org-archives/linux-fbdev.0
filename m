From: Petr Vandrovec <vandrove@vc.cvut.cz>
Subject: Re: Mixing g400 dualhead and old Millennium.
Date: Mon, 14 Oct 2002 00:35:07 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20021013223507.GA5348@ppc.vc.cvut.cz>
References: <20021012153641.GA13798@casa.fluido.as> <20021013001324.GF4267@ppc.vc.cvut.cz> <20021013141516.GA9973@casa.fluido.as> <20021013145604.GC20348@ppc.vc.cvut.cz> <20021013160746.GA17618@casa.fluido.as>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from p0076.as-l042.contactel.cz ([194.108.237.76] helo=ppc.vc.cvut.cz)
	by usw-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 180rMS-0006P9-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Oct 2002 15:37:26 -0700
Content-Disposition: inline
In-Reply-To: <20021013160746.GA17618@casa.fluido.as>
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

On Sun, Oct 13, 2002 at 06:07:46PM +0200, Carlo E. Prelz wrote:
> 	Subject: Re: Mixing g400 dualhead and old Millennium.
> 	Date: dom, ott 13, 2002 at 04:56:04 +0200
> 
> Quoting Petr Vandrovec (vandrove@vc.cvut.cz):
> 
> > If you could print return value from register_framebuffer in 
> > matroxfb_dh_regit in matroxfb_crtc2.c, maybe it could reveal
> > problem. Maybe that using non-ac kernel fixes problem too.
> 
> It never reaches register_framebuffer. It leaves dh_regit at tese
> lines:
> 
>         else if (ACCESS_FBINFO(video.len) < mem) {
>                 kfree(d);
>                 return -ENOMEM;
>         }
> 
> ACCESS_FBINFO(video.len) is 2097152. Mem is 8388608.

Really... I did not notice in your original email that it
reports G400 as 2MB only device... Can you send me
output of 'lspci -s X:Y.Z -vvvxxx' (where X:Y.Z is
your G400 device, probably 1:00.0 or 2:00.0) with
2.4.19-pre10, and with Alan version? Alan's version
uses data from BIOS to set memory type, and it
apparently made mistake.

In Alan's kernel you should have option to enable procfs
interface - can you enable it and send me also
contents of /proc/driver/mga/fb*/pins. It is binary
file, if you want, you can parse it by matrox_pins
from ftp://platan.vc.cvut.cz/pub/linux/matrox-latest.
				Thanks,
					Petr Vandrovec
					vandrove@vc.cvut.cz


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
