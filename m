From: "Luis R. Rodriguez" <mcgrof@suse.com>
Date: Wed, 25 Mar 2015 19:50:54 +0000
Subject: Re: [PATCH v1 03/47] devres: add devm_ioremap_wc()
Message-Id: <20150325195054.GB12247@wotan.suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
 <1426893517-2511-4-git-send-email-mcgrof@do-not-panic.com>
 <CALCETrX5K4pZE0DqcEwJiKYZofCr6yjJGK8MhjhPXMHNLJ4TTQ@mail.gmail.com>
In-Reply-To: <CALCETrX5K4pZE0DqcEwJiKYZofCr6yjJGK8MhjhPXMHNLJ4TTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andy Lutomirski <luto@amacapital.net>
Cc: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>, Jan Beulich <JBeulich@suse.com>, Borislav Petkov <bp@suse.de>, Suresh Siddha <suresh.b.siddha@intel.com>, venkatesh.pallipadi@intel.com, Dave Airlie <airlied@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux Fbdev development list <linux-fbdev@vger.kernel.org>, X86 ML <x86@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

On Fri, Mar 20, 2015 at 04:49:51PM -0700, Andy Lutomirski wrote:
> On Fri, Mar 20, 2015 at 4:17 PM, Luis R. Rodriguez
> <mcgrof@do-not-panic.com> wrote:
> > From: "Luis R. Rodriguez" <mcgrof@suse.com>
> >
> > We have devm_ioremap_nocache() but no devm_ioremap_wc()
> > so add that. This will be used later.
> >
> > Cc: Suresh Siddha <suresh.b.siddha@intel.com>
> > Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> > Cc: Ingo Molnar <mingo@elte.hu>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Juergen Gross <jgross@suse.com>
> > Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> > Cc: Andy Lutomirski <luto@amacapital.net>
> > Cc: Dave Airlie <airlied@redhat.com>
> > Cc: Antonino Daplas <adaplas@gmail.com>
> > Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
> > Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> > Cc: linux-fbdev@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
> 
> Looks good to me.

Thanks, I'll peg a Reviewed-by.

 Luis
