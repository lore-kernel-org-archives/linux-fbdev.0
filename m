From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: 2.6.12-rc1-mm2 -- nvidiafb driver gives black screen
Date: Fri, 22 Apr 2005 20:12:17 -0400
Message-ID: <a44ae5cd05042217122613bac4@mail.gmail.com>
References: <a44ae5cd0503242023233dc23f@mail.gmail.com>
	 <200504141351.42971.adaplas@hotpop.com>
	 <20050414191323.10d7d435.khali@linux-fr.org>
	 <200504151107.49810.adaplas@hotpop.com>
	 <a44ae5cd05041601211c292316@mail.gmail.com>
	 <a44ae5cd05042022512e840cfa@mail.gmail.com>
	 <20050421092215.3e6d8be4.rddunlap@osdl.org>
	 <20050421113645.4768967d.rddunlap@osdl.org>
	 <a44ae5cd05042217031c6fbbf5@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DP8G2-0002RC-R3
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 17:12:26 -0700
Received: from wproxy.gmail.com ([64.233.184.200])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DP8G1-00058E-FY
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 22 Apr 2005 17:12:26 -0700
Received: by wproxy.gmail.com with SMTP id 69so867862wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 22 Apr 2005 17:12:17 -0700 (PDT)
In-Reply-To: <a44ae5cd05042217031c6fbbf5@mail.gmail.com>
Content-Disposition: inline
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
Content-Type: text/plain; charset="us-ascii"
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@pol.net, khali@linux-fr.org, akpm@osdl.org

Okay, it also fails with Antonio's patches applied in addition to yours.

Thanks,
           Miles

On 4/22/05, Miles Lane <miles.lane@gmail.com> wrote:
> Hi Randy,
>=20
> I tried your patch to a clean 2.6.12-rc2-mm3 tree (I backed out
> Antonio's patches).  The result of not having a vmalloc=3D in the boot
> arguments is that the screen is still black:
>=20
> allocation failed: out of vmalloc space - use vmalloc=3D<size> to increas=
e size.
> nvidiafb: cannot ioremap FB base
>=20
> I will try again with Antonio's patches added.
>=20
>        Miles


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
