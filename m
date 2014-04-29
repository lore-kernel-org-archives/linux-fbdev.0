From: Stephen Warren <swarren@wwwdotorg.org>
Date: Tue, 29 Apr 2014 15:59:17 +0000
Subject: Re: [PATCH 1/3] drm/dsi: Support device shutdown
Message-Id: <535FCC55.7000407@wwwdotorg.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1398785339-8107-1-git-send-email-thierry.reding@gmail.com>
In-Reply-To: <1398785339-8107-1-git-send-email-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thierry Reding <thierry.reding@gmail.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org

On 04/29/2014 09:28 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Hook up the MIPI DSI bus's .shutdown() function to allow drivers to
> implement code that should be run when a device is shut down.

The series,
Tested-by: Stephen Warren <swarren@nvidia.com>

(On an NVIDIA Tegra Dalmore board. Now, the backlight actually turns off
when the system is shut down. Note that the backlight power on this
system is directly sourced from the AC adapter for some strange reason,
rather than passing through the main system PMIC, and hence backlight
power isn't shut off even when the rest of the system really is powered off)
