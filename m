From: Felipe Contreras <felipe.contreras@gmail.com>
Date: Wed, 17 Nov 2010 18:08:58 +0000
Subject: Re: [PATCH 2/3] OMAP: VRAM: Fix boot-time memory allocation
Message-Id: <AANLkTimkR9G9Gxm7oK7-0j+5Ywr=-oPvLPJ_uFc6W3k8@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1289382320-17412-1-git-send-email-tomi.valkeinen@nokia.com>
	<1289382320-17412-2-git-send-email-tomi.valkeinen@nokia.com>
In-Reply-To: <1289382320-17412-2-git-send-email-tomi.valkeinen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Wed, Nov 10, 2010 at 11:45 AM, Tomi Valkeinen
<tomi.valkeinen@nokia.com> wrote:
> Use memblock_free() and memblock_remove() to remove the allocated or
> reserved VRAM area from normal kernel memory.
>
> This is a slightly modified version of patches from Felipe Contreras and
> Namhyung Kim.
>
> Reported-by: Felipe Contreras <felipe.contreras@gmail.com>
> Reported-by: Namhyung Kim <namhyung@gmail.com>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@nokia.com>

I would have kept these as two separate patches as they do two different things:
 1) Fix a build error
 2) Prepare for future ioremap() changes[1]

The current patch mentions 1) in the summary, and 2) in the commit
message, but it doesn't explain why 2) is needed. Maybe for the next
time.

Cheers.

[1] http://article.gmane.org/gmane.linux.ports.arm.omap/44978

-- 
Felipe Contreras
