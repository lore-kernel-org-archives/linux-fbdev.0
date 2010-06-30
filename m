From: Bernie Thompson <bernie@plugable.com>
Date: Wed, 30 Jun 2010 15:41:14 +0000
Subject: Re: [PATCH 4/4] HID: picolcd: implement refcounting of framebuffer
Message-Id: <AANLkTikJuRwnuY9rvqYGoANPnaiJcTgpKQgeL7bU3pmI@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20100628223327.23c6006a@neptune.home>
In-Reply-To: <20100628223327.23c6006a@neptune.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

On Tue, Jun 29, 2010 at 1:42 PM, Bruno Prémont
<bonbons@linux-vserver.org> wrote:
> Something like
>  framebuffer_alloc()              <-- set refcount to 1
>  ...
>  register_framebuffer()           <-- inc refcount
>  ...
>  and open() of fb device would inc refcount
>  and close() would decrement it
>
>  unregister_framebuffer()         <-- dec refcount
>  framebuffer_release()            <-- dec refcount

Totally agree.  Just verbalizing smaller details - wiith a struct kref
added to fb_info, initialized in framebuffer_alloc, get_kref() and
put_kref() at the points you list, and a framebuffer_free() for use
with put_kref (static to start, assuming only fbmem itself will
directly touch refs), this is sounds like you'd have a good fix for
fbdev's current problems here.

Best wishes,
Bernie
