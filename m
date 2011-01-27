From: "Luck, Tony" <tony.luck@intel.com>
Date: Thu, 27 Jan 2011 18:35:21 +0000
Subject: RE: [PATCH 0/2][concept RFC] x86: BIOS-save kernel log to disk	upon
Message-Id: <987664A83D2D224EAE907B061CE93D53019438F1BA@orsmsx505.amr.corp.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20110125134748.GA10051@laptop>
 <AANLkTinU0KYiCd4p=z+=ojbkeEoT2G+CAYvdRU02KJEn@mail.gmail.com>
 <20110126124954.GC24527@laptop>
 <987664A83D2D224EAE907B061CE93D53019438EABF@orsmsx505.amr.corp.intel.com>
 <20110126231620.GA14807@redhat.com>
 <987664A83D2D224EAE907B061CE93D53019438EB02@orsmsx505.amr.corp.intel.com>
 <20110126233033.GB14807@redhat.com>
 <987664A83D2D224EAE907B061CE93D53019438EBB6@orsmsx505.amr.corp.intel.com>
 <4D40F7F1.3020509@zytor.com> <20110127120039.GD20279@elte.hu>
In-Reply-To: <20110127120039.GD20279@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Dave Jones <davej@redhat.com>, "Ahmed S. Darwish" <darwish.07@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, X86-ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Randy Dunlap <rdunlap@xenotime.net>, Willy Tarreau <wtarreau@hera.kernel.org>, Willy Tarreau <w@1wt.eu>, Dirk Hohndel <hohndel@infradead.org>, "Hohndel, Dirk" <dirk.hohndel@intel.com>, IDE-ML <linux-ide@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, =?iso-8859-1?Q?Fr=E9d=E9ric_Weisbecker?= <fweisbec@gmail.com>, Borislav Petkov <bp@alien8.de>, Arjan van de Ven <arjan@infradead.org>, Tejun Heo <tj@kernel.org>, James Bottomley <James.Bottomley@suse.de>, Mark Lord <kernel@teksavvy.com>, Jeff Garzik <jgarzik@pobox.com>, Eric Biederman <ebiederm@xmission.com>, Vivek

> - A bar code is encoded and i generally want to know what info i'm sending to
>   potentially untrusted parties ... also, i want to be sure i'm sending the right
>   oops, at a glance, before hitting 'send' on the email.

Maybe someone will write an iPhone/Android/Meego app that takes the picture, does
The decode and lets you look, together with options on whether to just send to
Your e-mail address, or to Cc; kerneloops?

> - A screenshot of a well-compressed oops output tells a lot of context as well:
>   surrounding kernel messages, general state of the system when it crashed.
>   Sometimes it tells me the type of the laptop as well, via the logo visible on the
>   border of the picture ;-) Context strengthens whether i can *trust* the oops - 
>   and often i'm really in doubt about oopses and want more context.

Perhaps some of this context can be encoded in the barcode too?

-Tony
