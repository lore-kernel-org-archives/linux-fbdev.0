From: Sylvain Meyer <sylvain.meyer@worldonline.fr>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Fri, 04 Mar 2005 19:43:55 +0100
Message-ID: <4228AC6B.9070503@worldonline.fr>
References: <9e47339105030102003ee47879@mail.gmail.com>	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>	 <9e47339105030210135dbe71ed@mail.gmail.com>	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org> <9e47339105030320085331555a@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7Hnc-000220-EY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:45:20 -0800
Received: from smtp12.wanadoo.fr ([193.252.22.20])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7HnZ-00054x-Rb
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Mar 2005 10:45:20 -0800
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
Content-Type: text/plain; charset="iso-8859-1"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net
Cc: James Simmons <jsimmons@pentafluge.infradead.org>



Jon Smirl a =E9crit:

> Is this why we don't have fbdev drivers
>for these chips?
>
> =20
>
    There is an intelfb fbdev driver. Not very actively maintained,=20
sorry for that, but i did a port to kernel 2.6 and try to get some spare=20
time to update it. The driver can change modes and i also did a driver=20
for TV-Out, not yet DFP/LFP (not in the kernel for now).

Sylvain





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
