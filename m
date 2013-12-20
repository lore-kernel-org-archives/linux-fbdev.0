From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri, 20 Dec 2013 15:31:34 +0000
Subject: Re: [PATCH] video/logo: don't look for the logo after system boot
Message-Id: <52B462D6.6040304@linutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387549460-18501-1-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1387549460-18501-1-git-send-email-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 12/20/2013 04:27 PM, Geert Uytterhoeven wrote:
> On Fri, Dec 20, 2013 at 3:24 PM, Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
>> If the primary GPU driver has been loaded _after_ system as a module
>> then this logo memory is no longer valid.
>> Managed to crash the system by booting a box without a GPU and then
>> hotpluggin => BOOM.
> 
> Which GPU driver is this?

i915.

> 
> drivers/video/fbmem.c:fb_prepare_logo() has protection against this:
> 
>         if (info->flags & FBINFO_MISC_TILEBLITTING ||
>             info->flags & FBINFO_MODULE)
>                 return 0;

but gpu driver is built-in. I just add PCI device at run-time. The same
thing should happen if you go to sysfs and remove the PCI device and
then do
  echo 1 > /sys/bus/pci/rescan

Sebastian

