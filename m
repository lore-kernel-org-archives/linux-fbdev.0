From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: RFC: Modeline configuration strategies.
Date: Mon, 7 Mar 2005 13:03:13 -0500
Message-ID: <9e4733910503071003128a7487@mail.gmail.com>
References: <20050307173753.GA7774@god.dyndns.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8MZb-0006wn-0n
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:03:19 -0800
Received: from rproxy.gmail.com ([64.233.170.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D8MZa-0004tq-Fh
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 10:03:18 -0800
Received: by rproxy.gmail.com with SMTP id z35so2008215rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 07 Mar 2005 10:03:14 -0800 (PST)
In-Reply-To: <20050307173753.GA7774@god.dyndns.org>
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

This is a case where the userspace hotplug modedb is needed. The funny
mode would be added to /etc/fb.modes. The hotplug app would find it
and set it back into the driver.

Meanwhile the fbset command can set an arbitrary mode into the driver
after user space starts.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
