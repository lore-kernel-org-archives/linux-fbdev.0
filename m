From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 01/11] video: Add support for
	the	Avionic Design Xanthos framebuffer.
Date: Mon, 18 May 2009 15:55:46 +0200
Message-ID: <20090518135546.GA7364@avionic-design.de>
References: <1242294422-10478-1-git-send-email-thierry.reding@avionic-design.de>
	<4A0C334B.9040008@compulab.co.il>
	<20090516112243.44194c20.krzysztof.h1@poczta.fm>
	<20090518085300.GA14909@avionic-design.de>
	<20090518144028.9b8dbc3f.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <thierry.reding@avionic-design.de>)
	id 1M63P9-0001lj-T8 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 14:01:23 +0000
Received: from moutng.kundenserver.de ([212.227.126.186])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M63P7-0001An-Fw for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 18 May 2009 14:01:23 +0000
Content-Disposition: inline
In-Reply-To: <20090518144028.9b8dbc3f.krzysztof.h1@poczta.fm>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk, "Antonino A. Daplas" <adaplas@gmail.com>

* Krzysztof Helt wrote:
> On Mon, 18 May 2009 10:53:01 +0200
> Thierry Reding <thierry.reding@avionic-design.de> wrote:
[...]
> > > I have no comments to rest of the patch so I removed it.
> > > 
> > > I have a general comment that you should make your driver
> > > conform to the fbdev API (check_var/set_par) for mode setting.
> > > I know you have the scaler, so leave the adfxfb_ioctl to handle it.
> > > If you define the set_par/check_var functions to handle size of
> > > the overlay's input (without scaling) and color format one can
> > > use standard FBIOPUT_VSCREENINFO and 
> > > FBIOGET_VSCREENINFO ioctls to set and read your overlay.
> > > If the overlay should be scaled use the custom ioctls to set the 
> > > scaling factors only.
> > > Currently, your driver looks like it wants to work around the
> > > fbdev API. See the skeletonfb.c for guidance.
> > 
> > I was under the impression that FBIOPUT_SCREENINFO was used to set the
> > framebuffer resolution, which can be (even usually is) different from
> > that of the overlay. How can I distinguish between which of the video
> > pages (framebuffer or overlay) should be modified?
> > 
> 
> The FBIOPUT_SCREENINFO is used for the framebuffer and not the overlay.
> I got an impression that your framebuffer has a scaler and can be scaled to
> display resolution without changing framebuffer resolution.

It is possible to use the scaler for that purpose, but we've never done (or
needed) that. The framebuffer always runs at the native resolution (the
processor board is tightly coupled to the rest of the hardware, including
display). The scaler is only used to take arbitrary-sized images and resize
them to another arbitrary size for display in the overlay (used for video
playback, for instance).

> How do you program framebuffer registers? Usually, there is a set_par()
> function to do this. If you have a framebuffer that cannot change a resolution
> (either fixed resolution framebuffer or with resolution which can be set only
> during board set up) do not define fb_check_var() or check there if the mode
> has not changed.

The framebuffer can actually change the resolution, though we've never tried
that in practice. Each derived board comes with a default predefined
resolution that is never changed (because the displays we use don't support
mode setting either). Therefore changing the resolution does not make sense.
I guess it is better, as you say, to not define fb_check_var() in this case
until at some point it may become relevant.

> Regards,
> Krzysztof

Thierry


------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables 
unlimited royalty-free distribution of the report engine 
for externally facing server and web deployment. 
http://p.sf.net/sfu/businessobjects
