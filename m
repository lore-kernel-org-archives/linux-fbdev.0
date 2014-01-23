From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 23 Jan 2014 19:23:30 +0000
Subject: Re: [PATCH 4/10] atyfb: set FBINFO_READS_FAST
Message-Id: <CA+55aFxPfHmpcMH-bmRcTPUQeq5=67cKVmra6+SvT26ybvQaug@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.LRH.2.02.1401231259340.31739@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.LRH.2.02.1401231302340.31739@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.LRH.2.02.1401231303100.31739@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.LRH.2.02.1401231303460.31739@file01.intranet.prod.int.rdu2.redhat.com>
	<alpine.LRH.2.02.1401231305390.31739@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.1401231305390.31739@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Mikulas Patocka <mpatocka@redhat.com>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hmm. You're doing this for Matrix and now the aty driver.

Maybe the problem is at the fbcon level? Depending on
FBINFO_READS_FAST to decide whether you should scroll or rewrite
sounds a bit silly: even if a device doesn't have fast reads, maybe it
has a fast accelerated BLIT operation and scrolls quickly. Should the
fbcon test perhaps be for FBINFO_READS_FAST _or_ the
FBINFO_HWACCEL_COPYAREA bits?

I dunno. I didn't actually check the ->bcopy implementations, maybe
they don't use copyarea. So I'm just going by a general "this feels
wrong" feeling..

                Linus

On Thu, Jan 23, 2014 at 10:18 AM, Mikulas Patocka <mpatocka@redhat.com> wrote:
> Set FBINFO_READS_FAST so that the console code uses scrolling instead of
> rewriting. This improves scrolling speed.
