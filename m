From: Jason Gunthorpe <jgunthorpe@obsidianresearch.com>
Date: Wed, 22 Apr 2015 05:39:39 +0000
Subject: Re: ioremap_uc() followed by set_memory_wc() - burrying MTRR
Message-Id: <20150422053939.GA29609@obsidianresearch.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CALCETrV0B7rp08-VYjp5=1CWJp7=xTUTBYo3uGxX317RxAQT+w@mail.gmail.com>
 <20150421224601.GY5622@wotan.suse.de>
 <20150421225732.GA17356@obsidianresearch.com>
 <20150421233907.GA5622@wotan.suse.de>
In-Reply-To: <20150421233907.GA5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Andy Lutomirski <luto@amacapital.net>, mike.marciniszyn@intel.com, infinipath@intel.com, linux-rdma@vger.kernel.org, awalls@md.metrocast.net, Toshi Kani <toshi.kani@hp.com>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hal Rosenstock <hal.rosenstock@gmail.com>, Sean Hefty <sean.hefty@intel.com>, Suresh Siddha <sbsiddha@gmail.com>, Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Roland Dreier <roland@purestorage.com>, Juergen Gross <jgross@suse.com>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Borislav Petkov <bp@suse.de>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, Dave Hansen <dave.hansen@linux.intel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Thomas Gleixner <tglx@linutronix.de>, Ville Syrj?l? <syrjala@sci.fi>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, linux-media@vger.kernel.org, X86 ML <x86@kernel.org>, mcgrof@do-not-panic.com

On Wed, Apr 22, 2015 at 01:39:07AM +0200, Luis R. Rodriguez wrote:
> > Mike, do you think the time is right to just remove the iPath driver?
> 
> With PAT now being default the driver effectively won't work
> with write-combining on modern kernels. Even if systems are old
> they likely had PAT support, when upgrading kernels PAT will work
> but write-combing won't on ipath.

Sorry, do you mean the driver already doesn't get WC? Or do you mean
after some more pending patches are applied?

Jason
