From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Problem: how to sequence reset of PCI hardware
Date: Mon, 21 Feb 2005 12:33:28 -0500
Message-ID: <9e47339105022109333ae696dc@mail.gmail.com>
References: <9e47339105022023242e2fd9ce@mail.gmail.com>
	 <42199DD9.10807@pobox.com> <9e47339105022108527e3c679d@mail.gmail.com>
	 <421A142A.1060302@pobox.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D3HR7-0007yE-FY
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 09:33:33 -0800
Received: from rproxy.gmail.com ([64.233.170.205])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D3HR6-0000Mt-1i
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 21 Feb 2005 09:33:33 -0800
Received: by rproxy.gmail.com with SMTP id z35so563237rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 21 Feb 2005 09:33:31 -0800 (PST)
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
> <shrug>  You do precisely what you just said:  run it before the
> device's probe function.
> 
> That typically means either initramfs addition or using 'install
> <module> command...' in /etc/modprobe.conf.

How does this work with a built-in framebuffer driver? Isn't it's
probe function going to get called before I can run something on
initramfs?


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
