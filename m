From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: RFC: disallow modular framebuffers
Date: Tue, 1 Mar 2005 01:07:51 -0500
Message-ID: <9e47339105022822079eb6f86@mail.gmail.com>
References: <20050301024118.GF4021@stusta.de> <4223E59D.3060902@pobox.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D60Yq-00030l-KP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 22:08:48 -0800
Received: from rproxy.gmail.com ([64.233.170.204])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D60Yo-00040g-Cp
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 28 Feb 2005 22:08:48 -0800
Received: by rproxy.gmail.com with SMTP id z35so2084267rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 28 Feb 2005 22:08:44 -0800 (PST)
In-Reply-To: <4223E59D.3060902@pobox.com>
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
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@stusta.de>, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The on-going work to support XGL is going to change the significance
of modular framebuffers. Right now there is no real need to load
framebuffers on X86. In the future XGL is probably going to require
that the framebuffer be loaded. When XGL initially starts being
distributed people are not going to have framebuffer loaded so modular
framebuffer will let you load it on demand. From then on, in the XGL
case, if framebuffers weren't modular Redhat would have to compile all
75 of them into their distro kernel.

I don't think the framebuffer codebase has received the same level of
inspection that a lot of the other kernel code has. This is probably
because all X86 users can currently avoid loading them due to VGA
compatibility.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
