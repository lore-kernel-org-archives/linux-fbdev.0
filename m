From: Antonino Daplas <adaplas@pol.net>
Subject: [FBDEV]: Framebuffer driver for Intel 810/815 chipsets
Date: 11 Dec 2002 15:46:21 +0500
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039603490.1147.80.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

James,

It seems the fbdev framework is stable enough, and already in the
development tree.  So, I'm submitting a driver for the Intel 810/815 for
review and perhaps inclusion to your tree (to get more testing), and
hopefully merge with Linus's tree.

The patch is against linux-2.5.51, but will not work yet because of 2
reasons:

1. agpgart is not working for the i810
2. support for early agp initialization needs to be added.

Once #1 is fixed, the driver should work as a module.  And once #2 gets
included, the driver can be compiled statically.  Dave Jones (thanks for
the help, by the way) has already #2 in his tree (tested and works), and
is currently working on #1 (I have a hacked version at home).

The driver should be compliant with fbdev-2.5, and should support most
if not all features that are to be expected (modularity, state saving
and restoring, full hardware support, etc).  One thing also that's very
important for many people is that the driver will work with XFree86 with
its native i810 drivers without further modification, and quite stably
too.

The patch is at
http://i810fb.sourceforge.net/linux-2.5.51-i810fb.diff.gz

Thanks,

Tony
