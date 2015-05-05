From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 05 May 2015 13:47:31 +0000
Subject: Re: [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <CALCETrVdAG1NFA_dYHhOyCbwKR3msHZaaVs0MZMkW33_Sw=Kqg@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On Mon, May 4, 2015 at 3:33 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
> On 29/04/15 22:18, Luis R. Rodriguez wrote:
>> On Tue, Apr 21, 2015 at 1:16 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>>>
>>> This series addresses simple changes to framebuffer drivers to use
>>> arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to add
>>> missing mtrr_del() calls. These changes are pretty straight forward.
>>>
>>> Luis R. Rodriguez (17):
>>>   video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: gbefb: add missing mtrr_del() calls
>>>   video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
>>>   video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
>>>   video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
>>>   video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
>>
>> Hey folks, these are all pretty straight forward, can anyone take them?
>
> I can take these to fbdev tree. Unfortunately I'm not familiar with x86
> nor mtrr, so I can't really say much about the patches themselves.
>

I'm on vacation and there's no way I'll be able to usefully review
these in the next two weeks.  I can describe what's going on in case
it helps:

On x86 there are two ways to get a write-combining MMIO mapping.  The
sane way is ioremap_wc, and the ridiculous way is mtrr_add.
ioremap_wc does exactly what it appears to do, whereas mtrr_add acts
on physical addresses, requires power-of-two alignment, and is
unreliable.

On all recent hardware, ioremap_wc works, and mtrr_add is problematic
on all hardware even if it often works.  The silly thing is that
mtrr_add pokes at the registers it uses even on hardware with working
ioremap_wc.  This causes problems (those resources are a very limited
resource).

The solution I came up with a couple years ago is a new API
arch_phys_wc_add.  It is a hint that a physical address range should
be write-combining.  On hardware with working ioremap_wc, it's a
no-op.  On x86 hardware without working ioremap_wc, it just calls
mtrr_add.

The upshot is that changing mtrr_add with a WC type to
arch_phys_wc_add is OK as long as the driver also uses ioremap_wc or
similar _wc APIs.  Once everything has been converted, we can unexport
mtrr_add, which will have all kinds of benefits.


--Andy
