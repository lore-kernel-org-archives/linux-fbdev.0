From: Michel =?UTF-8?Q?D=C3=A4nzer?= <daenzer@debian.org>
Subject: Bug#347186: [Linux-fbdev-devel] Re: Bug#347186: linux-image-2.6.14-2-alpha-generic: garbled Matrox framebuffer
Date: Thu, 12 Jan 2006 11:13:22 +0100
Message-ID: <1137060802.3941.92.camel@localhost>
References: <20060109090849.GB3481@tennyson.dodds.net>
	 <20060109093517.GA23253@localhost.localdomain>
	 <20060109105146.GE3481@tennyson.dodds.net> <20060111102827.GF7691@nancy>
	 <43C4EAD4.2090704@pol.net> <20060109090849.GB3481@tennyson.dodds.net>
	 <20060109093517.GA23253@localhost.localdomain>
	 <20060109105146.GE3481@tennyson.dodds.net> <20060111102827.GF7691@nancy>
	 <20060112051522.GP11974@tennyson.dodds.net>
Reply-To: Michel =?UTF-8?Q?D=C3=A4nzer?= <daenzer@debian.org>,
	347186@bugs.debian.org
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <bounce-debian-bugs-dist=glddb-debian-bugs-dist=m.gmane.org@lists.debian.org>
Resent-To: debian-bugs-dist@lists.debian.org
Resent-Message-ID: <handler.347186.B347186.11370608321658@bugs.debian.org>
In-Reply-To: <20060112051522.GP11974@tennyson.dodds.net>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:debian-bugs-dist@lists.debian.org>
List-Help: <mailto:debian-bugs-dist-request@lists.debian.org?subject=help>
List-Subscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=subscribe>
List-Unsubscribe: <mailto:debian-bugs-dist-request@lists.debian.org?subject=unsubscribe>
Content-Type: text/plain; charset="iso-8859-1"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: maximilian attems <maks@sternwelten.at>, "Antonino A. Daplas" <adaplas@pol.net>, 347186@bugs.debian.org

On Wed, 2006-01-11 at 21:15 -0800, Steve Langasek wrote:
> On Wed, Jan 11, 2006 at 07:24:04PM +0800, Antonino A. Daplas wrote:
>=20
> > The "UseFBDev" option was added to X so it can cooperate with fbcon (ie=
, allows
> > X to restore the console state by using the fbdev API ).  In 2.6, fbcon=
 has its
> > own way of restoring its own state so the "UseFBDev" option is not need=
ed, and in
> > your case, is counterproductive.
>=20
> Aha, didn't know that.  It had been my impression that this option meant
> using the fbdev API for all vidcard access;

It does, for the things the fbdev API provides.


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer
