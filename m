From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [patch] radeonfb: FB_WAITFORVSYNC implementation
Date: Sat, 12 Mar 2005 10:33:45 -0500
Message-ID: <9e473391050312073314dcb39f@mail.gmail.com>
References: <1110636406.5997.86.camel@atlantis.netenviron.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DA8cp-0002b2-If
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 07:33:59 -0800
Received: from rproxy.gmail.com ([64.233.170.204])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DA8co-00037o-69
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 07:33:59 -0800
Received: by rproxy.gmail.com with SMTP id z35so1839284rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 12 Mar 2005 07:33:45 -0800 (PST)
In-Reply-To: <1110636406.5997.86.camel@atlantis.netenviron.com>
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

You can't do this without coordination from X and DRM. If either of
those are in use you will lock the machine with this patch.  DRM also
implements WAITFORVSYNC as well as other interrupts. If you clear the
ISR DRM is going to stop working.

X is a bigger problem. If the radeonfb adapter is not the primary X
adapter, X is going to disable its IO/MEM access at the PCI level on
VT switch. Your radeonfb will then take an interrupt and not be able
to acknowledge it. This results in an interrupt loop and you rebooting
your machine.

See the "Who is stomping PCI config space?" thread in the x.org xserver list.

Because of these issues WAITFORVSYNC in radeondb has to wait for
merged DRM/fbdev to be implemented.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
