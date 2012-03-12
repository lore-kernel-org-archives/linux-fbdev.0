From: Matthew Garrett <mjg59@srcf.ucam.org>
Date: Mon, 12 Mar 2012 17:51:30 +0000
Subject: Re: [PATCH] Added backlight driver for Acer Aspire 4736
Message-Id: <20120312175130.GA18002@srcf.ucam.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1331608337.2267.67.camel@debian.Gayathri>
In-Reply-To: <1331608337.2267.67.camel@debian.Gayathri>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Pradeep Subrahmanion <subrahmanion.pradeep@gmail.com>
Cc: rpurdie@rpsys.net, FlorianSchandinat@gmx.de, akpm@linux-foundation.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

On Mon, Mar 12, 2012 at 11:12:17PM -0400, Pradeep Subrahmanion wrote:
> Hi ,
> 
>   Brightness control was not  working on Acer Aspire 4736 using default ACPI interface.  acer-acpi also do not support 4730 series since it uses new WMI interface.
> This driver adds brightness control by accessing the LBB PCI configuration register. This approach may also work on other laptops in 4730 series .But currently ,  it is only tested  for 
> Aspire 4736. 

1) If there's a WMI interface to brightness control, why not use that?
2) You're hitting a hardware resource that belongs to the i915 driver, 
which may well cause problems.
3) Why does the ACPI interface not work? Can you attach the acpidump 
output?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
