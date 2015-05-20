From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 20 May 2015 21:06:15 +0000
Subject: Re: [PATCH v3 1/4] pci: add pci_ioremap_wc_bar()
Message-Id: <CAB=NE6UCdw9F-NRCm_mHuW133xBJbEgdadBy6Vt+D4awvuC-tQ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
 <1429647634-17169-2-git-send-email-mcgrof@do-not-panic.com> <20150520210234.GD32152@google.com>
In-Reply-To: <20150520210234.GD32152@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev <linux-fbdev@vger.kernel.org>, Andy Lutomirski <luto@amacapital.net>, "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>, Toshi Kani <toshi.kani@hp.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <syrjala@sci.fi>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Borislav Petkov <bp@suse.de>, Davidlohr Bueso <dbueso@suse.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, May 20, 2015 at 2:02 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Tue, Apr 21, 2015 at 01:20:31PM -0700, Luis R. Rodriguez wrote:
>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>
>> This lets drivers take advantage of PAT when available. This
>> should help with the transition of converting video drivers over
>> to ioremap_wc() to help with the goal of eventually using
>> _PAGE_CACHE_UC over _PAGE_CACHE_UC_MINUS on x86 on
>> ioremap_nocache() (de33c442e titled "x86 PAT: fix performance
>> drop for glx, use UC minus for ioremap(), ioremap_nocache() and
>> pci_mmap_page_range()")
>>
>> Cc: Toshi Kani <toshi.kani@hp.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Suresh Siddha <sbsiddha@gmail.com>
>> Cc: Ingo Molnar <mingo@elte.hu>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Juergen Gross <jgross@suse.com>
>> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
>> Cc: Andy Lutomirski <luto@amacapital.net>
>> Cc: Dave Airlie <airlied@redhat.com>
>> Cc: Antonino Daplas <adaplas@gmail.com>
>> Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
>> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
>> Cc: Ville Syrjälä <syrjala@sci.fi>
>> Cc: Mel Gorman <mgorman@suse.de>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Borislav Petkov <bp@suse.de>
>> Cc: Davidlohr Bueso <dbueso@suse.de>
>> Cc: linux-fbdev@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
>
> I don't have any objection to this, and I can apply the follow-on patches
> as well, given the appropriate acks and prerequisite patches (ioremap_wc()
> implementation).

OK great, ioremap_wc() has been upstream for a long time. So I'll wait
for Tomi's review of the fbdev changes. Once I get those I can resend
in a series bundled together with the other pending pci / fbdev
changes we just discussed to make things clear.

 Luis
