From: David <stormbyte@gmail.com>
Date: Thu, 04 Aug 2011 12:04:46 +0000
Subject: Re: [Bugme-new] [Bug 40492] New: FB_BACKLIGHT should be set by BACKLIGHT_CLASS_DEVICE
Message-Id: <9652620.X6XvMONVgs@darkness>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
In-Reply-To: <20110803175541.7ed2fb24.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thursday 04 August 2011 07:55:16 you wrote:
> On Mit, 2011-08-03 at 17:55 -0700, Randy Dunlap wrote:
> > On Wed, 3 Aug 2011 18:55:41 GMT bugzilla-daemon@bugzilla.kernel.org wrote:
> > > https://bugzilla.kernel.org/show_bug.cgi?id@492
> > > 
> > >            Summary: FB_BACKLIGHT should be set by
> > >            BACKLIGHT_CLASS_DEVICE Product: Other
> > >            Version: 2.5
> > >     
> > >     Kernel Version: 3.0.0
> > >     
> > >           Platform: All
> > >         
> > >         OS/Version: Linux
> > >         
> > >               Tree: Mainline
> > >             
> > >             Status: NEW
> > >           
> > >           Severity: normal
> > >           Priority: P1
> > >          
> > >          Component: Configuration
> > >         
> > >         AssignedTo: other_configuration@kernel-bugs.osdl.org
> > >         ReportedBy: StormByte@gmail.com
> > >         Regression: No
> > > 
> > > Created an attachment (idg432)
> > > 
> > >  --> (https://bugzilla.kernel.org/attachment.cgi?idg432)
> > > 
> > > Kernel's config
> > > 
> > > I discovered a scenario in which menuconfig fails to set
> > > FB_BACKLIGHT symbol when needed.
> > > 
> > > In my case, I have propietary nvidia drivers once loaded Xorg, but
> > > in the meanwhile, I have configured an uvesafb framebuffer (thus,
> > > no other framebuffer active nor compiled).
> > > 
> > > System works ok, but when trying to install nvidiabl[1] (to control
> > > nvidia's backlight) I find that FB_BACKLIGHT is not set where it
> > > should be because I have BACKLIGHT_CLASS_DEVICE set.
> > > 
> > > The result is that nvidiabl does not compile.
> 
> Sounds like an nvidiabl bug. I'm successfully using backlight control
> with radeon KMS with
> 
> # CONFIG_FB_BACKLIGHT is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=m

It does not seem a bug in nvidiabl, it needs this symbol in order to get 2 
defines (from include/linux/fb.h)
394 #ifdef CONFIG_FB_BACKLIGHT
395 /* Settings for the generic backlight code */
396 #define FB_BACKLIGHT_LEVELS     128
397 #define FB_BACKLIGHT_MAX        0xFF
398 #endif

I think nvidiabl uses those instead of having them hardcoded in its source, 
and thus not a bug really.

