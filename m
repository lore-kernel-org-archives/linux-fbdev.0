From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Subject: Re: Re: Hotplug blacklist and video devices
Date: Fri, 18 Feb 2005 17:58:51 -0500
Message-ID: <1108767531.5631.29.camel@thor.asgaard.local>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2H5k-0001Ps-LU
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 14:59:20 -0800
Received: from mail-res.bigfish.com ([63.161.60.61] helo=mail31-res-R.bigfish.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D2H5j-0001we-A2
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 14:59:20 -0800
In-Reply-To: <9e47339105021813146cf69759@mail.gmail.com>
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
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
Cc: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>

On Fri, 2005-02-18 at 16:14 -0500, Jon Smirl wrote:
> On Fri, 18 Feb 2005 16:08:22 -0500, Bill Nottingham <notting@redhat.com> =
wrote:
> > Under Fedora (and RHEL), they're there because we generally
> > don't want to load them unless the user asked for them.
>=20
> Is there a specific reason why they are blocked?=20

One reaseon might be that the framebuffer devices can cause problems,
e.g. with proprietary X drivers.

> For example I'm looking at making changes to DRM such that DRM will
> require the corresponding framebuffer driver to be loaded.

Ignoring my suspicion that people won't like stuff getting forced down
their throats like this (why would a DRM _require_ a framebuffer
device?), does the hotplug blacklisting of the framebuffer devices
matter at all if the DRM depends on them, i.e. won't they be loaded
regardless when the DRM is loaded?


--=20
Earthling Michel D=C3=A4nzer      |     Debian (powerpc), X and DRI develop=
er
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=3Ddaenzer



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
