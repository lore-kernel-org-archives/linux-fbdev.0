From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
Date: Mon, 21 Feb 2005 12:27:13 -0500
Message-ID: <9e47339105022109276261e845@mail.gmail.com>
References: <9e47339105022023242e2fd9ce@mail.gmail.com>
	 <42199DD9.10807@pobox.com> <9e47339105022108527e3c679d@mail.gmail.com>
	 <421A142A.1060302@pobox.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3HL4-0007YO-MI
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 09:27:18 -0800
Received: from rproxy.gmail.com ([64.233.170.192])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D3HL3-0004Cg-4y
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 09:27:18 -0800
Received: by rproxy.gmail.com with SMTP id z35so561291rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 09:27:13 -0800 (PST)
In-Reply-To: <421A142A.1060302@pobox.com>
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
Cc: lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>

On Mon, 21 Feb 2005 12:02:34 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> Jon Smirl wrote:
> > On Mon, 21 Feb 2005 03:37:45 -0500, Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>You either need to execute the video BIOS to initialize the hardware
> >>registers, or initialize the hardware registers themselves.
> >
> >
> > That is what the user mode reset program does.
> >
> > The problem is, how do I get it to run before calling the device's
> > probe function? Most of the framebuffer drivers assume that the
> > hardware has already been reset in their probe code.
> 
> <shrug>  You do precisely what you just said:  run it before the
> device's probe function.
> 
> That typically means either initramfs addition or using 'install
> <module> command...' in /etc/modprobe.conf.

How does install module work if one driver is servicing several adapters?
What if one adapater is in the card at boot and another shows up via hotplug?

> 
>         Jeff
> 
> 


-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
