From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Changing modes with fbset
Date: Tue, 6 Jan 2004 16:23:13 +0100 (MET)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0401061621160.5752@waterleaf.sonytel.be>
References: <3FDBB97F.4070207@undead.cc>  <Pine.LNX.4.44.0401060005511.7347-100000@phoenix.infradead.org>
  <20040106002822.GB442@guug.org>  <1073349349.780.181.camel@gaston>
 <1073389131.25197.30.camel@thor.asgaard.local>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1Adt3I-0005Nn-0y
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 07:23:28 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Adt3H-0000ni-F2
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 06 Jan 2004 07:23:27 -0800
In-Reply-To: <1073389131.25197.30.camel@thor.asgaard.local>
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
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Otto Solares <solca@guug.org>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Tue, 6 Jan 2004, Michel [ISO-8859-1] D=E4nzer wrote:
> On Tue, 2004-01-06 at 01:35, Benjamin Herrenschmidt wrote:
> > Then, we probably want some way to also enable mirroring instead of
> > dual head...
>
> Crazy idea: What would break if it defaulted to mirroring? :) You could
> achieve true multihead via panning or something...

Not that crazy!

It would revert the current con2fbmap approach: instead of mapping virtua=
l
consoles to frame buffer devices, it would allow to map frame buffer devi=
ces to
a virtual console or to another frame buffer device...

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
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
