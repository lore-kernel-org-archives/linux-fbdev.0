From: Hetz Ben Hamo <hetz@softier.com>
Subject: Framebuffer fbtest issues
Date: Wed, 26 Nov 2003 12:15:05 +0200
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200311261215.05761.hetz@softier.com>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_p0Hx/qsMOXxsbU6"
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 1AOwhk-0000r3-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Wed, 26 Nov 2003 02:15:28 -0800
Received: from enigma.barak.net.il ([212.150.48.99])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.24)
	id 1AOwhj-0007PJ-Nu
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 26 Nov 2003 02:15:27 -0800
Received: from abu-fatma.softier.local ([62.90.245.250])
          by enigma.barak.net.il
          (InterMail vK.4.04.00.00 201-232-137 license b2629777bce4038e9f419f7b71122558)
          with ESMTP
          id <20031126101648.EPMS1995.enigma@abu-fatma.softier.local>
          for <linux-fbdev-devel@lists.sourceforge.net>;
          Wed, 26 Nov 2003 12:16:48 +0200
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
To: linux-fbdev-devel@lists.sourceforge.net


--Boundary-00=_p0Hx/qsMOXxsbU6
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I took the fbtest from the CVS and compiled it. It seems it needs some 
updating ;)

in the fbtest/pnmtohex/Makefile - it won't compile, as the NetPBM library has 
been changed, so you'll need to install it and change the Makefile to 
something like:

LIBS += -lnetpbm

One weird issue - the netpbm package that comes with redhat doesn't compile 
the fbtest - any suggestions why? (same in mandrake) - only installing the 
netpbm from sourceforge seems to help (and modifying the Makefile)..

I'm also enclosing sort of README to save others the hair tearing I had here 
;)

Could someone please commit those changes to CVS?

Thanks,
Hetz

--Boundary-00=_p0Hx/qsMOXxsbU6
Content-Type: text/english;
  charset="us-ascii";
  name="README"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="README"

Framebuffer test "suite"
------------------------

This is a package which contains 10 tests to make sure your framebuffer works.

In order to compile it, you'll need NetPBM to be installed first 
(http://netpbm.sf.net) and make sure your libnetpbm.so files are correctly known
to the either your LD_LIBRARY_PATH or to your /etc/ld.so.conf (in Linux)

After compiling (a simple "make" should do the job), you can run the test by
runnning: ./fbtest

On some machines, running the fbtest might take a bit of pause and then the demos
will run, so you might want to launch the fbtest with: ./fbtest -d -v

Good Luck,
The framebuffer development team
(http://linux-fbdev.sf.net)

--Boundary-00=_p0Hx/qsMOXxsbU6--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
