From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32
Date: Sun, 13 Mar 2005 15:14:12 -0800
Message-ID: <20050313151412.060ad5ea.akpm@osdl.org>
References: <20050313132844.7270c817.akpm@osdl.org>
	<9e47339105031313553994f15a@mail.gmail.com>
	<9e4733910503131408cd57b01@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAcIA-0002QZ-Eo
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:14:38 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DAcI8-0002rT-Vw
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:14:38 -0800
In-Reply-To: <9e4733910503131408cd57b01@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net, mikpe@csd.uu.se

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> This should be a more general fix. Mikael can you give it a try on ppc
>  since I don't have one?
> 
>  If you have time it would also be helpful if you could try building
>  all of the ppc drivers both as modules and built-in just to make sure
>  they build.
> 
>  There are 77 framebuffer drivers on eight platforms that need to be
>  checked. I tried to get them all right but I don't own all of the
>  needed hardware.
> 

Confused.  Is Tony's patch OK?

>  ===== drivers/video/Makefile 1.120 vs edited =====
>  --- 1.120/drivers/video/Makefile	2005-03-10 03:39:10 -05:00
>  +++ edited/drivers/video/Makefile	2005-03-13 16:56:53 -05:00
>  @@ -10,6 +10,9 @@
>   
>   obj-$(CONFIG_FB)                  += fb.o
>   fb-y                              := fbmem.o fbmon.o fbcmap.o
>  fbsysfs.o modedb.o
>  +ifdef $(CONFIG-PPC)
>  +fb-y				  += macmodes.o
>  +endif
>   fb-objs                           := $(fb-y)

Your email client is mangling whitespace.  This won't apply.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
