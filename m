From: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Date: Mon, 25 Apr 2005 08:49:25 +0800
Message-ID: <1114390165.29778.8.camel@sli10-desk.sh.intel.com>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com>
	 <20050412105115.GD17903@elf.ucw.cz>
	 <1113309627.5155.3.camel@sli10-desk.sh.intel.com>
	 <20050413083202.GA1361@elf.ucw.cz>
	 <1113467253.2568.10.camel@sli10-desk.sh.intel.com>
	 <20050423153501.5286b6c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050423153501.5286b6c6.akpm-3NddpPZAyC0@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
Content-Type: text/plain; charset="us-ascii"
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: "Antonino A. Daplas" <adaplas-wvnVOKZljk0@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, lkml <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ACPI-DEV <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Len Brown <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Zwane Mwaikambo <zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org>, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

On Sun, 2005-04-24 at 06:35, Andrew Morton wrote:
> fbcon is trying to call kmalloc before the slab system is initialised. 
> It would be best to fix that within fbcon.
This solves the problem too.

> Well as the comment says, if this CPU isn't online yet, and if the system
> has not yet reached SYSTEM_RUNNING state then we bale out of the printk
> because this cpu's per-cpu resources may not yet be fully set up.
After the CPU is offline (we are doing CPU hotplug). Its per-cpu
resources like kmalloc also aren't initialized. This is in
SYSTEM_RUNNING state too, so the system state doesn't matter. Removing
the system state check seems better than fixing the fbcon driver to me.

Thanks,
Shaohua



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
