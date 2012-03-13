From: joeyli <jlee@suse.com>
Date: Tue, 13 Mar 2012 23:12:53 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <1331680373.10557.169.camel@linux-s257.site>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
	 <20120312175130.GA18002@srcf.ucam.org>
	 <1331640592.3485.50.camel@debian.Gayathri>
	 <20120313124738.GB10822@srcf.ucam.org>
	 <CABNxG=Dqg26EHmC3vibf3-SjVhby1qgQfMniQObUeh9eJ6SwEw@mail.gmail.com>
	 <20120313133458.GA11574@srcf.ucam.org>
	 <1331688294.2577.19.camel@debian.Gayathri>
In-Reply-To: <1331688294.2577.19.camel@debian.Gayathri>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Pradeep, 

於 二，2012-03-13 於 21:24 -0400，Pradeep Subrahmanion 提到：
> On Tue, 2012-03-13 at 13:34 +0000, Matthew Garrett wrote:
> > On Tue, Mar 13, 2012 at 06:56:16PM +0530, Pradeep Subrahmanion wrote:
> > > I tried giving acpi_backlight = vendor . In that case hot key for
> > > brightness control is working. But i think  , it is not calculating the
> > > correct value for brightness because increasing brightness after maximum
> > > level gives blank screen .
> > 
> > Which backlight device appears then?
> > 
> 
> 'intel_backlight' appears when i gave option acpi_backlight = vendor. Writing to /sys/class/backlight/intel_backlight/brightness
> 
> does not cause any change in brightness.
> 

The above command not work, that means EC didn't change backlight
value:

Method (_BCM, 1, NotSerialized)
{
    Divide (Arg0, 0x0A, Local0, Local1)
    Decrement (Local1)
    Store (Local1, ^^^^LPC.EC0.BRTS)    <== write backlight value to EC
register
}

Per my understood, EC firmware should change brightness but didn't do
that, another
way is touch i915 register in _BCM.

Acer machine provide a broken _BCM implementation and they didn't test
it.

> > > By ' ACPI interface' , I mean 'acpi_video0' inside the
> > > /sys/class/backlight. I havn't tried the /sys/class/backlight interface
> > > directly . I will try that also.
> > 
> > So writing values into /sys/class/backlight/acpi_video0/brightness does 
> > nothing?
> 
> 
> No change in value when writing
> to /sys/class/backlight/acpi_video0/brightness.
> 
> Another thing is that when i did boot with acpi_backlight = 'acer_wmi' ,
> in new kernel (3.3.0-rc7) , it shows following messages , 
> 
> [    8.350825] wmi: Mapper loaded
> [   10.363975] acer_wmi: Acer Laptop ACPI-WMI Extras
> [   10.396186] acer_wmi: Function bitmap for Communication Device: 0x91
> [   10.396385] acer_wmi: Brightness must be controlled by generic video
> driver
> 
> Also there was no interface inside /sys/class/backlight for acer_wmi. 
> 

Yes, acer_wmi support backlight control with AMW0 interface, your
machine didn't have AMW0 interface.

Normally, backlight should control by standard acpi interface.

> I also tried writing directly to Embedded controller register .But no
> change.

The machine has broken _BCM method, because EC should do something after
_BCM changed EC register.

> ----
> 
> Thanks , 
> 
> Pradeep Subrahmanion
>   


Thanks a lot!
Joey Lee

