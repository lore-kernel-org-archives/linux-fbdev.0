From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Re: [2.6.11 Permedia-2 Framebuffer] driver broken (?).
Date: Tue, 22 Mar 2005 07:37:08 +0800
Message-ID: <200503220737.08763.adaplas@hotpop.com>
References: <Pine.LNX.4.60.0503052355320.12643@poirot.grange> <20050321145936.6f742d89.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DDWSQ-0007ZN-IS
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 15:37:14 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DDWSO-00052x-PU
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Mar 2005 15:37:14 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id A9F17FE2DF6
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Mar 2005 23:36:56 +0000 (UTC)
In-Reply-To: <20050321145936.6f742d89.akpm@osdl.org>
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
To: Andrew Morton <akpm@osdl.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-kernel@vger.kernel.org, jim.hague@acm.org, linux-fbdev-devel@lists.sourceforge.net

On Tuesday 22 March 2005 06:59, Andrew Morton wrote:
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > Hi
> >
> > Worked on 2.6.10-rc2. With 2.6.11 during boot upon switching to fb, text
> > becomes orange, penguins look sick (not sharp). X starts and runs normal
> > (doesn't use fb), switching to vt not possible any more. Disabling
> > fb-console in kernel config fixes VTs. Reverting pm2fb.c fixes the
> > problem.
>
> Guennadi, could you please confirm that
>
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc1/2.
>6.12-rc1-mm1/broken-out/pm2fb-x-and-vt-switching-crash-fix.patch
>
> fixes this one?
>

Actually, he was the one that confirmed that the above patch fixes this
problem.

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
