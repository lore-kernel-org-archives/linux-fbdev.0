From: Alexei Starovoitov <ast@plumgrid.com>
Date: Mon, 14 Oct 2013 21:35:38 +0000
Subject: Re: [PATCH] do_register_framebuffer() fix potential deadlock
Message-Id: <CAMEtUux9apsaC-ZWhEUgyxPPZ+SGbwp-SEW_LpiceTsGdgahRA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1381528835-3351-1-git-send-email-ast@plumgrid.com>
In-Reply-To: <1381528835-3351-1-git-send-email-ast@plumgrid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Sun, Oct 13, 2013 at 11:22 PM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> Hi,
>
> On 12/10/13 01:00, Alexei Starovoitov wrote:
>> commit 50e244cc79
>> "fb: rework locking to fix lock ordering on takeover"
>>
>> fixed the locking, but in one place the console_lock() and lock_fb_info()
>> seem to be in the wrong order vs the rest
>
> The order seems to be lock_fb_info(), console_lock() everywhere. Your
> change makes it the other way in one function, so I don't understand how
> that could be a correct fix...
>
> I wonder if you're seeing the same issue as John Tapsell in "fbcon: fix
> deadlock in fbcon_generic_blank()"?

yes. It is the same issue.
console_callback() grabs the console_lock and eventually calls fbcon_blank().
So yes both mine and John's approach needs more work.
I guess it's too painful to change lock_fb_info/console_lock order
through out fb code...
Have to live with workaround for now...
