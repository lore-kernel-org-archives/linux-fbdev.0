From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Fw: [PATCH][2.6.11-mm3] CONFIG_FB_ATY linkage error on PPC32
Date: Sun, 13 Mar 2005 19:33:27 -0500
Message-ID: <9e47339105031316337d4d1958@mail.gmail.com>
References: <20050313132844.7270c817.akpm@osdl.org>
	 <9e47339105031313553994f15a@mail.gmail.com>
	 <9e4733910503131408cd57b01@mail.gmail.com>
	 <20050313151412.060ad5ea.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAdXT-0005ql-E8
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 16:34:31 -0800
Received: from externalmx-1.sourceforge.net ([12.152.184.25])
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1DAdXR-0004wP-T4
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 16:34:31 -0800
Received: from rproxy.gmail.com ([64.233.170.203])
	by externalmx-1.sourceforge.net with esmtp (Exim 4.41)
	id 1DAdXQ-0004lu-Bd
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 13 Mar 2005 16:34:29 -0800
Received: by rproxy.gmail.com with SMTP id z35so2831008rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 16:33:27 -0800 (PST)
In-Reply-To: <20050313151412.060ad5ea.akpm@osdl.org>
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
Cc: linux-fbdev-devel@lists.sourceforge.net, mikpe@csd.uu.se

On Sun, 13 Mar 2005 15:14:12 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Confused.  Is Tony's patch OK?

Tony's patch is fine. I was worried that it would show the macmodes
option in xconfig on the x86 but now I see that it doesn't.

We took two differerent approaches for doing the same thing. His is
probably the better one.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
