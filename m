From: David Eger <eger@havoc.gtf.org>
Subject: Re: [PATCH][RIVAFB]: Updates to rivafb driver
Date: Wed, 16 Jun 2004 20:16:34 -0400
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <20040617001634.GA6013@havoc.gtf.org>
References: <200406160406.07060.adaplas@hotpop.com> <200406161353.51195.adaplas@hotpop.com> <20040616173429.GA8601@havoc.gtf.org> <200406170629.09691.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BakaA-0002iZ-SR
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 17:16:42 -0700
Received: from havoc.gtf.org ([216.162.42.101])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BakaA-0005dj-IT
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 16 Jun 2004 17:16:42 -0700
Content-Disposition: inline
In-Reply-To: <200406170629.09691.adaplas@hotpop.com>
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
To: adaplas@pol.net, benh@kernel.crashing.org
Cc: James Simmons <jsimmons@infradead.org>, Andrew Morton <akpm@osdl.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

On Thu, Jun 17, 2004 at 06:29:09AM +0800, Antonino A. Daplas wrote:
> On Thursday 17 June 2004 01:34, David Eger wrote:
> > And yes, the capabilities patch makes your driver slow.
> > But setting the proper flags makes it fast again ;-)
>=20
> Do you mind submitting a patch yourself?  It's probably a 1 liner patch=
,=20
> unless we also modify rivafb to use cfb_* drawing functions depending o=
n
> the setting of var->accel_flags.

I'd be happy to.  I'll forward it to Andrew+James tomorrow.
( I'm currently at the GNU/yak caf=E9 night in Atlanta, away=20
  from my TNT2 testing box )

> > The driver still doesn't play nice with the evil binary nvidia driver=
s,
> > but then, that's expected.  (It'd be nice if changing from X to aa
> > console didn't *crash my machine* though.)
>=20
> Yeah, even with XOrg/Free86 nv driver, it hangs.  Don't really know the
> exact solution, probably a complete re-initialization of the hardware
> when switching from X.  But this will require that fbcon recognizes
> a switch from X itself which it currently doesn't (unless I'm mistaken)=
.

Back in February, BenH said he was going to work on a patch for this:

http://www.uwsg.iu.edu/hypermail/linux/kernel/0402.2/0247.html

Hey Ben, what ever became of this?  Are there now hooks for this or=20
something?

-dte


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
