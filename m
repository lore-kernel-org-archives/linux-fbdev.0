From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: video dir reorg
Date: 15 Jan 2003 22:38:31 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1042666710.3186.40.camel@thor>
References: <Pine.LNX.4.44.0301150035470.23774-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from netline-be1.netline.ch ([195.141.226.32])
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18YvF6-0001oN-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 15 Jan 2003 13:38:36 -0800
In-Reply-To: <Pine.LNX.4.44.0301150035470.23774-100000@phoenix.infradead.org>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="iso-8859-1"
To: James Simmons <jsimmons@infradead.org>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, Jon Smirl <jonsmirl@yahoo.com>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Mit, 2003-01-15 at 01:37, James Simmons wrote:=20
> > There is a response of linus in the mailing list archive about this, i
> > don't remember nor checked if it was only the first time, or not. I
> > think the objection was about complicate to supervise diffs.
>=20
> Yes. The DRI people want to keep there work seperate from us.

While I hope there will be some form of cooperation between framebuffer
devices and the DRM in the future, I do think they basically serve very
different purposes so I don't think merging them makes sense.

> > Also, i think the drm drivers should compile not only on linux, but on
> > other oses too (BSDs at least).
>=20
> That will be difficult. The VM layer to BSD is very very different from=20
> linux. There is no way they coudl use the same code set for both without =

> making a mess.=20

Probably, but keeping all code separate for all supported OSs would be
at least as big a mess, so we share as much code as possible via a
template mechanism. The BSD specific parts aren't in the Linux kernel of
course.

> > Also, i believe some of the XFree86 guys don't like fbdevs.
> =20
> :-(

Luckily, those aren't part of the DRI project AFAICT. On the contrary,
several DRI developers have declared interest in supporting framebuffer
devices, and at least one of them is working on 'an embedded radeon 3d
driver that lives on top of fbdev' in Mesa CVS.


--=20
Earthling Michel D=E4nzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast



-------------------------------------------------------
This SF.NET email is sponsored by: A Thawte Code Signing Certificate=20
is essential in establishing user confidence by providing assurance of=20
authenticity and code integrity. Download our Free Code Signing guide:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0028en
