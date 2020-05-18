From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 18 May 2020 12:39:47 +0000
Subject: Re: [PATCH v2 2/2] powerpc/configs: replace deprecated riva/nvidia with nouveau
Message-Id: <906228e89ae11cad241f78ac74142d030f3ab16e.camel@kernel.crashing.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200517220524.4036334-1-emil.l.velikov@gmail.com>
 <20200517220524.4036334-2-emil.l.velikov@gmail.com>
 <9b0db95949b973c682b449906573e7b28c6113ef.camel@kernel.crashing.org>
 <CACvgo52Qws2VF0Bui-V3VdL5CFLsean9H=shLBi5H2S2fvjFSA@mail.gmail.com>
In-Reply-To: <CACvgo52Qws2VF0Bui-V3VdL5CFLsean9H=shLBi5H2S2fvjFSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Emil Velikov <emil.l.velikov@gmail.com>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Michael Ellerman <mpe@ellerman.id.au>, ML dri-devel <dri-devel@lists.freedesktop.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, 2020-05-18 at 12:00 +0100, Emil Velikov wrote:
> I believe you reported issues due to different page size for the CPU/GPU.
> Have you tried nouveau recently, there has been a handful of patches
> on the topic since your report.
> 
> Alternatively, it would make sense you rebase, cleanup and merge your patch.

That was a problem for the G5s. There were other issues for more
ancient machines with older nVidia GPUs. Additionally a lot of those
Apple machines don't have a BIOS ROM to get the various tables from.

At this stage unfortunately I don't have access to most of that HW to
test with anymore. I do have one G5 I might be able to dig out of my
basement this week to try out.

In any case, digging out that patch should be useful as powerpc64 is
still 64k pages :)

Cheers,
Ben.
