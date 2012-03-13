From: Matthew Garrett <mjg@redhat.com>
Date: Tue, 13 Mar 2012 12:47:38 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <20120313124738.GB10822@srcf.ucam.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
 <20120312175130.GA18002@srcf.ucam.org>
 <1331640592.3485.50.camel@debian.Gayathri>
In-Reply-To: <1331640592.3485.50.camel@debian.Gayathri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Cc: rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Mar 13, 2012 at 08:09:52AM -0400, Pradeep Subrahmanion wrote:
> Before taking this approach , I had a look at the WMI interface.But I found from acer-acpi site that , the 4730 series 
> is using new WMI interface which needs to be reverse engineered.
> As far as  acpi interface is concerned , by default it is not at all causing any change in brightness.
> When 'acpi_osi=Linux' was added to the boot grub config , the brightness control with hot key started to work .
> But it was not changing to correct values. Increasing brightness after maximum level gives blank screen.

That page was last updated in 2009. Have you tried the current acer-wmi 
code? You'd probably need to pass backlight=vendor if there's a 
non-working ACPI interface.

When you say the ACPI interface doesn't work, what do you mean? Have you 
tried using the /sys/class/backlight interface directly?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
