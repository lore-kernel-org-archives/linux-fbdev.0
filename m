From: Zack Smith <plinius@comcast.net>
Subject: Re: Fw: 2.6.11, framebuffer
Date: Mon, 14 Feb 2005 14:19:02 -0500
Message-ID: <4210F9A6.4060302@comcast.net>
References: <20050214100348.3542b897.akpm@osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D0ln9-0004Ij-VR
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 11:21:55 -0800
Received: from sccrmhc12.comcast.net ([204.127.202.56])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D0ln8-0004nQ-Es
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Feb 2005 11:21:55 -0800
In-Reply-To: <20050214100348.3542b897.akpm@osdl.org>
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
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: linux-fbdev-devel@lists.sourceforge.net


> I cannot start a frame buffer on 2.6,11x using
> hardware with the
>     intel 915g 
> chip. Either it crashes or nothing happens, depending on modules,
> kernel compilation etc. Nothing works.

Similarly:

With kernel 2.6.9 using an Intel 82852/82855 (not sure which)
and compiling the kernel with the VESA framebuffer, starting
up with vga requested at 1024x768 16bit, the framebuffer
console doesn't start.

I also tried the Intel framebuffer and that didn't work either.

Both start up as text.

Zack Smith



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
