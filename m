From: Timur Tabi <timur@freescale.com>
Date: Mon, 13 Sep 2010 16:04:46 +0000
Subject: DirectFB vs. DRI
Message-Id: <AANLkTinsZB9RCh6SNeAL5ROYjn=GD3cQ8ijz9r8jmNGC@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

I have a question about providing Linux support for a new video device
that has 2D and 3D acceleration.  I'm trying to figure out how this
device should be supported in Linux.  That is, what drivers need to be
written?  After doing a little research, it appears to me that
DirectFB is the primary interface for hardware 2D acceleration, and
DRI is used to provide hardware 3D acceleration for OpenGL.  But then
I see stuff about projects that seem to fix DRI with DirectFB, or use
one of the two when the other makes more sense.  For example,
DirectFBGL.  Then there's this Slashdot article from 2003 about DRI
"coming to" DirectFB
(http://developers.slashdot.org/article.pl?sid/05/01/120254), but
most of the links don't seem to go anywhere.  And then there's also
SDL.

Anyway, the point I'm trying to make is that I can't figure out
exactly which drivers need to be written to get my 2D/3D video
hardware supported in Linux.  Can anyone help me?

-- 
Timur Tabi
Linux kernel developer at Freescale
