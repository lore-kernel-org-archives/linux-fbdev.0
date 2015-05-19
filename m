From: Dave Airlie <airlied@gmail.com>
Date: Tue, 19 May 2015 22:17:11 +0000
Subject: Re: [Cocci] [PATCH v3 00/17] framebuffer: simple conversions to arch_phys_wc_add()
Message-Id: <CAPM=9tw62Oi7YcX+ok9-2RSoXNCcLCb=3rK68YR3KiCU4-Vbnw@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150519175802.GJ23057@wotan.suse.de>
In-Reply-To: <20150519175802.GJ23057@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 20 May 2015 at 03:58, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Thu, May 14, 2015 at 04:26:45PM +0200, Luis R. Rodriguez wrote:
>> On Tue, May 05, 2015 at 06:47:31AM -0700, Andy Lutomirski wrote:
>> > On Mon, May 4, 2015 at 3:33 AM, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> > > On 29/04/15 22:18, Luis R. Rodriguez wrote:
>> > >> On Tue, Apr 21, 2015 at 1:16 PM, Luis R. Rodriguez
>> > >> <mcgrof@do-not-panic.com> wrote:
>> > >>> From: "Luis R. Rodriguez" <mcgrof@suse.com>
>> > >>>
>> > >>> This series addresses simple changes to framebuffer drivers to use
>> > >>> arch_phys_wc_add() and ioremap_wc() as well as fixing gbefb to add
>> > >>> missing mtrr_del() calls. These changes are pretty straight forward.
>> > >>>
>> > >>> Luis R. Rodriguez (17):
>> > >>>   video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: gbefb: add missing mtrr_del() calls
>> > >>>   video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
>> > >>>   video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: matrox: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: neofb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
>> > >>>   video: fbdev: atmel_lcdfb: use ioremap_wc() for framebuffer
>> > >>>   video: fbdev: geode gxfb: use ioremap_wc() for framebuffer
>> > >>

These 17 are all

Reviewed-by: Dave Airlie <airlied@redhat.com>

Tomi, can you please take them via the fbdev tree?

Dave.
