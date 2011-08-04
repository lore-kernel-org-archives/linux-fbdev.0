From: Randy Dunlap <rdunlap@xenotime.net>
Date: Thu, 04 Aug 2011 15:46:32 +0000
Subject: Re: [Bugme-new] [Bug 40492] New: FB_BACKLIGHT should be set by
Message-Id: <20110804084632.347e4b49.rdunlap@xenotime.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
In-Reply-To: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, 04 Aug 2011 14:04:46 +0200 David wrote:

> On Thursday 04 August 2011 07:55:16 you wrote:
> > On Mit, 2011-08-03 at 17:55 -0700, Randy Dunlap wrote:
> > > On Wed, 3 Aug 2011 18:55:41 GMT bugzilla-daemon@bugzilla.kernel.org wrote:
> > > > https://bugzilla.kernel.org/show_bug.cgi?id@492
> > > > 
> > > >            Summary: FB_BACKLIGHT should be set by
> > > >            BACKLIGHT_CLASS_DEVICE Product: Other
> > > >            Version: 2.5
> > > >     
> > > >     Kernel Version: 3.0.0
> > > >     
> > > >           Platform: All
> > > >         
> > > >         OS/Version: Linux
> > > >         
> > > >               Tree: Mainline
> > > >             
> > > >             Status: NEW
> > > >           
> > > >           Severity: normal
> > > >           Priority: P1
> > > >          
> > > >          Component: Configuration
> > > >         
> > > >         AssignedTo: other_configuration@kernel-bugs.osdl.org
> > > >         ReportedBy: StormByte@gmail.com
> > > >         Regression: No
> > > > 
> > > > Created an attachment (idg432)
> > > > 
> > > >  --> (https://bugzilla.kernel.org/attachment.cgi?idg432)
> > > > 
> > > > Kernel's config
> > > > 
> > > > I discovered a scenario in which menuconfig fails to set
> > > > FB_BACKLIGHT symbol when needed.
> > > > 
> > > > In my case, I have propietary nvidia drivers once loaded Xorg, but
> > > > in the meanwhile, I have configured an uvesafb framebuffer (thus,
> > > > no other framebuffer active nor compiled).
> > > > 
> > > > System works ok, but when trying to install nvidiabl[1] (to control
> > > > nvidia's backlight) I find that FB_BACKLIGHT is not set where it
> > > > should be because I have BACKLIGHT_CLASS_DEVICE set.
> > > > 
> > > > The result is that nvidiabl does not compile.
> > 
> > Sounds like an nvidiabl bug. I'm successfully using backlight control
> > with radeon KMS with
> > 
> > # CONFIG_FB_BACKLIGHT is not set
> > CONFIG_BACKLIGHT_CLASS_DEVICE=m
> 
> It does not seem a bug in nvidiabl, it needs this symbol in order to get 2 
> defines (from include/linux/fb.h)
> 394 #ifdef CONFIG_FB_BACKLIGHT
> 395 /* Settings for the generic backlight code */
> 396 #define FB_BACKLIGHT_LEVELS     128
> 397 #define FB_BACKLIGHT_MAX        0xFF
> 398 #endif
> 
> I think nvidiabl uses those instead of having them hardcoded in its source, 
> and thus not a bug really.

David,

You could propose a patch that makes those 2 defines not be conditional
on the CONFIB_FB_BACKLIGHT symbol.

Or you could propose a patch that makes the FB_BACKLIGHT symbol
user-configurable.  Currently it is not user-configurable since it
does not have a prompt string.  I think all it would take is
changing the "bool" line to include a prompt string and adding some
help text.  Something like (not tested, probably needs some
wordsmithing):

config FB_BACKLIGHT
	bool "Generic video backlight support"
	depends on FB
	select BACKLIGHT_LCD_SUPPORT
	select BACKLIGHT_CLASS_DEVICE
	default n
	help
	  This option provides a little video backlight support.
	  Most drivers that need it enable it automatically.

---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
