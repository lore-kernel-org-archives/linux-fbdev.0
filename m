From: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Status for my work.
Date: Fri, 4 Feb 2005 21:05:02 -0500
Message-ID: <9e47339105020418053a196220@mail.gmail.com>
References: <Pine.LNX.4.56.0502042214120.26842@pentafluge.infradead.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CxFJq-0001tt-II
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 18:05:06 -0800
Received: from rproxy.gmail.com ([64.233.170.200])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CxFJo-00038r-5c
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 04 Feb 2005 18:05:06 -0800
Received: by rproxy.gmail.com with SMTP id j1so626125rnf
        for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 04 Feb 2005 18:05:02 -0800 (PST)
In-Reply-To: <Pine.LNX.4.56.0502042214120.26842@pentafluge.infradead.org>
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
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>, Geert Uytterhoeven <geert@linux-m68k.org>

On Sat, 5 Feb 2005 01:03:40 +0000 (GMT), James Simmons
<jsimmons@www.infradead.org> wrote:
>         The other thing I have been working on is real sysfs support. So far I
>     brought it back and made it functional. You can also get the name of the device
>     also which can replace /proc/fb. I have been attempting to figure out how to
>     handle the mode database. How should it be displayed in the tree?

I have coded up various tries at the modefb problem. My best solution
was to have pairs of variables like graphics/fb0/modes and
graphics/fb0/mode. modes is a list of legal modes and can only be set
by root but read by everyone. I pulled all of the code for querying
DDC, building the modedb, matching, etc out of fbdev and moved it to a
user space app triggered by hotplug or manually on a monitor switch.
This app queries the DDC and then builds a list of fb_mode structures
which it sets to graphics/fb0/modes. Since it is user space it is easy
to add modes to this list from an etc/fb.modes file. The fb driver
then remembers this list of modes.

If you "cat graphics/fb0/modes" you see a list of things like
1024x768-60, 1024x768-70, etc generated from the list of fb_modes. Set
one of these strings back to graphics/fb0/mode and you change the
mode. By allowing owner writes of fb0/mode and using pan to assign
ownership, it is now safe for the user to set any mode they want
without needing root priv. Setting modes without root priv is a major
requirement for X on GL support. cat graphics/fb0/mode and you can see
the current mode.

This scheme does disallow a user from setting a custom mode. The user
is limited to the modes that have been set into graphics/fb0/modes. If
you want a custom mode, add it to etc/fb.modes and rerun the hotplug
command as root to add it to the list. On the other hand, this stops
malicious users from setting modes that will destory the monitor.

A parallel scheme can be used for things like bits per pixel, but in
this case the bpps attribute would be static. After setting bpp the
mode list would be scanned to disable entries that exceed hardware
bandwidth.

The fb_info variable also needs to be evaluated. I would like to see
it split into a base fb_info with multiple fb_head structures. Now a
days most cards have two heads and some like Matrox have three.
Duplicating fb_info as is causes info that is global per card to be
duplicated. So if you set a global value into one fb_info it will be
out of sync with the other ones. Splitting into fb_info/fb_head would
also make things match what DRM is doing internally.

X on GL definitely needs per head mode control. Part of why there is
the DRM/fbdev split is lack of mode setting for the secondary heads.

-- 
Jon Smirl
jonsmirl@gmail.com


-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
