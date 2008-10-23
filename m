From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Freeze when calling ioctl with VT_ACTIVATE
 request code number on intelfb
Date: Thu, 23 Oct 2008 09:29:45 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0810230907560.7533@anakin>
References: <db471ace0810221552k158829d0te481c8f4483754fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <geert@linux-m68k.org>) id 1Ksudn-0005R3-HV
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 07:29:55 +0000
Received: from monty.telenet-ops.be ([195.130.132.56])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ksudl-0006Vz-Pi for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 23 Oct 2008 07:29:55 +0000
In-Reply-To: <db471ace0810221552k158829d0te481c8f4483754fa@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Peter Geoghegan <peter.geoghegan86@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 22 Oct 2008, Peter Geoghegan wrote:
> I hoped one of you could weigh in, and help me find out why a utility
> that writes to the framebuffer causes my system to freeze (the
> applicaton immediately freezes, and I can only restart through ctrl,
> alt, del). It's called ts_calibrate, and it's a utility for
> calibrating touchscreens that use Tslib, an abstraction layer for
> touchscreen panel events.
> 
> When I start the program, I am prompted with a message, but it is
> totally unresponsive (save for the ctrl, alt, del thing). I decided to
> run it through GDB, to isolate the problem.
> 
> Here is where the problem occurs:
> 
> *snip*
> (gdb) n
> 79                      sprintf(vtname, "%s%d", consoledevice, nr);

I guess `consoledevice' contains `/dev/tty', not `/dev/fb'?

> (gdb) n
> 81                      con_fd = open(vtname, O_RDWR | O_NDELAY);
> (gdb) n
> 82                      if (con_fd < 0) {
> (gdb) n
> 81                      con_fd = open(vtname, O_RDWR | O_NDELAY);
> (gdb) n
> 82                      if (con_fd < 0) {
> (gdb) n
> 87                      if (ioctl(con_fd, VT_GETSTATE, &vts) == 0)
> (gdb) n
> 88                              last_vt = vts.v_active;
> (gdb) n
> 90                      if (ioctl(con_fd, VT_ACTIVATE, nr) < 0) {
> (gdb) n
> 
> ...
> 
> And now, the screen goes black. As I've said, when I'm not debugging,
> I can see an appropriate message that indicates that the framebuffer
> is succesfully written to at least initally, but it's still not
> responsive.

Are you debugging this from the frame buffer console? If yes, please try
a serial console or remote login.

> I'm using the intelfb kernel module for intel graphics controllers. I
> run the X server on a separate virtual terminal.
> 
> I guess the ioctl system call is responsible, but I'm unsure of how,
> or what can be done about it. If someone could offer advice on how to
> prevent this from occurring, that would be greatly appreciated,

So far this looks virtual console specific, not frame buffer specific.
Does switching virtual consoles manually work?

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
