From: =?ISO-8859-1?Q?Dani=EBl_Mantione?= <daniel@deadlock.et.tudelft.nl>
Subject: Re: atyfb expert needed
Date: Thu, 12 Feb 2004 10:45:06 +0100 (CET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0402121030520.801-100000@deadlock.et.tudelft.nl>
References: <Pine.GSO.4.58.0402121024540.7297@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArDQH-0005rU-T9
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Feb 2004 01:46:17 -0800
Received: from deadlock.et.tudelft.nl ([130.161.36.93] ident=mail)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1ArDNK-0006hT-Iz
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 12 Feb 2004 01:43:14 -0800
In-Reply-To: <Pine.GSO.4.58.0402121024540.7297@waterleaf.sonytel.be>
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>



On Thu, 12 Feb 2004, Geert Uytterhoeven wrote:

> On Thu, 12 Feb 2004, Benjamin Herrenschmidt wrote:
> > The current driver in James tree (with generic lcd support) breaks
> > the display on the LT-G chip of the powerbook wallstreet. I don't
> > have time at the moment to dig into every change (there's a lot).
> >
> > The "effect" is that the screen appears to be cut in vertical bands,
> > each of them displaying a slightly offseted version of what should be
> > there with some noise near the right edge.
> >
> > If that symptom rings any bell about what registers can be wrong,
> > that would help me a lot figuring out what's up.
>
> Sounds like a problem with DSP_CONFIG and DSP_ON_OFF.
>
> Check aty_dsp_gt(), either the value of fifo_size or the dsp_* values.

Please take a look at the fifo size in the table of chips in atyfb_base.c.
That value was set incorrectly in 2.4 too.

> BTW, according to Dani=EBl Mantione the DSP calculations in atyfb have al=
ways
> been wrong (but apparently worked on most machines due to sheer luck ;-),=
 so
> you may want to compare with aty_dsp_gt() in current 2.4.

Well, wrong in the sense that the calculations they make are very
different from both Ati's example code and XFree86 code. The original autho=
r
(unknown to me at this time) might have had reasons to code it like this,
but it looks realistic that he simply tried to modify it till it worked
for him.

The code in 2.4 is a slightly size optimized version of the XFree86
code from Marc Aurele la France.

Dani=EBl



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
