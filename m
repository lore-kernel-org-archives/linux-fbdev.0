From: Jan Kasprzak <kas-0hYGf3jDe+XrBKCeMvbIDA@public.gmane.org>
Subject: Re: inappropriate use of in_atomic()
Date: Fri, 11 Mar 2005 10:11:42 +0100
Message-ID: <20050311091142.GB22415@fi.muni.cz>
References: <20050310204006.48286d17.akpm@osdl.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20050310204006.48286d17.akpm-3NddpPZAyC0@public.gmane.org>
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
Cc: Paul Mackerras <paulus-eUNUBHrolfbYtjvyW6yDsg@public.gmane.org>, Jean Tourrilhes <jt-yAE0UhLNZJawPNPzzlOzwdBPR1lH4CV8@public.gmane.org>, javier-UOFnMJzu7Pp1eVVWpSVkNqxOck334EZe@public.gmane.org, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux1394-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Roland Dreier <roland-nF87da4h5whBDgjK7y7TUQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org

Andrew Morton wrote:
: 
: in_atomic() is not a reliable indication of whether it is currently safe
: to call schedule().
: 
: This is because the lockdepth beancounting which in_atomic() uses is only
: accumulated if CONFIG_PREEMPT=y.  in_atomic() will return false inside
: spinlocks if CONFIG_PREEMPT=n.
: 
: Consequently the use of in_atomic() in the below files is probably
: deadlocky if CONFIG_PREEMPT=n:
[...]
: 	drivers/acpi/osl.c
[...]

This may be the cause of 

http://bugme.osdl.org/show_bug.cgi?id=4150

- I have recently verified that the problem described in bug #4150 disappears
when CONFIG_PREEMPT=y is used.

-Yenya


-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
