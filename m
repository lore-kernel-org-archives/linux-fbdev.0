From: Randy Dunlap <rdunlap@xenotime.net>
Date: Thu, 04 Aug 2011 00:55:41 +0000
Subject: Re: [Bugme-new] [Bug 40492] New: FB_BACKLIGHT should be set by
Message-Id: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Wed, 3 Aug 2011 18:55:41 GMT bugzilla-daemon@bugzilla.kernel.org wrote:

> https://bugzilla.kernel.org/show_bug.cgi?id@492
> 
>            Summary: FB_BACKLIGHT should be set by BACKLIGHT_CLASS_DEVICE
>            Product: Other
>            Version: 2.5
>     Kernel Version: 3.0.0
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: normal
>           Priority: P1
>          Component: Configuration
>         AssignedTo: other_configuration@kernel-bugs.osdl.org
>         ReportedBy: StormByte@gmail.com
>         Regression: No
> 
> 
> Created an attachment (idg432)
>  --> (https://bugzilla.kernel.org/attachment.cgi?idg432)
> Kernel's config
> 
> I discovered a scenario in which menuconfig fails to set FB_BACKLIGHT symbol
> when needed.
> 
> In my case, I have propietary nvidia drivers once loaded Xorg, but in the
> meanwhile, I have configured an uvesafb framebuffer (thus, no other framebuffer
> active nor compiled).
> 
> System works ok, but when trying to install nvidiabl[1] (to control nvidia's
> backlight) I find that FB_BACKLIGHT is not set where it should be because I
> have BACKLIGHT_CLASS_DEVICE set.
> 
> The result is that nvidiabl does not compile.
> 
> The workarround for this now is to enable as a modile any component with
> support for backlight [Nvidia Framebuffer (CONFIG_FB_NVIDIA), ATI Radeon
> display (CONFIG_FB_RADEON), etc...]
> 
> I propose either enabling it automatically with CONFIG_BACKLIGHT_CLASS_DEVICE,
> or either having a separate option to allow it to be selected manually for
> external modules.
> 
> I add an attachment of a kernel config showing this scenario with FB_BACKLIGHT
> not set nor any other framebuffer than uvesafb
> 
> -- 

Any fbdev comments on this bug report?

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
