From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] sysfs support for fbdev
Date: Wed, 2 Mar 2005 19:57:02 -0500
Message-ID: <9e47339105030216576d592d14@mail.gmail.com>
References: <9e47339105030102003ee47879@mail.gmail.com>
	 <Pine.LNX.4.56.0503012105420.4595@pentafluge.infradead.org>
	 <9e47339105030210135dbe71ed@mail.gmail.com>
	 <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D6f4y-0006ag-2r
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 17:24:40 -0800
Received: from rproxy.gmail.com ([64.233.170.199])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D6f4s-0003C4-B6
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 02 Mar 2005 17:24:39 -0800
Received: by rproxy.gmail.com with SMTP id z35so478868rne
        for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 02 Mar 2005 17:24:19 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0503030005490.27751@pentafluge.infradead.org>
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
Cc: James Simmons <jsimmons@pentafluge.infradead.org>

On Thu, 3 Mar 2005 00:12:22 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
> 
> > Have you considered moving all of the monitor support out into a
> > hotplug helper app? This will even work at boot time since early user
> > space is there when fbdev initializes. The helper app would be on
> > initrd just like the boot disk drivers.
> 
> Consider the following case. I have high end server with fbcon running as
> the console. One VC is at a different resolution than another. Now say the
> system is under really heavy load. When I VC switch I would have to wait
> until userland sets up the proper mode for me to VC switch. Consider also
> if userland apps start getting killed. I'm limited to only VCs of the same
> resolution if that helper app dies :-(

It is a helper app, not a daemon, it does not stay running. It also
only runs when the monitor is changed - not mode change, monitor
changed. On monitor change (loading fbdev counts as a monitor change)
the helper is called. The helper reads the DDC, parses it, merges in
any updates from /etc/fb.modes (or builds a modelist from fb.modes if
no DDC), and then sets this list of legal modes into the driver. After
the list is set a hal/dbus event is generated. Doing this is a root
only operation.

It can also happen in early user space when the kernel is first
booting. Early user space starts before fbcon currently starts. The
helper app would be loaded on to initrd or initramfs.

To change a mode, pick one of the mode names from the mode_list and
cat it to /sys/graphics/fbX/mode. This will cause the mode to be set
and a hal/dbus event to be generated. If you are just running console
the mode change event goes into fbcon. Any user can now safely set a
mode.

Changing modes does not require a user space helper, only changing
monitors (flipping a KVM switch for example).

I have working code for generating the interrupt on monitor change but
it isn't ready yet to send out.

This is the complete event sequence....

modprobe card driver
card driver checks if post needed, if so uses a new version of
request_firmware() to post
sys/graphics/fbX is added for each head
udev builds /dev/fbX for each head
1) driver locates monitors
creates sys/graphics/fbX/monitor(edid)
creating this causes a hotplug event
root priv hotplug event parses edid merges etc/mode file
sets legal modes back into sys/graphics/fbX(mode-list)
altering the modelist causes an event hal/dbus can see
user space mesa/X reads the mode-list, strings like 1024x768-60
set the one you want back into sys/graphics/fbX(mode)
this causes another hal/dbus event

If the card supports an interrupt on monitor change, flipping a KVM
switch will restart the process at #1.

Mode lists are generated at root priv.
Pam assigns ownership of mode variable to user
This allows a non-root user to safely set the mode

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
