From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: matroxfb returning incorrect fix.smem_len?
Date: Thu, 1 Mar 2007 18:58:17 +0200
Message-ID: <20070301165817.GB7907@sci.fi>
References: <45E5D610.5060807@us.ibm.com>
	<Pine.LNX.4.62.0703011420461.766@pademelon.sonytel.be>
	<45E703A6.6080200@us.ibm.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HMobz-0004vl-T8 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 08:58:35 -0800
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HMoby-0007XV-Fq
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 01 Mar 2007 08:58:35 -0800
Content-Disposition: inline
In-Reply-To: <45E703A6.6080200@us.ibm.com>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Geert Uytterhoeven <geert@linux-m68k.org>

On Thu, Mar 01, 2007 at 08:47:34AM -0800, Ian Romanick wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> =

> Geert Uytterhoeven wrote:
> > On Wed, 28 Feb 2007, Ian Romanick wrote:
> >> While doing some work on the pci-rework branch of X.org, I noticed
> >> something strange.  matroxfb correctly detects that my card has 16MiB,
> >> but fix.smem_len is only 8MiB.
> >>
> >> I looked around the matroxfb code and some of the other driver's code,
> >> and I believe that matroxfb is incorrectly setting fix.smem_len.
> >> Matroxfb sets fix.smem_len to (total_memory_size -
> >> memory_used_by_current_mode).  Other drivers, such as nvidiafb do not =
do
> >> this.
> > =

> > Did matroxfb detect a dual-head capable card?
> =

> I did some more digging on this yesterday.  It seems that ydstorg.bytes
> is always zero, so what I originally thought was the problem is not the
> problem.
> =

> Looking at the logs, it looks like it is detecting my card as dual-head,
> but it's not.  The weird thing is that I added a printk in
> matroxfb_update_fix to show what smem_len is begin set to.  Before I
> start X, it prints 16MiB twice.  As soon as X starts, it prints 8MiB and
> returns that value to the X server.
> =

> I'm not quite sure what to make of that.

IIRC someone using DirectFB noticed something similar. I didn't bother =

investigating it much though.

Also matroxfb will never report > 16MB. We have a patch in DirectFB to =

fix that but IIRC it was not accepted into matroxfb because the matroxfb =

accel code can't actually handle it.

-- =

Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=3Djoin.php&p=3Dsourceforge&CID=3DDE=
VDEV
