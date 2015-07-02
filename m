From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Thu, 02 Jul 2015 23:23:26 +0000
Subject: Re: [PATCH v5 1/3] video: fbdev: atyfb: clarify ioremap() base and length used
Message-Id: <CAB=NE6Uac5x4+fr9d7OymaKS9nG=Da3h+qW7Ni0o0XGOSagEdg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1435196060-27350-1-git-send-email-mcgrof@do-not-panic.com>
 <1435196060-27350-2-git-send-email-mcgrof@do-not-panic.com>
 <20150625230437.GA4362@sci.fi> <CAB=NE6V0HGCkpYFghUyyk=+St-494Y8e9PEakF9F7cEB8vpKvA@mail.gmail.com>
 <20150625231103.GB4362@sci.fi> <20150626010927.GI3005@wotan.suse.de> <20150626073028.GA14776@pd.tnic>
In-Reply-To: <20150626073028.GA14776@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Borislav Petkov <bp@suse.de>
Cc: =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, Andy Lutomirski <luto@amacapital.net>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "Michael S. Tsirkin" <mst@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Dave Airlie <airlied@redhat.com>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Rob Clark <robdclark@gmail.com>, Mathias Krause <minipli@googlemail.com>, Andrzej Hajda <a.hajda@samsung.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>

On Fri, Jun 26, 2015 at 12:30 AM, Borislav Petkov <bp@suse.de> wrote:
> On Fri, Jun 26, 2015 at 03:09:27AM +0200, Luis R. Rodriguez wrote:
>> Sure, mind this as a follow up patch if its too late?
>
> No need, you can send me an updated one - I'll replace it.

Will do!

  Luis
