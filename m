From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 17 Apr 2015 10:40:31 +0000
Subject: Re: [PATCH] video/logo: fix use logo after free prevention
Message-Id: <5530E31F.2010300@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <5530D6D2.8080103@gmx.at>
In-Reply-To: <5530D6D2.8080103@gmx.at>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Manfred Schlaegl <manfred.schlaegl@gmx.at>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>

Hi,

On 04/17/2015 12:48 PM, Manfred Schlaegl wrote:
> After 92b004d1aa9f367c372511ca0330f58216b25703 the logos disappeared on
> Freescale i.MX53 and i.MX6 SoC's (detected on linux-3.12.37).
> This happens because the fb_find_logo function is validly called
> (initdata still not freed) AFTER newly introduced latecall
> fb_logo_late_init.
>
> Instead of stetting a logos_freed flag somewhere in lateinit, this patch
> uses system_state=SYSTEM_BOOTING as indication for valid initdata.

The kernel init does free_initmem() call before setting the system_state 
to SYSTEM_RUNNING, so there's a period of time when the logos are freed, 
but the check in you patch does not catch it.

  Tomi
