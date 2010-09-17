From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 17 Sep 2010 19:05:44 +0000
Subject: Re: DirectFB vs. DRI
Message-Id: <4C93BC08.1050001@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <AANLkTinsZB9RCh6SNeAL5ROYjn=GD3cQ8ijz9r8jmNGC@mail.gmail.com>
In-Reply-To: <AANLkTinsZB9RCh6SNeAL5ROYjn=GD3cQ8ijz9r8jmNGC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

*wonders about the subject as neither DirectFB nor DRI are topic of this mailing 
list*
Perhaps you should also try:
directfb-dev@directfb.org
dri-devel@lists.freedesktop.org

But I'll try to answer your question anyway (see below)

Timur Tabi schrieb:
> Hi,
> 
> I have a question about providing Linux support for a new video device
> that has 2D and 3D acceleration.  I'm trying to figure out how this
> device should be supported in Linux.  That is, what drivers need to be
> written?  After doing a little research, it appears to me that
> DirectFB is the primary interface for hardware 2D acceleration, and
> DRI is used to provide hardware 3D acceleration for OpenGL.  But then
> I see stuff about projects that seem to fix DRI with DirectFB, or use
> one of the two when the other makes more sense.  For example,
> DirectFBGL.  Then there's this Slashdot article from 2003 about DRI
> "coming to" DirectFB
> (http://developers.slashdot.org/article.pl?sid/05/01/120254), but
> most of the links don't seem to go anywhere.  And then there's also
> SDL.
> 
> Anyway, the point I'm trying to make is that I can't figure out
> exactly which drivers need to be written to get my 2D/3D video
> hardware supported in Linux.  Can anyone help me?

So your question is
What do you need under Linux to get your hardware working?
Well it depends on what applications you want to run and how much effort you are 
spending on it.
If you are talking about a full blown desktop system where you want to run an X 
server and have everything accelerated than you'll probably have to go down the 
road, write an kernel drm module that supports GEM/TTM and KMS 
(kernel-based-modesetting) and also the userspace parts like a X driver and 
parts of mesa. That is what is currently done for Intel, AMD/ATI and Nvidia 
hardware.
If you are talking about smaller/embedded devices or acceleration is not as 
important there are framebuffers. Basically the framebuffer API supports 
modesetting and a way to modify pixels. For in-kernel use there is also the 
possibility to add hardware acceleration. Those can be also used from userspace 
by programs (for example SDL programs can run in frambuffers) or you can start 
an X server in the framebuffer. This can be done relatively easy/fast but is 
essentially not accelerated. As far as I know you can add acceleration on top of 
that with the DirectFB library so if you add support there it can speed up 
applications that support directFB.


Hope that was a bit of help,

Florian Tobias Schandinat
