From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: RFC: disallow modular framebuffers
Date: Wed, 2 Mar 2005 13:01:33 -0500
Message-ID: <9e47339105030210012e98d658@mail.gmail.com>
References: <20050301024118.GF4021@stusta.de>
	 <20050302121744.GA2871@linux-sh.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6YAF-0000wO-QA
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 10:01:39 -0800
Received: from rproxy.gmail.com ([64.233.170.195])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6YAE-0007Qh-6H
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 10:01:39 -0800
Received: by rproxy.gmail.com with SMTP id z35so331266rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Mar 2005 10:01:33 -0800 (PST)
In-Reply-To: <20050302121744.GA2871@linux-sh.org>
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
To: Paul Mundt <lethal@linux-sh.org>, Adrian Bunk <bunk@stusta.de>, adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005 14:17:44 +0200, Paul Mundt <lethal@linux-sh.org> wrote:
> It seems more sensible to just fix up the drivers that don't do this
> right.. most of the broken drivers seem to be geared at x86 anyways where
> people generally don't seem to care.

X86 people don't care because they have VGA (with all of it's warts).
But that doesn't mean that VGA is a good thing. VGA lets X86 systems
run without needing framebuffer support.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
