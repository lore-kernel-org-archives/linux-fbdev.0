From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: Fw: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32
Date: Mon, 14 Mar 2005 07:47:22 +0800
Message-ID: <200503140747.22202.adaplas@hotpop.com>
References: <20050313132844.7270c817.akpm@osdl.org> <9e4733910503131408cd57b01@mail.gmail.com> <20050313151412.060ad5ea.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAcoA-00040P-Pp
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:47:42 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAco9-0005Dm-9Q
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:47:42 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 63FC7FB24D6
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 23:47:27 +0000 (UTC)
In-Reply-To: <20050313151412.060ad5ea.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>, Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, mikpe@csd.uu.se

On Monday 14 March 2005 07:14, Andrew Morton wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > This should be a more general fix. Mikael can you give it a try on ppc
> >  since I don't have one?
> >
> >  If you have time it would also be helpful if you could try building
> >  all of the ppc drivers both as modules and built-in just to make sure
> >  they build.
> >
> >  There are 77 framebuffer drivers on eight platforms that need to be
> >  checked. I tried to get them all right but I don't own all of the
> >  needed hardware.
>
> Confused.  Is Tony's patch OK?
>
> >  ===== drivers/video/Makefile 1.120 vs edited =====
> >  --- 1.120/drivers/video/Makefile	2005-03-10 03:39:10 -05:00
> >  +++ edited/drivers/video/Makefile	2005-03-13 16:56:53 -05:00
> >  @@ -10,6 +10,9 @@
> >
> >   obj-$(CONFIG_FB)                  += fb.o
> >   fb-y                              := fbmem.o fbmon.o fbcmap.o
> >  fbsysfs.o modedb.o
> >  +ifdef $(CONFIG-PPC)
> >  +fb-y				  += macmodes.o
> >  +endif

The problem with generalizing macmodes under CONFIG_PPC is that not all
PPC-based drivers will use macmodes. While most depend on PPC, some require
PPC_OF, and others PPC_PMAC. It's more flexible if each driver does the
selection.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
