From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: doubts
Date: Sat, 5 Jun 2004 19:34:56 +0200 (MEST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <Pine.GSO.4.58.0406051932130.12190@waterleaf.sonytel.be>
References: <000001c44316$487bf040$7c04b40a@dlh.st.com>
 <200405280044.24185.lucasvr@gobolinux.org>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BWf5P-0008R1-2i
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Jun 2004 10:36:03 -0700
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1BWf5M-0003WA-MB
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 05 Jun 2004 10:36:00 -0700
In-Reply-To: <200405280044.24185.lucasvr@gobolinux.org>
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
To: Lucas Correia Villa Real <lucasvr@gobolinux.org>
Cc: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>

On Fri, 28 May 2004, Lucas Correia Villa Real wrote:
> On Wednesday 26 May 2004 08:40, Manish RATHI wrote:
> > (*changevar)();
>
> Oh, I didn't see any driver using that. In the case of fbcon_changevar, it
> just calls fbcon_setup (specifying not to show the logo again), which resets
> the framebuffer settings such as font and pan/wrap offsets.
>
> When one calls (*setvar)(), which modifies the display variable configuration,
> it checks for the existence of a non-null function pointer to changevar and
> if found, calls that function. I really don't know why a driver should need
> to restart things when changing var data. Could anyone help to clarify that?

It's there so fbcon can resize the emulated text console based on the new
screen size. E.g. when switching from 640x480 to 1024x768 using fbset, the text
console will change from 80x30 to 128x48 (assuming a 8x16 font).

It's broken in 2.6, though (unless it got fixed while I was on holidays last
week :-)

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
