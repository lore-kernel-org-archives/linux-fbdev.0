From: "Alex Deucher" <alexdeucher@gmail.com>
Subject: Re: radeonfb doesn't work with an ati X800 pcie
	card
Date: Wed, 28 Mar 2007 16:42:42 -0500
Message-ID: <a728f9f90703281442q1aa19fc0l7a1ab844cc666373@mail.gmail.com>
References: <46093D22.3090401@gmx.net> <460AD932.5080903@gmx.net>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWg8k-0006Oe-C7 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 14:57:10 -0700
Received: from wx-out-0506.google.com ([66.249.82.226])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HWful-0002rO-IQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 28 Mar 2007 14:42:43 -0700
Received: by wx-out-0506.google.com with SMTP id i30so4412323wxd
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 28 Mar 2007 14:42:42 -0700 (PDT)
In-Reply-To: <460AD932.5080903@gmx.net>
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Jimmy.Jazz@gmx.net, linux-fbdev-devel@lists.sourceforge.net

On 3/28/07, Jimmy Jazz <Jimmy.Jazz@gmx.net> wrote:
> Jimmy Jazz a =E9crit :
> >
> > Certainly not related to the current issue, radeonfb and x11 disagree
> > how many memories the video card really has. radeonfb found half the
> > content and detects the dvi connector where the flat screen is
> > attached to quite well but identifies a CRT monitor instead of a TMDS.
>
> this one was easy,  the size was just limited to less then 256 :)
>

It's not that easy.  Not all radeons can expose more than 128 MB or
ram to the CPU.  You also have to make sure the PCI aperture is big
enough, some are only 64 or 128 MB while the card may actually have
128 to 256 or more ram.  Take a look at the radeon Xorg driver more
more info.

Alex

> # diff -ruN radeon_base.c.patched2 radeon_base.c
> --- radeon_base.c.patched2      2007-03-26 14:15:47.000000000 +0200
> +++ radeon_base.c       2007-03-28 23:03:53.000000000 +0200
> @@ -2139,10 +2139,6 @@
>         /* mem size is bits [28:0], mask off the rest */
>         rinfo->video_ram =3D tmp & CONFIG_MEMSIZE_MASK;
>
> -       /* Limit memory to 128 megs for now */
> -       if (rinfo->video_ram > MAX_VRAM)
> -               rinfo->video_ram =3D MAX_VRAM;
> -
>         /*
>          * Hack to get around some busted production M6's
>          * reporting no ram
>
>

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
