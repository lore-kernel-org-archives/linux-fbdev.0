From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
Date: 03 Apr 2003 14:20:24 +0200
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1049372424.796.21.camel@zion.wanadoo.fr>
References: <4A83DF6367@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <4A83DF6367@vcnet.vc.cvut.cz>
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: Sven Luther <luther@dpt-info.u-strasbg.fr>, James Simmons <jsimmons@infradead.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org, adaplas@pol.net


> No. With matroxfb, you have two framebuffer devices, /dev/fb0 & /dev/fb1,
> which can be connected to any of three outputs: analog primary, analog
> secondary and DVI. Analog primary & DVI share same pair of DDC cables,
> and analog secondary has its own... And user can interconnect fb* with
> outputs in almost any way he wants, as long as hardware supports it.
>                                                         Petr Vandrovec

It's +/- similar on radeon's and r128's...

I think at this point, we really need to add a structure defining
an "output" along with a few calls so the driver can tell us about
the "default" output/head mapping and can be changed from userland.

That way, the "struct fb_connection" would then be the parameter
passed to those EDID routines...

The driver would setup a default policy at boot based on what
have been probed. But userland would be able to

 - Request connection info from all outputs. Note that these contains
more than just EDID. Some drivers can "probe" for the presence of
something in the VGA or S-Video connectors by sensing the load on
the signals, even if that "thing" cannot provide an EDID. So we need
a bit more than just the EDID, something like

  struct fb_connection_info {
	int	index;	/* Absolute index of output on this card */
	int	type;	/* FB_VGA, FB_DVI, FB_ADC, FB_LVDS, ... */
 	int	flags;	/* FB_CONN_PRESENCE, FB_VALID_EDID, ... */
	u8	edid[128];
  }

 - Ask/Set output<->head mapping. Possibly by an ioctl to the head
that sets the connection index. Of course, the driver may fail if
the combo isn't supported. Also, the policy isn't defined on what
happens to the head's current mode. I beleive the head should try to
keep it's current mode unless it's not suitable to whatever have been
detected on that connection.

What do you think ?

Ben.
