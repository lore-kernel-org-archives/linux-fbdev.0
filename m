From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 24 May 2019 08:06:02 +0000
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after failed memory allocation
Message-Id: <20190524080602.GA19514@kroah.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190426145946.26537-1-ghalat@redhat.com>
 <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
In-Reply-To: <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Grzegorz Halat <ghalat@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Jiri Slaby <jslaby@suse.com>, Oleksandr Natalenko <oleksandr@redhat.com>

On Thu, May 16, 2019 at 04:33:40PM +0200, Grzegorz Halat wrote:
> On Fri, 26 Apr 2019 at 16:59, Grzegorz Halat <ghalat@redhat.com> wrote:
> >
> > After memory allocation failure vc_allocate() doesn't clean up data
> > which has been initialized in visual_init(). In case of fbcon this
> > leads to divide-by-0 in fbcon_init() on next open of the same tty.
> 
> Hi,
> A gentle reminder. Could you please review my patch? I've seen two
> crashes caused by this bug.

How?  How are you triggering a memory allocation failure in a "normal"
system?

Anyway, I'll queue this up, but it really does not seem like anything
anyone would see "in the wild".

thanks,

greg k-h
