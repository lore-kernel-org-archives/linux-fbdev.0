From: Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Subject: Re: [Linux-fbdev-devel] Re: inappropriate use of in_atomic()
Date: Fri, 11 Mar 2005 23:26:13 +1100
Message-ID: <1110543974.5809.98.camel@gaston>
References: <20050310204006.48286d17.akpm@osdl.org>
	 <20050311091142.GB22415@fi.muni.cz> <20050311014601.166ae43d.akpm@osdl.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
In-Reply-To: <20050311014601.166ae43d.akpm-3NddpPZAyC0@public.gmane.org>
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
To: Linux Fbdev development list <linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Cc: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>, Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, jt-yAE0UhLNZJawPNPzzlOzwdBPR1lH4CV8@public.gmane.org, javier-UOFnMJzu7Pp1eVVWpSVkNqxOck334EZe@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, roland-nF87da4h5whBDgjK7y7TUQ@public.gmane.org, Linux Kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Fri, 2005-03-11 at 01:46 -0800, Andrew Morton wrote:
> Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org> wrote:
> >
> > This may be the cause of 
> > 
> >  http://bugme.osdl.org/show_bug.cgi?id=4150
> 
> Looks that way, yes.

Note that it would be interesting to fix that (I mean the reliability of
is_atomic() or an alternative). I agree it's quite bad to rely on that
in practice, but there are a few corner cases where it's useful (like
oops handling in fbdev's etc...)

Ben.




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
