From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: atyfb expert needed
Date: Thu, 12 Feb 2004 10:55:46 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402121054590.7297@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402121030520.801-100000@deadlock.et.tudelft.nl>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArDaY-000154-TP
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Feb 2004 01:56:54 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1ArDXb-00007J-14
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Feb 2004 01:53:51 -0800
In-Reply-To: <Pine.LNX.4.44.0402121030520.801-100000@deadlock.et.tudelft.nl>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="iso-8859-1"
To: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 12 Feb 2004, [ISO-8859-1] Dani=EBl Mantione wrote:
> On Thu, 12 Feb 2004, Geert Uytterhoeven wrote:
> > BTW, according to Dani=EBl Mantione the DSP calculations in atyfb hav=
e always
> > been wrong (but apparently worked on most machines due to sheer luck =
;-), so
> > you may want to compare with aty_dsp_gt() in current 2.4.
>
> Well, wrong in the sense that the calculations they make are very
> different from both Ati's example code and XFree86 code. The original a=
uthor
> (unknown to me at this time) might have had reasons to code it like thi=
s,
> but it looks realistic that he simply tried to modify it till it worked
> for him.

I remember starting from ATI sample code, but that didn't work well, and
modifying that based on info from the XFree86 code, until it worked.

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
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
