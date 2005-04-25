From: Miles Lane <miles.lane@gmail.com>
Subject: Re: Re: [PATCH 1/6] nvidiafb: ioremap and i2c fixes
Date: Sun, 24 Apr 2005 22:36:42 -0700
Message-ID: <a44ae5cd0504242236365088ba@mail.gmail.com>
References: <200504161313.25574.adaplas@hotpop.com>
	 <20050423174013.3006852f.akpm@osdl.org>
	 <200504251121.20530.adaplas@hotpop.com>
	 <20050424220309.77617eed.rddunlap@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPwH9-00035W-HD
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:36:55 -0700
Received: from wproxy.gmail.com ([64.233.184.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DPwH7-0000MH-BG
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Apr 2005 22:36:55 -0700
Received: by wproxy.gmail.com with SMTP id 69so1160299wra
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 24 Apr 2005 22:36:42 -0700 (PDT)
In-Reply-To: <20050424220309.77617eed.rddunlap@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: adaplas@hotpop.com, akpm@osdl.org, adaplas@pol.net

On 4/24/05, Randy.Dunlap <rddunlap@osdl.org> wrote:
> On Mon, 25 Apr 2005 11:21:20 +0800 Antonino A. Daplas wrote:
>=20
> | On Sunday 24 April 2005 08:40, Andrew Morton wrote:
> | > "Antonino A. Daplas" <adaplas@hotpop.com> wrote:
> | > > - Add 'vram' option to specify amount of video RAM to remap
> | > >  - Limit remap size to 128 MIB
> | >
> | > Am I right in believing that if someone has a 256MB card and doesn't =
know
> | > about the `vram' option, their card will fail to work, because the 12=
8MB
> | > vmalloc() will fail?
> | >
> |
> | I thought that a 128MiB vmalloc will work.
>=20
> The default vmalloc total size is 128 MB, but the kernel always
> requires a "guard page", which cannot be allocated, so the
> total allocation fails.
>=20
> I tried to make a patch that sets the default vmalloc total size
> to 128 MB + PAGE_SIZE, but Miles reported that the driver's
> vmalloc() call still failed...

Which seems to beg a couple of questions:
How much memory is _really_ trying to get allocated when I boot
with no vmalloc argument.  Does this point to some problem in=20
the nvidiafb code?  Does the fact that specifying vmalloc=3D128M
does not fix the problem indicate that something about my video
card won't work with less than 256Mb vmalloced, or is this a
driver issue?

Thanks,
        Miles


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
