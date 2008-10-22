From: "Peter Geoghegan" <peter.geoghegan86@gmail.com>
Subject: Freeze when calling ioctl with VT_ACTIVATE
	request code number on intelfb
Date: Wed, 22 Oct 2008 23:52:51 +0100
Message-ID: <db471ace0810221552k158829d0te481c8f4483754fa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <peter.geoghegan86@gmail.com>) id 1KsmZU-0003TI-Q1
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 22 Oct 2008 22:52:56 +0000
Received: from mail-gx0-f19.google.com ([209.85.217.19])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1KsmZS-00020O-D7 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 22 Oct 2008 22:52:56 +0000
Received: by gxk12 with SMTP id 12so339725gxk.10
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 22 Oct 2008 15:52:53 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

Hi,

I hoped one of you could weigh in, and help me find out why a utility
that writes to the framebuffer causes my system to freeze (the
applicaton immediately freezes, and I can only restart through ctrl,
alt, del). It's called ts_calibrate, and it's a utility for
calibrating touchscreens that use Tslib, an abstraction layer for
touchscreen panel events.

When I start the program, I am prompted with a message, but it is
totally unresponsive (save for the ctrl, alt, del thing). I decided to
run it through GDB, to isolate the problem.

Here is where the problem occurs:

*snip*
(gdb) n
79                      sprintf(vtname, "%s%d", consoledevice, nr);
(gdb) n
81                      con_fd = open(vtname, O_RDWR | O_NDELAY);
(gdb) n
82                      if (con_fd < 0) {
(gdb) n
81                      con_fd = open(vtname, O_RDWR | O_NDELAY);
(gdb) n
82                      if (con_fd < 0) {
(gdb) n
87                      if (ioctl(con_fd, VT_GETSTATE, &vts) == 0)
(gdb) n
88                              last_vt = vts.v_active;
(gdb) n
90                      if (ioctl(con_fd, VT_ACTIVATE, nr) < 0) {
(gdb) n

...

And now, the screen goes black. As I've said, when I'm not debugging,
I can see an appropriate message that indicates that the framebuffer
is succesfully written to at least initally, but it's still not
responsive.

I'm using the intelfb kernel module for intel graphics controllers. I
run the X server on a separate virtual terminal.

I guess the ioctl system call is responsible, but I'm unsure of how,
or what can be done about it. If someone could offer advice on how to
prevent this from occurring, that would be greatly appreciated,

Thanks in advance,
Peter

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
