From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Hotplug blacklist and video devices
Date: Fri, 18 Feb 2005 16:14:16 -0500
Message-ID: <9e47339105021813146cf69759@mail.gmail.com>
References: <9e4733910502181251ea2b95e@mail.gmail.com>
	 <20050218210822.GB8588@nostromo.devel.redhat.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D2FSE-00047s-Vv
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 13:14:26 -0800
Received: from rproxy.gmail.com ([64.233.170.197])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D2FSD-0002qy-ES
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 18 Feb 2005 13:14:26 -0800
Received: by rproxy.gmail.com with SMTP id z35so811532rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 18 Feb 2005 13:14:16 -0800 (PST)
In-Reply-To: <20050218210822.GB8588@nostromo.devel.redhat.com>
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
To: Jon Smirl <jonsmirl@gmail.com>, lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 18 Feb 2005 16:08:22 -0500, Bill Nottingham <notting@redhat.com> wrote:
> Under Fedora (and RHEL), they're there because we generally
> don't want to load them unless the user asked for them.

Is there a specific reason why they are blocked? 

For example I'm looking at making changes to DRM such that DRM will
require the corresponding framebuffer driver to be loaded. If you back
up further this is part of fixing X so that it won't mess with the
hardware from user space. Mode setting would come from the framebuffer
driver instead of the X 2D XAA driver.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
