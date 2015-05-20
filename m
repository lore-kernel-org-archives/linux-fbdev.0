From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 20 May 2015 20:57:36 +0000
Subject: Re: [PATCH v4 6/6] video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <CAB=NE6U5OPbMru4W5f+S8gut2uM=ijF43-TJJCekVGKN5uns3A@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343851-967-7-git-send-email-mcgrof@do-not-panic.com> <20150520195333.GZ23057@wotan.suse.de>
In-Reply-To: <20150520195333.GZ23057@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Borislav Petkov <bp@suse.de>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Daniel Vetter <daniel.vetter@intel.com>, Dave Airlie <airlied@linux.ie>, Doug Ledford <dledford@redhat.com>, Andy Walls <awalls@md.metrocast.net>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Andy Lutomirski <luto@amacapital.net>, "Michael S. Tsirkin" <mst@redhat.com>, "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Rob Clark <robdclark@gmail.com>, Mathias Krause <minipli@googlemail.com>, Andrzej Hajda <a.hajda@samsung.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, linux-fbdev <linux-fbdev@vger.kernel.org>

On Wed, May 20, 2015 at 12:53 PM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> Tomi,
>
> the new required ioremap_uc() which was added in the initial patch set here is
> now merged on linux-next but I just noticed a small issue with this atyfb
> specific patch, I'll fix that and respin and send to you as v5.

Actually since this series depends on ioremap_uc() and since I need to
respin the last patch in this series for atyfb provided I get an
Acked-by from you for the fbdev changes do you mind if this goes
through the x86 tree as that already has the ioremap_uc() required
call? Otherwise we will have one kernel release with that call
available but not used, and we'll have to wait for 2 releases before
these changes get merged.

Thoughts?

 Luis
