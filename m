From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Re: [announce 7/7] fbsplash - documentation
Date: Wed, 9 Mar 2005 11:54:30 -0500
Message-ID: <9e4733910503090854e245740@mail.gmail.com>
References: <20050308021706.GH26249@spock.one.pl>
	 <200503080418.08804.arnd@arndb.de>
	 <20050308223728.GA11065@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D94S9-0004WE-5k
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 08:54:33 -0800
Received: from rproxy.gmail.com ([64.233.170.196])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D94S8-0005WZ-MG
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Mar 2005 08:54:33 -0800
Received: by rproxy.gmail.com with SMTP id i8so253276rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 09 Mar 2005 08:54:31 -0800 (PST)
In-Reply-To: <20050308223728.GA11065@spock.one.pl>
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
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005 23:37:29 +0100, Michal Januszewski <spock@gentoo.org> wrote:
> On Tue, Mar 08, 2005 at 04:18:07AM +0100, Arnd Bergmann wrote:
> 
> > It should probably just use its own hotplug agent instead of calling
> > the helper directly.
> 
> I've just had a look at it, and it seems possible. From what I have seen
> in the firmware_class.c code, it would require:
>  - registering a class somewhere in the initializaton code
>  - every time a request from fbcon is generated:
>    - register the class device
>    - create a timer
>    - call kobject_hotplug() to send the event to userspace
>    - unregister the device

framebuffer already has a class registered. check out /sys/class/grpahics.

You should be able to just call request_firmware and have it download
your image whenever you need it. It doesn't have to be firmware,
request_firmware will download anything.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
