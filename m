From: Helge Hafting <helgehaf@aitel.hist.no>
Subject: Re: Much better framebuffer fixes.
Date: Thu, 27 Mar 2003 10:58:00 +0100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <3E82CB28.8020001@aitel.hist.no>
References: <Pine.LNX.4.44.0303270017180.25001-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from hermine.idb.hist.no ([158.38.50.15])
	by sc8-sf-list1.sourceforge.net with smtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18yU6l-0007ox-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 27 Mar 2003 01:55:39 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"; format="flowed"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

James Simmons wrote:
> Okay. Here are more framebuffer fixes. Please try these fixes and let me 
> know how they work out for you.
> 

The cursor line on radeonfb now is solid, instead of the broken line
in 2.5.66.  It is still impossible to set the resolution.

The lilo approach:
append="video=radeonfb:1280x1024-24@60"
This seems to do nothing.  I get the same low resolution as
plain 2.5.66, which looks bad as it don't match the flat screen resolution.

The stty approach:
stty rows 64 cols 160 gives me an odd error message about
stdin being wrong.  Forcing it with -F /dev/tty
gives me lots of random colored text on the screen and the
scrolling is wrong afterwards.  Resolution don't change though.
I run devfs if that matters.

stty rows 25 cols 80 brought things back to normal, or so it seemed.
I switched back to X and noticed that most programs except ls
wouldn't run, they all segfaulted.  Something was wrong, and
a shutdown ended in a BUG in slab.c line 1557 and a hang.


A new thing with this patch is that I get a lot of junk displayed
to the side of the boot penguin. (Random colored letters).
  The junk disappear after a little while though.

Helge Hafting




-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
