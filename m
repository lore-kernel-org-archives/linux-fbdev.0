From: Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: [PATCH][2.6.11-mm3] CONFIG_FB_ATY
 linkage error on PPC32
Date: Sun, 13 Mar 2005 17:49:03 -0800
Message-ID: <20050313174903.272f39b3.akpm@osdl.org>
References: <20050313132844.7270c817.akpm@osdl.org>
	<200503140657.45864.adaplas@hotpop.com>
	<9e473391050313150644027e09@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAei6-0002vN-VL
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 17:49:34 -0800
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DAei5-0005hG-GP
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 17:49:34 -0800
In-Reply-To: <9e473391050313150644027e09@mail.gmail.com>
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
Cc: adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, mikpe@csd.uu.se

Jon Smirl <jonsmirl@gmail.com> wrote:
>
> On Mon, 14 Mar 2005 06:57:43 +0800, Antonino A. Daplas
> <adaplas@hotpop.com> wrote:
> 
> That will work too. FB_MACMODES should depend on PPC so that it
> doesn't appear on x86.

OK, thanks.

I didn't apply anything.  Tony, could you queue that one up please?


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
