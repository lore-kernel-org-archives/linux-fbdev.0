From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [Linux-fbdev-devel] [PATCH] nvidiafb: allow ignoring EDID info
Date: Mon, 26 Feb 2007 20:46:25 +0800
Message-ID: <1172493985.20842.11.camel@daplas>
References: <ephv35$4i3$1@sea.gmane.org> <1172161290.4198.12.camel@daplas>
	 <cb7bb73a0702221108r161441ebt61886ce67746f389@mail.gmail.com>
	 <1172187249.4279.7.camel@daplas>
	 <cb7bb73a0702230534o4e2c7e9frd5f2b05accf18c05@mail.gmail.com>
	 <1172300694.4109.50.camel@daplas>
	 <cb7bb73a0702240116g33a9b5bv2e3668a536a70938@mail.gmail.com>
	 <1172351769.4415.5.camel@daplas>
	 <cb7bb73a0702250226k53369655vc9c4e5a71c337a8c@mail.gmail.com>
	 <1172401825.6187.2.camel@daplas>
	 <cb7bb73a0702250516p4e64ec64ueca3128f752bb421@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965254AbXBZMoM@vger.kernel.org>
In-Reply-To: <cb7bb73a0702250516p4e64ec64ueca3128f752bb421@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Cc: James Simmons <jsimmons@infradead.org>, Luca Tettamanti <kronos@people.it>, linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org

On Sun, 2007-02-25 at 14:16 +0100, Giuseppe Bilotta wrote:
> On 2/25/07, Antonino A. Daplas <adaplas@gmail.com> wrote:
> > On Sun, 2007-02-25 at 11:26 +0100, Giuseppe Bilotta wrote:
> > >
> > > Applied. No noticeable difference, in the sense that the EDID debug
> > > output is still the same and so is the snow effect.
> >
> > Here's a temporary workaround:
> >
> > In drivers/video/nvidia/nv_i2c.c:nvidia_probe_i2c_connector(),comment
> > this out:
> >
> >         if (par->chan[conn - 1].par)
> >                 edid = fb_ddc_read(&par->chan[conn - 1].adapter);
> >
> > and make sure CONFIG_FIRMWARE_EDID=y.
> 
> With this patch, I don't get any dmesg info about my monitor EDID, but
> I still get the snow. Could it be that there's something else on my
> system which is setting the video to some absurd timings when I
> switchg on the framebuffer console? I'm running an up-to-date debian
> unstable.
> 

At this point, I don't know.  You're the first person to report this
kind of problem. I'm still studying the nvidiafb and Xorg source code.

Tony
