From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Add three new IOCTLs to FB API
Date: Mon, 22 Sep 2003 09:21:40 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.21.0309220919230.4957-100000@vervain.sonytel.be>
References: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1A1L0z-0007y7-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 22 Sep 2003 00:21:45 -0700
Received: from mail2.sonytel.be ([195.0.45.172] helo=witte.sonytel.be)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 1A1L0w-0000Ro-TF
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 22 Sep 2003 00:21:43 -0700
In-Reply-To: <20030922052838.53671.qmail@web14913.mail.yahoo.com>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: fb-devel <linux-fbdev-devel@lists.sourceforge.net>

On Sun, 21 Sep 2003, Jon Smirl wrote:
> I'd like to add three new IOCTLs to the FB API to help support standalone Mesa.
> The idea is to eliminate the need for config files. Xfree might even use these
> in the future.

For 2.4.x or 2.6.0?

> In order to load DRM 3D support I need two pieces of information. The name of
> the 3D DRM driver and the bus:dev:func of the hardware. DRM does not implement
> PCI ID probing, instead you need to it what hardware to use. 
> 
> By adding these to the FB API you can start standalone Mesa just by specifying
> the name of the FB device to use. I can pick up mode and resolution from the
> existing FB API.
> 
> 1) Get location of card that is associated with this fb device. It would return
> bus,dev,func of hardware. There may be more than one piece of the same hardware
> installed.
> 
> 3) Get vendor and card PCI ID

In 2.6.0, you should be able to get them from sysfs, once fbdev does full
sysfs.

Note that both are PCI-specific, for whatever that matters (no DRM for non-PCI
chips anyway, right?).

> 2) Get 3D driver name. Return the name of the DRM driver that is associated
> with this fb device. For example aty128fb would return r128, radeonfb would
> return radeon. Empty string if there is none. There are eight DRM drivers and
> 15 fb ones.

I think this should be done using sysfs, too. I.e. symbolic links between the
fbdev and drm drivers in /sys.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
