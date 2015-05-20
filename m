From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 20 May 2015 20:54:22 +0000
Subject: Re: [Cocci] [PATCH v3 0/4] pci: add and use pci_ioremap_wc_bar()
Message-Id: <CAB=NE6UsMMoPhkKof+VN7ZUCd81VxrwP9nqHDUj5Lr3DJLm3bA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647634-17169-1-git-send-email-mcgrof@do-not-panic.com>
 <CAB=NE6VYvd-Au58QRJprCquuvJkY9NYe1x8FmbW7qAhVrVE=QQ@mail.gmail.com>
 <20150519175310.GH23057@wotan.suse.de>
In-Reply-To: <20150519175310.GH23057@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

On Tue, May 19, 2015 at 10:53 AM, Luis R. Rodriguez <mcgrof@suse.com> wrote:
> On Wed, Apr 29, 2015 at 02:08:47PM -0700, Luis R. Rodriguez wrote:
>> On Tue, Apr 21, 2015 at 1:20 PM, Luis R. Rodriguez
>> <mcgrof@do-not-panic.com> wrote:
>> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
>> >
>> > This series adds pci_ioremap_wc_bar() and makes use of it
>> > on a few framebuffer device drivers.
>> >
>> > Luis R. Rodriguez (4):
>> >   pci: add pci_ioremap_wc_bar()
>> >   video: fbdev: i740fb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
>> >   video: fbdev: kyrofb: use arch_phys_wc_add() and pci_ioremap_wc_bar()
>> >   video: fbdev: gxt4500: use pci_ioremap_wc_bar() for framebuffer
>>
>> Bjorn,
>>
>> any feedback on this series?
>
> Hey Bjorn, any feedback on this series ?

I meant this series. Also Tomi, do I get your Acks for these as well?
Since they depend on pci parts do you mind if we route them through
the PCI tree? I'll poke you soon about another similar type of patch
which has dependencies on another development tree.

 Luis
