From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: waitforVBlank, how does this even work?
Date: Wed, 2 Mar 2005 00:55:03 -0500
Message-ID: <9e47339105030121553cd4c02f@mail.gmail.com>
References: <9e473391050301215019081bce@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6Mp6-0000hV-Bu
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 21:55:04 -0800
Received: from rproxy.gmail.com ([64.233.170.201])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D6Mp5-0003kU-TQ
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 01 Mar 2005 21:55:04 -0800
Received: by rproxy.gmail.com with SMTP id z35so120169rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 01 Mar 2005 21:55:03 -0800 (PST)
In-Reply-To: <9e473391050301215019081bce@mail.gmail.com>
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>, DRI developer's list <dri-devel@lists.sourceforge.net>

Ok I see now how it works. The fbdev support is only on the Rage not
the Rage128. But this is really confusing trying to track down who is
actually controlling the interrupts.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
