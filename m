From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: Hotplug blacklist and video devices
Date: Fri, 18 Feb 2005 18:35:49 -0500
Message-ID: <9e473391050218153527cbb893@mail.gmail.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
	 <9e47339105021813146cf69759@mail.gmail.com>
	 <1108767531.5631.29.camel@thor.asgaard.local>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2Hf5-0003K6-8i
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 15:35:51 -0800
Received: from rproxy.gmail.com ([64.233.170.194])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2Hf3-0006hH-RZ
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 15:35:51 -0800
Received: by rproxy.gmail.com with SMTP id z35so6082rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 15:35:49 -0800 (PST)
In-Reply-To: <1108767531.5631.29.camel@thor.asgaard.local>
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
To: =?ISO-8859-1?Q?Michel_D=E4nzer?= <michel@daenzer.net>
Cc: linux-fbdev-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>

On Fri, 18 Feb 2005 17:58:51 -0500, Michel D=E4nzer <michel@daenzer.net> wr=
ote:
> > For example I'm looking at making changes to DRM such that DRM will
> > require the corresponding framebuffer driver to be loaded.
>=20
> Ignoring my suspicion that people won't like stuff getting forced down
> their throats like this (why would a DRM _require_ a framebuffer
> device?), does the hotplug blacklisting of the framebuffer devices
> matter at all if the DRM depends on them, i.e. won't they be loaded
> regardless when the DRM is loaded?

There is no mechanism for getting a hotplug remove event into a driver
like DRM that doesn't attach to the PCI device.

--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
