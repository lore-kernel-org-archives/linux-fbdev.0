From: Jon Smirl <jonsmirl@gmail.com>
Subject: Problem: how to sequence reset of PCI hardware
Date: Mon, 21 Feb 2005 02:24:07 -0500
Message-ID: <9e47339105022023242e2fd9ce@mail.gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D37vN-0001DN-QS
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 23:24:09 -0800
Received: from rproxy.gmail.com ([64.233.170.206])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D37vN-0004Df-Dh
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 20 Feb 2005 23:24:09 -0800
Received: by rproxy.gmail.com with SMTP id z35so414734rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 20 Feb 2005 23:24:07 -0800 (PST)
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
To: lkml <linux-kernel@vger.kernel.org>, fbdev <linux-fbdev-devel@lists.sourceforge.net>, Greg KH <greg@kroah.com>

Secondary video cards need to be reset before they will work. How can
we get the kernel to do this? I can not come up with a good solution
for triggering this from a device driver.

One sequence I tried:
modprobe driver
driver registers sysfs class and triggers hotplug
probe code fail because HW is not reset
user space hotplug reset app runs
when reset is finished poke a sysfs attribute
in attribute handler reprobe the card

The sequence needs to be tolerant of the user space hotplug app failing
It also has to handle a rmmod of the driver while the user space app is running

An alternative is to put a emu86 execution module into the kernel.
That will allow the reset to occur synchronously. The linuxbios people
have one that is about 40-50K in size.

Another solution would be to have the PCI subsystem track devices that
have not been reset yet. modprobe of a driver would trigger a hotplug
reset event and fail the modprobe. The user space reset app would tell
the PCI subsystem when the hardware was successfully reset. After that
the modprobe would be allow to procede like normal.

I haven't been able to come up with a reliable way to call a user
space reset program from a driver's probe function except with an
in-kernel emu86. Is there another way? I'd also like to try an find a
solution that doesn't need to modify the 73 existing framebuffer
drivers.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
