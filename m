From: James Simmons <jsimmons-4a22rCvIain6YmnWEzS1oti2O/JbrIOy@public.gmane.org>
Subject: Re: [RFC] Reliable video POSTing on resume
Date: Fri, 4 Feb 2005 21:56:20 +0000 (GMT)
Message-ID: <Pine.LNX.4.56.0502042153420.26459@pentafluge.infradead.org>
References: <20050122134205.GA9354@wsc-gmbh.de> <20050204163019.GC1290@elf.ucw.cz>
 <9e4733910502040931955f5a6@mail.gmail.com> <200502041010.13220.jbarnes@engr.sgi.com>
Mime-Version: 1.0
In-Reply-To: <200502041010.13220.jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jesse Barnes <jbarnes-UzQTBcouhwxWk0Htik3J/w@public.gmane.org>
Cc: Jon Smirl <jonsmirl-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ncunningham-jjFNsPSvq+iXDw4h08c5KA@public.gmane.org, ACPI List <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>, Linux Fbdev development list <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>


> Jon does your emulator sit on top of the new legacy I/O and memory APIs?  I 
> added them for this very reason, though atm only ia64 supports them.  There's 
> documentation in Documentation/filesystems/sysfs-pci.txt if you want to take 
> a look.  On kernels that support it, sysfs can be a one stop shop for all 
> your gfx programming needs, since it provides access to the rom, PCI 
> resources (i.e. MMIO ranges, fb memory, etc.) and legacy I/O ports and 
> memory.

Thanks for the info. Actually the is what /sys/bus/graphics is for. I'm 
working on some patchs to migrate the fbdev subsystem to using it.



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
