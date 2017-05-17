From: Michal Hocko <mhocko@kernel.org>
Date: Wed, 17 May 2017 11:02:22 +0000
Subject: Re: setting brightness as privileged operation?
Message-Id: <20170517110221.GJ18247@dhcp22.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170105092307.GD21618@dhcp22.suse.cz>
 <20170511210755.GA1360@xo-6d-61-c0.localdomain>
 <20170512062003.GB6803@dhcp22.suse.cz>
 <20170512094712.GA29780@amd>
In-Reply-To: <20170512094712.GA29780@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri 12-05-17 11:47:12, Pavel Machek wrote:
> On Fri 2017-05-12 08:20:04, Michal Hocko wrote:
> > On Thu 11-05-17 23:07:55, Pavel Machek wrote:
> > > On Thu 2017-01-05 10:23:07, Michal Hocko wrote:
> > > > Hi,
> > > > I have just learned that my Xfce Power Manager cannot manipulate
> > > > brightness because I do not have policykit installed on my computer.
> > > > There is a reason for that (yeah it depends on systemd which I prefer
> > > > not have).
> > > > 
> > > > While this is clearly a problem of the Xfce applet I am wondering why
> > > > setting the brightness has to be a privileged operation at all. Is there
> > > > any strong reason for it or just a general policy that we do not give
> > > > world writable files into sysfs?
> > > 
> > > Well, if you have another user logged in using ssh, and changing _your_
> > > brightness, that will be somehow annoying, right?
> > 
> > I am pretty sure that such a user can do much larger harm than playing
> > with brigtness of my LCD. Anyway I went with my own rc.local hack.
> 
> Can he? Those are bugs to be fixed. We don't want them in kernel...

Good luck with that whack a mole. But more seriously. Having an
untrusted user on a system requires many measures including a very
restricted access to mounted filesystems to contain such a user.
Something tells me that /sys is one of the first candidate to deny
access to.

Instead it seems that we enforce people to use policy kit and other crap
to allow to use my HW as I want. I will not argue more here, I have a
workaround for me but this is just weird...
-- 
Michal Hocko
SUSE Labs
