From: Alexander Kern <alex.kern@gmx.de>
Subject: Re: atyfb expert needed
Date: Fri, 13 Feb 2004 16:41:28 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200402131641.29028.alex.kern@gmx.de>
References: <1076537453.868.123.camel@gaston> <Pine.GSO.4.58.0402121024540.7297@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1ArfTW-0006Aj-Oz
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 Feb 2004 07:43:30 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1ArfOm-0008VO-QC
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 13 Feb 2004 07:38:36 -0800
In-Reply-To: <Pine.GSO.4.58.0402121024540.7297@waterleaf.sonytel.be>
Content-Disposition: inline
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net

Am Donnerstag, 12. Februar 2004 10:29 schrieb Geert Uytterhoeven:
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
>
> BTW, according to Dani=EBl Mantione the DSP calculations in atyfb have al=
ways
> been wrong (but apparently worked on most machines due to sheer luck ;-),
> so you may want to compare with aty_dsp_gt() in current 2.4.
>
> Gr{oetje,eeting}s,
>
> 						Geert
>

Hi,
mach64_ct.c(where aty_dsp_gt is) from James tree should be identical with=20
Daniel'S 2.4 tree. If not, please send me the diff.

Regards Alex


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
