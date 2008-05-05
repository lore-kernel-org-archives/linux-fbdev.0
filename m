From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: intelfb and G33 / Q33 / Q35 chipsets support ?
Date: Mon, 5 May 2008 14:11:02 -0700
Message-ID: <200805051411.03047.jbarnes@virtuousgeek.org>
References: <4815EEB4.2060509@frugalware.org> <200805050938.54453.jbarnes@virtuousgeek.org> <481F7533.6070503@googlemail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1761417AbYEEVLg@vger.kernel.org>
In-Reply-To: <481F7533.6070503@googlemail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
To: Gabriel C <nix.or.die@googlemail.com>
Cc: Dave Airlie <airlied@linux.ie>, Gabriel C <crazy@frugalware.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-fbdev-devel@lists.sourceforge.net, "Antonino A. Daplas" <adaplas@gmail.com>, Wang Zhenyu <zhenyu.z.wang@intel.com>

On Monday, May 05, 2008 1:59 pm Gabriel C wrote:
> Jesse Barnes wrote:
> > On Tuesday, April 29, 2008 7:16 pm Gabriel C wrote:
> >>>> See the modesetting-101 branch of
> >>>> git://git.freedesktop.org/git/mesa/drm. It's a bit rough in spots but
> >>>> the i915 driver should be pretty close to feature parity with the
> >>>> Intel X driver at this point.
> >>>
> >>> Thx , I will try out the tree.
> >>
> >> modesetting-101 does not compile on current git , NOPAGE_SIGBUS , nopage
> >> and friends gone.
> >
> > Yeah the DRM tree doesn't have a full kernel included, so it'll
> > occasionally be out-of-sync.  You could try a different kernel version
> > (it almost always works with the last stable release of Linux) or merging
> > DRM master into modesetting-101.  Assuming there are no conflicts that
> > might also fix things. :)
>
> Hehe yes , I noticed :)
>
> I've fixed myself local but it died later with:
>
> WARNING: "i2c_bit_add_bus" [/work/git/drm/linux-core/i915.ko] undefined!
>
> I didn't got time to investigate this one.

That can happen if the i2c stuff isn't loaded before the DRM module.  Usually 
depmod picks this up, but if you have multiple versions lying around it may 
pick the wrong one.  You can still load i2c-core etc. by hand though, and 
then 'insmod i915 modeset=1'.

Jesse
