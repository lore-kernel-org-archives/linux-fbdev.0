From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32
Date: Mon, 14 Mar 2005 07:09:52 +0800
Message-ID: <200503140709.52961.adaplas@hotpop.com>
References: <20050313132844.7270c817.akpm@osdl.org> <200503140657.45864.adaplas@hotpop.com> <9e473391050313150644027e09@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAcDp-00028M-S5
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:10:09 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAcDo-0002TV-AF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 15:10:09 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 9D55CFB0FF7
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 23:09:54 +0000 (UTC)
In-Reply-To: <9e473391050313150644027e09@mail.gmail.com>
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
To: Jon Smirl <jonsmirl@gmail.com>, adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Mikael Pettersson <mikpe@csd.uu.se>

On Monday 14 March 2005 07:06, Jon Smirl wrote:
> On Mon, 14 Mar 2005 06:57:43 +0800, Antonino A. Daplas
> <adaplas@hotpop.com> wrote:
>
> That will work too. FB_MACMODES should depend on PPC so that it
> doesn't appear on x86.
>

That's why some has a 'select FB_MACMODES if <arch>' for multi-arch devices.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
