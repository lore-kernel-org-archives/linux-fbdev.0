From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: sysfs support for framebuffer
Date: Mon, 21 Feb 2005 14:33:43 -0500
Message-ID: <9e4733910502211133a8d7e59@mail.gmail.com>
References: <9e4733910502181435f60371c@mail.gmail.com>
	 <Pine.LNX.4.56.0502211841580.13423@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3JJW-0007Dg-I5
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:33:50 -0800
Received: from rproxy.gmail.com ([64.233.170.206])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3JJU-00054p-0A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 11:33:50 -0800
Received: by rproxy.gmail.com with SMTP id z35so600779rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 11:33:45 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502211841580.13423@pentafluge.infradead.org>
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

On Mon, 21 Feb 2005 18:50:17 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> Yes. line_length. The cursor needs to be expanded. There is much more than
> that. Pretty much var and fix fields need to be exported to userland.

I would like to keep the export data to user space at a minimum. So if
you want to set a non-standard mode edit /etc/mode and then use the
root priv app to add it to the list as a binary structure via
sysfs/modes. The patch currently supports this.

> Do we really want everything under fb0. I was thinking we should have a
> directory for a card and under that directory list all the properties.
> I was considering this approach so both DRM and fbdev can exist is the
> same spot.

DRM and fbdev can not exist in the same spot since they make
independent deivces, fb0 and drm0. Udev needs them in two different
places otherwise there is no way to make two 'dev' attributes.

> We also need to deal with mirroring. How are we going to handle that?
> Also some card support chaining cards together to into one monitor.
> We need to really think about the design. Because once it goes into the
> main tree it will be hard to change the userland api.

Mirroring and merged fb would be handled by special modes in the mode
list. You would need ownership of both heads to set these modes.
Setting a mode like this into one head would then disable the device
for the other one.


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
