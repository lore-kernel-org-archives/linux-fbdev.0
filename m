From: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Date: Wed, 14 Mar 2012 02:55:16 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <1331692996.3052.8.camel@debian.Gayathri>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
	 <20120312175130.GA18002@srcf.ucam.org>
	 <1331640592.3485.50.camel@debian.Gayathri>
	 <20120313124738.GB10822@srcf.ucam.org>
	 <CABNxG=Dqg26EHmC3vibf3-SjVhby1qgQfMniQObUeh9eJ6SwEw@mail.gmail.com>
	 <20120313133458.GA11574@srcf.ucam.org>
	 <1331688294.2577.19.camel@debian.Gayathri>
	 <1331680373.10557.169.camel@linux-s257.site>
In-Reply-To: <1331680373.10557.169.camel@linux-s257.site>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joeyli <jlee@suse.com>
Cc: Matthew Garrett <mjg@redhat.com>, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Joey , 

> Per my understood, EC firmware should change brightness but didn't do
> that, another
> way is touch i915 register in _BCM.

  how do we do this ? you mean change the _BCM implementation ? 
> 
> Acer machine provide a broken _BCM implementation and they didn't test
> it.
> 
> > > > By ' ACPI interface' , I mean 'acpi_video0' inside the
> > > > /sys/class/backlight. I havn't tried the /sys/class/backlight interface
> > > > directly . I will try that also.
> > > 
> > > So writing values into /sys/class/backlight/acpi_video0/brightness does 
> > > nothing?
> > 
> > 
> > No change in value when writing
> > to /sys/class/backlight/acpi_video0/brightness.
> > 
> > Another thing is that when i did boot with acpi_backlight = 'acer_wmi' ,
> > in new kernel (3.3.0-rc7) , it shows following messages , 
> > 
> > [    8.350825] wmi: Mapper loaded
> > [   10.363975] acer_wmi: Acer Laptop ACPI-WMI Extras
> > [   10.396186] acer_wmi: Function bitmap for Communication Device: 0x91
> > [   10.396385] acer_wmi: Brightness must be controlled by generic video
> > driver
> > 
> > Also there was no interface inside /sys/class/backlight for acer_wmi. 
> > 
> 
> Yes, acer_wmi support backlight control with AMW0 interface, your
> machine didn't have AMW0 interface.
> 
> Normally, backlight should control by standard acpi interface.
> 
> > I also tried writing directly to Embedded controller register .But no
> > change.
> 
> The machine has broken _BCM method, because EC should do something after
> _BCM changed EC register.

Thanks , 

Pradeep Subrahmanion

