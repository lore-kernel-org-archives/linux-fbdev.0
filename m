From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: Re: [Linux-fbdev-devel] Re: Problem with current fb_get_color_depth function
Date: Tue, 2 Nov 2004 20:04:12 +0800
Message-ID: <200411022004.12101.adaplas@hotpop.com>
References: <20041010225903.GA2418@darjeeling.triplehelix.org> <200410110832.19978.adaplas@hotpop.com> <20041102055555.GJ6361@triplehelix.org>
Reply-To: adaplas@pol.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261208AbUKBMJ0@vger.kernel.org>
In-Reply-To: <20041102055555.GJ6361@triplehelix.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Joshua Kwan <joshk@triplehelix.org>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net

On Tuesday 02 November 2004 13:55, Joshua Kwan wrote:
> [ long overdue follow-up ]
>
> On Mon, Oct 11, 2004 at 08:33:10AM +0800, Antonino A. Daplas wrote:
> > So, linux_logo_224 cannot be drawn when visual is directcolor at RGB555
> > or RGB565 because the logo clut requirements exceeds the hardware clut
> > capability. You need to use a logo image with a lower depth such as the
> > 16-color logo, linux_logo_16.
>
> This is weird, because removing that conditional from fb_get_color_depth
> allows a 224-color logo to show correctly on my Radeon framebuffer, in
> full color.
>
> Otherwise, it is dithered to kingdom come and mostly appears all orange
> and black.
>
> You may be right conceptually, but the fact of the matter is that this

It is correct.  You cannot force 224, 224, 224 colors on hardware that
accepts only 32, 64, 32.

> is a regression because 224-color logos work perfectly with the old
> fb_get_color_depth. So what is the real problem?

Other drivers do not show the correct logo colors if using 224-color logo
in Directcolor RGB565.  And you cannot consider this a regression since
2.4 behaves in the same way.

>
> > In short, fb_get_color_depth() and radeonfb both do the correct thing,
> > but you need a logo with a lower color depth. Or choose RGB888 or higher,
> > or set the visual to truecolor.
>
> What does that last sentence mean? -- I have no idea...

Meaning, if you want 224-color logos, boot at 8-bit pseudocolor or 24-32 bit
Directcolor.  If the hardware supports it, but in truecolor at >=8 bpp.

>
> > PS: Note that this behavior is the same as 2.4 behavior (224-color logo
> > is only chosen if directcolor and bpp >= 24).  It might have worked
> > before, and this is probably due to the directcolor clut being ramped to
> > truecolor values. However, the correct solution is to use a 16-color
> > logo.
>
> Oh, I see, I didn't read this before.

Yep, this is a code snippet from the 2.4 logo code:

        if (p->visual == FB_VISUAL_DIRECTCOLOR) {
	    ...	
	    if (depth >= 24 && (depth % 8) == 0) {
		/* have at least 8 bits per color */
		src = logo;
		bdepth = depth/8;
		...
	    else if (depth >= 12 && depth <= 23) {
	        /* have 4..7 bits per color, using 16 color image */
		unsigned int pix;
		src = linux_logo16;
		...
>
> Well, 16-color logos being used when 224-color ones work perfectly
> enough 99% of the time is pretty bad aesthetically, if you ask me.

It might work in the radeon, but it doesn't with others.

It's possible to convert the 224 logo to use a 32-entry color map.  If
really wanted, this can be done.

Tony
