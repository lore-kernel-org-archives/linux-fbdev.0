From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: [PATCH 6/6]suspend/resume SMP support
Date: Sun, 24 Apr 2005 00:41:55 +0200
Message-ID: <20050423224154.GG1884@elf.ucw.cz>
References: <1113283867.27646.434.camel@sli10-desk.sh.intel.com> <20050412105115.GD17903@elf.ucw.cz> <1113309627.5155.3.camel@sli10-desk.sh.intel.com> <20050413083202.GA1361@elf.ucw.cz> <1113467253.2568.10.camel@sli10-desk.sh.intel.com> <20050423153501.5286b6c6.akpm@osdl.org>
Mime-Version: 1.0
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
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
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>
Cc: Li Shaohua <shaohua.li-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Antonino A. Daplas" <adaplas-wvnVOKZljk0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, zwane-T6AQWPvKiI1fDP7aoN8Z5Q@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org

Hi!

> > > Code: d2 74 bd fc 8b 44 24 28 b9 0e 00 00 00 8b 74 24 14 01 c6 b8 0e
> > > 00 00 00 89 74 24 1c 8b 74 24 30 89 44 24 10 8b 7c 24 1c 83 c6 10 <f3>
> > > a5 8b 74 24 24 8b 44 24 1c 89 4c 24 10 01 ee f7 d5 21 ee 89
> > >  <0>Kernel panic - not syncing: Attempted to kill the idle task!
> > >  Stuck ??
> > > Inquiring remote APIC #0...
> > > ... APIC #0 ID: 00000000
> > > ... APIC #0 VERSION: 00040011
> > > ... APIC #0 SPIV: 000000ff
> > > root@hobit:/sys/devices/system/cpu/cpu1#
> > Andrew,
> > Below patch fixed Pavel's oops. But strange is the 'system_state' check
> > is added for CPU hotplug by Rusty. This really makes me confused. Could
> > you please look at it.
> 
> Well as the comment says, if this CPU isn't online yet, and if the system
> has not yet reached SYSTEM_RUNNING state then we bale out of the printk
> because this cpu's per-cpu resources may not yet be fully set up.
> 
> 
> > This can be reproduced 100% with radeonfb driver load. Attached is the
> > dmesg of an oops. It seems the 'objp' parameter for
> > 'cache_alloc_debugcheck_after' is invalid.
> > 
> > --- a/kernel/printk.c	2005-04-12 10:12:19.000000000 +0800
> > +++ b/kernel/printk.c	2005-04-13 17:22:40.912897328 +0800
> > @@ -624,8 +624,7 @@ asmlinkage int vprintk(const char *fmt, 
> >  			log_level_unknown = 1;
> >  	}
> >  
> > -	if (!cpu_online(smp_processor_id()) &&
> > -	    system_state != SYSTEM_RUNNING) {
> > +	if (!cpu_online(smp_processor_id())) {
> >  		/*
> >  		 * Some console drivers may assume that per-cpu resources have
> >  		 * been allocated.  So don't allow them to be called by this
> > 
> 
> That being said, I don't see why your patch should fix the oops.  The test
> (system_state != SYSTEM_RUNNING) should be returning true at this time.

We were booting CPU on running system. system_state was definitely
SYSTEM_RUNNING, but we were trying to bring CPU#1 online...

Check is wrong. If cpu is not yet online, we may not printk on
it... It does not really depend on system_state...

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
