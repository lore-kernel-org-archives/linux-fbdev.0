From: Jon Smirl <jonsmirl@gmail.com>
Subject: Framebuffer and non-PCI devices
Date: Sat, 19 Feb 2005 13:25:38 -0500
Message-ID: <9e47339105021910257461d4cc@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2ZIT-0007Ck-Ac
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 10:25:41 -0800
Received: from rproxy.gmail.com ([64.233.170.192])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D2ZIR-0003Cl-VO
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 19 Feb 2005 10:25:41 -0800
Received: by rproxy.gmail.com with SMTP id z35so134951rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 19 Feb 2005 10:25:39 -0800 (PST)
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
To: fbdev <linux-fbdev-devel@lists.sourceforge.net>

Are any of the framebuffers non-PCI devices?

Looking through the code fb_info->device appears to be filled in by
only a subset of the drivers. Can fb_info->device be converted to a
pci device? I would also add it as a parameter to register_fb() in
order to make sure it gets filled in. Are all of the drivers converted
to register_fb()?

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
