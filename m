From: Jim Hague <jim.hague@acm.org>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Tue, 22 Mar 2005 09:41:06 -0000 (GMT)
Message-ID: <XFMail.20050322094106.jim.hague@acm.org>
References: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDftA-0004zc-AV
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 01:41:28 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DDft8-00054i-Kg
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 22 Mar 2005 01:41:28 -0800
In-Reply-To: <Pine.LNX.4.60.0503220030230.12537@poirot.grange>
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
To: Andrew Morton <akpm@osdl.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On 21-Mar-2005 Guennadi Liakhovetski wrote:
> On Mon, 21 Mar 2005, Andrew Morton wrote:
>> Guennadi, could you please confirm that
>>=20
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-r=
c1/2.6.
>> 12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
>>=20
>> fixes this one?
>=20
> As discussed with Jim on linux-fbdev-devel this patch fixes the vt / X=20
> switching problem. We still don't know why starting with 2.4.11 I have =
to=20
> switch CONFIG_FB_PM2_FIFO_DISCONNECT off to restore colours / images.
> [...]
> I traced this breakage down to the patch to=20
> pm2fb.c after 2.6.10-rc2. Jim wanted to try to reproduce this problem w=
ith=20
> my fb-geometry / colour settings, but I haven't heard from him since th=
en,=20

FIrst off, so we're all clear, the problem with vt/X switching was defini=
tely a
pm2fb bug exposed by chages in fbcon, and is definitely fixed by the abov=
e
patch. Please apply.

As to Guennadi's problem with colours and images, I've been trying to
reproduce locally without success, hence silence. My pm2fb-on-Sparc
correspondent hasn't seen this either, and I've had no other reports.

I have one possible clue, which I'll pursue with Guennadi off-list.

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't l=
ift.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
