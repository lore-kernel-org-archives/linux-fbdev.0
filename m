From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] Provide control of active VGA device on PCI systems
Date: Mon, 21 Feb 2005 23:47:44 -0500
Message-ID: <9e473391050221204758a18a4f@mail.gmail.com>
References: <9e47339105021921507545d084@mail.gmail.com>
	 <Pine.LNX.4.56.0502220411560.21388@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3Rxb-00056V-SX
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 20:47:47 -0800
Received: from rproxy.gmail.com ([64.233.170.195])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3Rxa-0006FD-Gr
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 20:47:47 -0800
Received: by rproxy.gmail.com with SMTP id z35so731436rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 20:47:44 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502220411560.21388@pentafluge.infradead.org>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Jesse Barnes <jbarnes@sgi.com>

On Tue, 22 Feb 2005 04:13:02 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> Also please place the class_device for vga under /sys/class/graphics/ for
> cleaness.

Multiple head cards like the matrox create multiple entries in
/sys/class/graphics/. There can only be one 'vga' attribute that's why
it needs to go on the device.

As soon as I can get to it I'm post code that will activate the second
heads on radeon cards. It also creates another /sys/class/graphics/
entry like the matrox.


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
