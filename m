From: "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 04 Aug 2013 17:34:32 +0000
Subject: Re: [PATCH RESEND 0/8] x86 platform framebuffers
Message-Id: <51FE90A8.7080903@zytor.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1375445127-15480-1-git-send-email-dh.herrmann@gmail.com> <51FC431F.1080405@zytor.com> <CANq1E4SjN-=3oyRp2zXaQ+aaJB8yEVmJzcPvbxQxu1MTc8JjiQ@mail.gmail.com> <cf7f27cd-4b3e-41bf-ba26-0955a93b04ec@email.android.com> <CANq1E4S+MSv2s+ikPuJ7+jzbQfQFxjdj7wBk54e=n57GtZ0eeA@mail.gmail.com>
In-Reply-To: <CANq1E4S+MSv2s+ikPuJ7+jzbQfQFxjdj7wBk54e=n57GtZ0eeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Herrmann <dh.herrmann@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, David Airlie <airlied@linux.ie>, Geert Uytterhoeven <geert@linux-m68k.org>, Stephen Warren <swarren@wwwdotorg.org>, Peter Jones <pjones@redhat.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org, linux-fbdev@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

On 08/04/2013 10:30 AM, David Herrmann wrote:
> Hi
> 
> On Sat, Aug 3, 2013 at 5:53 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> When compiled for i386 PAE phys_addr_t is 64 bits but pointers are 32 bits.
> 
> Yepp, that makes sense. I am not really comfortable fixing this as I
> have no idea how PAE actually works, but I digged through git history
> and sent a patch to linux-fbdev (I put you on CC). The (long)-cast
> should be sufficient, I guess.
> 
> Were there any other build warnings you encountered?
> 
> Thanks
> David
> 

It looks like Fengguang's bot hasn't run yet, so I don't have a summary.
 I asked Fengguang what I need to do to kick it off.

	-hpa


