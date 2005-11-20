From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: 2 more fbcon rotation bugs
Date: Sun, 20 Nov 2005 10:58:32 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0511201055080.2941@numbat.sonytel.be>
References: <437DF1EA.7010906@t-online.de> <437E3856.9030509@gmail.com>
 <437EFA9B.8090402@t-online.de> <437FF1F8.9020307@gmail.com>
 <43803BD4.7080403@t-online.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584334533-124771815-1132480712=:2941"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91] helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EdlyE-00053N-Ix
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 01:58:50 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by mail.sourceforge.net with esmtp (Exim 4.44)
	id 1EdlyC-0002yh-AM
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Nov 2005 01:58:50 -0800
In-Reply-To: <43803BD4.7080403@t-online.de>
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
To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
Cc: "Antonino A. Daplas" <adaplas@gmail.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584334533-124771815-1132480712=:2941
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by witte.sonytel.be id jAK9wXrq020893

On Sun, 20 Nov 2005, Knut Petersen wrote:
> > It seems that cfbfillrect and cfbcopyarea were written in a big-endia=
n
> > machine (if I'm not mistaken, by Geert on m68k?) as unaligned access =
in
> > little endian produces this bug.
> > =20
> That patch set fixes my problems with vesafb. For the tested subset of
> possible
> font dimensions and rotation values everything seems to be ok now. But =
maybe
> someone with a  big-endian machine should also verify the code.
>=20
> Isn=B4t it amazing that code as old as this still contains undetected b=
ugs?

It's not _that_ old, it was written in the 2.5 timeframe ;-)
And it's about corner cases. Rotation opens up some parts of the code tha=
t were
never used with 8x8, 8x16, and 12x22 fonts.

> Is there anything like a framebuffer test suite that could be used for =
a quick
> verification
> of especially the seldom used features?

There exists fbtest, but it doesn't test the internal drawing routines.

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
---584334533-124771815-1132480712=:2941--


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
