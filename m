From: "sottek" <sottek@sottekland.com>
Subject: Current discussion about the future of free software graphics
Date: Tue, 11 May 2004 13:09:48 -0500
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200405111309.AA504430924@sottekland.com>
Reply-To: <sottek@sottekland.com>
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
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
Content-Transfer-Encoding: 7bit
To: eich@pdx.freedesktop.org, agd5f@yahoo.com, michel@daenzer.net, keithp@keithp.com, jonsmirl@yahoo.com, jsimmons@infradead.org
Cc: linux-fbdev-devel@lists.sourceforge.net, dri-devel@lists.sourceforge.net

Can we wrap this up the discussion and try to get to a consensus on
design requirements? I think most of the opinions are starting to
solidify enough to start hashing out the requirements and actual
design.

Also, we probably want to drop the communication down to just one
list? I think dri-devel seems to have the widest group of subscribers.

To start the ball rolling here is a few requirements that I have. We
can build up the list and veto as needed to try and get to a working 
set.

1: Design must provide a mechanism for basic mode setting in a
device independent manner from an application with user level
permissions. ("Basic" to be defined)
2: Design must provide a mechanism for any number of driver dependent
extensions.
3: Design must provide a mechanism to allow the kernel to draw oops
or console messages to the screen in any mode.
4: Design must insure that user applications may not set the hardware
into an unstable state that could lead to lockup or damage display
devices.
5: Design must incorporate a bi-direction API versioning system. The
application must indicate the API version it is expecting first,
followed by the driver's reply.

And some that may require some discussion:
6: Design must provide a mechnism by which the driver can inform a
user application of acceptable modes that may later be applied to
hardware.
7: Design must provide a mechnism for user level applications to
use rendering features of hardware in a secure manner.
8: Design must provide a mechanism for multi-framebuffer and
multi-display per framebuffer devices to be controlled.



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to 
deliver higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
