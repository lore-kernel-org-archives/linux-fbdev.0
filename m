From: Michal Hocko <mhocko@kernel.org>
Date: Fri, 12 May 2017 06:20:04 +0000
Subject: Re: setting brightness as privileged operation?
Message-Id: <20170512062003.GB6803@dhcp22.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170105092307.GD21618@dhcp22.suse.cz>
 <20170511210755.GA1360@xo-6d-61-c0.localdomain>
In-Reply-To: <20170511210755.GA1360@xo-6d-61-c0.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pavel Machek <pavel@ucw.cz>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 11-05-17 23:07:55, Pavel Machek wrote:
> On Thu 2017-01-05 10:23:07, Michal Hocko wrote:
> > Hi,
> > I have just learned that my Xfce Power Manager cannot manipulate
> > brightness because I do not have policykit installed on my computer.
> > There is a reason for that (yeah it depends on systemd which I prefer
> > not have).
> > 
> > While this is clearly a problem of the Xfce applet I am wondering why
> > setting the brightness has to be a privileged operation at all. Is there
> > any strong reason for it or just a general policy that we do not give
> > world writable files into sysfs?
> 
> Well, if you have another user logged in using ssh, and changing _your_
> brightness, that will be somehow annoying, right?

I am pretty sure that such a user can do much larger harm than playing
with brigtness of my LCD. Anyway I went with my own rc.local hack.
-- 
Michal Hocko
SUSE Labs
