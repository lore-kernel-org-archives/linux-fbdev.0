From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Fri, 4 Mar 2005 13:50:16 -0500
Message-ID: <9e473391050304105022d7394c@mail.gmail.com>
References: <9e47339105030102003ee47879@mail.gmail.com>
	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
	 <9e47339105030210135dbe71ed@mail.gmail.com>
	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>
	 <9e47339105030320085331555a@mail.gmail.com>
	 <4228AC6B.9070503@worldonline.fr>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7HsS-0002Dh-78
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:50:20 -0800
Received: from rproxy.gmail.com ([64.233.170.205])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7HsR-000267-PO
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:50:20 -0800
Received: by rproxy.gmail.com with SMTP id z35so1178490rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Mar 2005 10:50:19 -0800 (PST)
In-Reply-To: <4228AC6B.9070503@worldonline.fr>
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
Cc: James Simmons <jsimmons@pentafluge.infradead.org>

On Fri, 04 Mar 2005 19:43:55 +0100, Sylvain Meyer
<sylvain.meyer@worldonline.fr> wrote:
>=20
>=20
> Jon Smirl a =E9crit:
>=20
> > Is this why we don't have fbdev drivers
> >for these chips?
> >
> >
> >
>     There is an intelfb fbdev driver. Not very actively maintained,
> sorry for that, but i did a port to kernel 2.6 and try to get some spare
> time to update it. The driver can change modes and i also did a driver
> for TV-Out, not yet DFP/LFP (not in the kernel for now).

Has Intel released documentation for mode setting on these chips or
did you reverse engineer it?

>=20
> Sylvain
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.
> http://ads.osdn.com/?ad_ide95&alloc_id=14396&opclick
> _______________________________________________
> Linux-fbdev-devel mailing list
> Linux-fbdev-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel
>=20


--=20
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
