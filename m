From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: fbdev cursor part 1.
Date: Mon, 23 Feb 2004 14:51:07 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0402231449040.14277@waterleaf.sonytel.be>
References: <Pine.LNX.4.44.0402222234120.2390-100000@phoenix.infradead.org>
 <1077496550.5960.9.camel@gaston> <Pine.GSO.4.58.0402231156040.14277@waterleaf.sonytel.be>
 <1077533958.5942.42.camel@gaston> <Pine.GSO.4.58.0402231343270.14277@waterleaf.sonytel.be>
 <20040223132151.GA7255@sci.fi>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AvGbw-00041A-GI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 05:59:04 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AvGJ0-00035T-Js
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 23 Feb 2004 05:39:30 -0800
In-Reply-To: <20040223132151.GA7255@sci.fi>
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
To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Mon, 23 Feb 2004, Ville [iso-8859-1] Syrj=E4l=E4 wrote:
> BTW would it be possible to add a new accelerator type for Pro chips. I=
'd
> like to identify Pro chips in my DirectFB driver because there are a fe=
w
> important differences between Pro and older models. Othwerwise I'm goin=
g
> to have to the same thing I did with matrox cards and use /proc/bus/pci=
 :(

Can't you just check CONFIG_CHIP_ID in your DirectFB driver?

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
