From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Date: Fri, 04 Mar 2016 21:09:00 +0000
Subject: Re: [PATCH] x86: PAT: Documentation: update overlapping ioremap hack recommendation
Message-Id: <20160304210900.GT3577@linux.vnet.ibm.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457040108-27358-1-git-send-email-mcgrof@kernel.org>
 <20160303214233.GN3577@linux.vnet.ibm.com>
 <20160304192326.GU25240@wotan.suse.de>
In-Reply-To: <20160304192326.GU25240@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: bp@alien8.de, mingo@kernel.org, tglx@linutronix.de, hpa@zytor.com, toshi.kani@hp.com, airlied@redhat.com, benh@kernel.crashing.org, mst@redhat.com, vinod.koul@intel.com, jgross@suse.com, daniel.vetter@ffwll.ch, luto@amacapital.net, linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org, corbet@lwn.net

On Fri, Mar 04, 2016 at 08:23:26PM +0100, Luis R. Rodriguez wrote:
> On Thu, Mar 03, 2016 at 01:42:33PM -0800, Paul E. McKenney wrote:
> > On Thu, Mar 03, 2016 at 01:21:48PM -0800, Luis R. Rodriguez wrote:
> > > The current documentation refers to using set_memor_wc() as a
> > > possible hole strategy when you have overlapping ioremap() regions,
> > > that's incorrect as set_memory_*() helpers can only be used on RAM,
> > > not IO memory. This fixes that, and updates the documention to
> > > *strongly* discourage overlapping ioremap() memory uses, but also
> > > documents a possible solution should there really be no other
> > > option.
> > > 
> > > Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> > 
> > Given an Acked-by or better from the guys on the TO line, I would be
> > happy to queue it.
> 
> I'll need to respin as fortunately I ended up actually not needing
> to do an overlap on atyfb, and instead just let MTRR be effective
> over an entire range that included both write-combining and strong
> UC attributes. It was a bit fuzzy as this while ago, and since its
> also obscure, its more reason to document now.
> 
> Will spin a v2.

Sounds good!

							Thanx, Paul

