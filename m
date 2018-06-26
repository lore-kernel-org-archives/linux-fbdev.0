From: Hans de Goede <hdegoede@redhat.com>
Date: Tue, 26 Jun 2018 18:29:07 +0000
Subject: Re: [PATCH v3 2/3] fbcon: Call WARN_CONSOLE_UNLOCKED() where applicable
Message-Id: <91a98281-979f-9479-a31a-363243948372@redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20180626135535.2990-1-hdegoede@redhat.com>
 <20180626135535.2990-3-hdegoede@redhat.com>
 <20180626104740.0067bd5e@gandalf.local.home>
In-Reply-To: <20180626104740.0067bd5e@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Petr Mladek <pmladek@suse.com>, linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>

Hi,

On 26-06-18 16:47, Steven Rostedt wrote:
> On Tue, 26 Jun 2018 15:55:34 +0200
> Hans de Goede <hdegoede@redhat.com> wrote:
> 
>> Replace comments about places where the console lock should be held with
>> calls to WARN_CONSOLE_UNLOCKED() to assert that it is actually held.
> 
> Why replace the comments? I prefer them, even with the WARN. The reason
> is, when using functions, I don't tend to look inside the function I'm
> about to use, but instead, I expect the comment above the function to
> have basic information I need to use it. Especially what locks are
> expected to be held.
> 
> Please keep the comments in place, but the WARNs are fine. They are not
> a replacement for the comments.
> 
> Nack on removing comments.

Ok, I will submit a v4 with the comments left in place.

Regards,

Hans

