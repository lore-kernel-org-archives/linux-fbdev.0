From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: Fw: 2.6.11, framebuffer
Date: Tue, 15 Feb 2005 07:50:53 +0800
Message-ID: <200502150750.53844.adaplas@hotpop.com>
References: <20050214100348.3542b897.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0q06-0003J1-Tj
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 15:51:34 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0q03-0002Ek-BN
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 15:51:34 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id BCDECE279B5
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Feb 2005 23:51:14 +0000 (UTC)
In-Reply-To: <20050214100348.3542b897.akpm@osdl.org>
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
Cc: stegall@bayou.uni-linz.ac.at

On Tuesday 15 February 2005 02:03, Andrew Morton wrote:
> Begin forwarded message:
>
> Date: Mon, 14 Feb 2005 12:56:08 +0100 (CET)
> From: stegall@bayou.uni-linz.ac.at
> To: akpm@osdl.org
> Subject: 2.6.11, framebuffer
>
>
> framebuffer, intel, 915g
>
> Greetings,
> complaints were requested, but I am not sure this is the correct
> place to make them:
>
> I cannot start a frame buffer on 2.6,11x using
> hardware with the
>     intel 915g
> chip. Either it crashes or nothing happens, depending on modules,
> kernel compilation etc. Nothing works.
>
> One thing I did see was
>
>    allocation failed: out of vmalloc space - use
> vmalloc=<size> to increase size.
>
> I realize that this chip is ``new'', but
> it works quite satisfactorily  on 2.4.10* !

What driver are you using vesafb or intelfb? 915 support is a very recent
addition.

Can you send your dmesg and kernel config?

Tony




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
