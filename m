From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: [framebuffer] broken again :/
Date: Thu, 22 Jul 2004 14:51:35 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200407221451.37004.adaplas@hotpop.com>
References: <20040721224515.1b76193e.akpm@osdl.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BnXQh-00025R-5P
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Jul 2004 23:51:47 -0700
Received: from twix.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BnXQg-0008Pu-NF
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 21 Jul 2004 23:51:47 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by twix.hotpop.com (Postfix) with SMTP id B2FB81011545
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 22 Jul 2004 06:31:50 +0000 (UTC)
In-Reply-To: <20040721224515.1b76193e.akpm@osdl.org>
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, linux-fbdev-devel@lists.sourceforge.net
Cc: pluto@pld-linux.org

On Thursday 22 July 2004 13:45, Andrew Morton wrote:
> Begin forwarded message:
>
> Date: Wed, 21 Jul 2004 16:00:44 +0200
> From: Pawe=B3 Sikora <pluto@pld-linux.org>
> To: Andrew Morton <akpm@osdl.org>
> Subject: [framebuffer] broken again :/
>
>
> Hi,
>
> # vanilla 2.8.8rc2...
>
> I switch *all* consoles to 1024x768(75Hz,32bpp) (rivafb) mode.
> (http://149.156.124.14/~pluto/tmp/kernel/step1.png)
> Even without launching a bootsplash while switching
> to another console I observe below effect:
> (strange resolution and horrible aspect ratio)

The problem is that the bootsplash code uses vc_resize() to create a 'box'=
=20
effect (small viewport within the display).  Calling vc_resize() has no=20
effect in 2.4 as fbcon does not have a con_resize hook, but in 2.6, calling=
=20
vc_resize() is equivalent to doing an fbset.  This produces the unusual=20
aspect ratio and resolution.
=20
> http://149.156.124.14/~pluto/tmp/kernel/step2.png
> I switch consoles again to 1024x768(75Hz,32bpp) mode
> and get an oops:
> http://149.156.124.14/~pluto/tmp/kernel/step3.png

The oops here is from the bootsplash code, perhaps brought about  by the=20
unexpected mode change.

>
> # vanilla 2.6.7...
>
> I switch *all* consoles to 1024x768(75Hz,32bpp) (rivafb) mode.
> While switching to another console everything is all right.
> (no resolution/aspect changes, no oops).

Yes, fbset calls are ignored in pre 2.6.7-mm1 kernels, so this is expected.=
 =20
Latest kernel snapshots already handle fbset requests.

One solution for the bootsplash code in 2.6 is for it to disable the=20
con_resize/fbcon_resize hook in fbcon.c. You should let the bootsplash=20
developers know about this complication.=20

=46or rivafb, enable DDC/I2C support in your kernel config and try booting =
with=20
the 'strictmode' option. If you do not have a GTF capable display and=20
assuming your monitor can do DDC and has a valid EDID block, the 'strictmod=
e'=20
option will force rivafb to restrict itself to using video modes creaed fro=
m=20
the EDID block. This, hopefully, avoids the unusual aspect ratio and=20
resolution change.

> Framebuffer in 2.6.8-xx is broken (again) :/
> Writing to lkml =3D=3D Writing to /dev/null :/

Next time, write to fbdev-devel list for any fbdev/fbcon related problems.

Tony




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
