From: Michal Hocko <mhocko@kernel.org>
Date: Thu, 05 Jan 2017 09:23:07 +0000
Subject: setting brightness as privileged operation?
Message-Id: <20170105092307.GD21618@dhcp22.suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>, Lee Jones <lee.jones@linaro.org>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,
I have just learned that my Xfce Power Manager cannot manipulate
brightness because I do not have policykit installed on my computer.
There is a reason for that (yeah it depends on systemd which I prefer
not have).

While this is clearly a problem of the Xfce applet I am wondering why
setting the brightness has to be a privileged operation at all. Is there
any strong reason for it or just a general policy that we do not give
world writable files into sysfs?
-- 
Michal Hocko
SUSE Labs
