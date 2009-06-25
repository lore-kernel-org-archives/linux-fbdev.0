From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: Re: [PATCH] video: arch specific page protection support for deferred 
	io
Date: Fri, 26 Jun 2009 02:06:13 +0800
Message-ID: <45a44e480906251106h6cd72a72h380da4283be62506@mail.gmail.com>
References: <20090624105413.13925.65192.sendpatchset@rx1.opensource.se>
	 <20090624195647.9d0064c7.akpm@linux-foundation.org>
	 <aec7e5c30906242306x64832a8dtfd78fa00ba751ca9@mail.gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <aec7e5c30906242306x64832a8dtfd78fa00ba751ca9@mail.gmail.com>
Sender: owner-linux-mm@kvack.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
To: Magnus Damm <magnus.damm@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, arnd@arndb.de, linux-mm@kvack.org, lethal@linux-sh.org

On Thu, Jun 25, 2009 at 2:06 PM, Magnus Damm<magnus.damm@gmail.com> wrote:
>
> The code is fbmem.c is currently filled with #ifdefs today, want me
> create inline versions for fb_deferred_io_open() and
> fb_deferred_io_fsync() as well?
>

The patch looks good. I was going to suggest that it might be
attractive to use __attribute__(weak) for each of the dummy functions
instead of ifdefs in this case, but I can't remember if there was a
consensus about attribute-weak versus ifdefs.

Thanks,
jaya

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
