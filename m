From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: [Linux-fbdev-devel] fbdv/fbcon pending problems
Date: Thu, 26 Feb 2004 16:26:57 +0100
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1077809216.2681.107.camel@thor.asgaard.local>
References: <20040224214106.GA17390@guug.org>
	 <Pine.LNX.4.44.0402250118210.24952-100000@phoenix.infradead.org>
	 <20040225031553.GC17390@guug.org>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <20040225031553.GC17390@guug.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="iso-8859-1"
To: Otto Solares <solca@guug.org>
Cc: James Simmons <jsimmons@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel list <linux-kernel@vger.kernel.org>

On Wed, 2004-02-25 at 04:15, Otto Solares wrote:=20
>=20
> 4. Memory mappings.
> 	We can currently map the vmem and io regions in userspace.  It
> 	current exists problems with highmem but in short it simply works
> 	for dumb chips or programable chips so specialized libs (like
> 	mesa-solo) can do a decent job.

I hope Mesa-solo doesn't bang the chip directly, does it? That would
mean root only.

And while we're brainstorming... :)

I'm not sure being able to map the whole video RAM is a good idea in th=
e
long run either; at some point we probably need a centralized memory
manager, and I think ideally it should map the allocated regions
separately (which could allow for moving them between video RAM, GART
and system RAM transparently, e.g.) and only allow to use them for
acceleration by opaque handles (via the DRM or whatever). This would be
quite a lot of stuff in the kernel, but I'm not sure it can be done
safely in user space...


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI dev=
eloper
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaen=
zer
