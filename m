From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Subject: Re: fbcon=map:... broke with 2.6.7 -> 2.6.9-rc3 transition
Date: Sat, 16 Oct 2004 03:06:47 +0300
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20041016000647.GA6807@sci.fi>
References: <20041006100310.GA14889@sci.fi> <200410061904.10630.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CIc60-0000qg-BK
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 17:06:52 -0700
Received: from gw02.mail.saunalahti.fi ([195.197.172.116])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CIc5y-0000AK-WE
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Oct 2004 17:06:52 -0700
Received: from kuori.saunalahti.fi (kuori.saunalahti.fi [195.197.175.23])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id A9EFF2DFC7
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Oct 2004 03:06:47 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <200410061904.10630.adaplas@hotpop.com>
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

On Wed, Oct 06, 2004 at 07:04:10PM +0800, Antonino A. Daplas wrote:
> On Wednesday 06 October 2004 18:03, Ville Syrj=E4l=E4 wrote:
> > I just upgraded from 2.6.7 to 2.6.9-rc3 and the fbcon=3Dmap:... optio=
n
> > stopped working.
> >
> > My system has two matrox cards with /dev/fb1 being the head I want to=
 use.
> > So I boot with fbcon=3Dmap:111111. With 2.6.9-rc3 all I could see was
> > some garbage and I had to log in via network to run con2fb manually. =
I
> > don't have a monitor attached to the other card so I'm not sure if th=
e
> > output went there.
> >
> > I seem to recall some patches from Tony regarding fbcon options. Were
> > those applied to 2.6.9-rc3?
>=20
> No, it's still in the mm tree.  It won't get into mainline until 2.6.10=
, I think.

2.6.9-rc4-mm1 fixed the issue for me. Sorry for the noise :)

--=20
Ville Syrj=E4l=E4
syrjala@sci.fi
http://www.sci.fi/~syrjala/


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
