From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: RE: 2.5.70 - Blank Screen with VESA VGA Framebuffer
Date: Fri, 13 Jun 2003 10:54:18 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0306131052590.11546-100000@vervain.sonytel.be>
References: <0BCBFEACE44CF0469CF5EBF7F6B612534468DE@chn-snr-msg.wipro.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 19QkLV-0007xm-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 13 Jun 2003 01:55:41 -0700
In-Reply-To: <0BCBFEACE44CF0469CF5EBF7F6B612534468DE@chn-snr-msg.wipro.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: Parag Warudkar <parag.warudkar@wipro.com>
Cc: James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 13 Jun 2003, Parag Warudkar wrote:
> No. Atyfb hasn't worked for me in 2.4.20. If I use video=3Datyfb, I get=
 a
> corrupted white screen which is beyond my capabilities to describe!! :)

OK, so there's no point in trying atyfb in 2.5.x, it won't work neither.

> The graphics chip is ATI RAGE Mobility M1(LT) AGP2X - a MACH64 Derivate
> with 8Mb RAM..  For X, 3D acceleration (DRI, direct rendering) works

So you probably have the same version as I have. Thanks to Dani=EBl Manti=
one,
it's almost working, though.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m6=
8k.org

In personal conversations with technical people, I call myself a hacker. =
But
when I'm talking to journalists I just say "programmer" or something like=
 that.
							    -- Linus Torvalds



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
