From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Re: [PATCH] sisfb accel capabilities
Date: Sun, 6 Jun 2004 13:19:49 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406061315370.4558@waterleaf.sonytel.be>
References: <20040603024412.GE20951@havoc.gtf.org> <40BEF4ED.7090909@winischhofer.net>
 <1086269209.40bf27191fe1c@mail.theboonies.us> <40BF5482.7080900@winischhofer.net>
 <1086282526.40bf5b1e52eca@mail.theboonies.us>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWvgz-0004By-9F
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 04:19:57 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWvgy-0007oj-Es
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Jun 2004 04:19:56 -0700
In-Reply-To: <1086282526.40bf5b1e52eca@mail.theboonies.us>
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Eger <eger-dated-1086887330.ffe1f7@theboonies.us>
Cc: Thomas Winischhofer <thomas@winischhofer.net>, David Eger <eger@havoc.gtf.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Thu, 3 Jun 2004, David Eger wrote:
> I guess I shouldn't mark it "stupid shit" until I actually have the replacement
> code ready ;-)  You want me to revise the name of the #define?

Yes, please do so. We need it for backwards compatibility.

> Basically, I think the name FB_ACCELF_TEXT is silly and misleading:
> + it means the kernel is enabling the acceleration engine; not really to do with
> _TEXT

Well, inside the kernel, the acceleration engine is used for acceleration the
text console emulation only.

> + it's not really a flag, since it and zero are the only valid settings

What other things do you do with a flag? Waiving? ;-)

> + it doesn't really belong with the mode settings (i.e. 1024x768, 60 Hz 32bpp)
> which is what var is, mainly

A long time ago, we also intended to use it to switch to real text mode on
cards that supported it[*]. But no one ever implemented that.

[*] Remember, fbdev originated on platforms without VGA graphics. Although some
graphics cards were based on VGA-compatible chips, they all booted in graphics
mode.

> But it is how things are done now.  So yes, fbset -accel 0 => var.accel_flags =

Indeed.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
From Windows to Linux, servers to mobile, InstallShield X is the one
installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
