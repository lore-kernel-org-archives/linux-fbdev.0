From: Grzegorz Halat <ghalat@redhat.com>
Date: Thu, 16 May 2019 14:33:40 +0000
Subject: Re: [PATCH] vt/fbcon: deinitialize resources in visual_init() after failed memory allocation
Message-Id: <CAKbGCscqbvOaXPTdmxatNLBygdu=WC0hVUKx0_WnqUR4+dj_zQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190426145946.26537-1-ghalat@redhat.com>
In-Reply-To: <20190426145946.26537-1-ghalat@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Oleksandr Natalenko <oleksandr@redhat.com>

On Fri, 26 Apr 2019 at 16:59, Grzegorz Halat <ghalat@redhat.com> wrote:
>
> After memory allocation failure vc_allocate() doesn't clean up data
> which has been initialized in visual_init(). In case of fbcon this
> leads to divide-by-0 in fbcon_init() on next open of the same tty.

Hi,
A gentle reminder. Could you please review my patch? I've seen two
crashes caused by this bug.

--
Grzegorz Halat
