From: Daniel Thompson <daniel.thompson@linaro.org>
Date: Mon, 05 Feb 2018 14:39:52 +0000
Subject: Re: [PATCH 1/5] backlight: lp8788: document sysfs attributes
Message-Id: <20180205143952.tqzywm6wtgw23jvb@oak.lan>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1516978005.git.aishpant@gmail.com>
 <6523e26889d3dd65e90ea27c0d302a95aeb9da8b.1516978005.git.aishpant@gmail.com>
 <20180131110727.rmmwyqzwozwhda6z@oak.lan>
 <878tceckli.fsf@intel.com>
 <20180201113604.kcue6auuivud52qz@oak.lan>
 <20180205072550.GA9376@mordor.localdomain>
In-Reply-To: <20180205072550.GA9376@mordor.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Aishwarya Pant <aishpant@gmail.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, Milo Kim <milo.kim@ti.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jingoo Han <jingoohan1@gmail.com>, Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Julia Lawall <julia.lawall@lip6.fr>, Greg KH <gregkh@linuxfoundation.org>, Lee Jones <lee.jones@linaro.org>

On Mon, Feb 05, 2018 at 12:55:50PM +0530, Aishwarya Pant wrote:
> On Thu, Feb 01, 2018 at 11:36:04AM +0000, Daniel Thompson wrote:
> > On Wed, Jan 31, 2018 at 01:51:21PM +0200, Jani Nikula wrote:
> > > On Wed, 31 Jan 2018, Daniel Thompson <daniel.thompson@linaro.org> wrote:
> > > > On Fri, Jan 26, 2018 at 08:20:08PM +0530, Aishwarya Pant wrote:
> > > >> Add documentation for sysfs interfaces of lp8788 backlight driver by
> > > >> looking through the code and the git commit history.
> > > >> 
> > > >> Signed-off-by: Aishwarya Pant <aishpant@gmail.com>
> > > >> ---
> > > >>  Documentation/ABI/testing/sysfs-class-backlight-lp8788 | 10 ++++++++++
> > > >>  1 file changed, 10 insertions(+)
> > > >>  create mode 100644 Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > > >> 
> > > >> diff --git a/Documentation/ABI/testing/sysfs-class-backlight-lp8788 b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > > >> new file mode 100644
> > > >> index 000000000000..c0e565c8d63d
> > > >> --- /dev/null
> > > >> +++ b/Documentation/ABI/testing/sysfs-class-backlight-lp8788
> > > >> @@ -0,0 +1,10 @@
> > > >> +sysfs interface for Texas Instruments lp8788 mfd backlight driver
> > > >> +-----------------------------------------------------------------
> > > >> +
> > > >> +What:		/sys/class/backlight/<backlight>/bl_ctl_mode
> > > >> +Date:		Feb, 2013
> > > >> +KernelVersion:	v3.10
> > > >> +Contact:	Milo Kim <milo.kim@ti.com>
> > > >> +Description:
> > > >> +		(RO) Displays whether the brightness is controlled by the PWM
> > > >> +		input("PWM based") or the I2C register("Register based").
> > > >
> > > > I rather dislike drivers with this type of "bonus" sysfs controls. I'm
> > > > struggling to come up with any reason why the userspace would want to
> > > > read this control (and I think bl_ctl_mode gets the fewest hits after
> > > > searching with google hits of any search I've tried) . It looks to me 
> > > > like this is debug information that should never have gone into sysfs 
> > > > at all.
> > > 
> > > Agreed. I think the same holds for the other extra sysfs attributes. At
> > > worst, having these prevents the backlight class from adding the names
> > > later on, which is just backwards.
> > 
> > The problem is that they do exist...
> > 
> > For controls which appear to be misplaced debug attributes I think I am
> > happy to nuke the values entirely. It is extremely improbable that any
> > userspace will notice.
> > 
> > Unfortunately some of the controls look like they could be poked by an
> > custom userspace so I'm quite so confident about nuking these ones...and if we
> > don't nuke we should document (so thanks Aishwarya!). 
> > 
> 
> Hi
> 
> Thanks for reviewing. Should I take it to assume that we would like to keep the
> debug-like attributes in documentation for now?

The opposite I think!

Can you drop patch 1/2 from this series, tidy the maintainer values, etc
and resubmit?

If you want to propose patches to remove the debug attributes from the
TI drivers that's up to you (perhaps adding a dev_dbg() containing
equivalent information). If you want to you are welcome to add to these:
Suggested-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.
