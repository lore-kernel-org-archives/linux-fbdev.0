From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: 2.5.70 - Blank Screen with VESA VGA Framebuffer
Date: Sat, 14 Jun 2003 00:06:32 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200306140006.33037.alex.kern@gmx.de>
References: <Pine.GSO.4.21.0306131123460.11546-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from pop.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19QxLC-0006M3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 15:48:14 -0700
In-Reply-To: <Pine.GSO.4.21.0306131123460.11546-100000@vervain.sonytel.be>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Am Freitag, 13. Juni 2003 11:24 schrieb Geert Uytterhoeven:
> On Fri, 13 Jun 2003, Parag Warudkar wrote:
> > You mean to say you have 2.5.XX working with VESA VGA Framebuffer or
> > ATYFB? If yes, could you please direct me to relevant sources / patches?
>
> I mean atyfb in 2.4.20. But it's not yet working out-of-the-box, it needs
> an program to play with some registers, and more investigation. Stay
> tuned...

> > > The graphics chip is ATI RAGE Mobility M1(LT) AGP2X - a MACH64 Deriva=
te
> > > with 8Mb RAM..  For X, 3D acceleration (DRI, direct rendering) works

Hi,

search for a '"Re: [Linux-fbdev-devel] [PATCH resend] aty rage 3d mobility =
m1"=20
on the list. This is a patch on top of 2.5.69. I test and develop it with=20
ARMADA notebook, chip ATI RAGE 3D Mobility M1. I think, it will work with=20
"LTPro" too, but for "LT" I can't believe.

Dani=EAl's patch is only for 2.4.XX, he worked and tested with LTPro 800x60=
0.

Regards Alex

=20




-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
