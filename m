From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: [Question] Colour management
Date: Sun, 1 Aug 2004 01:18:58 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040731221858.GA17721@sci.fi>
References: <20040722184937.GA11361@sci.fi> <200407260647.03489.adaplas@hotpop.com> <200407302012.36325.alex.kern@gmx.de> <200407311826.27332.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Br2Bw-0006TY-2A
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 15:19:00 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.34)
	id 1Br2Bv-0003t3-Jn
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 31 Jul 2004 15:18:59 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id ACD9ED03B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun,  1 Aug 2004 01:18:58 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200407311826.27332.adaplas@hotpop.com>
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

On Sat, Jul 31, 2004 at 06:26:27PM +0800, Antonino A. Daplas wrote:
> On Saturday 31 July 2004 02:12, Alexander Kern wrote:
> > Hallo Tony,
> >
> > can you explain the deep mining of fb_setcolreg. Background, I observ=
e
> > wrong palette using in 15 and 16 bpp modes, but can not understand, w=
hat is
> > the right approach. In both cases from penguin logo I can see only co=
ntour
> > in honey yellow and blue vertical string jsimmons, pretty scury ;-) T=
he
> > rest is black! The simple text or ncurses applications have always ri=
ght
> > colours. Additionally and only by 16bpp fbi shows blurry images. In 1=
5bpp
> > fbi works fine. fbtest works fine and his penguins look good in all
> > resolutions ?!
>=20
> This will need a long answer. (For mistakes or ommisions, please let me=
 know)
>=20
> fb_setcolreg has 2 functions, initialize info->pseudopalette (if needed=
) and
> initialize the hardware CLUT (if needed).

BTW fb_setcolreg ends up writing half of the registers twice (more if you=
=20
have to fill all slots). It might be better to have two functions. The=20
first one would be the current fb_setcolreg except it wouldn't actually=20
write anything. It would only fill in the correct register values. And th=
e=20
second one would write the clut to hardware. That would avoid the multipl=
e=20
writes.

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
