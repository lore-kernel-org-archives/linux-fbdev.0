From: Jim Hague <jim.hague@acm.org>
Subject: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Mon, 07 Mar 2005 19:44:24 -0000 (GMT)
Message-ID: <XFMail.20050307194424.jim.hague@acm.org>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8O9e-0004pB-8s
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 11:44:38 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1D8O9c-00067x-Iq
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 11:44:38 -0800
In-Reply-To: <Pine.LNX.4.60.0503052355320.12643@poirot.grange>
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
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On 05-Mar-2005 Guennadi Liakhovetski wrote:
> Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, tex=
t=20
> becomes orange, penguins look sick (not sharp). X starts and runs norma=
l=20
> (doesn't use fb), switching to vt not possible any more. Disabling=20
> fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the=20
> problem.

I've just tried a stock 2.6.11 fresh from the tarball, and I see some of =
what
you are seeing.

I don't see any problems with text colour or images. Text is white, Tux i=
s 100%
normal. This on a single processor K6/2-450 with a Creative Graphics Blas=
ter
Exxtreme, BTW.

However, I do see the problem switching back to a vt from X. In fact it d=
oes
work, except that the video is blanked. This is a bug in pm2fb.c exposed =
by
recent changes to fbcon. Please try this fix (works for me) and let me kn=
ow if
it restores normal service for you too.

--- drivers/video/pm2fb.c.orig  2005-03-07 15:35:28.000000000 +0000
+++ drivers/video/pm2fb.c       2005-03-07 18:34:13.000000000 +0000
@@ -747,7 +747,7 @@
        }
        if ((info->var.vmode & FB_VMODE_MASK)=3D=3DFB_VMODE_DOUBLE)
                video |=3D PM2F_LINE_DOUBLE;
-       if (info->var.activate=3D=3DFB_ACTIVATE_NOW)
+       if ((info->var.activate & FB_ACTIVATE_MASK)=3D=3DFB_ACTIVATE_NOW)
                video |=3D PM2F_VIDEO_ENABLE;
        par->video =3D video;

Returning to your problems with text colour and images, can you try
with CONFIG_FB_PM2_FIFO_DISCONNECT=3Dn and see if that makes a difference=
.

Thanks.

--=20
Jim Hague - jim.hague@acm.org          Never trust a computer you can't l=
ift.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=3D6595&alloc_id=3D14396&op=3Dclick
