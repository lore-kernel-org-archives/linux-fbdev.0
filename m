From: Borislav Petkov <bp@suse.de>
Date: Tue, 05 May 2015 07:53:47 +0000
Subject: Re: [PATCH v4 2/6] x86: document WC MTRR effects on PAT / non-PAT pages
Message-Id: <20150505075347.GC4199@pd.tnic>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430343851-967-1-git-send-email-mcgrof@do-not-panic.com>
 <1430343851-967-3-git-send-email-mcgrof@do-not-panic.com>
 <5542A628.8050705@infradead.org>
 <20150505004506.GI5622@wotan.suse.de>
 <20150505072214.GA4199@pd.tnic>
 <20150505074634.GL5622@wotan.suse.de>
In-Reply-To: <20150505074634.GL5622@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Ville =?utf-8?B?U3lyasOkbMOk?= <syrjala@sci.fi>, luto@amacapital.net, Randy Dunlap <rdunlap@infradead.org>, "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, mingo@elte.hu, tglx@linutronix.de, hpa@zytor.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, daniel.vetter@intel.com, airlied@linux.ie, dledford@redhat.com, awalls@md.metrocast.net, mst@redhat.com, cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>, Jonathan Corbet <corbet@lwn.net>, Dave Hansen <dave.hansen@linux.intel.com>, Suresh Siddha <sbsiddha@gmail.com>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>, Davidlohr Bueso <dbueso@suse.de>, linux-fbdev@vger.kernel.org

On Tue, May 05, 2015 at 09:46:34AM +0200, Luis R. Rodriguez wrote:
> If so since they depend on ioremap_uc() should it go through Boris as he's
> taking that in?

Let's slow down a bit first, ok? First let's have all the x86 changes
ready, in and tested. Drivers can convert to them in a following step.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
