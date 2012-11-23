From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Fri, 23 Nov 2012 04:30:59 +0000
Subject: RE: [PATCH v2 0/2] da8xx-fb: LCDC driver cleanup
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E9FB8BE@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1350363196-9340-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1350363196-9340-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

On Tue, Oct 16, 2012 at 10:23:14, Manjunathappa, Prakash wrote:
> This patch series clean up driver as it is necessary for DT migration.
> 
> Manjunathappa, Prakash (2):
>   da8xx-fb: adopt fb_videomode data for panel information
>   da8xx-fb: cleanup LCDC configurations
> 

There are no review comment on this, Could you please accept this series? 

Thanks,
Prakash

>  arch/arm/mach-davinci/devices-da8xx.c |   22 +----
>  drivers/video/da8xx-fb.c              |  167 +++++++++++++++------------------
>  include/video/da8xx-fb.h              |   25 +----
>  3 files changed, 79 insertions(+), 135 deletions(-)
> 
> 

