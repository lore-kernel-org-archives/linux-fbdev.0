From: Pavel Machek <pavel@ucw.cz>
Date: Thu, 11 May 2017 21:07:55 +0000
Subject: Re: setting brightness as privileged operation?
Message-Id: <20170511210755.GA1360@xo-6d-61-c0.localdomain>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170105092307.GD21618@dhcp22.suse.cz>
In-Reply-To: <20170105092307.GD21618@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Hocko <mhocko@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Thu 2017-01-05 10:23:07, Michal Hocko wrote:
> Hi,
> I have just learned that my Xfce Power Manager cannot manipulate
> brightness because I do not have policykit installed on my computer.
> There is a reason for that (yeah it depends on systemd which I prefer
> not have).
> 
> While this is clearly a problem of the Xfce applet I am wondering why
> setting the brightness has to be a privileged operation at all. Is there
> any strong reason for it or just a general policy that we do not give
> world writable files into sysfs?

Well, if you have another user logged in using ssh, and changing _your_
brightness, that will be somehow annoying, right?

That's the reason why global settings should be root-only...

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
