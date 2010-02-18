From: Bernie Thompson <bernie@plugable.com>
Date: Thu, 18 Feb 2010 23:06:48 +0000
Subject: Re: [PATCH 7/10] udlfb: improved rendering performance
Message-Id: <480988181002181506x6093b48bof00554c9848197fd@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1266245181.4353.3302.camel@bernie-aspireone>
In-Reply-To: <1266245181.4353.3302.camel@bernie-aspireone>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Thu, Feb 18, 2010 at 7:59 AM, Greg KH <greg@kroah.com> wrote:
> Very nice job, although it would be interesting to see if the
> preallocated urbs really had any affect here :)

Yea, as you say it's not the pre-alloc, it's the async dispatch
(multiple urbs in flight - rendering of one buffer being able to be
concurrent with others in transit) that's the big win.

Best wishes,
Bernie
